Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270AE6D0A49
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbjC3Pqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjC3Pqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:46:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD669D509
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:46:01 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r11so19548173wrr.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680191147; x=1682783147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bt3Z+HMoJYIzkmSX3sH1ZTn84Gu0acDcqEVk57vmUoI=;
        b=3D+C33AbHdSHXYv18ienRAtfdFpzZ3HGGjwnhBgBnkBxOVCdiOOmIxbIs/A17m2jjx
         Amxp6qXtSLzSwG+IBCtWr+XITprahLzidhD5x+1k35lI2fRsH//KKruBlWHqBrtC5MpQ
         uQiVV3e/1ePh2wp3gdy707KSaKtT8k/xcbSr27TaYEKSJzlu+XfqCc6Cq80DkXhRMZxD
         zFrLdIFowEVg1uhzw44jt0ghV6gngV0M5ySA/OKM/ZSqNwT4TqXNRi5/5IJWWZcEzvj+
         4RiCBQ35FcioVLKonv7WSjsVFS60QuPyBvgdtjjQ7IroBlfsv37Hv9EwP0/4/B/hb4ZA
         /LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680191147; x=1682783147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bt3Z+HMoJYIzkmSX3sH1ZTn84Gu0acDcqEVk57vmUoI=;
        b=6Km3Q1AAyI2CCC1Upe8eQGmIx42zuzKtSIVc3PvnB3nALV4/a3oPLcqowPv77HV1du
         2buxXnuM+kI+vd18/WCqynrXymLfUIxAsolCPqrHx9hCxsJ1hEy5vZl+GG3eWspBkhVI
         xrtz3JbVKPtS/4kGIbvreR5vTsf5A095K5TCxLdtPPynY8biYBTjRiwjm+2t9A1zg5nh
         vznxIY3Wd0ngjEfGDBrud31B+citRFtat7wanV619c/34guMwONjgaZy/mxj1VtPYGmw
         8u+3j0tL0ZjcKn+FSvjgKiUttGU3zmmhKHQytrEj6+6H+YMpjoGMtshaPMVwtl85b0en
         5EpA==
X-Gm-Message-State: AAQBX9cuVOgibhVtO4wQCt8aOdF7alVO1gV4tKwK+wn0cLGVkgUIAenj
        Ve/R6u0Anyv2QPv/JY24S+XR1w==
X-Google-Smtp-Source: AKy350aTnQVJ29GM9xhQgheOavkMe1pxyqllfaF/IZQFD2jWnj0+YK6CpqAFqB/fJBS71FuSwSdJkw==
X-Received: by 2002:a05:6000:1044:b0:2dd:a3:c2e8 with SMTP id c4-20020a056000104400b002dd00a3c2e8mr18562410wrx.44.1680191146970;
        Thu, 30 Mar 2023 08:45:46 -0700 (PDT)
Received: from [192.168.1.70] (151.31.102.84.rev.sfr.net. [84.102.31.151])
        by smtp.gmail.com with ESMTPSA id p10-20020a056000018a00b002c3f9404c45sm33560000wrx.7.2023.03.30.08.45.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 08:45:46 -0700 (PDT)
Message-ID: <68fb2d6f-9434-7bcd-0f13-2132612888e5@baylibre.com>
Date:   Thu, 30 Mar 2023 17:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 4/4] misc: tps6594-pfsm: Add driver for TI TPS6594 PFSM
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, corbet@lwn.net, arnd@arndb.de,
        derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com,
        yi.l.liu@intel.com, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com
References: <20230330082006.11216-1-jpanis@baylibre.com>
 <20230330082006.11216-5-jpanis@baylibre.com> <ZCVJv-erahM_Jdug@kroah.com>
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <ZCVJv-erahM_Jdug@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/23 10:35, Greg KH wrote:
> On Thu, Mar 30, 2023 at 10:20:06AM +0200, Julien Panis wrote:
>> This PFSM controls the operational modes of the PMIC:
>> - STANDBY and LP_STANDBY,
>> - ACTIVE state,
>> - MCU_ONLY state,
>> - RETENTION state, with or without DDR and/or GPIO retention.
>> Depending on the current operational mode, some voltage domains
>> remain energized while others can be off.
>>
>> This PFSM is also used to trigger a firmware update, and provides
>> R/W access to device registers.
> What userspace code uses these new ioctls?  Do you have a pointer to it
> anywhere?

I will provide a user app in 'samples' directory in v6.

>
>> --- /dev/null
>> +++ b/include/uapi/linux/tps6594_pfsm.h
>> @@ -0,0 +1,45 @@
>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +/*
>> + * Userspace ABI for TPS6594 PMIC Pre-configurable Finite State Machine
>> + *
>> + * Copyright (C) 2023 BayLibre Incorporated - https://www.baylibre.com/
>> + */
>> +
>> +#ifndef __TPS6594_PFSM_H
>> +#define __TPS6594_PFSM_H
>> +
>> +#include <linux/const.h>
>> +#include <linux/ioctl.h>
>> +#include <linux/types.h>
>> +
>> +/* PFSM state definitions */
>> +enum pfsm_state {
>> +	PMIC_ACTIVE_STATE,
>> +	PMIC_MCU_ONLY_STATE,
>> +	PMIC_RETENTION_STATE
>> +};
>> +
>> +/**
>> + * struct pmic_state - PMIC state identification
>> + * @state:   PFSM destination state
>> + * @options: options for destination state
>> + */
>> +struct pmic_state {
>> +	enum pfsm_state state;
>> +	__u8 options;
>> +};
>> +
>> +/* Commands */
>> +#define	PMIC_BASE			'P'
>> +
>> +#define	PMIC_GOTO_STANDBY		_IO(PMIC_BASE, 0)
>> +#define	PMIC_GOTO_LP_STANDBY		_IO(PMIC_BASE, 1)
>> +#define	PMIC_UPDATE_PGM			_IO(PMIC_BASE, 2)
>> +#define	PMIC_SET_STATE			_IOW(PMIC_BASE, 3, struct pmic_state)
>> +
>> +/* Options for destination state */
>> +#define PMIC_GPIO_RETENTION		_BITUL(0)
>> +#define PMIC_DDR_RETENTION		_BITUL(1)
>> +#define PMIC_MCU_ONLY_STARTUP_DEST	_BITUL(2)
> Please read Documentation/driver-api/ioctl.rst which says:
>
> * Bitfields and enums generally work as one would expect them to,
>    but some properties of them are implementation-defined, so it is
>    better to avoid them completely in ioctl interfaces.
>
> For a brand-new ioctl interface, you did both of these unrecommended
> things.  Why set yourself for complexity when you do not need to?

I will fix that. Thank you for your feedback.

Julien

