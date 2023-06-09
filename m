Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97793729051
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbjFIGo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238506AbjFIGoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E535B7;
        Thu,  8 Jun 2023 23:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 714AF6540A;
        Fri,  9 Jun 2023 06:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E16C4339B;
        Fri,  9 Jun 2023 06:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686293048;
        bh=7CRV//bpqPgpX7M+VfN7tuQw2P3TtlCTk0uKjILu+k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EnHauCcS1OVpscQjPOWer/ZB/CSa4Fx/iR3BDV0g6iX0u0OvWl+Svh28/suCPrumV
         lg2aByRBvTE9g493FnllENDS3tdFWfazGPpyciXRQk5yv3Oeu4gao0QYNoNsnXbLSu
         fVMztjjqM0bNtcVAxnpnYF3n7sbdmhiFbeigAUvgKcVYgeNFKiMHpaf/UtgLXNLFPi
         T3jPTPr3FL1JOWhKBvakK4CCJjrBitWM/PgsOHRFe7o8mhYTmrtO0fdUjkVOnrRDWM
         P8TVDmi/AgKZU93l8IeT1PFv0U/6UxYYvL+WS4KYK11qsNd4fkjFZIh3XBJHq/uSFK
         zHBCrCL/QjT2w==
Date:   Fri, 9 Jun 2023 07:44:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     pavel@ucw.cz, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v3 7/8] leds: leds-mt6323: Add support for MT6331 leds
Message-ID: <20230609064403.GJ3635807@google.com>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-8-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601110813.2373764-8-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023, AngeloGioacchino Del Regno wrote:

> Add the register offsets for MT6331. The hwspec is the same as MT6323.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/leds/leds-mt6323.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
