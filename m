Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94145749569
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 08:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjGFGNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 02:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjGFGNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 02:13:12 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F7310A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 23:13:11 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so305573f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688623990; x=1691215990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Nv3H1t676R6gpBVJiSbi0SZfBJx+t6Qgt1kAMQcWL8=;
        b=IFYkxzVATsF/Zd3hKrNE3fZoOh2AlBX6DAasjJJAnwwQG3XcYIleiOQtrZtauAGfE1
         NgsYStMrKNr8bUqoBwZfe54q7I2MYm2qMYl5TPIy8tZPcK7rsdI/5qQ7FwRjy3RUKh0T
         V55TM8il9hYvehg0ey3g+/RJAWEMGmjsePLNvMv0areSj1+eOnvtwgdcCwoWMI1YPF3A
         RxvS6nhLwXj23pGKJaim4qKuL5vNUU+4kd0mqZKkXGz3o3yf29EPWGflO2mLWdw+E9Yi
         1juF2BTpp1CEQXH+2lYo3ik49UHbIwVSevR5tqPsRUtFWXwlG1pZ+rOMByaPRqv16bN6
         KTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688623990; x=1691215990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Nv3H1t676R6gpBVJiSbi0SZfBJx+t6Qgt1kAMQcWL8=;
        b=CBhw8fihLmkx2efHNd480M6yLjBYeR9tST6EvknYfkUlML0IaUcKxdypm1+7zWou5A
         hNiyu4b0dqWSFVPACsI51m4A6bc7FiBeCCDEAOvi608JV1oDZ1CJqQ8Q8fR/MF2VPhHF
         d4ahYonSpk0OweSqYCPfvr8rGiXnZioCN7dvgfqDDxYaiuwdp7AUQkPVJz0N08DGzcFg
         1DV10pK/t02XvJIHRopJh6aKt30mOYJ4Q5m8qu3fY7gDvUhzgthrZWkRPAgvXbRArooC
         Ry1ewKQiM51vdk9aAXdfwTi0OwRNvYK+Q65A/8tzlKrqFVSY7nEYJ1E+3Q6XhsQUjn1w
         YA8Q==
X-Gm-Message-State: ABy/qLY3z3IYMl/7scbxx1RamXCzEVRMFjNWwo+powbEZDlkBCUk+wRq
        6fRQIttGtrNthxx4NmX8s8qSYQ==
X-Google-Smtp-Source: APBJJlEggBQFG1oDGJ9gymFoBUzNli2bTPdtqP/MeYxqRmfwv/cWdJgU8cgkb38FKyu49xNI9JH3+A==
X-Received: by 2002:a5d:4145:0:b0:313:dfa3:4f7b with SMTP id c5-20020a5d4145000000b00313dfa34f7bmr1236628wrq.20.1688623990363;
        Wed, 05 Jul 2023 23:13:10 -0700 (PDT)
Received: from [192.168.45.155] ([95.152.217.99])
        by smtp.gmail.com with ESMTPSA id n3-20020a5d51c3000000b00313f7b077fesm892508wrv.59.2023.07.05.23.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 23:13:09 -0700 (PDT)
Message-ID: <6ded07cc-4a78-a509-a588-d658f720a70d@linaro.org>
Date:   Thu, 6 Jul 2023 07:13:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: qemu-x86_64 booting with 8.0.0 stil see int3: when running LTP
 tracing testing.
Content-Language: en-US
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <CA+G9fYsETJQm0Ue7hGsb+nbsiMikwycOV3V0DPr6WC2r61KRBQ@mail.gmail.com>
 <2d7595b1-b655-4425-85d3-423801bce644@app.fastmail.com>
 <20230621160655.GL2053369@hirez.programming.kicks-ass.net>
 <20230704074620.GA17440@redhat.com> <20230705162830.GC17440@redhat.com>
 <CAFXwXrmbpuFNf5=nQxiTteo8fpCdAbK4pEAN176Cq0yvwZcfFw@mail.gmail.com>
 <20230705163523.GJ7636@redhat.com>
 <CAFXwXrk1FEZPUO-zqNVJZ6YCHKUkgNehwmyDYuOr5fx8ff0OCA@mail.gmail.com>
 <20230705164006.GL7636@redhat.com>
From:   Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230705164006.GL7636@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 17:40, Richard W.M. Jones wrote:
> On Wed, Jul 05, 2023 at 06:36:43PM +0200, Richard Henderson wrote:
>> No, I thought it would be the fix for 8.0.0.
> 
> Thanks for the suggestion anyway.
> 
> Am I right in thinking that tb_invalidate_phys_page() ought to be
> called when the kernel self-modifies its text segment?  If there's
> some function that we expect to be called in this case then I can
> instrument it.

All such go through notdirty_write(), which has a convenient tracepoint.  Recall there are 
migration and vga dirty pages as well, which also go through here, so disabling vga if 
possible may help.

Code stuff should then go through tb_invalidate_phys_range_fast(), so not 
tb_invalidate_phys_page() at all.


r~

