Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA36F8987
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233378AbjEETaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjEET3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:29:54 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01D92D7C;
        Fri,  5 May 2023 12:29:53 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-18f4a6d2822so19517872fac.1;
        Fri, 05 May 2023 12:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683314993; x=1685906993;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Pig4YACD/UgX2hQKgAOpS3srvDEjTrIf9fD2QloV1A=;
        b=gM7Tkt419Aox11QLana/HdeXL2ho6mLdfFXhtwpp+lhGXS5RQD3ennXfwNjJq7ZJ0c
         dCAdMLNsOH7mejX++eCXmWALCt83+uTptt5Dxfa6EzFY2pUbwxKjKCEogMN2WU655+NO
         lNKMEr8+mlY5SsdmtJO0MRW/ci27p9Vr5g1fSFVUqzk0gEbWDWGfta2afZ61UYBPracv
         ++0vtIhHl/IzfeTyGg1+m+j4zgOZ+qc1HGBDs/szYmrBZOk96KEApX9MMTZtyTGwATTF
         oNdyNvZTzlPDtUtQXYc/ou+aWCtOD+SfMmt1yMYbEZ0ZFeNibiVvl6Lm0NE99B2qqxTZ
         AoCg==
X-Gm-Message-State: AC+VfDwbZNksxwJSsNUtgco2i7U39WXmb614wkT61yV/GnbETGRbZW+M
        BNlYY3uKOs5zdYnQTzHF7g==
X-Google-Smtp-Source: ACHHUZ5nfCS8okSJ27dYmJp75kHHJBypd/p/CQexWTC36kJPDRbZf0TRU3In6KTQ7voiBFFF78V4lg==
X-Received: by 2002:a05:6830:18f0:b0:6a1:2c80:5a3f with SMTP id d16-20020a05683018f000b006a12c805a3fmr1355264otf.19.1683314993195;
        Fri, 05 May 2023 12:29:53 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v4-20020a9d69c4000000b006a7b28e052dsm1247718oto.40.2023.05.05.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:29:52 -0700 (PDT)
Received: (nullmailer pid 3426450 invoked by uid 1000);
        Fri, 05 May 2023 19:29:51 -0000
Date:   Fri, 5 May 2023 14:29:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.4, part 1
Message-ID: <20230505192951.GA3409270-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull.

Note that I'll be out the next month, so you may see stuff from 
Krzysztof if there's anything urgent.

Rob

The following changes since commit 66ae0535167660e427f9fcadeee5d05646e2bb22:

  dt-bindings: rng: Drop unneeded quotes (2023-04-20 16:30:03 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-6.4-1

for you to fetch changes up to 6997f847cbb72082a2e9aa0fef8ebfcc3bd4ddc5:

  MAINTAINERS: add Conor as a dt-bindings maintainer (2023-05-05 07:45:17 -0500)

----------------------------------------------------------------
Devicetree fixes for 6.4, part 1:

- Add Conor Dooley as a DT binding maintainer

- Swap the order of parsing /memreserve/ and /reserved-memory nodes so
  that the /reserved-memory nodes which have more information are
  handled first

- Fix some property dependencies in riscv,pmu binding

- Update maintainers entries on a couple of bindings

----------------------------------------------------------------
Chris Paterson (4):
      dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro
      dt-bindings: pinctrl: renesas,rzn1: Change maintainer to Fabrizio Castro
      dt-bindings: pinctrl: renesas,rzv2m: Change maintainer to Fabrizio Castro
      dt-bindings: clock: r9a06g032-sysctrl: Change maintainer to Fabrizio Castro

Conor Dooley (2):
      dt-bindings: perf: riscv,pmu: fix property dependencies
      MAINTAINERS: add Conor as a dt-bindings maintainer

Lucas Tanure (1):
      of: fdt: Scan /memreserve/ last

Michal Simek (1):
      dt-bindings: xilinx: Remove Naga from memory and mtd bindings

 .../devicetree/bindings/clock/renesas,r9a06g032-sysctrl.yaml         | 2 +-
 Documentation/devicetree/bindings/i2c/renesas,rzv2m.yaml             | 2 +-
 .../devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml        | 1 -
 Documentation/devicetree/bindings/mtd/arasan,nand-controller.yaml    | 2 +-
 Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml       | 1 -
 Documentation/devicetree/bindings/perf/riscv,pmu.yaml                | 1 -
 Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.yaml  | 2 +-
 Documentation/devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml | 2 +-
 MAINTAINERS                                                          | 1 +
 drivers/of/fdt.c                                                     | 5 +++--
 10 files changed, 9 insertions(+), 10 deletions(-)
