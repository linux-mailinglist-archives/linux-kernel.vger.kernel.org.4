Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43A1738E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjFUSJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjFUSJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:09:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B821BEF;
        Wed, 21 Jun 2023 11:09:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA226157D;
        Wed, 21 Jun 2023 18:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D568CC433C8;
        Wed, 21 Jun 2023 18:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687370958;
        bh=PlIasYKsQ5UvEaRDORwyujyoektYVWvqdQghCpADg04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6Vgh1/aK4fRzJPkXw4ZESR7yNMJPTkjUHEAEgvBAcABQCXTNXcam/KqLa2GaIPx5
         2dpHk2PlLITXDx6+Dq6Y/qo4vMPRGH0dSSfsQzJo1eAhUu2Z0uG1443w4ExNNP3WpA
         g1dNgEnsLTvCsLLY33fN5ptubv3JLuUkgJZ73JbAoGz+r9ldfDcvC9zaoRozMkVHSN
         3m94LiJEq/mx7YLWvEafCexjXov+bVQk9PeEjssZ5EIzpX3W9MUc5DePDGaIDAHm/6
         1IioQDCOgnZNqzObJs155htf1Hxp/pJROkTGNMhhxTcd5EcsRAPWijVqJGH7vX0U0B
         6hItlgwNaB08Q==
Date:   Wed, 21 Jun 2023 19:09:13 +0100
From:   Lee Jones <lee@kernel.org>
To:     Raymond Hackley <raymondhackley@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: sgm3140: Document richtek,rt5033
 compatible
Message-ID: <20230621180913.GS10378@google.com>
References: <20230602130644.259933-1-raymondhackley@protonmail.com>
 <20230602131009.260239-1-raymondhackley@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230602131009.260239-1-raymondhackley@protonmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023, Raymond Hackley wrote:

> Add devicetree binding for Richtek RT5033 Flash LED charge pump used for
> camera flash LEDs.
> 
> Signed-off-by: Raymond Hackley <raymondhackley@protonmail.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-sgm3140.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
