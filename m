Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B7F683812
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjAaU4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjAaU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:56:25 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D85AA61;
        Tue, 31 Jan 2023 12:55:59 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F3A292D3;
        Tue, 31 Jan 2023 20:55:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F3A292D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1675198518; bh=qedbN6x4BBtrHmS4z0xKl0Dfd2n3kOOA5RTX7mwdEIM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aN2F7VqVwKx7iQcE9ALV3rn0MW6KVuvk+OGCT+2KteAjnX6HvMpJmmCD/obpnh8Ri
         vBSmaAw681EmcfaXFhybIBXZIjguABzgwQF2+AmCYP79JzBm0uap5CRUXpRsnhtSxl
         +dw6gyPQkECXNDie2S0ljmoQp113eQ+8hq/sPQ5zeFvSeuKtjmWZb77IkV0HnwzNso
         AaVHJltX5QjHuNu38BgeFFmqeWBhYfySsO3Lqkmii0UILU/4Rpw0cYvUFrp6H/8vBV
         h0/mzfZuQj37pEm+yTNAFSYIQiE2QvtOXkqIKjar5SrxLx6V5Q2s9/19CRBCutuPOH
         G0eunlblhlnfQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: kernel-doc: Remove workaround for @param...
 syntax
In-Reply-To: <20230129150435.1510400-1-j.neuschaefer@gmx.net>
References: <20230129150435.1510400-1-j.neuschaefer@gmx.net>
Date:   Tue, 31 Jan 2023 13:55:17 -0700
Message-ID: <87pmau2zm2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> Commit 43756e347f21 ("scripts/kernel-doc: Add support for named variable
> macro arguments") improved how named variable macro arguments are
> handled, and changed how they are documented in kerneldoc comments
> from "@param...", to "@param", deprecating the old syntax.
>
> All users of the old syntax have since been converted, so this commit
> finally removes support for it.
>
> The output of "make htmldocs" is the same with and without this commit.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  scripts/kernel-doc | 11 -----------
>  1 file changed, 11 deletions(-)

Applied, thanks.

jon
