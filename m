Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4592A602936
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 12:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJRKTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJRKTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:19:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945D2B70;
        Tue, 18 Oct 2022 03:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666088368; x=1697624368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YtxjgirAzPuap8ZUR7kfOKK9rB1B7+w6oxeIz3DRT5A=;
  b=fOzwYxeRbIJRsUF7putD0TmIVAWs5eGvyF9uU4WciupzjVPpVSQi4K8P
   38uDiwkbmPVB5Ln/LZ3n9FXTEqkOu8sIB/mCpdujtn4+ir5ov9LA1jHI/
   th/5Of64jqcE62pv1oU25c0Kmus+RYzc2G02kj7qw/p5OsvKK0rCHSjxD
   68k8VwZ2f8AK33uPF7Jyz78IvgZgsW5JevLCTzATEHZ8lAUtFmRfZ6UNo
   49E8oe0z9PWuQOBoKHzYS52caJnJuPD+PA8tchXm7QWyAKNN4VQk3UQsb
   9yHlEFlgu8yuCTaoX8tk3MMPMGNkM1AbTl2Bi9psmG1s47M/tZKNayL+V
   g==;
X-IronPort-AV: E=Sophos;i="5.95,193,1661842800"; 
   d="scan'208";a="185196940"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Oct 2022 03:19:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 18 Oct 2022 03:19:25 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 18 Oct 2022 03:19:22 -0700
Date:   Tue, 18 Oct 2022 11:19:00 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
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
Message-ID: <Y059lG8ZOXXzc4N+@wendy>
References: <20220930163631.27040-1-zajec5@gmail.com>
 <166578177913.2909910.7600034251484225468.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166578177913.2909910.7600034251484225468.robh@kernel.org>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 14, 2022 at 04:09:40PM -0500, Rob Herring wrote:
> On Fri, 30 Sep 2022 18:36:31 +0200, Rafał Miłecki wrote:
> > From: Rafał Miłecki <rafal@milecki.pl>
> > 
> > Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Boot
> > stores its configuration in an environment data block.
> > 
> > Such blocks are usually stored on flash as a separated partition at
> > hardcoded address. Broadcom however decided to:
> > 1. Store env data block inside U-Boot partition
> > 2. Avoid sticking to hardcoded offsets
> > 3. Use custom header with "uEnv" magic and env data length
> > 
> > Example (length 0x4000):
> > $ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
> > 00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
> > 00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|
> > (0x40000 offset is unit specific and can change)
> > 
> > Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions:
> > support label/name only partition") DT can describe partitions matching
> > them by a name (without specifying actual address). With that feature
> > and this binding change it's possible to:
> > 1. Specify DT node for Broadcom's U-Boot env data subpartition
> > 2. Add nodes for specific environment data variables
> > 3. Reference them as NVMEM cells
> > 
> > This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs to
> > find environment data early (before it accesses DTB) and it does that by
> > looking for an "uEnv" magic. Dirty way.
> > 
> > This binding can however be used by operating systems. It allows
> > describing cleanly U-Boot, its env data and variables. It tells
> > operating system about Broadcom-specific env data so it can parse it.
> > 
> > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> > ---
> > V2: Work on better commit body & add example
> > ---
> >  .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> 
> Applied, thanks!

Hey Rob,
Maybe my tooling is out of date or w/e but this is breaking
dt_binding_check for me.

I applied the below to fix the build, which I was about to send, before
realising that you'd applied it and wondered if I was missing something.

Thanks,
Conor.

-- >8 --
From b1b57f70a07b02f0119cc1543af49df294e0372c Mon Sep 17 00:00:00 2001
From: Conor Dooley <conor.dooley@microchip.com>
Date: Tue, 18 Oct 2022 11:03:17 +0100
Subject: [PATCH] dt-bindings: nvmem: fix error in u-boot,env

The duplicate mac address trips up dt_binding_check, causing it to fail:
u-boot,env.example.dts:67.34-68.23: ERROR (duplicate_label): /example-1/partitions/partition@0/partition-u-boot-env/ethaddr: Duplicate label 'mac' on /example-1/partitions/partition@0/partition-u-boot-env/ethaddr and /example-0/partitions/partition@40000/ethaddr
ERROR: Input tree has errors, aborting (use -f to force output)

The unreferenced labels don't appear to add anything to the dt-schema
examples, so just remove them.

Fixes: c34f9f549927 ("dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
Hopefully I've not missed the obvious & there's some u-boot parsing that
depends on having this label & I've gone and ruined your example...
CC: Rafał Miłecki <rafal@milecki.pl>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 Documentation/devicetree/bindings/nvmem/u-boot,env.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
index 987957e3ffc8..ebefd565c518 100644
--- a/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
+++ b/Documentation/devicetree/bindings/nvmem/u-boot,env.yaml
@@ -71,7 +71,7 @@ examples:
             compatible = "u-boot,env";
             reg = <0x40000 0x10000>;
 
-            mac: ethaddr {
+            ethaddr {
             };
         };
     };
@@ -89,7 +89,7 @@ examples:
             partition-u-boot-env {
                 compatible = "brcm,env";
 
-                mac: ethaddr {
+                ethaddr {
                 };
             };
         };
-- 
2.38.0

