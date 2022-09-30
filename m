Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0515F1409
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiI3Uq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiI3UqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:46:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4E17E00B;
        Fri, 30 Sep 2022 13:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8AE6B82A01;
        Fri, 30 Sep 2022 20:46:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891BFC433C1;
        Fri, 30 Sep 2022 20:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664570764;
        bh=I1/gS0JlirI7nfxeveJPESvWNaj3A/j9Ok35hZQRkH4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pYuVONRDldbd2KWgJJF6Pz6XkBY327uAbE9hAUswQ60/+i7SGA8+Sxg2pOdr7/z/y
         uKaa+OHa0z9gQQtgDdbcnkmjCwt4re4C3QUajFjqaPBJb4o3mTN8PQdFZvYYOMrJ0X
         oHAoFfGxcHA8+n4S5dyuW7R/62CYRl+ktpIWQlYKgXbmWExNxWMBewiGDmTSr44I15
         pqlvU1GJQKAdo5qEEs6/Rmjg3CoitShqWHMXRUPZVBjFz6tsB9ccwQ+KkFpMtbRD3z
         z6k0L5QCEi+ttNlNvbad7GldQr64HpolW5rTDRMKAWwNz+SQxVAqyEffA7befn7UBq
         cgn5KDEb3BeIQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220720110026.9173-1-lukas.bulwahn@gmail.com>
References: <20220720110026.9173-1-lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add header file to TI DAVINCI SERIES CLOCK DRIVER
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     David Lechner <david@lechnology.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org
Date:   Fri, 30 Sep 2022 13:46:02 -0700
User-Agent: alot/0.10
Message-Id: <20220930204604.891BFC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lukas Bulwahn (2022-07-20 04:00:26)
> While creating a patch submission on the davinci clock drivers, I noticed
> that the header file include/linux/clk/davinci.h belongs to the section
> TI DAVINCI SERIES CLOCK DRIVER.
>=20
> Add a file entry for this header file in TI DAVINCI SERIES CLOCK DRIVER.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---

Applied to clk-next
