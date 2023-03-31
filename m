Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55FA66D1C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjCaJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjCaJdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:33:55 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2386F1D2F7;
        Fri, 31 Mar 2023 02:33:26 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Pnw7y6y75z49QHd;
        Fri, 31 Mar 2023 12:33:18 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1680255203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gdxuNf+Axr67LtZ9uJ4KzAt1BhlIlNW7JVJbQsQ2a4=;
        b=uXy9sQTh/lvsZhI8D39u2L7eRoKWTZqYrBObxWhgUi19wSqbDOo4bkQAA+JNPylXaevKjR
        wX/cLSrqWnxfqJwi4d4ID9rAxNsHIQ112pOwbAz1+s30nbtRPb6oqSXDqy0o4h7CfBdn81
        s1JlPIRZe3B6HLaH92Oc2D9xJ34xUDkPrP/OS869Ave1kMhR/xsCCUgB4wRAPKdfbzqn8Q
        4NBmnKpHUV3JDk48b1eihaTahad1sEMxctjY6q+Mq3Mf/JTxKV3XBLkyiQBlnv++n6jGvW
        yezJnJeADvPG6kYbfW+aVWBXvLybXRjXRe60kZFJgPe2xX0mMZR7Lch8VRNzcg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1680255203; a=rsa-sha256;
        cv=none;
        b=Y2mZwfIhcSXk29ca9bHqTLn/zar/UzrZyA15qi7nfy1qho/19EEqw6j7C++olU6O/EUuKU
        B73TSoLjdSUX5WFyBllNzObNCbJXuRpOSRgBgBK3g8xAchzvJOMYNwAh/cO0vFbwaSOjLO
        W57CeqdPyNDzZMbFKXxktS6jOQQf77Ed8EhR3rB1SsZFqGMfgZ1PCVbGLAnhW41lId6jf7
        IB8nQDQboFRYhBKJR5eC2GYQbfmhaCsdtitIvOYg3sNpbt5sLSVuLlgp1bElmbkenu+2rB
        oFaropMfL/y7VZmCxvcb3bmKAx/tUBavgkBuB4pwuJyqT4vlrmiCXgXks7v1EQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1680255203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3gdxuNf+Axr67LtZ9uJ4KzAt1BhlIlNW7JVJbQsQ2a4=;
        b=E2uOv63ikqvai+QjOg9zREzxnZCJkC84meEtQzTTa7nzCuzXVI/dbifCOExzIHLQM+BepV
        EhNPoaAmQE2hr0gXNblU6SPC5ScIEEimrRd6DPY63TxoJS0wWHczl2ukMPynVMubfz6EpD
        +T6xspQJ+7wT8ELSfD0u8gPTVc0hH6hzm3iHcSdXGG24mqVNCEDwlhgjnLaH+fGLfKAhaa
        JmbkXn/Bp2/+tNw6qjbUHnekPOVMDTR/SQcDPFtlSFpR8xDynoJrmaIN2I5J4xnWeLb3wS
        U/KGktAh2MVh6tv7vpwbCl7mMQXJIK4IMlAWJDRshfxdjuNAysNfaJKHXHR4xg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id D0C70634C99;
        Fri, 31 Mar 2023 12:31:03 +0300 (EEST)
Date:   Fri, 31 Mar 2023 12:31:03 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Rob Herring <robh@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Joe Tessler <jrt@google.com>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Benoit Parrot <bparrot@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: dt-bindings: Drop unneeded quotes
Message-ID: <ZCaoVwRuxVOTZdI4@valkosipuli.retiisi.eu>
References: <20230320233944.2920964-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320233944.2920964-1-robh@kernel.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Mar 20, 2023 at 06:39:42PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

This patch contains changes to Qualcomm bindings that have been already
made by other patches by Krzysztof. I think these took some time to get
merged to the media tree.

I've dropped those, the result is here:

<URL:https://git.linuxtv.org/sailus/media_tree.git/commit/?id=d75cae0884e80bba486f85e82b33a1dae3c9c976>

-- 
Kind regards,

Sakari Ailus
