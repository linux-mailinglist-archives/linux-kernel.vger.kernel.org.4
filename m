Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA560285A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJRJ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJRJ2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:28:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BA0AD990;
        Tue, 18 Oct 2022 02:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D32FB81E0F;
        Tue, 18 Oct 2022 09:28:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95968C433D6;
        Tue, 18 Oct 2022 09:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666085310;
        bh=FNvybaaMSsU92LM//vA2J3d3Vos299Q6dH/tB2HZSFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BoMPy1FAOHq5BZA2CnEyws5/nBk29uNnj7pXHtFvQmOdEpi6SEsgzOrizDu+lJdiU
         s6PEmpn4evaWY+VO1JHdctD1qpmgc2AG3rXYwhMbY9a1QB1UcmiwgE6QOkJ/Yn9+xe
         CvU2UAgk/Yg0CPuFjJFicRyODN+e48aB4oDn1K6sR3we7H8h6PsqrfFeW8BHhWerl4
         oxYxdfIHQIiQgCFoQXFU64r0ENhw1xxy+TAm8/G3XrfKPeCsSFfYarQDh0wzQD4PsP
         mZ/k7OB6nOD/inO41U8TiEH4W0TEMFJerIrbcWF7KScIXwpNDAVlneIu9yyCHUK0Z7
         ofC29dlwbBrwg==
Date:   Tue, 18 Oct 2022 10:28:23 +0100
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     ChiaEn Wu <peterwu.pub@gmail.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, chiaen_wu@richtek.com,
        matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org, cy_huang@richtek.com,
        sre@kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: mt6370: fix the interrupt order of
 the charger in the example
Message-ID: <Y05xt+r2tPmfJbcq@google.com>
References: <fcf4e7e7594070a8698dc0d4b96e031bcaa9b3a3.1665585952.git.chiaen_wu@richtek.com>
 <166558333754.1988433.10175192101178879616.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <166558333754.1988433.10175192101178879616.robh@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Oct 2022, Rob Herring wrote:

> On Wed, 12 Oct 2022 15:08:14 +0800, ChiaEn Wu wrote:
> > From: ChiaEn Wu <chiaen_wu@richtek.com>
> > 
> > Fix the interrupt order of the charger in the binding example.
> > 
> > Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> > Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> > v3
> > - Add a 'Reviewed-by' tag.
> > 
> > v2
> > - Revise the commit syntax.
> > 
> > v1
> > - Due to this patch modifiacation
> >   (https://lore.kernel.org/all/20221001202918.me7z2qzm7cmrkzsg@mercury.elektranox.org/),
> >   there will get some warnings in linux-next when compiling the dts.
> > ---
> >  Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> Applying to go into rc1 along with the other mt6370 fix, thanks!

Fine by me, but please change the subject line to start with an
upper-case char.

-- 
Lee Jones [李琼斯]
