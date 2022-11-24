Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79861637E55
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 18:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiKXRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 12:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKXRen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 12:34:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375A2FA71D;
        Thu, 24 Nov 2022 09:34:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5E96621B1;
        Thu, 24 Nov 2022 17:34:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F332C433C1;
        Thu, 24 Nov 2022 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669311281;
        bh=ZimMhVjHA71uL0p/U9neQ/CDzc18IyUZBXeajOZUTeE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6G06OHkw6Lw76Ptb8RrcCNwrJORwJ0uxyvjribBoTqmMheB4hPy0a1LCCFhLyRg0
         NP4ZXhreHKZTWxkZ/xT2si1pC9MOQpzU5At5vRRTLQZii1ZGr20tojcpR9GhRJ7/Qy
         GX9CehQ3oyGxNq60W8s+JdwLzIIL7hG6pPNP8prgRtxvcXn8M78Lz+3kTFNHaeh6DX
         /yakbGdGyI0Xz0t5T+ekmfq18y7mTjksrWU1ruQFv46WoTMZvGoUpigKE7CXcZe6cd
         g3EWvyFhNs4SbgLi4Ou0VJXfQBj04dULk2mtiZ4BbttmkF5GlIZTQWQerdZl+vUqFR
         YMHR6F1AaVhIQ==
Date:   Thu, 24 Nov 2022 23:04:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 0/8] phy: allwinner: phy-sun6i-mipi-dphy: Add the A100
 DPHY
Message-ID: <Y3+rLe4xrnR/Mmo3@matsya>
References: <20221114022113.31694-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114022113.31694-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-11-22, 20:21, Samuel Holland wrote:
> This series adds support for the updated DPHY found in a couple of
> recent Allwinner SoCs. The first three patches fix an omission in the
> existing binding. The remaining patches add the new hardware variant.

Applied 1 & 4-8, thanks

-- 
~Vinod
