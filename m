Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD689631CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiKUJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKUJbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:31:06 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B776B27FF8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:31:04 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id be13so17950322lfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 01:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQPROz4aDycrK9hXyd7awxnQI16NhFsbYCXty/7iDLc=;
        b=YPif/7z/4Oju2FVv753TaQXyOan8g+BkANWHTTfY+Xz9WU6M8HM1oUUiFNSzCm5vcH
         ssu9Zh8I8sTu/zX8IxmoyFonDRcEHxL/n4FPNR20CS6rFeZ4M1+tHcmrVdQ0ebDPE3IQ
         gtkQZ4T8DCQQAM+fQJGyjidb69XI0L8bM3W3YHB0qAZ2FxVjowQPI7+RFr5dEzkvZqNf
         USjmHYxXVPb2JBvQRe04p6hACI/yAxV95+tvkUtMpNABK0c/gEgtgiOo4yix79P2Ouah
         HUnXUbjcf3UbMlkW8z/wsVTZvZfuAWklwn9XI+oX9xjnk9azRhbUOAUtFtsGy3QdavJG
         GT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQPROz4aDycrK9hXyd7awxnQI16NhFsbYCXty/7iDLc=;
        b=DJt4jnrQp7bewgtQNob2NkgEFmw1/nJZsD4Tff2+B/TM2TQ7nit6mCKlihDKADnd8a
         ec/zvusmTkWOOGQNve+0OiZIO9dV5OIZLyD2OVZ198i3+3Y99w3TILwhFqli6TlcK2hX
         J+rr3kdIRsN56y3bdtcR/RiAEZxw4ibc6w4DTI6L/7WWk16nDKk3C6xV29SpvJ5KNUap
         oUd1O7RNAMjcl+PMCA1aEhpbGlSdfu/h7tutHkfLgxD6MimH/At1RhaprBdPfwvege7w
         uEGUcwLhvo1NirsztQuqaJfrif7/dR7Knpx/KaRs2bEmPWfDY7Q2KWJbqwR36vYly4b0
         WUsA==
X-Gm-Message-State: ANoB5ploMG78p2Qdfkyrqn1l+9Ji5pq1rOAhGZO8At77/KjiGFYiIi4m
        VNkd47SDSS6qZNA4oT7mKO6QRw==
X-Google-Smtp-Source: AA0mqf41zO2BkZnCLnbyNAxGF2Zdz2SvHz17MTRYX8uZRG2eaqIi0wmkIWOF20jrFoqi96NsGegt+Q==
X-Received: by 2002:a05:6512:260f:b0:4b4:caeb:c9b1 with SMTP id bt15-20020a056512260f00b004b4caebc9b1mr1601719lfb.500.1669023063096;
        Mon, 21 Nov 2022 01:31:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e9bc8000000b0026e00df2ed0sm1403812ljj.30.2022.11.21.01.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:31:02 -0800 (PST)
Message-ID: <5ebc0bb2-55a0-eba3-6391-27e190c68b4f@linaro.org>
Date:   Mon, 21 Nov 2022 10:31:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] media: add FSD MIPI-CSI2 Rx controller driver
Content-Language: en-US
To:     Sathyakam M <sathya@samsung.com>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pankaj Kumar Dubey <pankaj.dubey@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Andi Shyti <andi@etezian.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ming Qian <ming.qian@nxp.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Will Deacon <will@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CGME20221120184648epcas5p3e08766377944a2c5850f9600bf75cf8f@epcas5p3.samsung.com>
 <cover.1668963790.git.sathya@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cover.1668963790.git.sathya@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2022 19:52, Sathyakam M wrote:
> This patch series adds the V4L2 media driver for
> Tesla Full Self Driving (FSD) SoC MIPI-CSI2 Rx controller.
> 
> The controller is compliant to MIPI CSI2 v1.3 specification.
> It receives images from camera sensors over the D-PHY interface.
> 
> The D-PHY interface is compliant to MIPI D-PHY v1.2 specification. It
> supports up to maximum of 4 data lanes.
> 
> V4L2 user control is provided to set the desired number of data lanes.
> 
> Maximum of up to 4 streams can be received simultaneously by one Rx
> port. (Each streams identified by designated Virtual Channel
> Identifier).
> 
> The controller instances consist of port property describing the endpoints.
> When combined with remote-endpoint property the driver instantiates
> video device nodes using V4L2 async subdev methods.
> 
> Streaming formats supported:
> - YUV420
> - RGB565, RGB666, RGB888
> - RAW8, RAW10, RAW12
> - JPEG
> 
> The driver implementation is verified on FSD evaluation board.
> 
> Thanks, Sathyakam
> 
> Cc: Sathyakam M <sathya@samsung.com>,Vinod Koul <vkoul@kernel.org>
> Cc: Kishon Vijay Abraham I <kishon@kernel.org>,Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: Pankaj Kumar Dubey <pankaj.dubey@samsung.com>,Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>,Shashank Prashar <s.prashar@samsung.com>
> Cc: Aswani Reddy <aswani.reddy@samsung.com>,Chandrasekar R <rcsekar@samsung.com>
> Cc: Andi Shyti <andi@etezian.org>,Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>,Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Ming Qian <ming.qian@nxp.com>,Dmitry Osipenko <digetx@gmail.com>
> Cc: Jacopo Mondi <jacopo@jmondi.org>,Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>,Bjorn Andersson <andersson@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>,Arnd Bergmann <arnd@arndb.de>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>,Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org,linux-phy@lists.infradead.org,devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org,linux-media@vger.kernel.org
> 
> Sathyakam M (5):
>   dt-bindings: phy: fsd: MIPI CSI2 Rx controller syscon node
>   media: dt-bindings: fsd: MIPI CSI2 Rx controller device nodes
>   arm64: dts: fsd: add device tree nodes for MIPI CSI2 Rx controller
>   media: fsd: add MIPI CSI2 Rx controller driver

I did not get your patch #4. Don't Cc selectively.

Best regards,
Krzysztof

