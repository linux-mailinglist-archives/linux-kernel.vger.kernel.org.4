Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33E863A6B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiK1LG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbiK1LGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:06:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C9E1C139;
        Mon, 28 Nov 2022 03:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669633552; x=1701169552;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=/ZYnjHxTbbC8RHpwopjgL6MHoNVmg9d8WyhOCxTzcYU=;
  b=Rgz16FH5eWKQOzZDT5LuiW+Jo0M4pkiSyA6D8kiAr4aCzrHq/V0mlJW5
   j+zZ3EYryrq/S6GCGblEEN6RylH2L+KP4oN6c2k7Lp9w7LQpUS9VzPKhb
   8301Igd2l4Ueq0J/W1z+ZDztCodv9Qbv08wBOWvCaUI3GnRrGpZumV/4x
   sjXjxGP9eeu/fIGyXO7xJi+j2D5m1J6wG/tC4AHADTEEx+s6Bfv0HIA0N
   43TbYz9LA40uFLQH8xPhVnoL4hsGd37or7x6LMeNBIOVYnfAX3QllMPnL
   hjE+F3RRVfXQaqNdmwRHhHX16hqHNXAS2P+unxQoY2aGk2Q0UnTOoo4Sj
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="190793210"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2022 04:05:52 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 28 Nov 2022 04:05:51 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 28 Nov 2022 04:05:50 -0700
Date:   Mon, 28 Nov 2022 11:05:31 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        <linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
        <linux-spi@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Message-ID: <Y4SV+5/3Y0dw5QeU@wendy>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-2-j.neuschaefer@gmx.net>
 <166950112932.8087.6546134123286782729.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166950112932.8087.6546134123286782729.robh@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 04:25:36PM -0600, Rob Herring wrote:
> 
> On Thu, 24 Nov 2022 20:13:58 +0100, Jonathan Neuschäfer wrote:
> > The Flash Interface Unit (FIU) is the SPI flash controller in the
> > Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
> > (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
> > accessed by software-defined SPI transfers.
> > 
> > The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.
> > 
> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > ---
> > 
> > v2:
> > - A few cleanups suggested by Krzysztof Kozlowski
> > - Simplify binding by making second reg item mandatory
> > 
> > v1:
> > - https://lore.kernel.org/lkml/20221105185911.1547847-4-j.neuschaefer@gmx.net/
> > ---
> >  .../bindings/spi/nuvoton,wpcm450-fiu.yaml     | 66 +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.example.dts:18:18: fatal error: dt-bindings/clock/nuvoton,wpcm450-clk.h: No such file or directory
>    18 |         #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
>       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.example.dtb] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1492: dt_binding_check] Error 2

FWIW this seems to now be in linux-next as dd71cd4dd6c9 ("spi: Add Nuvoton
WPCM450 Flash Interface Unit (FIU) bindings") & is breaking
dt_binding_check.

Thanks,
Conor.

