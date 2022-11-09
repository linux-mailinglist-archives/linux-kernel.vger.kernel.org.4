Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C962355A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiKIVDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiKIVDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:03:37 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DC110077;
        Wed,  9 Nov 2022 13:03:34 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 386BF735;
        Wed,  9 Nov 2022 21:03:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 386BF735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668027811; bh=tffqkokSe67mEjaJEheehIb5oj8+UVSETr54rqR1I5Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OEvea2ntLsCsP2YuOvADWmxNyc8iT1nYwb86B9vBilI6J+bCaxo11TcAdXxusMtdf
         UAVGq7vYiflu3N1qq6keC5oHXY/AGEQ2beGVjmREKrTZ6sRENzvEpdgScVY48Q5FMj
         tfyaWINKty5wI0EbQXs0I/aKfOUNRYBpxWh1GcQy4ij9aX7JnupZ8shgJ0vSVfAFdA
         iiickS+3kUqr8hk9C560BbDGiw3oW74TF9Q71TigjzBhKsVnA0GgLWlBs0d6QsQF4u
         rQc6Ta4lSt8xnA1l+V2RXHKr2EBrHlYFyaKQP1kcZ83PG0f1EB3HbqgghM96Fk4a+/
         Qvz5C8MeKUgfw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: admin-guide: hw_random: Make document title more
 generic and concise
In-Reply-To: <20221101160119.955997-1-j.neuschaefer@gmx.net>
References: <20221101160119.955997-1-j.neuschaefer@gmx.net>
Date:   Wed, 09 Nov 2022 14:03:30 -0700
Message-ID: <87pmdvj0wt.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> The hw_random subsystem no longer works only on specific Intel chipsets;
> make the title of hw_random.rst reflect this fact.
>
> While we're at it, also remove the words "Linux support for", since it's
> clear from context that this is a document about Linux.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/admin-guide/hw_random.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon
