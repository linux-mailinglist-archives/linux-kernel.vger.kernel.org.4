Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC0C5F0BD6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiI3Mkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiI3Mkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:40:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256DAD7B3A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:40:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADE0AB8289D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F90C433D6;
        Fri, 30 Sep 2022 12:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664541645;
        bh=JaemdEB8Tz0oLNGh2q7yrWCufRhyktkyw9BpZMOIDuw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T6RakQqxYSkyYzDNBanm9oPDbcZY3fBjEHy8fajXEA62mTfBju9w9zaxdOL6sksjs
         rYKUkvaLtEJrED0EPGa85/BUjrL54obsJmBsv9oMYR8mebIDKB1n9PAthuYcLInkta
         u6GaXPIfoQ+pM/0c1pwdPXcWmrKBDmR4uHUOb4DEPfAvU/5e8N7IKXg4lXhrMpQ73U
         4FdxHrtv6hy4GorQ48xOMwmS7X8cjaPIiK/w71fukYFGgH5mhTWEryg5GZRP7ez+uH
         z2PzJYnaansTQTTXEUYs1WZjoodq4imyvVQR3SHM/ZPYIEOLSaKnXrXM2qHgu6L3o0
         aHVgoA+3LS9PQ==
Date:   Fri, 30 Sep 2022 14:40:40 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Josef Schlehofer <josef.schlehofer@nic.cz>
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Add channel labels for
 temperature sensor
Message-ID: <20220930144040.666a6090@dellmb>
In-Reply-To: <20220930123901.10251-1-pali@kernel.org>
References: <20220930123901.10251-1-pali@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 14:39:01 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> Channel 0 of SA56004ED chip refers to internal SA56004ED chip sensor (chip
> itself is located on the board) and channel 1 of SA56004ED chip refers to
> external sensor which is connected to temperature diode of the P2020 CPU.
>=20
> Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x ro=
uters")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>

Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
