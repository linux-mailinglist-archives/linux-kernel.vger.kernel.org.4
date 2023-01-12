Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA1D66844C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbjALUv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239998AbjALUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:50:51 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04E0676E2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:22:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id s8so13030297plk.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhBH0AUTeetrtAjmnA8xJ1rYb8bPDUkKnc3BqPH+Vr8=;
        b=rS3mhpphBBIIxk5efj6bYbJSvFcdarRdauFmIAECEk+U8um3aioM3xJFMomZKzs5Ym
         QTiJoJfRUiobmPocwwp3gFiPmOcizwCmDtfHmVfC3Z4z0meQoicctg4rlYhReVuBRfSi
         PlcP0BXZIRhttkwXPMD6Tmz7nZ809RRSJhgazEHhTw4zST9zr8dG3dutGtbjcJKM9mMp
         po2znQbMwmtxPuFknb4PAzWQPCGcGXPeU0tfCbULINN3vU0hFYSQKHLuEcMj3WCUopki
         3C68lHyxwIoAKaUx2rYY76SGAkwU/+b5Y18lx0WgKG0VNqJ0SL8bpARSIKVcy67fxU7f
         04mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhBH0AUTeetrtAjmnA8xJ1rYb8bPDUkKnc3BqPH+Vr8=;
        b=cMimxoEsEHRnHyFDYLD+UyyA4PhXUQ7Tmh3tNT6jidK7e0RxJGHKdbyC1pmlVw9LAY
         cq8h/0uQJG6E0m3Um/o9Zpy9HVAP+etNt521m70/wx8dkyqd0mKOHLVNzL1oPKA0C1y8
         7YumywUf2dUlpzYIfGC4III8Jr11frrc4Nu9nZdVxZvzfYUfpAaYADLnppliD0wBfsRR
         XaM2NghIPQi6TYC1QfArmhAICdk2+tsOrNiEb2PJRBw+jOzbGKHEIk4uN+sqO9p15zj3
         81knEanEPvEC20poSxHcPErcnEbNWj/4h9i4OB26hZTb/NCRrzrYMzVDGxLKfhAiuLy7
         tTcw==
X-Gm-Message-State: AFqh2krLl2dbBkYp9e7zhSgyeS/kzBuIwSjZarzzuUJ03M5UpuWOAaOh
        BKZzNch7oYwO4ZdSJe0XgePQOA==
X-Google-Smtp-Source: AMrXdXtT63SbStIpg8XEgeo2gFaUX48+aGc6t7ddQ3Zf+rQcJyfjpTq3GQYl21aDOke9bBgtlk+iYA==
X-Received: by 2002:a17:902:8484:b0:192:d631:be14 with SMTP id c4-20020a170902848400b00192d631be14mr33496852plo.13.1673554932452;
        Thu, 12 Jan 2023 12:22:12 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b0018982bf03b4sm12587498plm.117.2023.01.12.12.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 12:22:12 -0800 (PST)
Message-ID: <1c0412a7-7544-9398-c4fa-657b7ea59b94@rivosinc.com>
Date:   Thu, 12 Jan 2023 12:22:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
 <87tu0xko6g.fsf@email.froward.int.ebiederm.org>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <87tu0xko6g.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/23 08:53, Eric W. Biederman wrote:
> Vineet Gupta <vineetg@rivosinc.com> writes:
>
>> This implements the elf loader hook to parse RV specific
>> .riscv.attributes section. This section is inserted by compilers
>> (gcc/llvm) with build related information such as -march organized as
>> tag/value attribute pairs.
>>
>> It identifies the various attribute tags (and corresponding values) as
>> currently specified in the psABI specification.
>>
>> This patch only implements the elf parsing mechanics, leaving out the
>> recording/usage of the attributes to subsequent patches.
> Why does the kernel care?
>
> Unless I am mistaken the kind of information you are describing is
> typically dealt with by the dynamic linker, rather than the kernel.
>
> As a general strategy I think it is smart to leave as much to
> userspace and the dynamic linker and possible intead of asking
> the kernel's elf loader to care.

That is true in general. But in some cases we might have to do stuff 
before kick starting usermode such as setting up a shadow stack with 
special permissions etc.

> That allows more rapid
> prototyping and reduces the impact of parsing bugs.


