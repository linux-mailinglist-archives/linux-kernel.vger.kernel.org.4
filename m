Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993DC6D4652
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjDCN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjDCN6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:58:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257A0C179
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:58:24 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so30627699pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680530303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zI6MB2YZ4BE718nFORNJOvUurlul7DR51vzr2mzoofs=;
        b=pKi04bNY65I+lrYbuC1t89tt0XygwX4aQnSkqgs6XMNTANLuX58P48JHVQlCSi4+I4
         8zXG2Y8Dl/rd4ex0vj1vk0y4lJglCsCRuj6xfTEYlsZNGGQepBGpWDUZi+osc9SQTdaz
         y5GCPqHZmOwVCF2SRvMGIz0++PbkvODeyqDfeE8zoGZbVm/fZpgC8UI+tE5qqckcL+bY
         q55CDbWTyGIOhpoCe+2DHwjqCQ3YjTrx4ZUPxIolUdMrmJhQxQPeziiCi24ZLgIX8a1R
         I9h+HhWTBuaCv9iPkyKkIBjl5ShLW4wbKRDMfyHfSL8eWX21GXTdm22Q1gMLipcTQcdL
         2IIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680530303;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zI6MB2YZ4BE718nFORNJOvUurlul7DR51vzr2mzoofs=;
        b=HMRXMkNo3+SbLqPfjs4Dxc/Qm8+mzZ8gz2ZfuNgzE7GTGsmZudbdv4WTS+sVGe9ELH
         oD2/vFZPN7kfUtQHUDzuDXqO5Y+xlf6R6Dw01uXG+HojUt1chs156W0o4UwHgeOx6TBs
         fZKifKUpftr/JcA0UZUvI8KAJXs7uwlebEboOkMb+oIAc3jQbusBoFtlKr47H4V0n+1A
         SvmNtEdHBcvCkeEKZx+MiT/K6BAAfjnwQXP9bPVYkLEabJb0OhnxWtaQvEBTAX7fjh4f
         X2Uoy9ObVAmqT+Fwi7ATb005sZUWLgqX0zLpfou9Sxle80xxbKwdeUs8ZcMn46VlvEV9
         zRdw==
X-Gm-Message-State: AO0yUKVVP+3h+sZfO+Vzj3Po1q9HB/38fX0jo+ORaLLLVCORuDEkUxKD
        r5tFyPT/HYP4E5i/yAE1DHGYDv7iqqItWQ==
X-Google-Smtp-Source: AK7set93PE4nBrgJSGX1bny64aBaQoeJcSv4troyHaC0zVv12F/aDHMNbVFTu4ToucpSmc2AfzkdAA==
X-Received: by 2002:a05:6a20:6d05:b0:d5:1c74:27af with SMTP id fv5-20020a056a206d0500b000d51c7427afmr30054334pzb.29.1680530303493;
        Mon, 03 Apr 2023 06:58:23 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id q11-20020a631f4b000000b004fbd021bad6sm6042653pgm.38.2023.04.03.06.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:58:23 -0700 (PDT)
Message-ID: <60b019dc-ea62-0c63-983e-cc1918bfe419@gmail.com>
Date:   Mon, 3 Apr 2023 22:58:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recommend that use the "./scripts/get_maintainer.pl" script
to get the accurate maintainer list to send the patches.


On 23. 3. 22. 23:39, Andy Shevchenko wrote:
> A few fixes to the documentation and some cleanups against extcon core
> module.
> 
> Andy Shevchenko (14):
>   extcon: Fix kernel doc of property fields to avoid warnings
>   extcon: Fix kernel doc of property capability fields to avoid warnings
>   extcon: Use DECLARE_BITMAP() to declare bit arrays
>   extcon: use sysfs_emit() to instead of sprintf()
>   extcon: Amend kernel documentation of struct extcon_dev
>   extcon: Allow name to be assigned outside of the framework
>   extcon: Use unique number for the extcon device ID
>   extcon: Switch to use kasprintf_strarray()
>   extcon: Use device_match_of_node() helper
>   extcon: use dev_of_node(dev) instead of dev->of_node
>   extcon: Remove dup device name in the message and unneeded error check
>   extcon: Use sizeof(*pointer) instead of sizeof(type)
>   extcon: Drop unneeded assignments
>   extcon: Use positive conditional in ternary operator
> 
>  drivers/extcon/extcon.c | 126 +++++++++++++++++++++-------------------
>  drivers/extcon/extcon.h |   9 ++-
>  2 files changed, 71 insertions(+), 64 deletions(-)
> 


-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

