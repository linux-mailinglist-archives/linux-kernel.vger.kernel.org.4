Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17825607852
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJUNYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiJUNYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:24:23 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F76DCA;
        Fri, 21 Oct 2022 06:24:21 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bs14so3642003ljb.9;
        Fri, 21 Oct 2022 06:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8XVCt8zk03c9asrvK7r0rw8Bvfy8tRtb9InAD3Pc+wE=;
        b=I1uw4Swogq+wFwM4eZF4U7T0psUAUtaSiBLONbK7SmiRmwri2Fli7EFsCSAelhpI/E
         pKi+pRrn4XFdYMyRvAi+m+J81nErFKriRGZxtqEQVBFXDoEspocnP1KnqSQwzt3jYUm4
         xO+mMbAeugwp0EZBTbl26sFFg82143NQxMzILi2pRWuu8m7kkMQbYhQN8eLLcvxRWERw
         LGnlWFD6YQcQt6Pt5+DztsobpIts7k6ac5FIFQi3nwed8pbLI1Q2McNcAokKzK0DeDXB
         Al/YixJncrcx5IpuYgoqbgggSY5btOl8oeRJyLQJnKpaLmMxvfZ9ct7mTS8/84XXpsj3
         Qbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8XVCt8zk03c9asrvK7r0rw8Bvfy8tRtb9InAD3Pc+wE=;
        b=X7DEoRsazPFppDB/pL+kEs2oqRfj/l0TBOLDT5pXTzwPiB72B/B45Zj4/I9Gvq8f+R
         +lhuRxxGTWChW46C8KpYGZbZMeI7TyYV1xs+wESi68fHfePeEoTI91oeQjQOhMkiUgQJ
         RgzhS2XPWan5rvHJAHoWPat+ZhystgaQNqPRUHnCoVDCiNQb+iCmf71pMVpd1DHQhju6
         tVKsKe6FpzFzAfxye6BXfm8SnSH8v0uCB13/Jf4rRsINKt3W8683JkA88gnQJT1sgMcL
         KF1A6D+j219aGlh89FcKx2TWVYFepmpH07prnvX3x9V9HwwUUm0u+5NMJVpWUvfkujyZ
         JwgQ==
X-Gm-Message-State: ACrzQf3xaKgUkTkhoqoMsgLpYVXpJ2sCki87sY8OPujnC3YZtCU96s9n
        RnQmx+BOb0k13dBJ1VtS4GM=
X-Google-Smtp-Source: AMsMyM5sFCxauhaoyvskm4EO/dQHCsltNX5NPBoPJjuzzzwYzLjYNbmiDc0KlKoPXWDpf5yJVFWRgA==
X-Received: by 2002:a2e:bd0e:0:b0:267:fad4:7f72 with SMTP id n14-20020a2ebd0e000000b00267fad47f72mr7117490ljq.130.1666358659630;
        Fri, 21 Oct 2022 06:24:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::2? (dc75zzyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::2])
        by smtp.gmail.com with ESMTPSA id q8-20020a056512210800b0049d3614463dsm3158404lfr.77.2022.10.21.06.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 06:24:18 -0700 (PDT)
Message-ID: <d1ed9ab7-6d67-fd93-6a77-86ea029eedc5@gmail.com>
Date:   Fri, 21 Oct 2022 16:24:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 2/4] gpu: drm: sii902x: Use
 devm_regulator_bulk_get_enable()
Content-Language: en-US
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org
References: <cover.1666357434.git.mazziesaccount@gmail.com>
 <1ed8351c2cb4911fcda21b97f7a7b089e955c301.1666357434.git.mazziesaccount@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <1ed8351c2cb4911fcda21b97f7a7b089e955c301.1666357434.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 16:18, Matti Vaittinen wrote:
> Simplify using devm_regulator_bulk_get_enable()
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>

Robert, I did slightly modify the return from probe when using the 
dev_err_probe(). I still decided to keep your RBT - please let me know 
if you disagree.

Eg, this:
> -	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to enable supplies");
> -		return ret;
> -	}

was converted to:
 >   	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to enable supplies");

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

