Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5807A6EF65D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241373AbjDZO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbjDZO0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:26:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC5A7286
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:26:15 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f178da21afso48514415e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682519174; x=1685111174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zy8f63wbHKv6+bRflorRpAclXYwtdQ1Q82TnebF1vFw=;
        b=jae6KCXiJ6/tC6uH9w6dd0VDTTyUvtRRfX5zsqQCsMfLl2ZMqPdXCmaSo5xvHBekD+
         S3uMYREVTXUD57CRO3MoMxgzqvsCYQJOWerY4Nd/VrYrs6rYmG0O48Mz/kVxrbVlIm03
         ciiumNzHtc5gngS9IVK46SONLU40flwWBO879z1g8SAwLAgzIn9HZ2PXCm7O4lOWdmJ/
         pTvJ/4BB40OLREbaJiZrhTZVwOfvAPCb02s2EVtZuVMkPsTppRnhUbYsNLhXdqFyIJyX
         GV4WHoGx5luyAGwcU4ekvKwllEOITRx/F3Kb0jc/9JeNaQhp0tn9gOrgs7JUZtZ/Yv7S
         1mUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519174; x=1685111174;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zy8f63wbHKv6+bRflorRpAclXYwtdQ1Q82TnebF1vFw=;
        b=fFlBA/FK2+oE98O70y58zZcCH8FRrXTEkEQwCgrCkPBEJ7zDgWCvwkzfQLRqNilnwL
         PtP7J2fWRE6pNx8ZubJawJhfKCXXtHnMP8rrwaRTJ+nMxw58L3b5VduPG8XSfXCkNhfz
         4mkGCYTkTPXQjrR1CyVBoPLpRLmCbrBGyQCz79r3CCwKT9lFxZ4kGfES3kizS+zWd1Pd
         wG3OPuoJWnAvfqL9vbI5lEae3rFv1H0SWp9GFcv8rNZ8cZdNb5ifJrc9WCPwzo/x6cAL
         HR19xc5h67ob0dwevo6qVMp8Dz7BJjgI7mjIS2S7jMbjfcJvIIRe/VMf6ZH0IOOcTazH
         36xw==
X-Gm-Message-State: AAQBX9fO850m67coKtkTx+mvsN7w+deS7fYMB+Rx+FjsBfrC+Fbs4yGr
        hEycb8Rdd1zrH4ZIdWkf/YfRFQ==
X-Google-Smtp-Source: AKy350aS4E7hHwxhTcp4IBPASUizzb8DWpQElemlH0pyb8Rd4S+akRGaC4jINeVSNSNtgt5QAEA28A==
X-Received: by 2002:a5d:4cc4:0:b0:2fa:6e37:3d97 with SMTP id c4-20020a5d4cc4000000b002fa6e373d97mr14211258wrt.54.1682519174020;
        Wed, 26 Apr 2023 07:26:14 -0700 (PDT)
Received: from [172.23.2.142] ([31.221.30.162])
        by smtp.gmail.com with ESMTPSA id i5-20020a5d5585000000b002fa6929eb83sm15929021wrv.21.2023.04.26.07.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:26:13 -0700 (PDT)
Message-ID: <2f96d0e9-3659-fa20-53d7-73c883f77fda@linaro.org>
Date:   Wed, 26 Apr 2023 16:26:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [Syzkaller & bisect] There is WARNING in tpm_chip_unregister in
 upstream patch "tpm: st33zp24: Mark ACPI and OF related data as maybe unused"
To:     Pengfei Xu <pengfei.xu@intel.com>, jarkko@kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca, heng.su@intel.com,
        peterhuewe@gmx.de, dhowells@redhat.com, lkp@intel.com
References: <ZEjqhwHWBnxcaRV5@xpf.sh.intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZEjqhwHWBnxcaRV5@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/04/2023 11:10, Pengfei Xu wrote:
> Hi Jarkko and Krzysztof Kozlowski,
> 
> Greeting!
> 
> Platform: x86 platforms
> 
> There is WARNING in tpm_chip_unregister in upstream patch "tpm: st33zp24: Mark
> ACPI and OF related data as maybe unused":
> https://lore.kernel.org/lkml/20230424144130.1084795-1-jarkko@kernel.org/
> -> https://lore.kernel.org/lkml/20230319141354.22907-1-krzysztof.kozlowski@linaro.org/
> 
> We tested Intel internal kernel and found that, the above patch caused below
> WARNING and then kernel BUG dmesg info. After reverted above commit on top
> of Intel internal kernel, this issue was gone.
> I checked that internal commit:"c3985d8b9c22 tpm: st33zp24: Mark ACPI and OF
> related data as maybe unused" was same as above link patch.
> This issue could be reproduced in 155s in VM.

I am trying to reproduce it with mentioned reproducer.

One problem is that commit c3985d8b9c22 (and that patch of mine) was
never in the linux-next. I checked last next releases, including
next-20230421 and there is no such change. It seems it was applied just
before merge window, so was not tested by anything before.

Best regards,
Krzysztof

