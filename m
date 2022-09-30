Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745AD5F140C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbiI3Uqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiI3Uqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:46:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1406C6976;
        Fri, 30 Sep 2022 13:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B25EB82A01;
        Fri, 30 Sep 2022 20:46:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F670C43146;
        Fri, 30 Sep 2022 20:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664570788;
        bh=61jsI8MOLGuKJ4Lu67pBRBhMgw36zql/e2pSmjbkWy4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bnZ3z7XrYvzJ9+B5ZNvmUZyhEyVOFqsb6uWP5OUsmRod2VXgHDjQmcUm2EEI+VFv8
         WR488+UtwJtHVGVl9nNOU9l3NNM9XJ5sdGqSe59IoXOwVsUKrPZPMEJI5rjNoeY5Et
         TnB7dwqtGe2GuH1TMyE35hzj4L9v3f/No+QH6/ayzlNov13KEuqtwFdENQeVFbFvT4
         iEh0hB5trjCB9AiLKxsJ3LxHBT69ifjc16i+W61ZnW9KrbPOR8wN8auzVGNBIcDESP
         vBIizweLF5UDpGvHpAu99p56l6k6dpcSn2XjYeQmadcoY2OarvrHmd2mhD9c3O5YNj
         ZWBVwnwiPBdhQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220905065833.1831473-1-13667453960@163.com>
References: <20220905065833.1831473-1-13667453960@163.com>
Subject: Re: [PATCH] clk: davinci: pll: fix spelling typo in comment
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     nsekhar@ti.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
To:     Jiangshan Yi <13667453960@163.com>, david@lechnology.com,
        mturquette@baylibre.com
Date:   Fri, 30 Sep 2022 13:46:26 -0700
User-Agent: alot/0.10
Message-Id: <20220930204628.2F670C43146@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jiangshan Yi (2022-09-04 23:58:33)
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>=20
> Fix spelling typo in comment.
>=20
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---

Applied to clk-next
