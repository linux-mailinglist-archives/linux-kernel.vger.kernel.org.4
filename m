Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FCA674BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjATFQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjATFOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:14:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BDA2B28F;
        Thu, 19 Jan 2023 21:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A8F0B82498;
        Thu, 19 Jan 2023 14:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9EAC433D2;
        Thu, 19 Jan 2023 14:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674137864;
        bh=Ub7+BpDI8pbldr8h6coNNOTxSsE0eO00I8v8ShlQ32c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atVFTvAI6uwoH5ovmOoTs+0dyVBgtLYbb07M4wXWVLkhGskb+zpb5DQ2i8PXwOIve
         syECb49nftFmT0P2Pmh8YJQ8lUfjv+WDjDjy/a44kPBdFYuRS/d8iglZgHuBewMLXY
         gnjsWkOGHSorlSgZW8ZtDlINK8ZMpBWa8R1UClNRD4K9e3FSNHX4pYzyxFoD5zjYMF
         UVWGvgWvG/htcl0rP2H2lbQRlZJgqTg60EwnkcubYGFmAI0psdBa1e0369Hcv3sDK/
         v4XlpXgWVmZUcEeEsf7RqB6c0mJncyIj9jMCoxm1P7a8CVFp2ulIMqQs6gPVxUlwOw
         SdfnkAtk9OhWg==
Date:   Thu, 19 Jan 2023 14:17:32 +0000
From:   Lee Jones <lee@kernel.org>
To:     Brad Larson <blarson@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, brad@pensando.io,
        brendan.higgins@linux.dev, briannorris@chromium.org,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        davidgow@google.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v9 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando System Resource chip
Message-ID: <Y8lQ/G2OcjpXqNTt@google.com>
References: <20230119035136.21603-1-blarson@amd.com>
 <20230119035136.21603-7-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119035136.21603-7-blarson@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2023, Brad Larson wrote:

> Add support for the AMD Pensando SoC System Resource chip using the
> SPI interface.  The device functions are accessed using four
> chip-selects.  This device is present for all Pensando SoC designs.
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
> 
> Changes since v6:
> - Instead of four nodes, one per chip-select, a single
>   node is used with reset-cells in the parent.
> - No MFD API is used anymore in the driver so it made
>   sense to move this to drivers/spi.
> - This driver is common for all Pensando SoC based designs
>   so changed the name to pensando-sr.c to not make it Elba
>   SoC specific.
> - Added property cs for the chip-select number which is used
>   by the driver to create /dev/pensr0.<cs> 
> 
> ---
>  .../bindings/spi/amd,pensando-sr.yaml         | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/amd,pensando-sr.yaml

Please change the subject line - this doesn't appear to have anything to
do with MFD.

-- 
Lee Jones [李琼斯]
