Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434F56662E0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjAKShh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjAKShd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:37:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AB7EE04;
        Wed, 11 Jan 2023 10:37:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B3B461DB1;
        Wed, 11 Jan 2023 18:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B28C433EF;
        Wed, 11 Jan 2023 18:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673462252;
        bh=576SEdDOHXhYoUIgnxE+yGWSRtull3XcBKtrmzbOEf8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=KKAoYr6n7Z4ZwKhCtcgysV52ra4x1GiVba5yd8drH9I/4etVMMztv2/SJ/EBo2+QN
         +jbsHeU3F25WT6HQ+yZtWHG+wKPlyCaFqyHCKvYGJsfETqhqXDK7Rqbk3jkEesv7Hx
         3i+B2cuAFDP8hDqhwf3XoJUll/GnGC4vAtEuZrGUksBXr8FGHQqsbiiSH9sgV96//y
         FG8CE1uHWFLkfNoLp7jvKfAzEN7wV97wqsvpasyns5JQWICi9vd0lKwMI/lj4XRAeS
         vXhHtpz5pM6EbH1wq/RpHQfhca5J5A7lj0b91I8X3jiOA5qvfrs8Nhs13MR+n5Y4mT
         pcPgfMQppacgg==
Message-ID: <57d1f58c4c6cca793d629d5776b477d0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230110114540.2975540-1-me@linux.beauty>
References: <20230110114540.2975540-1-me@linux.beauty>
Subject: Re: [PATCH] clk: create write_enable file to control clk rate write and other dangerous ops permission
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Li Chen <lchen@ambarella.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Li Chen <me@linux.beauty>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 11 Jan 2023 10:37:29 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Li Chen (2023-01-10 03:45:39)
> From: Li Chen <lchen@ambarella.com>
>=20
> It's common requirement for bsp debug/test to change clk rate from usersp=
ace.
>=20
> Currently, we must define CLKOCK_ALLOW_WRITE_DEBUGFS then re-compile kern=
el
> to allow this feature. Let's replace it with a "write_enable" file to
> allow enable it at runtime.

Nak. This design is intentional.
