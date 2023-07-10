Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4174D91E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjGJOgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGJOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:36:46 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Jul 2023 07:36:43 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B60106
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:36:43 -0700 (PDT)
X-KPN-MessageId: cb8dc1ea-1f2e-11ee-a2b3-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id cb8dc1ea-1f2e-11ee-a2b3-005056992ed3;
        Mon, 10 Jul 2023 16:33:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=subject:to:from:message-id:date;
        bh=ndshqcXUb+Dwfuyshi1OMTZa+0+yuKFyMzM9cN1ZEac=;
        b=X5MAyiHuZK2zRPHU5y1vBpfWw/rFUPN75fgEFtHxu6bspWjHpxoL8QJiiVf+RFhzDtwNL9k8c7wJv
         vYJNQByypPfqkxx9dQ112w7O1Qjgpxvazc41DcPI8T2sAFqKiXhUzYKn2IwC3mQ1UXLRsta2JYcWX8
         2h5v40XGGTVivirjjDXa6wT4kj88ZifCnr1BgCwTKxHlippOU3vXg0iZVgAhinMKnY/PMkPTUzntFv
         4Rfw00XPgEXMwCoVUgAVZAOfsjIUbdy/fLefD3U8QjrUD8UltUB+7lTjpeO6KFxx8Y3yq7/rJM2lu5
         r6Fw9Q9GHgAdaMG1KuIqMFTNRkRequg==
X-KPN-MID: 33|XymNBmGApvd/hZTUbe+Y9MdUVxDjx6rIpwAJAnlVB9VsBKlfmYTOtfxO1eB1muT
 V0Vyt22MfCX/VkboWTyIdnDHT1e0Bsq1ZBD9MZOpsX1g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|0VKnzYBT35jfpfEU5x6YIKApLSQczTNqCw6izYs/9nBcAf8jRAUo8B4WRqX857i
 xhbyRkXjidrML4FWS21+qdw==
X-Originating-IP: 80.61.163.207
Received: from bloch.sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 0898b9d6-1f2f-11ee-aef8-00505699b758;
        Mon, 10 Jul 2023 16:35:37 +0200 (CEST)
Date:   Mon, 10 Jul 2023 16:35:36 +0200
Message-Id: <87wmz7q1fr.fsf@bloch.sibelius.xs4all.nl>
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     d3adme4t@gmail.com, macromorgan@hotmail.com, jbx6244@gmail.com,
        f.kardame@manjaro.org, amadeus@jmu.edu.cn, robh+dt@kernel.org,
        linux.amoon@gmail.com, aurelien@aurel32.net, anarsoul@gmail.com,
        wiagn233@outlook.com, frattaroli.nicolas@gmail.com,
        strit@manjaro.org, luiz.von.dentz@intel.com, zonyitoo@gmail.com,
        wens@csie.org, jensenhuang@friendlyarm.com, lasstp5011@gmail.com,
        frank-w@public-files.de, pgwipeout@gmail.com, conor+dt@kernel.org,
        leo@nabam.net, andyshrk@163.com, krzysztof.kozlowski+dt@linaro.org,
        michael.riesch@wolfvision.net, jonas@kwiboo.se, festevam@denx.de,
        tobetter@gmail.com, jagan@amarulasolutions.com, cnsztl@gmail.com,
        cristian.ciocaltea@collabora.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
In-Reply-To: <168899855919.1747213.9998138836668928892.b4-ty@sntech.de>
        (message from Heiko Stuebner on Mon, 10 Jul 2023 16:16:16 +0200)
Subject: Re: [PATCH] arm64: dts: rockchip: Drop invalid regulator-init-microvolt property
References: <20230707162217.675390-1-cristian.ciocaltea@collabora.com> <168899855919.1747213.9998138836668928892.b4-ty@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Heiko Stuebner <heiko@sntech.de>
> Date: Mon, 10 Jul 2023 16:16:16 +0200
> 
> On Fri, 7 Jul 2023 19:22:17 +0300, Cristian Ciocaltea wrote:
> > The 'regulator-init-microvolt' property is not currently supported by
> > any driver, it was simply carried on from downstream kernels.
> > 
> > The problem is also indicated by the following dtbs_check warning:
> > 
> >   rk3588-rock-5b.dtb: pmic@0: regulators:dcdc-reg4: Unevaluated properties are not allowed ('regulator-init-microvolt' was unexpected)
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] arm64: dts: rockchip: Drop invalid regulator-init-microvolt property
>       commit: 4d08b19629495b29601991d09d07865694c25199

This property *is used* by the drivers in U-Boot.  Dropping this from
the Linux DTBs will likely result in broken boards the next time the
U-Boot DTBs are synched again from Linux.  At least that is what
happened before...

I think the right solution is to add this property to the DT binding
instead.
