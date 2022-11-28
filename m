Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D9E63AA8A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiK1OKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiK1OKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:10:00 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5310C8;
        Mon, 28 Nov 2022 06:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669644599; x=1701180599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Hi8mtuMtBxkZtTKEz9kvonjsKm5H9vDF/St1rZpRREA=;
  b=FU0obIdLLE1uDOSB2LZ07jJxkgAEncGluY+GSjdapww6paPV/A434/Jc
   vJ4CYjRwKrINhdfoqA7Ot8Lb24Julzih+T+TYsk2mj+M9FCBh+m8TZbrZ
   J0N7AW83qKvNni0w65GtNNYI4ySflGOqY88gkcXxlMsZR3B4I+VlUlhgO
   1CN77mDJniOE25QyffhdeC9ySIL6U0mYYwnxFIr4bdpvaysKzClYjN12d
   r3Y/DucRVMm3pR+dOTSPg4jMEBm8h4weoCYnGIAoqKN7u8JfW+7CGYg4W
   dxYfzEHXzi6YTf/1UVku/JZoxA8rll9VFVlObFQmJHyCWQsA0GMKQHP9U
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,200,1665471600"; 
   d="scan'208";a="185487674"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Nov 2022 07:09:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 28 Nov 2022 07:09:58 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Mon, 28 Nov 2022 07:09:56 -0700
Date:   Mon, 28 Nov 2022 14:09:37 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
CC:     Rob Herring <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: spi: Add Nuvoton WPCM450 Flash
 Interface Unit (FIU)
Message-ID: <Y4TBIah6vJAG3kj2@wendy>
References: <20221124191400.287918-1-j.neuschaefer@gmx.net>
 <20221124191400.287918-2-j.neuschaefer@gmx.net>
 <166950112932.8087.6546134123286782729.robh@kernel.org>
 <Y4SV+5/3Y0dw5QeU@wendy>
 <Y4S+oWz8fNsQj5Gj@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4S+oWz8fNsQj5Gj@probook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 02:58:57PM +0100, Jonathan Neuschäfer wrote:
> On Mon, Nov 28, 2022 at 11:05:31AM +0000, Conor Dooley wrote:
> > On Sat, Nov 26, 2022 at 04:25:36PM -0600, Rob Herring wrote:
> [...]
> > > dtschema/dtc warnings/errors:
> > > Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.example.dts:18:18: fatal error: dt-bindings/clock/nuvoton,wpcm450-clk.h: No such file or directory
> > >    18 |         #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
> > >       |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > compilation terminated.
> > > make[1]: *** [scripts/Makefile.lib:406: Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.example.dtb] Error 1
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [Makefile:1492: dt_binding_check] Error 2
> > 
> > FWIW this seems to now be in linux-next as dd71cd4dd6c9 ("spi: Add Nuvoton
> > WPCM450 Flash Interface Unit (FIU) bindings") & is breaking
> > dt_binding_check.
> 
> Ah, sorry about that. It should resolve itself once nuvoton,wpcm450-clk
> binding gets merged, but I don't see a definite timeframe for that, yet.
> 
> Alternatively, I can send a patch to simplify the example in the FIU
> binding.

Without being a Responsible Adult^TM for either SPI or DT, my preference
would be for simplifying the binding so that if your clk stuff doesn't
land for 6.2 the binding checks still work.
