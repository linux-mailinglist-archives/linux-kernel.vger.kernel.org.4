Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E756C3ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCUXx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCUXxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:53:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0749032E50;
        Tue, 21 Mar 2023 16:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 022B7CE1B99;
        Tue, 21 Mar 2023 23:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185C9C433D2;
        Tue, 21 Mar 2023 23:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679442797;
        bh=cBjjSOfHwPZ8l7Csyk1X1ttp+Lka5LMHXhGlYenaST4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=O8InedzoAjAsl6CF6Ome3oAecvlAJhsQToRdAMQC25ySQxSf2R5TE39EXM5P/euSK
         G7pPojzWoeEOw6/92lB7eeiIiIrSW9nzwvTDaeCwY3s0umjvM8et1LCMQZiUQXZuGx
         t0DWBqaymZOspEueCmyHth1i2pyO1a0P3eRxMPUjY4Vvg8KRCUaRizFbPLWSp+ScLr
         zJ8Cy4b/3bb02tAsNXxY0Gx3ZGoj+THPIzieUYOv+4jOR/4rTTkPFowA8l3l+4oAHB
         ojbwbRPTmv/XBrGet3sm1QT9mNH9z3jwFqpndSFA7FugQZTfF8J/H5bHABemg0GjXq
         4m4hLEjKj9SNg==
Message-ID: <1a97927afe8c269c381a12b8b5aac552.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221209152913.1335068-3-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com> <20221209152913.1335068-3-marpagan@redhat.com>
Subject: Re: [PATCH 2/6] clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 21 Mar 2023 16:53:14 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Pagani (2022-12-09 07:29:09)
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
