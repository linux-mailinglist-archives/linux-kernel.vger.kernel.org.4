Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015C06ECCFA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjDXNRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjDXNRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8DCE76;
        Mon, 24 Apr 2023 06:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1DA621EA;
        Mon, 24 Apr 2023 13:16:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF1C433D2;
        Mon, 24 Apr 2023 13:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682342217;
        bh=Qor63KPZKV7QHdfEndKbYPownrJfBHOA94uMZQ+6dJ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m2uDwGyD9Z7nkiTxLkKry8lqsUlqi69KK+ovYC7R0Z67A5H+RqEYaifWly6G9aUtp
         usw62JHz7T5cuvFTm1Cr2f9niePFXg9+peOrKyBnPPG9MICVZJw0wX42xETSEvU+ZX
         V9cMEJm+iRxQsJjzJ7lKcVGsL9ACGdEob+610fUPC7pK/IHjch/lZgOVHtdSsAOp8l
         nI7Vp2T6xzkC95AU/Wxm4AqTCwr+OLxLbKwMWSzHm7KC8FMu5V5cL8t59zFFA/8e4s
         yoT0mW7YEg8wq6vEhWJpg49XjlSGrpv49o9j3gjJeHZp9dNfS65+qCcOi56XTu6kQi
         Z8JtKr1xa8euQ==
Date:   Mon, 24 Apr 2023 14:16:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/2] dt-bindings: leds: Add ROHM BD2606MVV LED
Message-ID: <20230424131651.GD50521@google.com>
References: <20230419111806.1100437-1-andreas@kemnade.info>
 <20230419111806.1100437-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230419111806.1100437-2-andreas@kemnade.info>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2023, Andreas Kemnade wrote:

> Document ROHM BD2606MVV LED driver devicetree bindings.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/leds/rohm,bd2606mvv.yaml         | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/rohm,bd2606mvv.yaml

Applied, thanks

-- 
Lee Jones [李琼斯]
