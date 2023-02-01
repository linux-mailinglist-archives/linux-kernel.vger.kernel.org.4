Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAAB6860F4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjBAHsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBAHr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:47:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1AF5CE65
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:47:47 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q5so16447509wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 23:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOAVtoDyGjZY+SIS62M9gmEfmVp9hRVMK35KqE9GNqU=;
        b=yC6P8rtKjMfxlizxYDpk/d0n8PxtFwRcGFMaE/6ViJqIJOj/ZHYf3WLGPgGl8ysq4a
         9swcZrxrknGTH151pyA9IrCK7HPQUL0v0KNlojJl1fnTWRqqGmesLejCsdamaiiPCpux
         rlXTfZD5lOwZA9WXaPe+CBBfaee1rr8mbsNM4aup2KO2LFd8HWOAkYXMfzOMcFMQax/t
         XZvdqqYRtnJLyRn5D7q/4qDlIdJEj1KzoM4jjFFhwNje9X7+w+TKN0oCQaYWMdG1m1nb
         BumzLKtdCVc66ch0kTVrWTCH5pedCpmkwU+/IeLIRtSMeHGWUu7dq79p/j+AKnOsbqcX
         r/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOAVtoDyGjZY+SIS62M9gmEfmVp9hRVMK35KqE9GNqU=;
        b=UCjxcs6t7/e+SdTHYT5oadfvghBIA4CJo4XXHkLXhw+Zey1KNP/sk/jqY065kTPA6g
         xE7+vr59p6SGyiH5XIXu2/5PL5HYaxqnLkZUO/Dlyva4GE4WoiwRhR/0QJgG1E13vX4t
         8yjS9qmrNhkQb9ULMJD0Uoi75U+QXUViXoFeifAQhiaMoRxAlymrtLSoE7oqUw8+EF24
         XYhWbpV+qChc1pFLx5uPgdsqYBXl2Yo25JpaKNJF+c53RueA16EBfFJrItgPRJDSb6vM
         UnuJVOKhuK2Bu8EZC8N7wqodbb/yj9Pm1KqaDC1/fXHqjXCSaxYGFSQM2cQb7o+9GZ/b
         UYSQ==
X-Gm-Message-State: AO0yUKWVWdhuwK40LQpINeDnfni+FdZndWKCalcAE9KOXjiVEbVka9XB
        0+leOIHvGsum7B/fVFd4VvAxaQ==
X-Google-Smtp-Source: AK7set8nqFHJYo7a4eebozO/03eyo/4ffYBLaond3yaQAHgnPDfYSecbma2ZGvil1SD9M2ZBXsqNJQ==
X-Received: by 2002:a5d:6906:0:b0:2bf:b7e3:7c82 with SMTP id t6-20020a5d6906000000b002bfb7e37c82mr1277533wru.57.1675237666253;
        Tue, 31 Jan 2023 23:47:46 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d500a000000b002be0b1e556esm16331729wrt.59.2023.01.31.23.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 23:47:45 -0800 (PST)
Message-ID: <17072296-c1fb-1e82-65fd-26b448167087@linaro.org>
Date:   Wed, 1 Feb 2023 08:47:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, bchihi@baylibre.com,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230131153816.21709-1-bchihi@baylibre.com>
 <202302011058.17Vvc1pN-lkp@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <202302011058.17Vvc1pN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 04:09, kernel test robot wrote:
> Hi Balsam,
> 
> Thank you for the patch! Yet something to improve:
> 
> 
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20230131-234122/bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230124-211910
> base:   the 4th patch of https://lore.kernel.org/r/20230124131717.128660-5-bchihi%40baylibre.com
> patch link:    https://lore.kernel.org/r/20230131153816.21709-1-bchihi%40baylibre.com
> patch subject: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage Thermal Sensor driver
> config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20230201/202302011058.17Vvc1pN-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/5646ebf6f10ff0fc60c04d8c57523f7c44526b41
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review UPDATE-20230131-234122/bchihi-baylibre-com/thermal-drivers-mediatek-Relocate-driver-to-mediatek-folder/20230124-211910
>         git checkout 5646ebf6f10ff0fc60c04d8c57523f7c44526b41
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> drivers/thermal/mediatek/lvts_thermal.c:20:10: fatal error: dt-bindings/thermal/mediatek,lvts-thermal.h: No such file or directory
>       20 | #include <dt-bindings/thermal/mediatek,lvts-thermal.h>
>          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

So here is your driver... and you decided not only to make reviewers
life more difficult, but also to fail all automated tools.

No, that's not how patchsets should be sent. You have here clear
dependency, you cannot send them separately.

Best regards,
Krzysztof

