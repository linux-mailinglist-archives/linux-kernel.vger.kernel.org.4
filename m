Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C6632E80
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbiKUVK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKUVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:10:55 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9D2CD977;
        Mon, 21 Nov 2022 13:10:55 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EB5745CC;
        Mon, 21 Nov 2022 21:10:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EB5745CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669065055; bh=ShlWXgU8TkOVBjZb6MNp+8oCHkfumSF5LLBNNLJGyqA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JtokOAp1BjsNZx94VBcpo2xCsJH9Fwx6OYqSHHo9GFNZoZmgM0lFFblCGdtsF5Czl
         TxWltoHj32mgBZPijyfIRvABFfeMeuD8MZNiE0l0jJPy6UT5KR0ajU2Gtj8Jdmj29P
         c91GmRx7KFzNQ7n0SGTI/uNIXN0/gTYjqYGb9shMNGMNe8muUCmNWK1/g1it+LgkYM
         Lblho7R7d/r7hbKpuUY+yuP/pJlwAzE0rzyxyZg0+/ZfzxBZYwEcMMA0tphw8bTS3b
         Efy2hVnhQL9yBt5z1sjxRo5qaRnGA3lbWuISf3a4FXDuGpK+JBAdyyjDS80kYLswzb
         F/KIVtzZX+Yhg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, sos-linux-ext-patches@mailman-svr.amd.com,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add memory-barriers.txt Spanish translation
In-Reply-To: <20221111174739.2471900-1-carlos.bilbao@amd.com>
References: <20221111174739.2471900-1-carlos.bilbao@amd.com>
Date:   Mon, 21 Nov 2022 14:10:54 -0700
Message-ID: <87fsec9foh.fsf@meer.lwn.net>
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

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Translate the following documents into Spanish:
>
> - memory-barriers.txt
>
> Also include it on index of Spanish translations, following the same
> approach used by the Korean translation, as a note at the end of the inde=
x.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/translations/sp_SP/index.rst    |    4 +
>  .../translations/sp_SP/memory-barriers.txt    | 3134 +++++++++++++++++
>  2 files changed, 3138 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/memory-barriers.txt
>
> diff --git a/Documentation/translations/sp_SP/index.rst b/Documentation/t=
ranslations/sp_SP/index.rst
> index e20dd6e875e7..61dace3df9a6 100644
> --- a/Documentation/translations/sp_SP/index.rst
> +++ b/Documentation/translations/sp_SP/index.rst
> @@ -79,3 +79,7 @@ Traducciones al espa=C3=B1ol
>=20=20
>     howto
>     submitting-patches
> +
> +.. include:: ./memory-barriers.txt
> +    :literal:

That's an awfully big "note" to add at the end of the index file; I
don't really think that's the best experience for our readers.  Can this
be done using the wrapper documents like for English in current
docs-next?

Thanks,

jon
