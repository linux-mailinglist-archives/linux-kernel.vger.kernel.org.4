Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2C4612146
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 10:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJ2IJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 04:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJ2IJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 04:09:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D265B1E3;
        Sat, 29 Oct 2022 01:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CD7560C98;
        Sat, 29 Oct 2022 08:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7AEC433C1;
        Sat, 29 Oct 2022 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667030980;
        bh=UC4z7mu5pZBDxzC29j4d1dHYgaV/4A8mo2vnnjbI1hk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bl3TUf0DbYKMSx03+g8tji24xoc7DrnnG+jxxNFR7p1eipwY4BYZxvpyCE2z2P+tQ
         bDB5f+nJVPrskMHgGPypzIfbjsUmUciLRXYT0gaczfMPV520yR0dTgtyRYAyHrWwAU
         NyL1P0BxAeBPHOm2K00RMRXRlHBj8Xhsz37pH2KBZj2f6b6TuWvkZjyV5/7m/xnmPy
         P8d5OyO79KypIive1O82ANixS6zE/wtdWwLWxNF9XFy7Fu+smffc1pkV3N8AwmDKNB
         /CDM5opgSjfZVSisTeqV2YUaimijCuBG4TVyA03IsSRWufXPgxidm3boJDWY2dU0B7
         aK67DdBgmcYiA==
Date:   Sat, 29 Oct 2022 16:09:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/2] imx8mp: spi: update binding and compatible
Message-ID: <20221029080933.GP125525@dragon>
References: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 06:31:56PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP ECSPI reused from i.MX6UL, so update binding and dts
> 
> Peng Fan (2):
>   dt-bindings: spi: fsl-imx-cspi: update i.MX8MP binding
>   arm64: dts: imx8mp: update ecspi compatible and clk

Applied both, thanks!
