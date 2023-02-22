Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3638669FFC0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjBVXoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjBVXoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:44:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34A8298CC;
        Wed, 22 Feb 2023 15:43:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8ECBB817C2;
        Wed, 22 Feb 2023 23:43:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B87C4339B;
        Wed, 22 Feb 2023 23:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677109436;
        bh=05zuIHUF2Jxq95BD3FXQmm8A1Va+9D4oc5j0eOsqeqA=;
        h=In-Reply-To:References:From:Cc:To:Date:From;
        b=GY9/KgHF+h9kBqfhUIkifXPZGMMzLXOxSO4GCaH+oCYE6msOoKyI7twbkamyiGU9w
         kZOPaQvoReuQQL4+xjFyQE5CqsxEHz1HwYmFNxI2Yo0SES9cEpVez0gvGxXVtC0Ruj
         vFNAiuoUu0kr3X0GJSTLfA/BwcMR5+SC8ia2t+Einn8H95x4rK/XesVSNh+yR/8Oow
         73bmS5gIsRCqhTn3EiPN5IYnwBAsGpsqpfcnb+4+QsuE61mnYPSktf60AE4m6I0kO7
         0l+3CzLlX55MgPpyUkttDKlAuryHIrdL2coPrJcrQOjR1FIfHoDbSTf9/vWBeGMs/H
         1/29LHn56q+PA==
Message-ID: <494290a9c80db9976fa8943210cd0cd5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230222121453.91915-13-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com> <20230222121453.91915-13-nick.alcock@oracle.com>
@ubject: Re: [PATCH 12/27] kbuild, clk: remove MODULE_LICENSE in non-modules
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Date:   Wed, 22 Feb 2023 15:43:54 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_SUBJECT,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nick Alcock (2023-02-22 04:14:38)
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>=20
> So remove it in the files in this commit, none of which can be built as
> modules.
>=20
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
