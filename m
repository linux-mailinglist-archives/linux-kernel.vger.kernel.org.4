Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0FD6D7F03
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbjDEORT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjDEORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC265B9;
        Wed,  5 Apr 2023 07:16:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E0EC628B0;
        Wed,  5 Apr 2023 14:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC0C433D2;
        Wed,  5 Apr 2023 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680704217;
        bh=6sSTihbp7P44lwSAC1Ce0D8/XwRsKhfginKjLZjCkaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNBXq3t3mS1/EbFLPR9QUvjjCKMCeP2FnLNgKoi2FeC+nS6FDNt17tLzEX5XAnijU
         1J6mLVky3QNuFgmSri5kQOxtte+TsR/KcOIsxjSsT+LQemRNYR8UbwuF4EsX+BGI8C
         ALDODJMX15df4arul+NEkH+jw604ohtieE9iag55Og7xvrpeSdPzMAc9KXT2tyxUbT
         WJRS8r2q2+eaFg7wourz9i1F8cXGeP3ZpTLEx3sYLiG1lSCQ2oNURAR7NwuSrkjj/p
         UgjZ7HgEoU+tP9zhT7We+iNSqT8TqwGnI1Gf3Dndki/EgWx+26ZW8/qpACctRSGI/F
         +nz9J9bBfEX4Q==
Date:   Wed, 5 Apr 2023 22:16:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V2 0/6] arm64: dts: imx8m: update pinctrl to match
 dtschema
Message-ID: <20230405141650.GE11367@dragon>
References: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328033640.1930104-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 11:36:34AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> During the System-ready IR 2.0 check, there are lots dtbs_check warning.
> The pinctrl dtschema requires grp in the end, so update pinctrl to address
> dtbs_check warning.
> 
> V2:
>  Add more update
>  With below script to filter out:
>  grep "pinctrl.*:.*{" ./arch/arm64/boot/dts/freescale/imx* -rn | grep -v "grp {"
> 
> Peng Fan (6):
>   arm64: dts: imx8mn-evk: update i2c pinctrl to match dtschema
>   arm64: dts: imx8mm-ddr4-evk: update gpmi pinctrl to match dtschema
>   arm64: dts: imx8mq-librem5: update pinctrl to match dtschema
>   arm64: dts: imx8mm-emcon: update pinctrl to match dtschema
>   arm64: dts: imx8mn-bsh-smm: update pinctrl to match dtschema
>   arm64: dts: imx8mm-prt8mm: update pinctrl to match dtschema

Applied all, thanks!
