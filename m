Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A53C67C9FE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbjAZLca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236186AbjAZLc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:32:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AA15A808;
        Thu, 26 Jan 2023 03:32:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 813BB6179F;
        Thu, 26 Jan 2023 11:32:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6F0C433EF;
        Thu, 26 Jan 2023 11:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674732746;
        bh=5LI56qEJnEP4EBGBEbc7t1SLKpX35xZzrAGlI2ogiUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btakdesZgjNE2Lw0Br1w2NCjC+jyPlnsfQ4cro3TihnnH3k7Rgu/fIOFffNQHCyMo
         pci7xX+8sRXbS/qzcUMb5vzrMi366SjEdROru+ZFDPO6inxKoCbspa7YWWdRm0FACH
         YDsx67lsiGDu9tRo/dPgDohNqGaBuUV50gF51OU0fpCSbJfxifuXIACzgDATpdLjQm
         VUc6IfrSfy43FX2qvGPpVBu+/kVhAknI0O1Ky8Uhe62VlX+fkLCiV3hggVJCt/I5TZ
         j5PloavYjkYlJi0tUSzwJYfMxkQA0UFG1Cq0Krl5bLU6xo6l74M1JoTKZ3Sc+8m1Xq
         SH2qvjtXaiiVw==
Date:   Thu, 26 Jan 2023 19:32:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 1/4] dt-bindings: arm: fsl: Add PDK2, PicoITX and
 DRC02 boards for the DHCOM i.MX6ULL SoM
Message-ID: <20230126113218.GH20713@T480>
References: <20230122162013.4872-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122162013.4872-1-cniedermaier@dh-electronics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 05:20:10PM +0100, Christoph Niedermaier wrote:
> Add DH electronics DHCOM PDK2, PicoITX and DRC02 boards
> for the DHCOM i.MX6ULL SoM.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Marek Vasut <marex@denx.de>

Applied all, thanks!
