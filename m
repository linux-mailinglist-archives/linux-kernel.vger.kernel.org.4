Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D496CAE6A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 21:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjC0TTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 15:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjC0TS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:18:59 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A966CF;
        Mon, 27 Mar 2023 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=xfwD58r7ManSAcpynfJdhPJPb96SmXfv4nKRVZMP16k=; b=xS3TkBLpKk7oxdcIdC9Bdo53Ny
        QwB2QZZLiC+Bi6w8bc7MVztJhPo3j8elRFfzvjeFdI59SaG2OGxMhJzkjWl2X1ZzdBPcephzafTcb
        rwBPLae2mbcT2HFnaoIgXZYwslSXnivcOEYv8K185DlnGDkiI94CMNu1ueRF+1Ri4BsBac1Ne8lSA
        PTMbAeqpmuW06qud/FMkRU0rPZxgqh9AqptFUkaMtyG5fOLBNHk5DgSNhmnNvtfW02qPd/mBBKnEu
        iKVZxCcnali3pFoyBWBlKYlmnLCLTomj4rJp2vmb45PDnNzQhHOTSpFLAarX3JSC4rNDUnM3N0r7F
        pvW8uqHA==;
Received: from p200300ccff0533001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff05:3300:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pgsMZ-00014E-IO; Mon, 27 Mar 2023 21:18:40 +0200
Date:   Mon, 27 Mar 2023 21:18:38 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 1/2] ARM: dts: omap: Drop ti,omap36xx compatible
Message-ID: <20230327211838.580af7a9@aktux>
In-Reply-To: <20230216153339.19987-2-afd@ti.com>
References: <20230216153339.19987-1-afd@ti.com>
        <20230216153339.19987-2-afd@ti.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 09:33:38 -0600
Andrew Davis <afd@ti.com> wrote:

> This was not matched anywhere and provides no additional information.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-xm.dts              | 2 +-
>  arch/arm/boot/dts/omap3-cm-t3730.dts               | 2 +-
>  arch/arm/boot/dts/omap3-igep0020-rev-f.dts         | 2 +-
>  arch/arm/boot/dts/omap3-igep0020.dts               | 2 +-
>  arch/arm/boot/dts/omap3-igep0030-rev-g.dts         | 2 +-
>  arch/arm/boot/dts/omap3-igep0030.dts               | 2 +-
>  arch/arm/boot/dts/omap3-lilly-dbb056.dts           | 2 +-
>  arch/arm/boot/dts/omap3-n9.dts                     | 2 +-
>  arch/arm/boot/dts/omap3-n950.dts                   | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-alto35.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-chestnut43.dts | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-gallop43.dts   | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-palo35.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-palo43.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-summit.dts     | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 2 +-
>  arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts    | 2 +-
>  arch/arm/boot/dts/omap3-pandora-1ghz.dts           | 2 +-
>  arch/arm/boot/dts/omap3-sbc-t3730.dts              | 2 +-
>  arch/arm/boot/dts/omap3-sniper.dts                 | 2 +-
>  arch/arm/boot/dts/omap3-zoom3.dts                  | 2 +-
>  21 files changed, 21 insertions(+), 21 deletions(-)
> 
hmm, we have
drivers/clk/ti/dpll.c:         of_machine_is_compatible("ti,omap36xx"))

but that is more completely
  if ((of_machine_is_compatible("ti,omap3630") ||
             of_machine_is_compatible("ti,omap36xx")) &&

so missing omap36xx will not harm if 3630 is there. SO this should
be probably ok.

Regards,
Andreas
