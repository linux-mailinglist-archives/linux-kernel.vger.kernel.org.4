Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4467D6929BC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbjBJV6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjBJV6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:58:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB197D3DF;
        Fri, 10 Feb 2023 13:58:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AC2561EB5;
        Fri, 10 Feb 2023 21:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861EDC433D2;
        Fri, 10 Feb 2023 21:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676066313;
        bh=5ibIyCABrPAbUMZu4ZZYAfh5cudEp2IOj9fkL3uGJlQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kRjYJMankEJHxSSDsxqqysxFDRI7fVFCWvCJbYbxK3TspCtIXIed9cy2fy+NL71lI
         U28PHesH5j+naWowkwrXn90Z6+52d5kAP9eow/5WQNiZZ/m9ogesUsgxB9g1e2h7XQ
         H7YT2Zv+0M0mU4tiwqK2ON8jDIUsX5GVuhLnKAQc313vMW3P6bT3+zhXHfG1yO0pIQ
         vxX94ahSygVaUVbavjWytrp7fwE+YNtjaqC25jDvXKeaEhdc8bOAIj/giQuGB932nf
         fk8LmAfctlDMFiFqO787bMhNToAeBU+ipLQT+Gyz6fZPK7oL8i96fMgLE0ZDCK97MA
         yqvckq/OuOIpA==
Message-ID: <c69a8d1ac9ea69a9b5d026138b8bce09.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230205030138.1723614-1-trix@redhat.com>
References: <20230205030138.1723614-1-trix@redhat.com>
Subject: Re: [PATCH] clk: imx: set imx_clk_gpr_mux_ops storage-class-specifier to static
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
To:     Tom Rix <trix@redhat.com>, abelvesa@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, mturquette@baylibre.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Fri, 10 Feb 2023 13:58:30 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tom Rix (2023-02-04 19:01:38)
> smatch reports
> drivers/clk/imx/clk-gpr-mux.c:73:22: warning: symbol 'imx_clk_gpr_mux_ops=
' was not declared. Should it be static?
>=20
> imx_clk_gpr_mux_ops is only used in clk-gpr-mux.c, so it should be static.
>=20
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Applied to clk-next
