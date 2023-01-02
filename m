Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9F565B83A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjABXiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjABXiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:38:09 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EE36242;
        Mon,  2 Jan 2023 15:38:08 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D1FEB2E0;
        Mon,  2 Jan 2023 23:38:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D1FEB2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672702688; bh=9LthIr0WKBPgTsQLCaPxU5dI/RFUDbXduPs1u7LEP0E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iRHPpyTWZCe5tl7bd1zxvJQbBknmeCfEyfyrsHdZ79vb8u4bmLnp2xfMMo4+m82ZD
         MYifnEqQUKV6KN2/eRTYVRLxt9qfiG2/lKVAJgF+IblL+fqbZfcx/g7EKpnt9RahVX
         ZdTQrL+d7QoLlbxvTkcgjm2QdUWn0K7wNN1dpbzLATuU3Q0x6o//ZDu0gKRPsDdeD9
         vKBZJL7f/KwMc6sBYrh0SdAPuJuiEKqsRwVoZYWBdqCNPNq5nSqlUN2VrvPQ3OKAnP
         YUUco46zgEAinsjSV94fu56TX9YpSFRAk80C4LaetKxLqxVSijb8I0pSP959qz1oJG
         JPs2fX20nsjeg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: maintainer-pgp-guide: update for latest gnupg
 defaults
In-Reply-To: <20221220-docs-pgp-guide-v1-1-9b0c0bf974fb@linuxfoundation.org>
References: <20221220-docs-pgp-guide-v1-1-9b0c0bf974fb@linuxfoundation.org>
Date:   Mon, 02 Jan 2023 16:38:07 -0700
Message-ID: <875ydoh5i8.fsf@meer.lwn.net>
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

Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

> It is finally becoming increasingly rare to find a distribution that
> still ships with gnupg-1.x, so remove the last vestiges of "gpg" vs
> "gpg2" from documentation.
>
> Similarly, starting with GnuPG 2.2 and above, the default --gen-key
> operation creates ed25519/cv25519 keypairs, so update all example
> command outputs to use that combination instead of rsa2048.
>
> Lastly, add a few wording tweaks and remove links that lead to stale
> information (e.g. hardware tokens overview from 2017).
>
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> ---
>  Documentation/process/maintainer-pgp-guide.rst | 102 ++++++++-----------------
>  1 file changed, 30 insertions(+), 72 deletions(-)

Applied, thanks.

jon
