Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61FE67508E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjATJSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 04:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjATJSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 04:18:34 -0500
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DA5A94CBF;
        Fri, 20 Jan 2023 01:18:07 -0800 (PST)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id DF8062626D1;
        Fri, 20 Jan 2023 10:18:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1674206286;
        bh=0Jggag92EktR6/A5U6dVytzRh4SjEmFN+pZTvEn3QwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XYypUJNJga6pEulJFmkZ03itRN0tzmcvhtN1jqw8rJQX7n8/zEhjsNHE9ASxwIGh
         egzpfc9TIlyf99mfTLEsN6BP0eIz9KHUcD3hrlqIghum0bC4Y9q2PvTygLcD71RpYP
         NL+KIO1CfE8HXbGqVLjWYygmEm+GC0LHJyawOdP9a84o/Ub+WvvGYVqCsC0nw7Wy9o
         mwNCruhoUo7oWsZmPb81ywRPToh3iawGC36U5B29FHgmXp/ARfSeuro3wcyumy8/hO
         O42YzReF2LFY1RCtx6yKEzo1b7uLjusBf+/EV1Wku1xRWJ77v2w23NJuyH8QH0vV3I
         9iIsyjrCT+tQg==
Date:   Fri, 20 Jan 2023 10:18:04 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v2 6/6] riscv: dts: allwinner: d1: Add the IOMMU node
Message-ID: <Y8pcTPHjqXuWXmsR@8bytes.org>
References: <20230103010903.11181-1-samuel@sholland.org>
 <20230103010903.11181-7-samuel@sholland.org>
 <Y8F6NxYpJELbvogC@8bytes.org>
 <9a36551c-225c-137c-9376-ad7306c7f3d0@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a36551c-225c-137c-9376-ad7306c7f3d0@sholland.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 11:17:06AM -0600, Samuel Holland wrote:
> The D1/D1s/T113 devicetree is added by this series[1], which will be
> merged through the sunxi -> soc tree. That patch is included to show how
> the new compatible string is used, and that the driver changes have been
> tested. You can ignore it when merging the binding/driver changes. The
> rest of the series should apply cleanly to v6.2-rc3.

Thanks for clarifying. Patches 1-5 are now applied.
