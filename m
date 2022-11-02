Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11DB61642F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiKBOAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKBOAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:00:23 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E6B5F52
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:00:18 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so2208804pji.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsJlfOgqiHgUxbwmXIMpsu5a+7TfV6gKqVgE2IVuVWw=;
        b=AHEPyvF6yJhpDPvZ8ro4YgNh/1b3ocEAMuI5HfpiDWENSPwoMudTtWa89Cu9MNghcI
         XnvfBLm5zKyTIL++yTuLk18tUTZ4ZG3YCv5l4MUzk/otRcanr1rGZ/ppKm00oahLog9H
         +ubnqs+SdzlTzcuFg3ASbmFgvBF4t5KTwgI9JBt2jrcWpeUjS3Q5UsoN6GHnhA5ChtjE
         j7EkUBJLld3iBHt/oOI06qx0TSlwF52IWdr5cNBP5XQ6A+U3RD1IEzklyOcvIDL+JGCK
         yMGPPpz4BJExg/rZDmJsOnitiANXG+NGOx2WCMP9JjCCpsyoJBBOdIO5ztzfMY7dRWSX
         OXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsJlfOgqiHgUxbwmXIMpsu5a+7TfV6gKqVgE2IVuVWw=;
        b=SJRiD8gBrRrQ/qlZnkTEmmRD0UwIi/0Br5XVR9KKjigtRRGUBTi53zGi+ecz4pMU1g
         X1QG8HB4CYthbkynLeYBTtZsFWbGN8nAeJzk2XIu1HAUE7ahZCVzLaegkJbYCv5NTCZl
         6aiB2yun81ZmDwOOJoNUtUQHqV+6L7J+fTQFbZ329OWLYJbb+u6S2CABjX6CjpnbTTSp
         PmzvlWlUFMk15QRfK+f3X6AMS4vAK4YlGPgX79V1Y3YKAoMEH/CQm+Peh7fOBsk7qFLR
         Pi81rl22wFnlxB3vV4TZwtaUWeDaW+8kyK9CvPvs/XFu0/PqyYWkSpmE+uEpcfcWNs2y
         fUqQ==
X-Gm-Message-State: ACrzQf2mSYvJ1oj51X1lkPEcqGuqLW7RlnffF/kguIjWyjb1Tyhq5ryE
        5I1l67idLMaY7OzT6Uo5FM83Qg==
X-Google-Smtp-Source: AMsMyM6yV8ivNbcxAFIU13pFb/62Dk7GdMTsYKKajObauYtzqrNkOCFepVJeBDJgkfsgk1NarljTIQ==
X-Received: by 2002:a17:902:ce82:b0:187:3591:edac with SMTP id f2-20020a170902ce8200b001873591edacmr9749767plg.153.1667397618240;
        Wed, 02 Nov 2022 07:00:18 -0700 (PDT)
Received: from [172.20.7.43] ([12.157.112.82])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b00176ba091cd3sm8294561plb.196.2022.11.02.07.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:00:17 -0700 (PDT)
Message-ID: <42b902eb-1ff3-2e44-8128-34d9a86ce8a1@monstr.eu>
Date:   Wed, 2 Nov 2022 07:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support for dynamic
 configuration
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, saikrishna12468@gmail.com,
        git@amd.com
References: <20221019054857.8286-1-sai.krishna.potthuri@amd.com>
 <54973f0b-33ab-6cbb-82ce-be769fe82bd9@intel.com>
Content-Language: en-US
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <54973f0b-33ab-6cbb-82ce-be769fe82bd9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 02:37, Adrian Hunter wrote:
> On 19/10/22 08:48, Sai Krishna Potthuri wrote:
>> Add dynamic configuration support for Xilinx ZynqMP which takes care of
>> configuring the SD secure space configuration registers using EEMI APIs,
>> performing SD reset assert and deassert.
>> High level sequence:
>> - Check for the PM dynamic configuration support, if no error proceed with
>> SD dynamic configurations(next steps) otherwise skip the dynamic
>> configuration.
>> - Put the SD Controller in reset.
>> - Configure SD Fixed configurations.
>> - Configure the SD Slot Type.
>> - Configure the BASE_CLOCK.
>> - Configure the 8-bit support.
>> - Bring the SD Controller out of reset.
>> - Wait for 1msec delay.
>>
>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> 
> Can we get an Ack from xilinx folks?
Xilinx was acquired by AMD some time ago. This has been tested and reviewed 
internally already. But

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

