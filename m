Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A460E3CD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbiJZOyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJZOx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:53:58 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55B9BBF25;
        Wed, 26 Oct 2022 07:53:57 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-13bd2aea61bso9546777fac.0;
        Wed, 26 Oct 2022 07:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0Nk9mWz0Lc07+mKRswe0gqSMa42Dcin935f+9F0ZCrw=;
        b=YZGfdyr+VFY30gxUawfKWb5y493oI5OXeBa4RJNoYSgcl2BPynKtklJpO10bSnOHZ1
         QYSbDfk+SLuZRRZEC2Ts7zvEyV/pTqA9t0X3SR8A2+lUr0tVpE91BMNHH9U63cyPH9JW
         Fkme6yjeSg9GC4Yi3fcJy2MM7Y+PIz9xFghZcI8LfWEt6KeK5DgXoxcbYCInMZPUQdfq
         tjKlQTSo1h7CotoYzfWaySISJZm0oXgXdlqiZxOssnlLEe135vzgW6e6y76HE/D45jH3
         qJ901z3VTP7im/oq/XdGja9NeMCub9C78itvQvIN5rgEslZFwIueTATQIto1537CjymO
         hvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Nk9mWz0Lc07+mKRswe0gqSMa42Dcin935f+9F0ZCrw=;
        b=L3mGNS354g6j7re4EfBQ87bOA5TGD2PHwcgGcq+4StDL3HkLvtjol+NgCw5t++ByAS
         Msc+pS9vQF8phKtE/bxLC1fK4QxVDaJzE87guCNN3mOh93VG7umG5uujiWarUFl8vTRe
         Tq51puwwyBoSaeJFJ/PjJgodBff/ob3BxV5+RzTg3VXyqLDtFYXpauDI/I5ZPYwk3K12
         HPyWZfQ2siX/4cJu9lKhVeuvZDaGocZOoWYNzGJWAK3K3yzWixK3NH9s3s89irUZ5oaX
         RM+W+augavGh54gXuDxEwpx6z0tRIpMy9NB/NcLWTvNbsUUnQlqcR54zOvhH4ScWHZ9y
         YN1Q==
X-Gm-Message-State: ACrzQf3kgOB85yj7mA5++M3o8O4qpCFZ/pFHx9AJLH0WcGoVbO63QiE+
        Hxq/oC9UsKuRZKw7yx9+IbU=
X-Google-Smtp-Source: AMsMyM4vDWuLjuvsrFnCW6vUX3lLIR1t9k6ZkMtbDYa/on8aTVs0k3wShNBfsVpYDpKDVPUk2XRPGQ==
X-Received: by 2002:a05:6870:312a:b0:132:9c83:353b with SMTP id v42-20020a056870312a00b001329c83353bmr2314047oaa.65.1666796037111;
        Wed, 26 Oct 2022 07:53:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d22-20020a4ad356000000b004805e9e9f3dsm2246828oos.1.2022.10.26.07.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:53:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ef7858ae-0236-0f04-ba5a-7302ecb6162e@roeck-us.net>
Date:   Wed, 26 Oct 2022 07:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] drivers: rtc: add max313xx series rtc driver
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, jdelvare@suse.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
References: <20221026131124.289-1-Ibrahim.Tilki@analog.com>
 <20221026131124.289-2-Ibrahim.Tilki@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221026131124.289-2-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 06:11, Ibrahim Tilki wrote:
> Adding support for Analog Devices MAX313XX series RTCs.
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>

Nit below, otherwise for hwmon:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
[ ... ]
> +
> +	if (max313xx->chip->temp_reg) {
> +		hwmon = devm_hwmon_device_register_with_info(dev, client->name,
> +							     max313xx,
> +							     &max313xx_chip_info,
> +							     NULL);
> +		if (IS_ERR(hwmon))
> +			dev_warn(dev, "cannot register hwmon device: %li\n",
> +				 PTR_ERR(hwmon));

You could use %pe here and just pass hwmon as parameter.

> +	}
> +
> +	return max313xx_trickle_charger_setup(dev);
> +}


