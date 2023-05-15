Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9057703168
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242374AbjEOPUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbjEOPU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:20:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75D2689;
        Mon, 15 May 2023 08:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DA2F62614;
        Mon, 15 May 2023 15:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99843C433D2;
        Mon, 15 May 2023 15:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684164013;
        bh=CMyv0BbG/nqnjuXh/nR8ZgK3x0tXoUNldfxBkwatG6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1Y33+naUQzqLAijtVAXl7tPP+USJ5tkWkPAhUVWsJIileAq+s753jDrbRidgRtgj
         Y76Lctq7QjAkXzqvEti6TIDr0xfhpAWPuGrNLl7MF399QPanQkh1ItPxW4T5obDdpX
         /JESI9K90xrZgxQQfPve3uiNjb0YQhZppDoN1XBTnMVOCxrCb8GplI8D7F1emxeJ0k
         eV5beieNOCjBJUf7ceDpk9ArM+fk3UXrBs/aXSwhL+i/fxLPT3gRpzaQWGc09rXHfU
         CYvNshCOAyGakPaQwJfSG9TjgoILbEC/VoEYKC8SLc+vRRiLC2/1FTFrd+kT3BUu7v
         ogBXNhicJeOrg==
Date:   Mon, 15 May 2023 16:20:07 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 07/14] dt-bindings: mfd: add rk806 binding
Message-ID: <20230515152007.GS10825@google.com>
References: <20230504173618.142075-1-sebastian.reichel@collabora.com>
 <20230504173618.142075-8-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230504173618.142075-8-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 May 2023, Sebastian Reichel wrote:

> Add DT binding document for Rockchip's RK806 PMIC.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/mfd/rockchip,rk806.yaml          | 406 ++++++++++++++++++
>  1 file changed, 406 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml

Applied, thanks

-- 
Lee Jones [李琼斯]
