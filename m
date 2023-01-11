Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB9666703
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 00:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbjAKXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 18:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAKXNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 18:13:04 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F4A38AE9;
        Wed, 11 Jan 2023 15:13:03 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 3F35C734;
        Wed, 11 Jan 2023 23:13:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3F35C734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1673478783; bh=dDwGXZocYb9bm1j15+JCwzaV6q/piPhQFY8QxjWQ5YY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Vfb5/xl2D6cFVufmN9AgwcMsKw1pO7MWBNmrzth6G20i6NIrAOoQRfS4d3aolT5CT
         Fc+qS18dt55PfXjcLXiM0gpZu2Jn37M3tePsHXAvQxCvRPA9x8fMHZU7iHSpvgMkYV
         Ma4Z3gU0I3NFuBoVB8ZpwkpeCpPbJvuGIXV7L/R2WbSvNxHBHjrQTiQlheUPriEk+L
         /1qDVxBU/eoul8k3gQNPYaskb4XVjN5lyn+bi+zaVwTieM2jHpmJA9Tr+RtGKE0NJU
         n/itTekwiUKW59agJ9RoE18udAVs7LGTWv2abZ0WEUD0RX9xFlDB8tpFFLG0DefWUd
         TuxgoOQMIBFqw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com, akpm@linux-foundation.org
Subject: Re: [PATCH] Docs/admin-guide/mm/zswap: remove zsmalloc's lack of
 writeback warning
In-Reply-To: <20230106220016.172303-1-nphamcs@gmail.com>
References: <20230106220016.172303-1-nphamcs@gmail.com>
Date:   Wed, 11 Jan 2023 16:13:02 -0700
Message-ID: <87mt6ovf5t.fsf@meer.lwn.net>
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

Nhat Pham <nphamcs@gmail.com> writes:

> Writeback has been implemented for zsmalloc, so this warning no longer
> holds.
>
> Suggested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  Documentation/admin-guide/mm/zswap.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/zswap.rst b/Documentation/admin=
-guide/mm/zswap.rst
> index f67de481c7f6..6dd74a18268b 100644
> --- a/Documentation/admin-guide/mm/zswap.rst
> +++ b/Documentation/admin-guide/mm/zswap.rst
> @@ -70,9 +70,7 @@ e.g. ``zswap.zpool=3Dzbud``. It can also be changed at =
runtime using the sysfs
>  The zbud type zpool allocates exactly 1 page to store 2 compressed pages=
, which
>  means the compression ratio will always be 2:1 or worse (because of half=
-full
>  zbud pages).  The zsmalloc type zpool has a more complex compressed page
> -storage method, and it can achieve greater storage densities.  However,
> -zsmalloc does not implement compressed page eviction, so once zswap fill=
s it
> -cannot evict the oldest page, it can only reject new pages.
> +storage method, and it can achieve greater storage densities.
>=20=20

Applied, thanks.

jon
