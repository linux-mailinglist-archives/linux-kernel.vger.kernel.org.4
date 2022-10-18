Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2936602E03
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiJROKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiJROK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:10:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A355D3D581;
        Tue, 18 Oct 2022 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666102218; x=1697638218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FslbosaZFDAZ9OA/TltPlWPrFXTlTk2Z/HSwtCIE19w=;
  b=dQYicbMMc1rMHL0Rrm3W4cl8yfQQ8TZTMv9N1oDk/14Hpaso9wXKqWwQ
   pBhxM7SCiVIj3GDbtXaxFP9HwFJwf5k6aCvxK4+ZBy7uG+rWT5+FZ2Wh0
   /HlKbwQ7JIj1vWjnNc61NH3d1yQOLR6GsAlfhsn3/lTg7dcXQ4cp1SvJ7
   3tZv8+iEkTeBNbV8cC/lgnKAqo37pZjdSPobATwQ5Lq24KLWo3FJxx4yo
   +x32qyulu1LLnoj2+nqjegVXJrqPWjCnH2DdpONSXTEHfQvHRPEgpQNxS
   e1OBNs75wszJLxwrFkuh1pzqPhHZfhSBFZvZFoMUJGrwF5jDB8nWzFHF7
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="195950583"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 07:10:16 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 07:10:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 18 Oct 2022 07:10:11 -0700
Date:   Tue, 18 Oct 2022 15:09:48 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] dt-bindings: nvmem: u-boot,env: add Broadcom's
 variant binding
Message-ID: <Y06zrIZPZOCV63Vc@wendy>
References: <20220930163631.27040-1-zajec5@gmail.com>
 <166578177913.2909910.7600034251484225468.robh@kernel.org>
 <Y059lG8ZOXXzc4N+@wendy>
 <2f5f0c7f-4e1d-2434-51b4-d98d3fa7f49a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f5f0c7f-4e1d-2434-51b4-d98d3fa7f49a@gmail.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:58:38PM +0200, Rafał Miłecki wrote:
> On 18.10.2022 12:19, Conor Dooley wrote:
> > On Fri, Oct 14, 2022 at 04:09:40PM -0500, Rob Herring wrote:
> > > On Fri, 30 Sep 2022 18:36:31 +0200, Rafał Miłecki wrote:
> > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > 
> > > > Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Boot
> > > > stores its configuration in an environment data block.
> > > > 
> > > > Such blocks are usually stored on flash as a separated partition at
> > > > hardcoded address. Broadcom however decided to:
> > > > 1. Store env data block inside U-Boot partition
> > > > 2. Avoid sticking to hardcoded offsets
> > > > 3. Use custom header with "uEnv" magic and env data length
> > > > 
> > > > Example (length 0x4000):
> > > > $ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
> > > > 00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
> > > > 00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|
> > > > (0x40000 offset is unit specific and can change)
> > > > 
> > > > Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions:
> > > > support label/name only partition") DT can describe partitions matching
> > > > them by a name (without specifying actual address). With that feature
> > > > and this binding change it's possible to:
> > > > 1. Specify DT node for Broadcom's U-Boot env data subpartition
> > > > 2. Add nodes for specific environment data variables
> > > > 3. Reference them as NVMEM cells
> > > > 
> > > > This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs to
> > > > find environment data early (before it accesses DTB) and it does that by
> > > > looking for an "uEnv" magic. Dirty way.
> > > > 
> > > > This binding can however be used by operating systems. It allows
> > > > describing cleanly U-Boot, its env data and variables. It tells
> > > > operating system about Broadcom-specific env data so it can parse it.
> > > > 
> > > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > > > ---
> > > > V2: Work on better commit body & add example
> > > > ---
> > > >   .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++++
> > > >   1 file changed, 21 insertions(+)
> > > > 
> > > 
> > > Applied, thanks!
> > 
> > Hey Rob,
> > Maybe my tooling is out of date or w/e but this is breaking
> > dt_binding_check for me.
> > 
> > I applied the below to fix the build, which I was about to send, before
> > realising that you'd applied it and wondered if I was missing something.
> 
> Thanks for catching that and submitting a fix!

No worries.

> 
> I guess I didn't run dt_binding_check this time or I did it before
> adding an example. Sorry for that!

BTW, subsequent to sending the fix I double checked my dt_binding_check
logs and I saw:
Documentation/devicetree/bindings/nvmem/u-boot,env.example.dtb: partition@0: Unevaluated properties are not allowed ('partition-u-boot-env' was unexpected)
	From schema: Documentation/devicetree/bindings/mtd/partitions/u-boot.yaml

I think unevaluated property detection got better in v2022.08 of
dt-schema so that is probably worth fixing too. I'll leave that one up
to you ;)

Thanks,
Conor.

