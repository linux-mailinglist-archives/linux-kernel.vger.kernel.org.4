Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD3C6F0AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 19:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244122AbjD0RT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 13:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243457AbjD0RTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 13:19:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97279102;
        Thu, 27 Apr 2023 10:19:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC1B63E74;
        Thu, 27 Apr 2023 17:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820BCC433EF;
        Thu, 27 Apr 2023 17:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682615962;
        bh=rOTwoERL2Dl5cmarh0a/Ds5UmVgUmPy7ngh1FKGKcFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LoJdG2JSCC1N6zOc+Q1aeqTbhkhB9c8piJOzCDejn62mY/auwRx1htDQxJs66GJW2
         eOTXBnW9fqvIRounJxNydmBvWqTQm2CTG9ulSOs7tzUJFv6+OItXyXch+9f7pJHer4
         qmt3/gAgXnAqoSJqf3YyNt7gzzjDlo0Gnmu+Wvc+YQ08VO/cEqSsau55Q9sYgs+OTn
         FI9Tz+uwWyzMHiZvFlvcXSFkck4ZvC2RFQvsDuwOW6DcquAWtp6OAASn97WON6A7nJ
         p+GncRN6gN59eKit6goynZcLA2tzbsfCweyg/G7eI7qaluaf1px8qv+CM4nNIPv4oq
         7Zi/fB60PKcYg==
Date:   Thu, 27 Apr 2023 18:19:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        andre.przywara@arm.com, conor.dooley@microchip.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: mfd: x-powers,axp152: Document the
 AXP15060 variant
Message-ID: <20230427171916.GH620451@google.com>
References: <20230421150816.10513-1-wiagn233@outlook.com>
 <TY3P286MB261177CF7AA2959BD9517DA998609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY3P286MB261177CF7AA2959BD9517DA998609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023, Shengyu Qu wrote:

> The X-Powers AXP15060 is a PMIC seen on Starfive Visionfive 2 board. Add
> relative compatible item and CPUSLDO support and disables DC-DC
> frequency setting for it.
> 
> ---
> Changes since v2:
>  - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch
>  - Disables DC-DC frequency setting (Andre Przywara)
> 
> Changes since v1:
>  - Move cpusldo before drivevbus (Krzysztof Kozlowski)
> 
> [1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/
> 
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

(not sure if I've sent this before or not, but just to make sure):

Applied, thanks

-- 
Lee Jones [李琼斯]
