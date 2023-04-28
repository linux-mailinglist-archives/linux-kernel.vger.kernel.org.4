Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B3E6F2053
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346639AbjD1V6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjD1V6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:58:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21D440FB;
        Fri, 28 Apr 2023 14:58:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E32160F7E;
        Fri, 28 Apr 2023 21:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F46C433D2;
        Fri, 28 Apr 2023 21:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682719111;
        bh=fyWwakSKamoWNBAsYwbyvuqW/0ewVXkTXZQ8lUJsseA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uQio8dgE4Oo0GlzvhVvjk7riCfNA5RsK7ujWfKeyiZLiwqkgcLkYJ/oEWt+7By+Og
         oGX8VQArrWbIJDuYiAMNul82uh677cZmyiF4u7w3L53P2MZatL1mSHAxVGf6xMLo9y
         wlEvSOrO41yfkKDOh0a7DUpgGO4cTHY7jMz2uy52aXgwgxVekjQi9s9+oy4oX94jV7
         WetQxU7Eyn///07l6vlJKM2fIIiAsNItXyjagtT7nf4u8O+1gOvZJScmxlxm/fxfdd
         MFCE/vxdA4wSK+U59rv0nhH3po6Ux5jUAgn0ePfdMMALVsyZGgGz/SvlbKN0/RJp7F
         mFw4cmQz0eFRw==
Message-ID: <6415cfbf0d89bd286b9ce36775125b4d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230420080154.2356480-1-suhui@nfschina.com>
References: <20230420080154.2356480-1-suhui@nfschina.com>
Subject: Re: [PATCH] clk: Remove unnecessary (void*) conversions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suhui <suhui@nfschina.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Suhui <suhui@nfschina.com>
Date:   Fri, 28 Apr 2023 14:58:29 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Suhui (2023-04-20 01:01:54)
> No need cast (void*) to (struct hlist_head **).
>=20
> Signed-off-by: Suhui <suhui@nfschina.com>
> ---

This is https://lore.kernel.org/r/20230316075826.22754-1-yuzhe@nfschina.com
