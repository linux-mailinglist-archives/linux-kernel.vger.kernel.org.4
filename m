Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433086ECD03
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjDXNTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDXNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:19:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8D5524A;
        Mon, 24 Apr 2023 06:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F99662150;
        Mon, 24 Apr 2023 13:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B32C433D2;
        Mon, 24 Apr 2023 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682342336;
        bh=egByEsh99QiMwFqj0XPB1pixzLMefgI+kkBSqfo8+eU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s/9bUC8xClMHhpRuyVOb7yMeGB13hqyhaSnfuxjjrC/ip7TeuJYAdUzJV9QvvaBfo
         cXSRQJ+3s7nEsvM8KUQ+4An8X2SaNq6U0LdPcg46Kgop95iUyalpIk8uwAHH11N3ll
         Emwe37Dzr6PLR+UcMWskj33JgPI4HJGDVhRpQDyZejNvciZ+q/V3udjSVV5ATNiisY
         mAIZ4n+IGILZWkh2MzU7KHvMIdFqm61esQijuejwdYGsoLvn4Bcwdfvg9X19yNCcNN
         67MGL6MvlyErI15RkaQ+mYxF6aMq0BCPSNu5ldRGBsEh/Ne8suiq5YnUVAXrKNoUHU
         OGG2oRx1TKOZA==
Date:   Mon, 24 Apr 2023 14:18:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: mfd: ti,j721e-system-controller: Add SoC
 chip ID
Message-ID: <20230424131851.GF50521@google.com>
References: <20230418010019.1222431-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230418010019.1222431-1-nm@ti.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Nishanth Menon wrote:

> The system-controller node also contains the chip-id node that is used
> to identify the SoC specific properties. Add a pattern property to
> match to the same, and add to the example.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/mfd/ti,j721e-system-controller.yaml      | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
