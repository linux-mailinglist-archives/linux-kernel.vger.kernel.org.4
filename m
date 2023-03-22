Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2529F6C443A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCVHmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCVHmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:42:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157905A6E9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:41:59 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so69142759edd.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 00:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679470917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qS06mqw6Gq+1rRSC5TaD+GeXJM68W3OY2rsM3goBUU0=;
        b=b63jxVHfc+ADhGI/mHvW0r2fjw7epc5gbj8E0yyKnn2oHINSCkG1dgdXt5AwWmpJjO
         e0AvQLKW0dKAieETNwkoPhO7TE1djmBYsFAr5b7Ds0C4+tKgPn4R/bxsDuiIx0RMoDHk
         6q+ITMVMNx53VdZ61RBmxcGqq0SQjZdqWY0PahEwXWaCOv3M9zt9XLEPtrdGnwxpVtja
         m7G3RstXFIuIfbB1tmEBi+ezBkV2TR9ZO9qBjr2cqYPnEZUQqtP3bCzp1vgSborMMx18
         TXdtafkAEQgipaATbh+9K9NR11Qr3mkd7O2duMm6dJI/Kk37C798YUZVOOTNZFGstziz
         4jlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679470917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qS06mqw6Gq+1rRSC5TaD+GeXJM68W3OY2rsM3goBUU0=;
        b=EjzZI7IAvHSCo1V//+Ht/e91J09jMyMVZ1F/Fdt3LHKmr1o6oSx/mRdZJWgUPmPkbl
         Ul4g7s3XRfc2dBjwVHgzZGXnl/K4AyEiJWV854YrUgj9vlWAMn/uIwWWNUUquuF/1v7K
         4r2pCWpGpCESTODyyKx9iljG7mIUAAG6ovSoZ4w2xFlGdOD9rYEbuV0ytZlMM27f4g/u
         kWZe/Os4KnW/YnV55uT6KiURWefRX63Lex0c5uNztbhwNZWPXcqJQz6T20PkI3Lb2Xa0
         o1tZVbs+x0ZLifccryGIg4hgkE38GDvqTOXnoU6IQtfTRW9UvHg+KYAdzjTKF2GOF2oJ
         p0Sg==
X-Gm-Message-State: AO0yUKWm0MWNbzyYR+XjYacqJVZ0gNJhwGmWtqo0uuSAJOO0fGLmDWOL
        LqPVWnoaNV0w6nzu8OdVGApTdA==
X-Google-Smtp-Source: AK7set+ZgNfXV7bB//44xLLwZHC+3pXY+ZXD+doyZaKPceN4E3t6MU9mRhBT+9A15kC2y7JUXyBf0g==
X-Received: by 2002:a17:906:a047:b0:92f:a6d3:b941 with SMTP id bg7-20020a170906a04700b0092fa6d3b941mr7063776ejb.30.1679470917587;
        Wed, 22 Mar 2023 00:41:57 -0700 (PDT)
Received: from ?IPV6:2003:f6:af46:bf00:c0c2:695b:730f:946e? (p200300f6af46bf00c0c2695b730f946e.dip0.t-ipconnect.de. [2003:f6:af46:bf00:c0c2:695b:730f:946e])
        by smtp.gmail.com with ESMTPSA id h25-20020a1709063c1900b008e8e975e185sm6747988ejg.32.2023.03.22.00.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 00:41:57 -0700 (PDT)
Message-ID: <87dd030b-77e1-edc0-846e-da654bbfc152@grsecurity.net>
Date:   Wed, 22 Mar 2023 08:41:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 0/6] KVM: MMU: performance tweaks for heavy CR0.WP
 users
Content-Language: en-US, de-DE
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230322013731.102955-1-minipli@grsecurity.net>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <20230322013731.102955-1-minipli@grsecurity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.03.23 02:37, Mathias Krause wrote:
> Bonus rant^Wbug report:
> [VMs #GP'ing on WRMSR(IA32_PRED_CMD,...)]

I see that this is already a well known bug, fully analyzed and taken
care off:

https://lore.kernel.org/kvm/20230322011440.2195485-1-seanjc@google.com/

Thanks,
Mathias
