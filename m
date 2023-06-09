Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8872904B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbjFIGnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbjFIGn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:43:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99343580;
        Thu,  8 Jun 2023 23:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA596518B;
        Fri,  9 Jun 2023 06:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCB3C433EF;
        Fri,  9 Jun 2023 06:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686293002;
        bh=AEbAo96XR77jp7lBbzHtyIYUJhXP+Oby6rYeaEku9F8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B/SLToL+KMPGhBMMoyClzVPJmAFOc3wG1277RQ3dXHH840+10sXl5IFTF3bNFDoCi
         x3NGl178WtaJxf+Zwbdj4/X5Gre+SOysJPvCeFhOGKjaXxjeqNiinL1h2+IMmZmmUM
         ou4rRHYOagCsqWjIQpK7UWl0O4sRXMZKKGrlzdSgX8uhMEb4GRTwWxjAllZCoqObIS
         XPUsfygiVW+nHkNlr4TWrF/nVQvB9jdaa7ecAgeUwvCB0tF7WyweJ9du4jlTSfr3Xj
         Q897lmc3msqpfxALB5TqB2hWCC/d/5eyl4pI8HxXkwt3hhamBQMWMmKGcoRgNCt/Mf
         pPj7083rK6blQ==
Date:   Fri, 9 Jun 2023 07:43:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     pavel@ucw.cz, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v3 5/8] leds: leds-mt6323: Drop MT6323_ prefix from
 macros and defines
Message-ID: <20230609064316.GH3635807@google.com>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601110813.2373764-6-angelogioacchino.delregno@collabora.com>
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

> This renames all definitions and macros to drop the MT6323_ prefix,
> since it is now possible to easily add support to more PMICs in
> this driver.
> While at it, also fix related formatting where possible.
> 
> This commit brings no functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/leds/leds-mt6323.c | 123 ++++++++++++++++++-------------------
>  1 file changed, 60 insertions(+), 63 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
