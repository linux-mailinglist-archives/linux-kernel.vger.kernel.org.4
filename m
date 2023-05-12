Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647B3700FF4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239375AbjELUuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbjELUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A568A5E;
        Fri, 12 May 2023 13:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40DEB61585;
        Fri, 12 May 2023 20:50:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEC1C433EF;
        Fri, 12 May 2023 20:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683924614;
        bh=/Mn4L+a1/bgxrze0zB5CbsA1BiqgmzfxAOiw6lAL/JU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=QhMSm/GbIBE//aSYVXOIvzEU+a6W4bv+7cB9Q65hpH5Vy5D5DSz7cdwVw7LTbncVt
         6trrJEGFYSkrnK9xkm4BU7VV/pz0VffkF8gtwWho6aQyBHyBPKPzOuhxhwErvKecGu
         qhFvJ7TmiO3ntSrn4hueZkgjIRPoqezim3V1BqEOLS6KBwDTCRGqVTICWfgxHftMxQ
         fOGNgFcUCNXOybrmRsxPOLUc04IgvzshZ+fdXV+90cM9pUMqvZht5Uhvhg4lt2L2iU
         LAItQ/NI7koE+f7MN7XCfT6XP+3CTiPUIwzj/7ArhgxC2KnQElN6CrBpZUI/OqgWl2
         LnEyB/i+OL0Og==
Message-ID: <a54a4634fd5e161a1ac2697a388018db.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230506090856.3599035-1-peng.fan@oss.nxp.com>
References: <20230506090856.3599035-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] clk: imx: drop imx_unregister_clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        festevam@gmail.com, kernel@pengutronix.de, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Fri, 12 May 2023 13:50:12 -0700
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

Quoting Peng Fan (OSS) (2023-05-06 02:08:56)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> There is no user using imx_unregister_clocks, so drop it.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
