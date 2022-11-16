Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C9D62CB82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiKPUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiKPUwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:52:15 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDA4663C5;
        Wed, 16 Nov 2022 12:52:08 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so11201763otl.3;
        Wed, 16 Nov 2022 12:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0mkEMmmiC29yXQhLvhp9TRUn2+MyHtG1TRf6rjXKQ0=;
        b=6JXRplDVliPAReEEhgpDiRwnlEABJxoGeB5WbfUHoBoKNSQRv5HNxlhaTcn0vZ5K12
         6mRXr/BZmxZ5UPYpCYSPebx/AjnY3HKJN/S/9Kixg8G1Z71JMIfsYI9h1Uky7L9P302/
         b9yXh8bx/OdOfrvQwhrOEflyO1hBbHHxAa8A28KEAGfJMWngCtLB3D3hBD8O/YfkrQGu
         qIiw2IZ/zf4m1pD9cd08ngc6JW2LjGL289ZVUupnJhUOP5hyIjGPX1WoFrsVvDep5vqj
         0Gv4Yl0iB7+tQfOfc1P+GRP+1W/sondBUqM9AL/PtRk6hjZ2fo8HXOV2d4QlofSW0NmK
         No8Q==
X-Gm-Message-State: ANoB5plPMen3ArtYcbqcweTGNzim8ei6N1j2b1TjgEuDR+GqLpd0zHD0
        fqJbsaeyeTkUe/foWzg2qiiTtln7PQ==
X-Google-Smtp-Source: AA0mqf6+KijdVSSY5FeKZl6llvtsCVws/IxK5+nchwW3Qu3zwekNStsmTRD2l3k/9xh4TdriciNhYA==
X-Received: by 2002:a05:6830:18f2:b0:66d:aba2:a8e4 with SMTP id d18-20020a05683018f200b0066daba2a8e4mr4035707otf.257.1668631927947;
        Wed, 16 Nov 2022 12:52:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s15-20020a4ae48f000000b0049ded99501bsm6452664oov.40.2022.11.16.12.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:52:07 -0800 (PST)
Received: (nullmailer pid 861740 invoked by uid 1000);
        Wed, 16 Nov 2022 20:52:09 -0000
Date:   Wed, 16 Nov 2022 14:52:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, Luka Perkov <luka.perkov@sartura.hr>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 1/5] dt-bindings: nvmem: Introduce the nvmem-layout
 container
Message-ID: <166863192845.861669.10779520962009282400.robh@kernel.org>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
 <20221114085659.847611-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114085659.847611-2-miquel.raynal@bootlin.com>
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


On Mon, 14 Nov 2022 09:56:55 +0100, Miquel Raynal wrote:
> The nvmem devices description works like this:
> 
> * Most cases (EEPROM & co):
> 
> eeprom@x {
> 	 compatible = "<eeprom-compatible>";
> 	 ...
> };
> 
> * MTD case:
> 
> flash@y {
> 	compatible = "<flash-compatible>";
> 	...
> 	otp {
> 		compatible = "user-otp"; /* or "factory-otp" */
> 		...
> 	};
> };
> 
> In the former case, the nvmem device is "eeprom@x", while in the latter
> case the nvmem device is "otp".
> 
> Nvmem devices can produce nvmem cells. The current way to describe nvmem
> cells is to locate them by providing their static byte and bit offset
> and length. These information are stored in subnodes of the nvmem
> device.
> 
> It is now a fact that such description does not fit more advanced use
> cases where the location or the size of the cells may vary. There are
> currently three known situations which require being described
> differently: Kontron's SL28 VPD, ONIE's TLV table and U-Boot's
> environment variables.
> 
> Hence, we need a way to describe the parsers that must be used in order
> to make the dynamic discovery of the nvmem cells. This new description
> must fit both use cases (the generic situation and the MTD case).
> 
> Let's create in both cases a container node named nvmem-layout whose
> content will depend on the parser. Right now nvmem-layout.yaml is
> "empty", but references to additional layout parser bindings will be
> inserted in the near future. The final goal being something that looks
> like:
> 
> * Most cases (EEPROM & co):
> 
> eeprom@x {
> 	compatible = "<eeprom-compatible>";
> 	...
> 	nvmem-layout {
> 		compatible = "<parser-compatible>";
> 		...
> 	};
> };
> 
> * MTD case:
> 
> flash@y {
> 	compatible = "<flash-compatible>";
> 	...
> 	otp {
> 		compatible = "user-otp"; /* or "factory-otp" */
> 		...
> 		nvmem-layout {
> 			compatible = "<parser-compatible>";
> 			...
> 		};
> 	};
> };
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/nvmem/layouts/nvmem-layout.yaml  | 30 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/nvmem.yaml      |  7 +++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/layouts/nvmem-layout.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
