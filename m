Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC76607B73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJUPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJUPsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:48:50 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DE8222F00;
        Fri, 21 Oct 2022 08:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1666366753; bh=CMrmPvkFy9Rnj6R3j7QT0enTO4XoE0Vw26Epmtis0+g=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=AOEvKLBb8mH5u5eqhb3ggdx4wGRkJSHhVMZlbDA6lj7TZ23qsX+M5kXwKbXYSA7zL
         dm61z2GB1I3COTwrpB0emSpvNhhxGFJJY9AzPLkoIQO9CvBW+OTXGJrXefYDfdhOCF
         GZoHMuRtRf2OZMAAscspxS669F9IH1l5GhgTp+5I=
Date:   Fri, 21 Oct 2022 17:39:13 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: rockchip: rk356x: Fix PCIe register map
 and ranges
Message-ID: <20221021153913.l5ry6v4mcnzcmj2v@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Peter Geis <pgwipeout@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        "moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20221005085439.740992-1-megi@xff.cz>
 <CAMdYzYrEXEqOmMeozGBbAAvrujZcOxLh4VYOmu5DSjPWTS-5zQ@mail.gmail.com>
 <20221005220812.4psu6kckej63yo2z@core>
 <4679102.Wku2Vz74k6@phil>
 <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMdYzYq3S2rR3Kb61irpV9xHYijNiJY0mkVnJwPrpXzxg_Zh9g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 09:07:50AM -0400, Peter Geis wrote:
> Good Morning Heiko,
> 
> Apologies for just getting to this, I'm still in the middle of moving
> and just got my lab set back up.
> 
> I've tested this patch series and it leads to the same regression with
> NVMe drives. A loop of md5sum on two identical 4GB random files
> produces the following results:
> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> fad97e91da8d4fd554c895cafa89809b  test-rand2.img
> 2d56a7baa05c38535f4c19a2b371f90a  test-rand.img
> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> 25cfcfecf4dd529e4e9fbbe2be482053  test-rand.img
> 74e8e6f93d7c3dc3ad250e91176f5901  test-rand2.img
> b9637505bf88ed725f6d03deb7065dab  test-rand.img
> f7437e88d524ea92e097db51dce1c60d  test-rand2.img
> 
> Before this patch series:
> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> d11cf0caa541b72551ca22dc5bef2de0  test-rand.img
> d11cf0caa541b72551ca22dc5bef2de0  test-rand2.img
> 
> Though I do love where this patch is going and would like to see if it
> can be made to work, in its current form it does not.

Thanks for the test. Can you please also test v1? Also please share lspci -vvv
of your nvme drive, so that we can see allocated address ranges, etc.

kind regards,
	o.

> Very Respectfully,
> Peter Geis
