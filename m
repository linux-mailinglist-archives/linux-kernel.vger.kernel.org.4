Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2826C3ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjCUXyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCUXyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:54:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30405943D;
        Tue, 21 Mar 2023 16:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68764B81986;
        Tue, 21 Mar 2023 23:53:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F274C433EF;
        Tue, 21 Mar 2023 23:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679442836;
        bh=J6tFeM38IM7MOoSSdzpx3tQvMrfs/A8zdFZCKt/JIJc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BPdw1YKDmHoOOBMf6Tv9JUL7ZmShVwcA4aaoAzxIPH1UQs01Wn82/b+eMyzG7Gngj
         CpeUT0ivk6JKWv3j0wyWF4JzTuHFMQDeVGBCjLmxgL6FNYP1kg8ZXCivfVOieTKhMe
         KWtJL8/U+rpKUTVZnR8zsReDdr1FPcd8QMu4RUZWNtsWxozyUskrS3dX/OeVs6/SAx
         6hx8u61vKQyqDiMWX5nn2a8YkYTV0MG2dsv327eC/LotHf/4xFOs9ZNo+PDzz3YsKu
         fuQoEqepI2cuIHYq2o6IGC/m8Ti1RwlSWeCIvQQDrJzn6yNVcMLQNZrHXKOsvzgVyA
         vY/u2AfQ3ffbA==
Message-ID: <3d2a4063dfa82d49dd98ee8f615f3aec.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221209152913.1335068-7-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com> <20221209152913.1335068-7-marpagan@redhat.com>
Subject: Re: [PATCH 6/6] clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 21 Mar 2023 16:53:54 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Pagani (2022-12-09 07:29:13)
> The function of_clk_add_provider() has been deprecated, so use its
> suggested replacement of_clk_add_hw_provider() instead.
>=20
> Since of_clk_add_hw_provider() can fail, like of_clk_add_provider(),
> check its return value and do the error handling.
>=20
> The return type of the init function has been changed to void since
> the return value was not used, and the indentation of the parameters has
> been aligned to match open parenthesis, as suggested by checkpatch.
>=20
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---

Applied to clk-next
