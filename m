Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326466C3ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCUXxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCUXxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:53:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A33900B;
        Tue, 21 Mar 2023 16:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94EF861EE5;
        Tue, 21 Mar 2023 23:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E6DC433D2;
        Tue, 21 Mar 2023 23:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679442788;
        bh=u3FIUoADjtoydcrO6I/aan1rZmbX5WL1LF1a+25+YAU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h1Hu+DeUR3VZRZVBG2jNUJRWJu0N59GwVNc5RxyKN/BoFepQ+v7/623jG/Ui20DH+
         5VWLZYUaixBqgHl3Rv33CPCTIjYqfRyOKfujqfjP9ssGc8NImR+LbZ6FBNB28+2jGg
         pcgkiozLHv47BpRX6trD7iM64iSY6v+Zmk9WQRN/YtHKHsfkrMM2TF07MvVmtzpUQH
         XqssElxcEcxJV+dOkTiV29n9HwVZZCI/eckjHmpOxIPBCT84d9Hh1edGnJIGVECX1m
         ngKMkmzTKdWqANJ/xjBNfFV3yB3zdhd46RTvxpO6PSnYu0z9cHXm9wYMVQKjNl5VQF
         rb4islGZnEV8w==
Message-ID: <be4595e1b4aecd2f8f7c07f6f5503ef7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221209152913.1335068-2-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com> <20221209152913.1335068-2-marpagan@redhat.com>
Subject: Re: [PATCH 1/6] clk: socfpga: use of_clk_add_hw_provider and improve error handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 21 Mar 2023 16:53:05 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Pagani (2022-12-09 07:29:08)
> The function of_clk_add_provider() has been deprecated, so use its
> suggested replacement of_clk_add_hw_provider() instead.
>=20
> Since of_clk_add_hw_provider() can fail, like of_clk_add_provider(),
> check its return value and do the error handling.
>=20
> The indentation of the init function parameters has been aligned
> to match open parenthesis, as suggested by checkpatch, and the __init
> macro moved before the function name, as specified in init.h.
>=20
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---

Applied to clk-next
