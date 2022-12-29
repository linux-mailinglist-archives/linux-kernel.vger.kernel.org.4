Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F8F658E68
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 16:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbiL2PkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 10:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiL2Pj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 10:39:59 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311F5FEF;
        Thu, 29 Dec 2022 07:39:59 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id c133so17438100oif.1;
        Thu, 29 Dec 2022 07:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+yasPu/FMSW02rgKC1nt4DHDdecaVj9VV//R/xPi0M=;
        b=lCU+oajxseYQ6RacSzu4ZZL9tu41SmMXfFx5kkJLFjlO+t36/dhs6fr7fMIHKYDJTr
         lMN7CqOoKj3OI2XmBg8Wlb6K8pKZ+Eu3H5vKym+K7/CzNTddIxhX99cc/WeGhS73pXe4
         kxzpNczOqxy0sFFJXadNT/L3Zp41qt/7rJZ1lqgM8BnQKEFwUCnnyYOZceW79bgY03b6
         rq81uPuhafMZ0/A6RS9QPcUxxN/NLnhN0IXtANZEUpWSAdB7q5u8i5Vi6oX70HkWS4zn
         KlPjoKECafDSlN2Uj1Nkh6gSq7alXvprBP6aait0r0j0IASv7P9eNJjYm/wGhP0vU9YN
         8ryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+yasPu/FMSW02rgKC1nt4DHDdecaVj9VV//R/xPi0M=;
        b=NiglsUKRDcoDECT58SwiVu29jCv+kIcoLC4SOJGG1PM9YJI7cNzP9H//bH4cp/tm83
         YxfRI7pEj/nZVGhVrHhXTSWvsV+hbWfteLPs0CMfbh6E4KFz6vDavr6bdI4AJnWCeteK
         uBAi+YNLdy4Tt0bXkPi4cHi/dsuE87kfttmfVgVlpTuHkSsOZss8sUBRdBZE7wFvszZ6
         jlucHt8/KYdM8R5X9D1hOrY2iHD+Plwn3sDddCcY6NbT9Uic5/ZNYXcuIPYzaoYUHRiA
         D7higAhvz/uYo9RHQL9xV8vcyGlVEjvd2hcHyk9hnGCd+V7YtkKqTbeeonDnrNHoto1T
         b3Ag==
X-Gm-Message-State: AFqh2kqUgPoytamsKiezJWYYXpix9YBAll42JyXrA+5uDk9GHr2GzeQk
        nC0n7++V5Gx5ve9n88xP6vQ=
X-Google-Smtp-Source: AMrXdXuAum7nXd32CkpwA759U0kJ9EauJJo4YB7XhSF1q8/kPLQ+dbGKanZNf9Wd/28zaoOWeLXwsA==
X-Received: by 2002:a05:6808:297:b0:361:e72:db5e with SMTP id z23-20020a056808029700b003610e72db5emr13122617oic.29.1672328398512;
        Thu, 29 Dec 2022 07:39:58 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i127-20020acaea85000000b0035a9003b8edsm8203035oih.40.2022.12.29.07.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 07:39:58 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 07:39:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sinan Divarci <Sinan.Divarci@analog.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] docs: hwmon: add max31732 documentation
Message-ID: <20221229153957.GA24429@roeck-us.net>
References: <20221214142206.13288-1-Sinan.Divarci@analog.com>
 <20221214142206.13288-3-Sinan.Divarci@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221214142206.13288-3-Sinan.Divarci@analog.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 05:22:05PM +0300, Sinan Divarci wrote:
> Adding documentation for max31732 quad remote temperature sensor
> 
> Signed-off-by: Sinan Divarci <Sinan.Divarci@analog.com>
> ---
>  Documentation/hwmon/index.rst    |  1 +
>  Documentation/hwmon/max31732.rst | 62 ++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>  create mode 100644 Documentation/hwmon/max31732.rst
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index fe2cc6b73..e521bf555 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -133,6 +133,7 @@ Hardware Monitoring Kernel Drivers
>     max20751
>     max31722
>     max31730
> +   max31732
>     max31760
>     max31785
>     max31790
> diff --git a/Documentation/hwmon/max31732.rst b/Documentation/hwmon/max31732.rst
> new file mode 100644
> index 000000000..67bfcf393
> --- /dev/null
> +++ b/Documentation/hwmon/max31732.rst
> @@ -0,0 +1,62 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Kernel driver max31732
> +======================
> +
> +Supported chips:
> +
> +  * Analog Devices MAX31732
> +
> +    Prefix: 'max31732'
> +
> +    Addresses scanned: none
> +
> +Author: Sinan Divarci <Sinan.Divarci@analog.com>
> +
> +
> +Description
> +-----------
> +
> +This driver implements support for Maxim MAX31732.
> +
> +The MAX31732 is a multi-channel temperature sensor that monitors its
> +own temperature and the temperatures of up to four external diodeconnected
> +transistors. The device operates with 3.0V to 3.6V supply range
> +and consume TBDμA of current in standby mode of operation. Resistance

TBDμA ?

> +cancellation feature compensates for high series resistance between
> +circuit-board traces and the external thermal diode, while beta
> +compensation corrects for temperature-measurement errors due to lowbeta
> +sensing transistors.
> +
> +The MAX31732 offers two open-drain, active-low alarm outputs,
> +ALARM1 and ALARM2. When the measured temperature of a channel
> +crosses the respective primary over/under temperature threshold levels
> +ALARM1 asserts low and a status bit is set in the corresponding thermal
> +status registers. When the measured temperature of a channel crosses the
> +secondary over/under temperature threshold levels, ALARM2 asserts low
> +and a status bit is set in the corresponding thermal status registers.
> +
> +Temperature measurement range: from -64°C to 150°C
> +
> +Temperature Resolution: 12 Bits, ±0.0625°C
> +
> +Sysfs entries
> +-------------
> +
> +===================== == =======================================================
> +temp[1-5]_enable      RW Temperature enable/disable
> +                         Set to 1 to enable channel, 0 to disable
> +temp[1-5]_input       RO Temperature input
> +temp[2-5]_fault       RO Fault indicator for remote channels
> +temp[1-5]_max         RW Temperature max value. Asserts "ALARM1" pin when exceeded
> +temp[1-5]_max_alarm   RO Temperature max alarm status
> +temp[1-5]_crit        RW Temperature critical value. Asserts "ALARM2" pin when exceeded
> +temp[1-5]_crit_alarm  RO Temperature critical alarm status
> +temp[1-5]_min         RW Temperature min value. Common for all channels.
> +                         Only temp1_min is writeable. Asserts "ALARM1" pin when exceeded
> +temp[1-5]_min_alarm   RO Temperature min alarm status
> +temp[1-5]_lcrit       RW Temperature critical low value. Common for all channels.
> +                         Only temp1_min is writeable. Asserts "ALARM2" pin when exceeded
> +temp[1-5]_lcrit_alarm RO Temperature critical low alarm status
> +temp[2-5]_offset      RW Temperature offset for remote channels
> +===================== == =======================================================
