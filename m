Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63B57317ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239270AbjFOLzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344931AbjFOLz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:55:28 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CCF2955
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:50:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f81b449357so17741575e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686829731; x=1689421731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ru2kY8wr09+4ygjN8vpjUnmo2WcmrcVqvM+LC/LqClo=;
        b=RJs4tRfh991y8kou8camFaZ8Te5e7Ipcz8pfRaCmjrIxrJDwRazj4F1lQUQH+LR7p/
         Cdat8ROquOeFdYXojuI2CIqdM32JaicSA4kfXkDfziwogTDA9rh0BLZsKidMdMzcERdv
         DN/7aLCTgeDxKNEhUNME0Qcc4Ukuf4X8Z1LWBeIFXEFSGKyJTNcliqc0o2VFDacR84GH
         jtemaLtSC3JNpJK13/FfCDJMRkpyYm8yTW7Auq1sZFnSRihZpWwOskktwPel6qCAaKvO
         c/XOszDSztEywNwMGUB1oRUGLujbS2xXax0AMGDAgYv9ZrRkXG7JWnAUGDkHDQBMpf7E
         KevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686829731; x=1689421731;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru2kY8wr09+4ygjN8vpjUnmo2WcmrcVqvM+LC/LqClo=;
        b=RqUT8RBtJRQwKIZBvhOH4NKPMTuZNbSqzfF1kVmpdT1yfIzQGDgvJ+My/9yD4/rYlD
         a7mvvykwsAWH/M12qMCk5Ga+ixrPTlWLCPCQUvnMHUHcMCLiBmYZa71zLGv0ir6HXj65
         Jo5462Fruf44f+wsJR99ApY1kSck2ti4s56Jvctg8V7qM2JF00vO+vdRTToT0trTU/RL
         vUL6v2XpZkrtb9dUWA1sAnJTtHYXK0vm9iI8RH8cycJnGtWbyTFDS03feXcux54jO44I
         UQ6fyahHQ6/f5mRP7KqkTzkgC3c/Ryx0LYWjPW/ELrYGrxUgHjbJyY+MXppAR0uSKhGe
         PGPg==
X-Gm-Message-State: AC+VfDyOHxcCG7sA6kOAwXkLM933SiQuGsNkqzEMXPdKBIu6CmhuKaaV
        BiGdkUwlMoSEcG7UN/UUY4n8gA==
X-Google-Smtp-Source: ACHHUZ6V61eGA9Jko2/8as5sLv4OlzdY23zKd022ouq6CVLScfCWucl7Nj0Cufly2/p7KJ8VPw/BEg==
X-Received: by 2002:a7b:c391:0:b0:3f6:e42:8f85 with SMTP id s17-20020a7bc391000000b003f60e428f85mr14647676wmj.37.1686829730963;
        Thu, 15 Jun 2023 04:48:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:331d:4ff0:1778:3425? ([2a05:6e02:1041:c10:331d:4ff0:1778:3425])
        by smtp.googlemail.com with ESMTPSA id y10-20020a1c4b0a000000b003f5ffba9ae1sm20395228wma.24.2023.06.15.04.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 04:48:50 -0700 (PDT)
Message-ID: <3e397cf5-0ca3-fa10-b5d8-bbc7b1038a37@linaro.org>
Date:   Thu, 15 Jun 2023 13:48:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
To:     Peng Fan <peng.fan@oss.nxp.com>,
        Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
        Peng Fan <peng.fan@nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <507b5daa-73e7-8d21-4f73-c56f88c6bf77@linaro.org>
 <2e57d14a-214e-c3e0-e011-e804ce8c9b39@oss.nxp.com>
 <4844567.31r3eYUQgx@pliszka>
 <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3518a2e7-806d-ad46-a439-ff4a57ed8158@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 06:04, Peng Fan wrote:
> 
> 
> On 6/15/2023 10:53 AM, Sebastian Krzyszkowiak wrote:
>> Caution: This is an external email. Please take care when clicking 
>> links or opening attachments. When in doubt, report the message using 
>> the 'Report this email' button
>>
>>
>> On czwartek, 15 czerwca 2023 04:29:01 CEST Peng Fan wrote:
>>> On 6/8/2023 3:10 AM, Daniel Lezcano wrote:
>>>>
>>>> [...]
>>>>
>>>> Ok, I misunderstood. I thought that was for failing registered thermal
>>>> zone.
>>>>
>>>> Would enabling the site in ops->change_mode do the trick ?
>>>
>>> No. ops->change_mode not able to do the trick.
>>>
>>> devm_thermal_of_zone_register->thermal_zone_device_enable
>>> ->thermal_zone_device_set_mode->__thermal_zone_device_update.part.0
>>> ->__thermal_zone_get_temp
>>>
>>> The thermal_zone_device_set_mode will call change_mode, if return
>>> fail here, the thermal zone will fail to be registered.
>>>
>>> Thanks,
>>> Peng.
>>
>> I think the idea is not to return a failure in ops->change_mode, but 
>> to move
>> enabling the site in REGS_TMR/REGS_V2_TMSR register from
>> qoriq_tmu_register_tmu_zone to ops->change_mode. 
> 
> But qoriq_tmu_register_tmu_zone will finally call ops->change_mode.
> 
> And it is per zone, so we not able to enable TMR_ME here.
> 
> This way the site will be
>> enabled only for actually existing thermal zones, since those not 
>> described in
>> the device tree won't reach thermal_zone_device_enable.
> 
> No. The TMR_ME is the gate for all sites.

What about the following change on top of your series:

diff --git a/drivers/thermal/qoriq_thermal.c 
b/drivers/thermal/qoriq_thermal.c
index c710449b0c50..ecf88bf13762 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -107,8 +107,6 @@ static int tmu_get_temp(struct thermal_zone_device 
*tz, int *temp)
  	 */

  	regmap_read(qdata->regmap, REGS_TMR, &val);
-	if (!(val & TMR_ME))
-		return -EAGAIN;

  	if (regmap_read_poll_timeout(qdata->regmap,
  				     REGS_TRITSR(qsensor->id),
@@ -131,14 +129,40 @@ static int tmu_get_temp(struct thermal_zone_device 
*tz, int *temp)
  	return 0;
  }

+static int qoriq_tmu_change_mode(struct thermal_zone_device *tz,
+				 enum thermal_device_mode mode)
+{
+	struct qoriq_sensor *qsensor = thermal_zone_device_priv(tz);
+	struct qoriq_tmu_data *qdata = qoriq_sensor_to_data(qsensor);
+	unsigned int site;
+	unsigned int value;
+	unsigned int mask;
+
+	if (qdata->ver == TMU_VER1) {
+		site = BIT(15 - qsensor->id);
+		mask = TMR_ME | TMR_ALPF | site;
+		value = mode == THERMAL_DEVICE_ENABLED ? mask : mask & ~site;
+		regmap_update_bits(qdata->regmap, REGS_TMR, mask, value);
+	} else {
+		site = BIT(qsensor->id);
+		mask = TMR_ME | TMR_ALPF_V2 | site;
+		value = mode == THERMAL_DEVICE_ENABLED ? mask : mask & ~site;
+		regmap_update_bits(qdata->regmap, REGS_V2_TMSR, mask, value);
+		regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
+	}
+
+	return 0;
+}
+
  static const struct thermal_zone_device_ops tmu_tz_ops = {
  	.get_temp = tmu_get_temp,
+	.change_mode = qoriq_tmu_change_mode,
  };

  static int qoriq_tmu_register_tmu_zone(struct device *dev,
  				       struct qoriq_tmu_data *qdata)
  {
-	int id, sites = 0;
+	int id;

  	for (id = 0; id < SITES_MAX; id++) {
  		struct thermal_zone_device *tzd;
@@ -158,25 +182,11 @@ static int qoriq_tmu_register_tmu_zone(struct 
device *dev,
  			return ret;
  		}

-		if (qdata->ver == TMU_VER1)
-			sites |= 0x1 << (15 - id);
-		else
-			sites |= 0x1 << id;
-
  		if (devm_thermal_add_hwmon_sysfs(dev, tzd))
  			dev_warn(dev,
  				 "Failed to add hwmon sysfs attributes\n");
  	}

-	if (sites) {
-		if (qdata->ver == TMU_VER1) {
-			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF | sites);
-		} else {
-			regmap_write(qdata->regmap, REGS_V2_TMSR, sites);
-			regmap_write(qdata->regmap, REGS_TMR, TMR_ME | TMR_ALPF_V2);
-		}
-	}
-
  	return 0;
  }


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

