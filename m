Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BF0730C81
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 03:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbjFOBGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 21:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFOBGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 21:06:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C8F2697;
        Wed, 14 Jun 2023 18:06:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29FA261CE4;
        Thu, 15 Jun 2023 01:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0BDC433C8;
        Thu, 15 Jun 2023 01:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686791202;
        bh=WVphbQvdDrewsJtwZkZ80s7KmaaKA7azPVcrm38R+bQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=D+fq+e6pBYZwX9xBEzVU81AIi0zmvAbqObVJWbFlBbsNLwSSLgXGjKPvWRaIGIh4V
         d0YvtcA3sQ55z/Y+MNCWtPhBldCFXi5pKdLWIN32vcnzZmZX0DrgQc9YHXTNJZ9xiA
         jaB+xINyHEWc+3PFMMCw94nHHl4hPJmXH0OXCYdJPcPok3/J6UqiTInHOqKcci9ckG
         xO22qGeSDHNohl9HArAsOBy/GsQw/mVtyTivLEcr4eTw3MwjVGOb8qDPiELlYCglNj
         8FCLsgkvuL/7MObkK7MHiYdiwisCoQfQNqoo9Nw9kidwEkR73lJGh5AQL387sBYitF
         XPq6smfNmrH3g==
Message-ID: <52e6278bb43511c5bccad41909c4423b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230510184305.v2.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
References: <20230510184305.v2.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
Subject: Re: [PATCH v2] dt-bindings: rcc: stm32: Sync with u-boot copy for STM32MP13 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     gabriel.fernandez@st.com, gabriel.fernandez@foss.st.com,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 14 Jun 2023 18:06:40 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Patrick Delaunay (2023-05-10 09:51:40)
> Minor cosmetic change, aligned with files in U-Boot:
> - change obsolete SPDX id : GPL-2.0+ and use the same license
>   GPL-2.0-only for the 2 files
> - use correct mail address gabriel.fernandez@foss.st.com
> - remove extra space
>=20
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---

Applied to clk-next
