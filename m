Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA6E5F4061
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiJDJyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJDJxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:53:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D1EBE7;
        Tue,  4 Oct 2022 02:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664877172; x=1696413172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WDkyn/xwXddNppq/eAkPzbUNzHf3vyZHD7Cpir1HgaU=;
  b=mPP2OED+gPVkiwhQRaqt+HWYAA87hn1wuZhC8uN/DzJxCF8T3SbfZ7mV
   Sxj7hcrKe8O0XGKDhEjrG8vIGE+BdDfMiLDkDNMnCLD8WuGnpFeiK2aZv
   jrmlsy3BWFs+934JfBOOHlh6FaC2yoX6VaNFjS8qQsHljo24ciCzEZLN4
   u5pV8qilCNffPIWhzP9yp5TdKPz9H1XOU1loCfKGPT+TmA5dK2k0+QjKz
   rUlGtn6+gAtDrnauvCdZLuDonPeYy+vyN75vkDTdjFSWDTafDTrfZ4Xju
   /EkuaPwDCGlaDpdMqfwd52LpvcZ1H5nN7tOpMOQ612zhiXx0cXBGjlCeU
   w==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="176917311"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 02:52:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 02:52:48 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 02:52:46 -0700
Date:   Tue, 4 Oct 2022 10:52:24 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@collabora.com>
Subject: Re: [PATCH v3 0/3] Enable initial support for StarFive VisionFive V1
 SBC
Message-ID: <YzwCWDN4NyIQ8a46@wendy>
References: <20220908142914.359777-1-cristian.ciocaltea@collabora.com>
 <c5169131-486e-9808-ba48-b7abe1be6a99@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c5169131-486e-9808-ba48-b7abe1be6a99@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 02:06:32PM +0300, Cristian Ciocaltea wrote:
> Please let me know if there is anything else missing in order to get this
> queued for merging.

Hey Cristian,

LinusW has applied a conflicting change for 6.1 as he renamed the
pinctrl header that you have moved from one file to another in this
patch [0]. Could you rebase once that lands upstream please?

Thanks,
Conor.

0 - https://lore.kernel.org/linux-riscv/CACRpkdZmmMjVwpHxkJP+Ui0XJgrdZx8kpVybifbwkRB1_uMhAg@mail.gmail.com/

> 
> Thanks,
> Cristian
> 
> On 9/8/22 17:29, Cristian Ciocaltea wrote:
> > The StarFive VisionFive V1 SBC [1] is similar with the already supported
> > BeagleV Starlight Beta board, both being based on the StarFive JH7100 SoC.
> > 
> > In addition to documenting the necessary compatibles, this patch series
> > moves most of the content from jh7100-beaglev-starlight.dts to a new file
> > jh7100-common.dtsi, to be shared between the two boards.
> > 
> > No other changes are required in order to successfully boot the board.
> > 
> > [1] https://github.com/starfive-tech/VisionFive
> > 
> > Changes in v3:
> >   - Added Reviewed-by tag from Krzysztof in patch 1/3
> >   - Optimized patch 2/3 by enabling copy detection on "git format-patch",
> >     as indicated by Krzysztof
> > 
> > Changes in v2:
> >   - Simplified documentation by using 'enum' instead of 'const' in
> >     patch 1/3, according to Conor's review
> >   - Added Reviewed-by tags from Conor
> > 
> > Cristian Ciocaltea (3):
> >    dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
> >    riscv: dts: starfive: Add common DT for JH7100 based boards
> >    riscv: dts: starfive: Add StarFive VisionFive V1 device tree
> > 
> >   .../devicetree/bindings/riscv/starfive.yaml   |   4 +-
> >   arch/riscv/boot/dts/starfive/Makefile         |   2 +-
> >   .../dts/starfive/jh7100-beaglev-starlight.dts | 153 +-----------------
> >   ...aglev-starlight.dts => jh7100-common.dtsi} |   3 -
> >   .../jh7100-starfive-visionfive-v1.dts         |  20 +++
> >   5 files changed, 25 insertions(+), 157 deletions(-)
> >   copy arch/riscv/boot/dts/starfive/{jh7100-beaglev-starlight.dts => jh7100-common.dtsi} (96%)
> >   create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
