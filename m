Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D663EF49
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiLALSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiLALRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:17:46 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E9A87CB7;
        Thu,  1 Dec 2022 03:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669893315; x=1701429315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rM+K1icdCaFKZCqOFV+QNCG9qeXYbf+NhJP0kyV2GKQ=;
  b=vxWBNehwxImCCblXDxK/ZXQ3R4taU74wFJ6dAoK94ptBidqPBsjclLQL
   5S9UhORHOqF+pGYESXvb4KIGc+EB9GmxIPjbE4bIqT4WEcI7ABdPommhY
   Ax7Cwt7rVLOtiiMiimNUlHjO+5r5WPOdquojDlG3dQ9AJ6bAD2z38k/7D
   PXOMWLwyuKrQLKikR8mLEPPjS9rscfq0ykmefq6mLXNDA5pEnqrWamB/s
   uzzXdH/X7VHopEBmR4vp9MBKlCrZBgRFnaD1CrvJyuStsH60K4SrJSiCn
   ED3favSXDGh9s5rTryIlT2aM0gk6Fi4QbgSkkZJJxJoX8PikH5v98z7rV
   A==;
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="191275759"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Dec 2022 04:15:14 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Dec 2022 04:15:13 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 1 Dec 2022 04:15:10 -0700
Date:   Thu, 1 Dec 2022 11:14:52 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Jisheng Zhang <jszhang@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] dt-bindings: riscv: Add bouffalolab bl808 board
 compatibles
Message-ID: <Y4iMrKjLAHpkCygo@wendy>
References: <20221127132448.4034-1-jszhang@kernel.org>
 <20221127132448.4034-6-jszhang@kernel.org>
 <60991459-945f-35db-f26a-fb27824728ad@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <60991459-945f-35db-f26a-fb27824728ad@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

On Thu, Dec 01, 2022 at 12:05:04PM +0100, Krzysztof Kozlowski wrote:
> On 27/11/2022 14:24, Jisheng Zhang wrote:
> > Several SoMs and boards are available that feature the Bouffalolab
> > bl808 SoC. Document the compatible strings.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  .../bindings/riscv/bouffalolab.yaml           | 34 +++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/riscv/bouffalolab.yaml b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > new file mode 100644
> > index 000000000000..91ca9dbdc798
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/riscv/bouffalolab.yaml
> > @@ -0,0 +1,34 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/riscv/bouffalolab.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Bouffalo Lab Technology SoC-based boards
> > +
> > +maintainers:
> > +  - Jisheng Zhang <jszhang@kernel.org>
> > +
> > +description:
> > +  Bouffalo Lab Technology SoC-based boards
> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    oneOf:
> > +      - description: Sipeed M1s SoM:
> > +        items:
> > +          - const: sipeed,m1s
> > +          - const: bouffalolab,bl808
> 
> I don't think that SoM is usable alone. It always needs a carrier, so
> drop this entry.

For my own information, if a SoM is not capable of functioning without a
carrier there is no merit in it having a compatible?
Does this also apply if there are multiple possible carriers from
different vendors?

Thanks,
Conor.

