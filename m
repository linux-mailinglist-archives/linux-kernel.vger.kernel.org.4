Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DCD6CBC79
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjC1KXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjC1KXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:23:22 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A9618B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:23:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s13so6597391wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679998999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JDzRFYi3RNic/LekPtwT66dQgjxUn0+xUq4SVUW3hGI=;
        b=qXrZqxXvk8TTChUZvPxCud+eZ30VRquAfpJfwKULgIKukYnNsDRVWrskBs/yGah/3i
         83B3/EjSGl4dG+VgHadyDwYoaC1hi4MbOvy1Qc2Oc/+DqWQeR6+s8D9LmVi0xWDmAs8H
         LMZutayy8YOQjc8VKeUcs0yO0SsYc03T+45tfadMHO7MRoueM/QsyW0yovgBLvdvelyo
         Qwiz7IJJJbiRlBCKJUuCd/ag5c5rgNiYpFUfixZnpvZhNmtRM49t0A2pQLYaRAzjvwh6
         lRTG3xl22rAxnQ0SIPzcP5Zrc+6LVD6klcI3ntmHYlyR/vxfVCA6z+9fLOxL5LFDZLEt
         Lc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDzRFYi3RNic/LekPtwT66dQgjxUn0+xUq4SVUW3hGI=;
        b=oPktajPTbEyTgdkF44wyvzwcArHEfbiwEfunycp6V38H/6QyhnYTgCG7JFJk/MkGxT
         7m8j+NYbASEyHRq4+rtWs3MowpQFM6aaXM9ht+eVdc22NbSLbmefdfRfTF1xyP+Y+BCL
         xdVx3CBlO2arA6/oGaj8XhcjgDKsnTtkwKT17hcL51BYJlbsCK9494aN02zQhGnfchX3
         oebAAa5H1hy7aG4lX5jeoI5e+hVEKbchCr6Djgz4HIw8fut+7QjpcIUdoZfVzwCRz6Q+
         mAIGwlEDtjX53CrLQLlw+26c1HjTxwFj9t6WUsa6CuzZK5g0XdihKtw3tYAvCBT5rOyZ
         GIFA==
X-Gm-Message-State: AO0yUKXTluaPgDeP5oEg6kkP440CUwtUw/hGVPRF7SIKG43ayKPuLUvu
        C5y90xxpwO3GRgideJ00Lgogfg==
X-Google-Smtp-Source: AK7set8+rVt9uMI2B65S9+dtPSt7AljkPiJbA/L6F0xN8a1/8VPJfc6C35dLQrNoKrs8jVWLcThGVQ==
X-Received: by 2002:a05:600c:291:b0:3ee:5147:3acd with SMTP id 17-20020a05600c029100b003ee51473acdmr11510334wmk.40.1679998999667;
        Tue, 28 Mar 2023 03:23:19 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b003ef5e5f93f5sm11981393wmq.19.2023.03.28.03.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 03:23:19 -0700 (PDT)
Message-ID: <026b9d7d-86db-45cd-9e86-066fa826a77e@linaro.org>
Date:   Tue, 28 Mar 2023 11:23:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/4] ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b
 SPI NOR flash at its maximum frequency
Content-Language: en-US
To:     nicolas.ferre@microchip.com, claudiu.beznea@microchip.com
Cc:     alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
References: <20230328101517.1595738-1-tudor.ambarus@linaro.org>
 <20230328101517.1595738-2-tudor.ambarus@linaro.org>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230328101517.1595738-2-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/23 11:15, Tudor Ambarus wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 

cut

> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

I don't understand why these differ. On my local machine I see them match:

commit e208a7b04cbde950588c561889d2f8eb8a10485f
Author: Tudor Ambarus <tudor.ambarus@linaro.org>
Date:   Thu Nov 17 12:52:46 2022 +0200

    ARM: dts: at91-sama5d27_wlsom1: Set sst26vf064b SPI NOR flash at its
maximum frequency

    sama5d27-wlsom1 populates an sst26vf064b SPI NOR flash. Its maximum
    operating frequency for 2.7-3.6V is 104 MHz. As the flash is operated
    at 3.3V, increase its maximum supported frequency to 104MHz. The
    increasing of the spi-max-frequency value requires the setting of the
    "CE# Not Active Hold Time", thus set the spi-cs-setup-ns to a value
of 7.

    The sst26vf064b datasheet specifies just a minimum value for the
    "CE# Not Active Hold Time" and it advertises it to 5 ns. There's no
    maximum time specified. I determined experimentally that 5 ns for the
    spi-cs-setup-ns is not enough when the flash is operated close to its
    maximum frequency and tests showed that 7 ns is just fine, so set the
    spi-cs-setup-ns dt property to 7.

    With the increase of frequency the reads are now faster with ~37%.

    Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Anyway, you can keep v2 then, looks like v2 has the same email on both
the author line and the S-o-b line. It's fine by me even if it is with
@microchip.com:
https://lore.kernel.org/all/20230328100723.1593864-2-tudor.ambarus@linaro.org/
