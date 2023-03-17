Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09306BE194
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 07:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCQGwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCQGwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 02:52:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6666FBCFC9;
        Thu, 16 Mar 2023 23:51:55 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v21so4350786ple.9;
        Thu, 16 Mar 2023 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679035914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ng4csT8/eG2uGdJLahxmp/MNi3VEyN0+GRHQD9Mqm70=;
        b=YvuPYYcMMo9cZVquIVtLKgtj8eiB9si0cdUsxpVjrgtHqVb2By0qgO84VuT931Ar9Y
         DoLkwWVoLerRLx2QPUoqtmSeV+FFO1LVDVtBig8W0UwHVXB8YDJZr+RVEQcIBycMIHDg
         7S5On2ri2rVpA+zOKip2bUJq/uVK9KrK/H8pC2ARhIEwyK0XpOKUKpmDtfG/47JsDYGB
         Zrm8Ayj8/2TFnF+YmzpCreNf7f1cAodWXde4O9u4lr2VF2PPWQSTJvTUSn/z4hS1UITT
         SEwR4JqFPBHP44Np3vqHO4LiwJzq4rrivybxbpiLpaPDlXc8h8E7OewNorlV7bUPC8Sc
         fSsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679035914;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng4csT8/eG2uGdJLahxmp/MNi3VEyN0+GRHQD9Mqm70=;
        b=0qOTCAIo9eWl0jcNcaCipSrStru+ebE6ptZWk9MG/3nwpg/f8Ov8GPc2A6h59wm/g1
         i0x0oa09sjja0REKBW5xVOQh5hzhpH+vcqgLgmZMEOapUOebKetlUoBRrCqs8CREejTu
         goe0u93oivCKd1MD1xkYYuZbm0NNGWrDy6YIIm0QpUaGzqIBJepVNRAAr8+2olAjs/87
         PF2Xki/A5xWucOK7ylOFLk/k43rhLKV1C+KUwNbiZEe6O1K8UsVpYAq2vuX4ub0UQUNU
         DR1x/OOvdD6CKmSPCl84C6I2atWE+4tpUMPFbG2tKA/7uqjfHqv8P9HiSEDXMwY7+DOi
         dj4g==
X-Gm-Message-State: AO0yUKXW1S1oUi+KIJTqfG+EHO/eCmxFVTbrtbutslS0i3Nh4cND7HJ8
        C5ZSFzBrbC3FisiASw+3cR8=
X-Google-Smtp-Source: AK7set+IolxjOJkPYrn4GVhZcAoUqBi2g4k/AeFqmKNybTZK7AD3syt70t2pT+Fa2cL5LZsvrPKH9Q==
X-Received: by 2002:a17:90b:164f:b0:23f:1165:b49f with SMTP id il15-20020a17090b164f00b0023f1165b49fmr6891354pjb.38.1679035914386;
        Thu, 16 Mar 2023 23:51:54 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id p32-20020a635b20000000b00478ca052819sm726685pgb.47.2023.03.16.23.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 23:51:54 -0700 (PDT)
Message-ID: <06c4aadb-4672-4dd0-50e9-9625a71fa811@gmail.com>
Date:   Fri, 17 Mar 2023 14:51:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/15] mfd: Add the header file of Nuvoton ma35d1 system
 manager
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, schung@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-4-ychuang570808@gmail.com>
 <4f892951-66-3661-7b96-607a67b13838@linux.intel.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <4f892951-66-3661-7b96-607a67b13838@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ilpo,


On 2023/3/16 下午 09:30, Ilpo Järvinen wrote:
> On Wed, 15 Mar 2023, Jacky Huang wrote:
>
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> The system manager is a set of registers used for power control,
>> multi-function pin control, USB phy control, IP reset, and other
>> miscellaneous controls. It also contains some registers that
>> provide SoC information and status.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   include/linux/mfd/ma35d1-sys.h | 95 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 95 insertions(+)
>>   create mode 100644 include/linux/mfd/ma35d1-sys.h
>>
>> diff --git a/include/linux/mfd/ma35d1-sys.h b/include/linux/mfd/ma35d1-sys.h
>> new file mode 100644
>> index 000000000000..dcd85231125d
>> --- /dev/null
>> +++ b/include/linux/mfd/ma35d1-sys.h
>> @@ -0,0 +1,95 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2023 Nuvoton Technologies.
>> + * Author: Chi-Fen Li <cfli0@nuvoton.com>
>> + *
>> + * System management control registers of MA35D1 SoC
>> + */
>> +#ifndef __LINUX_MFD_MA35D1_SYS_H
>> +#define __LINUX_MFD_MA35D1_SYS_H
>> +
>> +#define REG_SYS_PDID		(0x000) /* Product and Device Identifier */
>> +#define REG_SYS_PWRONOTP	(0x004) /* Power-on Setting OTP Source */
>> +#define REG_SYS_PWRONPIN	(0x008) /* Power-on Setting Pin Source */
>> +#define REG_SYS_RSTSTS		(0x010) /* Reset Source Active Status */
>> +#define REG_SYS_MISCRFCR	(0x014) /* Miscellaneous Reset Function */
>> +#define REG_SYS_RSTDEBCTL	(0x018) /* Reset Pin De-bounce Control */
>> +#define REG_SYS_LVRDCR		(0x01C) /* Low Voltage Reset & Detect */
>> +#define REG_SYS_IPRST0		(0x020) /* Reset Control Register 0 */
>> +#define REG_SYS_IPRST1		(0x024) /* Reset Control Register 1 */
>> +#define REG_SYS_IPRST2		(0x028) /* Reset Control Register 2 */
>> +#define REG_SYS_IPRST3		(0x02C) /* Reset Control Register 3 */
>> +#define REG_SYS_PMUCR		(0x030) /* Power Management Unit Control */
>> +#define REG_SYS_DDRCQCSR	(0x034) /* DDR Q Channel Control and Status */
>> +#define REG_SYS_PMUIEN		(0x038) /* PMU Interrupt Enable */
>> +#define REG_SYS_PMUSTS		(0x03C) /* PMU Status */
>> +#define REG_SYS_CA35WRBADR1	(0x040) /* A35 Core 1 Warm-boot Address */
>> +#define REG_SYS_CA35WRBPAR1	(0x044) /* A35 Core 1 Warm-boot Parameter */
>> +#define REG_SYS_CA35WRBADR2	(0x048) /* A35 Core 2 Warm-boot Address */
>> +#define REG_SYS_CA35WRBPAR2	(0x04C) /* A35 Core 2 Warm-boot Parameter */
>> +#define REG_SYS_USBPMISCR	(0x060) /* USB PHY Miscellaneous Control */
>> +#define REG_SYS_USBP0PCR	(0x064) /* USB Port 0 PHY Control */
>> +#define REG_SYS_USBP1PCR	(0x068) /* USB Port 1 PHY Control */
>> +#define REG_SYS_MISCFCR0	(0x070) /* Miscellaneous Function Control 0 */
>> +#define REG_SYS_MISCFCR1	(0x074) /* Miscellaneous Function Control 1 */
>> +#define REG_SYS_MISCIER		(0x078) /* Miscellaneous Interrupt Enable */
>> +#define REG_SYS_MISCISR		(0x07C) /* Miscellaneous Interrupt Status */
>> +#define REG_SYS_GPA_MFPL	(0x080) /* GPIOA Multi-Function Control LSB */
>> +#define REG_SYS_GPA_MFPH	(0x084) /* GPIOA Multi-Function Control MSB */
>> +#define REG_SYS_GPB_MFPL	(0x088) /* GPIOB Multi-Function Control LSB */
>> +#define REG_SYS_GPB_MFPH	(0x08C) /* GPIOB Multi-Function Control MSB */
>> +#define REG_SYS_GPC_MFPL	(0x090) /* GPIOC Multi-Function Control LSB */
>> +#define REG_SYS_GPC_MFPH	(0x094) /* GPIOC Multi-Function Control MSB */
>> +#define REG_SYS_GPD_MFPL	(0x098) /* GPIOD Multi-Function Control LSB */
>> +#define REG_SYS_GPD_MFPH	(0x09C) /* GPIOD Multi-Function Control MSB */
>> +#define REG_SYS_GPE_MFPL	(0x0A0) /* GPIOE Multi-Function Control LSB */
>> +#define REG_SYS_GPE_MFPH	(0x0A4) /* GPIOE Multi-Function Control MSB */
>> +#define REG_SYS_GPF_MFPL	(0x0A8) /* GPIOF Multi-Function Control LSB */
>> +#define REG_SYS_GPF_MFPH	(0x0AC) /* GPIOF Multi-Function Control MSB */
>> +#define REG_SYS_GPG_MFPL	(0x0B0) /* GPIOG Multi-Function Control LSB */
>> +#define REG_SYS_GPG_MFPH	(0x0B4) /* GPIOG Multi-Function Control MSB */
>> +#define REG_SYS_GPH_MFPL	(0x0B8) /* GPIOH Multi-Function Control LSB */
>> +#define REG_SYS_GPH_MFPH	(0x0BC) /* GPIOH Multi-Function Control MSB */
>> +#define REG_SYS_GPI_MFPL	(0x0C0) /* GPIOI Multi-Function Control LSB */
>> +#define REG_SYS_GPI_MFPH	(0x0C4) /* GPIOI Multi-Function Control MSB */
>> +#define REG_SYS_GPJ_MFPL	(0x0C8) /* GPIOJ Multi-Function Control LSB */
>> +#define REG_SYS_GPJ_MFPH	(0x0CC) /* GPIOJ Multi-Function Control MSB */
>> +#define REG_SYS_GPK_MFPL	(0x0D0) /* GPIOK Multi-Function Control LSB */
>> +#define REG_SYS_GPK_MFPH	(0x0D4) /* GPIOK Multi-Function Control MSB */
>> +#define REG_SYS_GPL_MFPL	(0x0D8) /* GPIOL Multi-Function Control LSB */
>> +#define REG_SYS_GPL_MFPH	(0x0DC) /* GPIOL Multi-Function Control MSB */
>> +#define REG_SYS_GPM_MFPL	(0x0E0) /* GPIOM Multi-Function Control LSB */
>> +#define REG_SYS_GPM_MFPH	(0x0E4) /* GPIOM Multi-Function Control MSB */
>> +#define REG_SYS_GPN_MFPL	(0x0E8) /* GPION Multi-Function Control LSB */
>> +#define REG_SYS_GPN_MFPH	(0x0EC) /* GPION Multi-Function Control MSB */
>> +#define REG_SYS_HIRCFTRIM	(0x100) /* HIRC Frequency Trim Value */
>> +#define REG_SYS_TSENSRFCR	(0x104) /* Temperature Sensor Control */
>> +#define REG_SYS_GMAC0MISCR	(0x108) /* GMAC 0 Miscellaneous Control */
>> +#define REG_SYS_GMAC1MISCR	(0x10C) /* GMAC 1 Miscellaneous Control */
>> +#define REG_SYS_MACAD0LSR	(0x110) /* MAC Address 0 LSW */
>> +#define REG_SYS_MACAD0HSR	(0x114) /* MAC Address 0 HSW */
>> +#define REG_SYS_MACAD1LSR	(0x118) /* MAC Address 1 LSW */
>> +#define REG_SYS_MACAD1HSR	(0x11C) /* MAC Address 1 HSW */
>> +#define REG_SYS_CSDBGCTL	(0x120) /* CoreSight Debug Control */
>> +#define REG_SYS_GPAB_MFOS	(0x140) /* GPIOA/B Output Mode Select */
>> +#define REG_SYS_GPCD_MFOS	(0x144) /* GPIOC/D Output Mode Select */
>> +#define REG_SYS_GPEF_MFOS	(0x148) /* GPIOE/F Output Mode Select */
>> +#define REG_SYS_GPGH_MFOS	(0x14C) /* GPIOG/H Output Mode Select */
>> +#define REG_SYS_GPIJ_MFOS	(0x150) /* GPIOI/J Output Mode Select */
>> +#define REG_SYS_GPKL_MFOS	(0x154) /* GPIOK/L Output Mode Select */
>> +#define REG_SYS_GPMN_MFOS	(0x158) /* GPIOM/N Output Mode Select */
>> +#define REG_SYS_UID0		(0x180) /* Unique Identifier Word 0 */
>> +#define REG_SYS_UID1		(0x184) /* Unique Identifier Word 1 */
>> +#define REG_SYS_UID2		(0x188) /* Unique Identifier Word 2 */
>> +#define REG_SYS_UCID0		(0x190) /* Unique Customer Identifier 0 */
>> +#define REG_SYS_UCID1		(0x194) /* Unique Customer Identifier 1 */
>> +#define REG_SYS_UCID2		(0x198) /* Unique Customer Identifier 2 */
>> +#define REG_SYS_RLKTZS		(0x1A0) /* TZS Register Lock Control */
>> +#define REG_SYS_RLKTZNS		(0x1A4) /* TZNS Register Lock Control */
>> +#define REG_SYS_RLKSUBM		(0x1A8) /* SubM Register Lock Control */
>> +#define REG_SYS_DPLPASWD	(0x1B0) /* Deployed Password */
> Remove the extra set of parenthesis from all those above. Hex numbers are
> easier to read with lowercased letters so please convert them all to
> lowercase.
>

Got it. I will remove parenthesis and use lower case hex instead.

Best regards,

Jacky Huang


