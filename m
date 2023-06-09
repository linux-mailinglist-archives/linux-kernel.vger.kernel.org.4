Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222172904E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjFIGoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238494AbjFIGns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C693583;
        Thu,  8 Jun 2023 23:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCB706518B;
        Fri,  9 Jun 2023 06:43:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FEBC433D2;
        Fri,  9 Jun 2023 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686293026;
        bh=OigEpXeDQ3rSjSeIS+qK5il4XD7oD1uJZU95Qjncfhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vQBKO7/FA/TCVQks52BvyricJiVPMBi09wi0+W4+I57MgVlaTg3P1F5bgIyIDlpUn
         r1UvjhUxxnsB/JpU0f8aBLGP3N1jYsVrLhVS3r5+ZmuLGJqzlr2qIewLNCney5ZZnp
         nLc5/cqVmh/CXFqxsd2KbfTX8aHIPw81h3bCCf+JOzZ4yAktdgQCwGCIJpDgi0ufqd
         Q6U4eZamVEdblQqjWIiJ6ClL+FvKAihGpEaIr6PYwU61nmbJ2wUA6OlWM+ApmAAh8w
         qvs74xLG3JT8mal+JRHaRA3OaCSFugqyqXXuAl2dya1+9Y2dG5v1c+hgczyyOiRcVH
         1bFw/0Cy/TIuA==
Date:   Fri, 9 Jun 2023 07:43:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     pavel@ucw.cz, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Alexandre Mergnat <amergnat@baylibre.com>
Subject: Re: [PATCH v3 6/8] leds: leds-mt6323: Open code and drop
 MT6323_CAL_HW_DUTY macro
Message-ID: <20230609064340.GI3635807@google.com>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-7-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230601110813.2373764-7-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023, AngeloGioacchino Del Regno wrote:

> There is only one instance of using this macro and it's anyway not
> simplifying the flow, or increasing the readability of this driver.
> 
> Drop this macro by open coding it in mt6323_led_set_blink().
> 
> No functional changes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  drivers/leds/leds-mt6323.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
