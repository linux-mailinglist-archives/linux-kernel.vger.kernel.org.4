Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291B470141D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 05:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241744AbjEMDKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 23:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjEMDKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 23:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184514C10;
        Fri, 12 May 2023 20:10:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A99EB65318;
        Sat, 13 May 2023 03:10:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922B3C433EF;
        Sat, 13 May 2023 03:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683947440;
        bh=yQiUbeqdfG9AE61EjmIS9LYWcW04Cq4yAB6gq7kg24Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WJtRcgb3Ip4RmZmX64eAuk8FPL3nLcSsIKIdYpRW/Sg9i+2fY3E2QrRB/3I2fZQ0n
         UBpRR4BDkCYbye1UZValfrUKLHgqZSGFB5WNqTmLloDbSguvaX01e52w1ehcRXdhhb
         xpXmvOxvWdhTIhOfKQG//ZFNB7hgNTsEPdxfpqqUQ6bBd3+61JcM8d1IQIGro27vdN
         x1R4wxJCs9mx/6ByrqjY9Ny2K4prokzLhX1fSSMDijEoqsLVWaW/Ui5g+Gd7e0A/fL
         hTVKMTxFgpi9hWXJeq3FofgH4xRM9oODvujQ2Xy9fSn1Mtbh00nAO9ko/LxR/wTfBQ
         n5urQl+7G+0RQ==
Date:   Sat, 13 May 2023 11:10:27 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/4] dt-bindings: arm: fsl: Add Marantec maveo box as
 a DHCOR i.MX6ULL SoM based board
Message-ID: <20230513031027.GA727834@dragon>
References: <20230407104943.5794-1-cniedermaier@dh-electronics.com>
 <20230407104943.5794-2-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407104943.5794-2-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 12:49:41PM +0200, Christoph Niedermaier wrote:
> Add Marantec maveo box. The system is used to get a smart conntection
> to a door drive. The core of this system is a soldered i.MX6ULL DHCOR
> SoM from DH electronics.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied 2/4, 3/4 and 4/4, thanks!
