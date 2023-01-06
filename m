Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909F565FD5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAFJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjAFJOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:14:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620826699A;
        Fri,  6 Jan 2023 01:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF9461D62;
        Fri,  6 Jan 2023 09:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A680C433EF;
        Fri,  6 Jan 2023 09:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672996488;
        bh=6a7N+091Z6NCe1Be8JsUKIhRH9rci8z3cmchqgVEigE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BUMsHkZz1lYN9STpZyZGWwVU7YfTytLh7rWqDfzATZoW9apHfKBM8f70LdNTVyyxj
         k2znIHRXHZulaNnn+EMSvkumr1yJ3viIAiS/9WMbGuYt5qJiPhaRyM0fadzL0+zLWw
         8IeRBPRVh7YV8uqEiPG2rcnsEuKmk9XO/4z16EpHFPV0wBEKiiGBEYYeypznp4ZIuv
         6zF7m/ZTjHqof0FxdsKFPfvG9YtMaoQ84M1Nld5yoydI1NqM5X7IddNotsmlAMxCIk
         SjnCmmhv3Iuy4YZU+W+BBnDsv44Mg+XyIZYwy27ctrlGrBMQbyXK4XqYmKLZHCfkCh
         6LndsOj5WzRPg==
Date:   Fri, 6 Jan 2023 09:14:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: mfd: Add RZ/V2M PWC
Message-ID: <Y7fmgWzR5Pyu3O1A@google.com>
References: <20230105201242.189195-1-fabrizio.castro.jz@renesas.com>
 <20230105201242.189195-2-fabrizio.castro.jz@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105201242.189195-2-fabrizio.castro.jz@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Fabrizio Castro wrote:

> The Renesas RZ/V2M External Power Sequence Controller (PWC)
> IP is a multi-function device, and it's capable of:
> * external power supply on/off sequence generation
> * on/off signal generation for the LPDDR4 core power supply (LPVDD)
> * key input signals processing
> * general-purpose output pins

The subject line now needs changing.

This patch doesn't have anything to do with MFD.

> Add the corresponding dt-bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> 
> v1->v2: I have dropped syscon, simple-mfd, regmap, offset, and the child nodes.
> v2->v3: No change.
> v3->v4: Moved file under Documentation/devicetree/bindings/soc/renesas,
>         and changed $id accordingly. Rob, I have kept your Reviewed-by
>         tag assuming you are still happy, please do jump in if you think
>         that's not appropriate anymore.
> 
>  .../soc/renesas/renesas,rzv2m-pwc.yaml        | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/renesas/renesas,rzv2m-pwc.yaml

-- 
Lee Jones [李琼斯]
