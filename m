Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B930466667E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbjAKWzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbjAKWy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:54:58 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34309F5F;
        Wed, 11 Jan 2023 14:54:57 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D106C5BF;
        Wed, 11 Jan 2023 22:54:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D106C5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673477697; bh=t9VKZ6IJLg0MXJYVJk8yw0WBePsYpo+E1Ag0Xn/wAWQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hVEJZ3OKdW6HcXOr735a8Q6Zvk7DBYVEV5v5KaLE0m0tumKQ4SnumYe303LliZBwg
         Kvum49mLpgBSD2ZGFg/mvoWT2ktgcBNrC/lF0x7seOBfvr6/U7/Ya7myECsOwQ2iHN
         KUS4xkYkmNKASvBnarXMtxQSx1+TA+i2g/aLNvULhBRUSdQFGrey2SHCLLw+fyWhtp
         IikfbdASD9ak5i3rQDLyoYHrjek976kmsHh3hB1d9kLA4f5MGFv0v7hxb6ZUwRcGMj
         pZCSuiKiRCuUPYDt8KQrrZ0hAlYgYaUujO2MithUb3TCQehLVKbqpgUnrn2O494aT1
         pbyupM+0iOmVw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>, broonie@kernel.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: process: Document suitability of
 Proton Mail for kernel development
In-Reply-To: <20221231152320.1340874-1-conor@kernel.org>
References: <20221231152320.1340874-1-conor@kernel.org>
Date:   Wed, 11 Jan 2023 15:54:56 -0700
Message-ID: <87cz7kwukf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Conor Dooley <conor@kernel.org> writes:

> From: Conor Dooley <conor.dooley@microchip.com>
>
> Proton Mail automatically picks up PGP keys for those with kernel.org
> accounts (and other domains!) which provide WKD for their users & uses
> them to encrypt emails, including patches.
>
> Document the behaviour & Proton Mail's unsuitability for kernel
> development.
>
> Reviewed-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> - Add section about why encrypted mail may be an issue
> - Use Konstantin's wording about the bridge.
> ---
>  Documentation/process/email-clients.rst | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Applied, thanks.

jon
