Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4226B67FFDE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 16:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjA2PWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 10:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjA2PWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 10:22:08 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A021ABD0;
        Sun, 29 Jan 2023 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CKXudx6D8ghx+FrwdKjLTeAENff6ZhcvHr24bvecLjE=;
  b=pCBslvixOo73tPhSVfWo5vjIpWA6xTkxcP6hR7xtD1Ch0D6KZkIEHBwj
   JdiPkXzk2Alk8lXWbwrEAfOFKA9SQ8ZwPn8ewMlzj9ufXQdQ/B1Qz14r1
   DpqNxJenLsczNAVJovcfxnG4fXTJIaeDHn3BSu9zlAaGMtiDC9UPlo04U
   w=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.97,256,1669071600"; 
   d="scan'208";a="46283717"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2023 16:22:03 +0100
Date:   Sun, 29 Jan 2023 16:22:03 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     =?ISO-8859-15?Q?Jonathan_Neusch=E4fer?= <j.neuschaefer@gmx.net>
cc:     linux-doc@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>, cocci@inria.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: coccinelle: Escape --options to fix Sphinx
 output
In-Reply-To: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
Message-ID: <alpine.DEB.2.22.394.2301291621350.2852@hadrien>
References: <20230129151408.1525324-1-j.neuschaefer@gmx.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1914809095-1675005724=:2852"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1914809095-1675005724=:2852
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 29 Jan 2023, Jonathan Neuschäfer wrote:

> Without such escaping, -- is rendered as – (en dash).
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Thanks.

Acked-by: Julia Lawall <Julia.Lawall@inria.fr>

> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index d9976069ed126..535ce126fb4fa 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -219,7 +219,7 @@ instance::
>      cat cocci.err
>
>  You can use SPFLAGS to add debugging flags; for instance you may want to
> -add both --profile --show-trying to SPFLAGS when debugging. For example
> +add both ``--profile --show-trying`` to SPFLAGS when debugging. For example
>  you may want to use::
>
>      rm -f err.log
> @@ -248,7 +248,7 @@ variables for .cocciconfig is as follows:
>
>  - Your current user's home directory is processed first
>  - Your directory from which spatch is called is processed next
> -- The directory provided with the --dir option is processed last, if used
> +- The directory provided with the ``--dir`` option is processed last, if used
>
>  Since coccicheck runs through make, it naturally runs from the kernel
>  proper dir; as such the second rule above would be implied for picking up a
> @@ -265,8 +265,8 @@ The kernel coccicheck script has::
>      fi
>
>  KBUILD_EXTMOD is set when an explicit target with M= is used. For both cases
> -the spatch --dir argument is used, as such third rule applies when whether M=
> -is used or not, and when M= is used the target directory can have its own
> +the spatch ``--dir`` argument is used, as such third rule applies when whether
> +M= is used or not, and when M= is used the target directory can have its own
>  .cocciconfig file. When M= is not passed as an argument to coccicheck the
>  target directory is the same as the directory from where spatch was called.
>
> --
> 2.39.0
>
>
--8323329-1914809095-1675005724=:2852--
