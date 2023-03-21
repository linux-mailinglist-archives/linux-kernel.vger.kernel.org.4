Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707616C3ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCUXxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCUXxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:53:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC2658B74;
        Tue, 21 Mar 2023 16:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD9BDB81AB8;
        Tue, 21 Mar 2023 23:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAECC433D2;
        Tue, 21 Mar 2023 23:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679442806;
        bh=nZcWtrnvUENMdJls1cCb4n1S+DLhWd2T2Qa8EAikTqE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=P/8HhZDceLjYkoL0Fm5ngMBupIoI+lhtAponOMcoXyNL3fn15za7sctuewb5Gxhxb
         67klz/FlOWs5ZFiCsVfb85OCN/T76shqpAf4bNowam9I3tUDT6mcTVb8WuzjEsz2cO
         ZgH1lm3mdMSTsDROYtmPd8yG4IBC7BSbB4ZUp7VDJY3vWZwQ2RXOKhwDQILuKJd4lQ
         Coxp4/CGaO5BAEiFy7s3S5fxfjocr99X4GGGngC6hjzdNnYYXF787uDdkkU+JwAB3b
         YPtfnNOlr9aycpb9mrrdLRu/T9bZYHEkKaWx9DAOz8aJkh+xtoSM2g2orxi/CeIjlw
         8BUBm/26mPRHQ==
Message-ID: <21fc28cccf3b9fa64428ddc9085deb63.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221209152913.1335068-4-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com> <20221209152913.1335068-4-marpagan@redhat.com>
Subject: Re: [PATCH 3/6] clk: socfpga: use of_clk_add_hw_provider and improve error handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 21 Mar 2023 16:53:24 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Pagani (2022-12-09 07:29:10)
> The function of_clk_add_provider() has been deprecated, so use its
> suggested replacement of_clk_add_hw_provider() instead.
>=20
> Since of_clk_add_hw_provider() can fail, like of_clk_add_provider(),
> check its return value and do the error handling.
>=20
> The err variable unnecessarily duplicates the functionality of the
> rc variable, so it has been removed.
>=20
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---

Applied to clk-next
