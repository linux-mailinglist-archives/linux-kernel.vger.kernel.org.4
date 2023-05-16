Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93777704EA2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjEPNEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjEPNEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C2949D4;
        Tue, 16 May 2023 06:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B8F4639E0;
        Tue, 16 May 2023 13:04:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4797EC433EF;
        Tue, 16 May 2023 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684242244;
        bh=VdqrGbdfxEFS/5J2JfzncnbQSVDrzAf7yrXeYtQkJDs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eU0fLyUF+iHfuBBjE6jPPhHzUuRLHz9TD24pWt4Mr65p2J1Bq7XiwpnidUWVY4Puj
         k3TfnR5y0qwVHujY/yCawxLKIBwqf5ovtUAE1BB/vSwk91jHa16v9S9FHa2NcgCI2l
         ZfOyqs6WQChh8WjrGWLQ1+uresXVQZbbmBn9XwC4PucQnXatCBBXm+VS2PELznSbWH
         0GtcfnmMdVxHOct08d5q/XniLBDkg75aRH09sBBe7V339A2O0b5BMoFuEH4gxVQXhe
         UsEnpjlcZ9Auiiw64UTq9zIzWyhsB7lX7UttAhq+DNOYMtLYnJxIU0qm8ZG1rlM82Z
         xMK/d3yBRYBAw==
Date:   Tue, 16 May 2023 18:34:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 10/13] phy: amlogic: phy-meson-g12a-mipi-dphy-analog:
 fix CNTL2_DIF_TX_CTL0 value
Message-ID: <ZGN/QA5ZeVS459Og@matsya>
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-0-2592c29ea263@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-10-2592c29ea263@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v4-10-2592c29ea263@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-23, 15:11, Neil Armstrong wrote:
> Use the same CNTL2_DIF_TX_CTL0 value used by the vendor, it was reported
> fixing timings issues.

Applied to phy/fixes, thanks

-- 
~Vinod
