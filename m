Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062EE701B6E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjENDxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjENDxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:53:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3421BE4;
        Sat, 13 May 2023 20:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 304D660EAC;
        Sun, 14 May 2023 03:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC40DC433EF;
        Sun, 14 May 2023 03:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684036388;
        bh=jobHusBtFzwvMz7o7qUskX/4HkRYfWt1hcP7zNq2QcU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axds7qTPyj1HGMABR8Eo0NuGtIjqe1ci9vg2cWzPXyTkygX5Ycs8r/Z4Pcq2p6v2T
         j7z0D+ot+oCWpoiyQUS2C90hddNOH75x0zLxZn5pOJnv0YYAau3uxqCnoY5SID7x1z
         atsOegHNpUcv4ma4j1m9NakgoCLy2cxUWirUhSNG9lVXoan/iBBEzA4LCriNETpxDe
         y73x4D6rqMsIRzWQ4RqMowRNX+O2k805P38CrScqGsRQfbzAnZnWCSiEsiv38I1TOC
         HmwKDhGn5+0nfbM+MgVKZcQJAwaAsVd+KN1cNZk0tvJX7FpCpwLMRq6XRo2g9C/Nmq
         k6tnOUKYyYcyA==
Date:   Sun, 14 May 2023 11:52:58 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx: add missing cache properties
Message-ID: <20230514035258.GP727834@dragon>
References: <20230421223204.115500-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421223204.115500-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 12:32:04AM +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified properties to fix warnings like:
> 
>   imx8dxl-evk.dtb: l2-cache0: 'cache-unified' is a required property
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
