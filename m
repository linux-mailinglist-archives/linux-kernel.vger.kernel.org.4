Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8522D68B03B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 15:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBEOMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 09:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEOMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 09:12:51 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20E026A6;
        Sun,  5 Feb 2023 06:12:47 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pOfks-00077L-Ly; Sun, 05 Feb 2023 15:12:30 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>, Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, airlied@gmail.com, daniel@ffwll.ch,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        philippe.cornu@foss.st.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v6 01/17] dt-bindings: display: rockchip: convert
 rockchip-lvds.txt to YAML
Date:   Sun, 05 Feb 2023 15:12:29 +0100
Message-ID: <5647788.DvuYhMxLoT@diego>
In-Reply-To: <87f5097d-1cd0-e09f-e759-8592a9165ea6@gmail.com>
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
 <20230203182119.GA615242-robh@kernel.org>
 <87f5097d-1cd0-e09f-e759-8592a9165ea6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Freitag, 3. Februar 2023, 20:02:54 CET schrieb Johan Jonker:
> 
> On 2/3/23 19:21, Rob Herring wrote:
> > On Thu, Dec 22, 2022 at 03:22:14PM +0100, Johan Jonker wrote:
> >> Convert rockchip-lvds.txt to YAML.
> >>
> >> Changed:
> >>   Add power-domains property.
> >>   Requirements between PX30 and RK3288
> >>
> >> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> ---
> >>
> >> Changed V3:
> >>   Filename matching compatible style
> >>   Drop "Regulator phandle for "
> >>   Specify properties and requirements per SoC
> >>   Sort order and restyle
> >>
> >> Changed V2:
> >>   Fix title
> >> ---
> >>  .../display/rockchip/rockchip,lvds.yaml       | 170 ++++++++++++++++++
> >>  .../display/rockchip/rockchip-lvds.txt        |  92 ----------
> >>  2 files changed, 170 insertions(+), 92 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip,lvds.yaml
> >>  delete mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
> > 
> 
> > What's the plan for these patches? Don't see them in linux-next still. 
> > Do you want me to take patches 1-8?
> 
> Hi,
> 
> The display patches normally go through the DRM git.
> Patch 2 must merge with grf.yaml.
> Heiko has merged now 3 PHY related patches to grf.yaml first.
> 
> [PATCH v6 02/17] dt-bindings: soc: rockchip: grf: add rockchip,lvds.yaml
> 
> See current
> https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=for-next&qt=grep&q=jonker
> 
> Not sure what Heiko's plans are.
> Patch 2 replaces  only a description text and some accolades removal, so not "too" important.
> 
> I urgent then you could merge without conflict:
> 1, 3-8

So I've applied patches 1-7 to the drm-tree now.

For the GRF-patch, I've dropped the quotes changes, as they are somewhat
unrelated to the lvds inclusion and so prevented any conflicts when applying
the rest to the DRM tree.

@Rob, if you could pick the fusb302 patch (number8), that would be great

Thanks
Heiko


