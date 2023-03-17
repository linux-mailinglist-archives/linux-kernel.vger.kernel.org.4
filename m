Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4652D6BDD99
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 01:29:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjCQA27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 20:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCQA25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 20:28:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04048298D7;
        Thu, 16 Mar 2023 17:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4CB01CE1D32;
        Fri, 17 Mar 2023 00:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B2DC433EF;
        Fri, 17 Mar 2023 00:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679012932;
        bh=3vJXnqBm00ZDstQ8uLx5XtAk2Rl5SQ7zjEvPgSWBmBo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BvP+XKEu613khmPNUON97fI8KB3YlzxNJDnrVmv0NBGlg6ft4RM5heQY5rV8nONpW
         svcubGvJF3z1RwI56P5ucnz+EEg3rBiKXLY4GVKZ/pvodNCi6nJ5QSaMR0hFWsCTiu
         PAWdu4w1Kj9UoVTPMvwSzAeeBjLmIBP+sEnlE90eOvW3Ru8moGvI3ROYShPGPKU4I1
         mJffXKukf4gyfBfPrkk1KHrIygCQGUrjjHvaYR4bnwdTR3Ke7RXR01LjWjCQchPLf0
         qoN0cgcU3WPtSEYD2qkzzouK4MKu5QJZAJbYEW8GQDF0wHrmaHI1krIGV/G72GtHzR
         nRiorYtQ0eOdw==
Message-ID: <08e3ad53673421caa01ae490813ec957.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230316075826.22754-1-yuzhe@nfschina.com>
References: <20230316075826.22754-1-yuzhe@nfschina.com>
Subject: Re: [PATCH] clk: remove unnecessary (void*) conversions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
To:     Yu Zhe <yuzhe@nfschina.com>, mturquette@baylibre.com
Date:   Thu, 16 Mar 2023 17:28:50 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yu Zhe (2023-03-16 00:58:26)
> Pointer variables of void * type do not require type cast.
>=20
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
> ---

Applied to clk-next
