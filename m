Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995117338A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbjFPS6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345667AbjFPS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569BA3C1B;
        Fri, 16 Jun 2023 11:58:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFB7B63548;
        Fri, 16 Jun 2023 18:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EB5C433C0;
        Fri, 16 Jun 2023 18:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686941887;
        bh=DtJ6MEfQGUbmzMwMZgbo5fgJAAQ/9g22c+hNM7o6k/w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=G0QqvpmgLn3p05oKZb0waSp2Uz0hXCD5F/RB1plLHWLjfYGXIG8ZEB3F3UAl56ssY
         qb0m7XLoDCfBRUyhErvCZrO7Pdtn/39bN4gmzCW8Ou81LPFPyLTUuG/iK0CQx2p4bZ
         1sUiiTyjEekBkmimEOl9mpfETVZzJs6SIHbpaCfMLMi9p3499jXUM2hyauSJ6QQQEL
         sHMcCAIfyIBtti8Vc/yS83ZS4nuIGcrXvDA7Inbz0+DAGFqYjhK++kU0EgfBTU2XRN
         6XAkZeS3Mb45Bw1zeI3OK4o89JcW9lZqrwZX1tIZt6h/L2qEuJrxigD6xVrYmiE4xL
         13Sn68M1e1E/A==
Message-ID: <74082576ed3e48ed69f66e0f8998dd66.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230516184626.154892-1-afd@ti.com>
References: <20230516184626.154892-1-afd@ti.com>
Subject: Re: [PATCH 1/2] clk: keystone: syscon-clk: Allow the clock node to not be of type syscon
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>
To:     Andrew Davis <afd@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Date:   Fri, 16 Jun 2023 11:58:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Davis (2023-05-16 11:46:25)
> There is a helper device_node_to_regmap() we can use that does not force
> this clock DT node to be a "syscon" node. It should work the same in
> this case but allow us to remove the unneeded "syscon" compatible.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---

Applied to clk-next
