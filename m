Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5253A616FB0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKBV0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKBV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:26:45 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893FD386;
        Wed,  2 Nov 2022 14:26:44 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 16-20020a9d0490000000b0066938311495so11001320otm.4;
        Wed, 02 Nov 2022 14:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLVVe6D1itbH1t6TKZAaQSu2DyfSrBfDR8AvY6oDwp4=;
        b=istveK+X30PNzCvzMKd5qimsJM/F2pXq9o8LSiEWNJIBP/HlkryAQ+HT5lKLnoZdSb
         C7ZkGOico2jq0DbA+Zl32RcKc3LHSWxZF934Gpol1Ur5noAvEv/Qzo4qinXMW/OcGwBc
         F7Sno6Kd7QtKqgMsbL6FGQCCemut4UsInpkW2OEbPbFz7zR8YXOzsyfCiBPLaQhhvtzr
         BU1GMERkhtPHRrco/DREy0hU6HE7UWuKc2wcJt3vDMpCIwACll75KS6Br5Ku2kEJM/9Q
         MN4A8/zDzkTqDtNnJCgVqQ4bLW3p6VcPTLf0H2gMoDodVWrjMMLDonMSuXHtoUxq6eXC
         pFxA==
X-Gm-Message-State: ACrzQf3mDaXeS3mExcALrUovkWd3hQ1mI8mgIHkXHcvVAlDmq+jKOtKs
        O8J14ZVqxFevtvs+dBAAsg==
X-Google-Smtp-Source: AMsMyM4uVetPtwuq+hlBmHbM1YIUjngA5Gvk4Jh6qRS5JFArR2DXbdZ0Ml6KflGi7R4f8uTVhQirXw==
X-Received: by 2002:a9d:7212:0:b0:66c:753a:840f with SMTP id u18-20020a9d7212000000b0066c753a840fmr2927409otj.158.1667424403726;
        Wed, 02 Nov 2022 14:26:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a056870612200b0013d7fffbc3csm606191oae.58.2022.11.02.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 14:26:43 -0700 (PDT)
Received: (nullmailer pid 503263 invoked by uid 1000);
        Wed, 02 Nov 2022 21:26:45 -0000
Date:   Wed, 2 Nov 2022 16:26:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dt-bindings: mfd: Add TI-Nspire misc registers
Message-ID: <20221102212645.GA459441-robh@kernel.org>
References: <20221101215804.16262-1-afd@ti.com>
 <20221101215804.16262-2-afd@ti.com>
 <20221102173558.GA4193055-robh@kernel.org>
 <c5e39861-dd81-7c9f-cbb5-2bfbef55ed41@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5e39861-dd81-7c9f-cbb5-2bfbef55ed41@ti.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:05:28PM -0500, Andrew Davis wrote:
> On 11/2/22 12:35 PM, Rob Herring wrote:
> > On Tue, Nov 01, 2022 at 04:57:56PM -0500, Andrew Davis wrote:
> > > The TI Nspire devices contain a set of registers with a seemingly
> > > miscellaneous set of functionality. This area is known simply as the
> > > "misc" region.
> > > 
> > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > ---
> > >   .../bindings/mfd/ti,nspire-misc.yaml          | 55 +++++++++++++++++++
> > >   1 file changed, 55 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> > > new file mode 100644
> > > index 0000000000000..d409eae7537bd
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
> > > @@ -0,0 +1,55 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/mfd/ti,nspire-misc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI Nspire MISC hardware block
> > > +
> > > +maintainers:
> > > +  - Andrew Davis <afd@ti.com>
> > > +
> > > +description: |
> > > +  System controller node represents a register region containing a set
> > > +  of miscellaneous registers. The registers are not cohesive enough to
> > > +  represent as any specific type of device. The typical use-case is
> > > +  for some other node's driver, or platform-specific code, to acquire
> > > +  a reference to the syscon node (e.g. by phandle, node path, or
> > > +  search using a specific compatible value), interrogate the node (or
> > > +  associated OS driver) to determine the location of the registers,
> > > +  and access the registers directly.
> > 
> > Looks like you copied the generic description? Describe what MISC
> > contains.
> > 
> 
> I don't know what all MISC contains (or maybe I do, but it is not
> publicly available so I'm not going to add anything that hasn't
> already been found by clean-room reverse engineering [0]).

Put whatever you are comfortable with, but not a duplicate generic 
description. You know it at least it has reboot registers...

> This is the point I was trying to make in that thread on v3. The
> node's content *is* the hardware description. Every time a new
> register is found it could have just been added to the DT. But now
> we also have to go back here and add the exact same information
> to the binding, every time. We don't require that for simple-bus,
> should simple-mfd be given the same flexibility?

The thing with any MFD is it makes up a device even if it's 'simple', so 
it's important to get a full picture of the device. It could evolve to 
not being 'simple'.

For example, if you came along and wanted to make it a clock provider, 
you'd probably create a clock child node that's just a compatible and 
'#clock-cells'. The feedback would be just add '#clock-cells' to the 
'ti,nspire-misc' node. So yes, I want to see additions.

Rob
