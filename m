Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4DF6A6262
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjB1WZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1WZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:25:51 -0500
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Feb 2023 14:25:48 PST
Received: from m228-62.mailgun.net (m228-62.mailgun.net [159.135.228.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD56D222D1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:25:48 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=codeagain.dev;
 q=dns/txt; s=smtp; t=1677623147; x=1677630347; h=Content-Type: MIME-Version:
 Message-ID: Subject: Subject: To: To: From: From: Date: Sender: Sender;
 bh=2UJ1akhy5RsOqPyJubbCb4xOTm/QKoxwWG+Uel/YVNI=;
 b=VD88AHiqNHNx8JYp+7+KaE30NvZucNK+SSbZKeNEpbLTEhxMdYBpV+3++WvegVJRQ+/Pe6S2d1t4DDnLKo634IjIEB7e1Sl5zidhjF3yO6s5xG91DWYPv/ZOoFqB5a7iOPQzoh8EuGa+dNsXJvhEQ2XIzJGN187eh/jDj//WLwTrO20PA4pR+lmqORj68bQApnT12GC1vMyC7IqYIiPpT9Xm7IjfHLbniA8BGDRXE7i5AqRWwxFTdXx+AAamnutVUL4frlcuBWjwYMoAgR+9tgLK7GSWukvRwaAfEFiJ6PlWcwH+cAYEJVmEHu4KTKxWxEqOzoOE04Tvm/H9+Y7wgQ==
X-Mailgun-Sending-Ip: 159.135.228.62
X-Mailgun-Sid: WyJkNDU4NiIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJiZTljNmQiXQ==
Received: from guidai (177.75.142.135.mhnet.com.br [177.75.142.135]) by 8ff609fc26a7
 with SMTP id 63fe7e3ee23dde8434ab2aa9; Tue, 28 Feb 2023 22:20:46 GMT
Sender: codeagain@codeagain.dev
Date:   Tue, 28 Feb 2023 19:20:35 -0300
From:   Bru Moreira-Guedes <codeagain@codeagain.dev>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Patch Watchbox <patch-reply@codeagain.dev>
Subject: [PATCH] coding-style.rst: indentation: Clarify tabs text
Message-ID: <20230228222035.k227xb3okt2lbksn@guidai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x33xvo4wnlnrxfu7"
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--x33xvo4wnlnrxfu7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The old text about tabs failed to clearly convey the message that the
TAB character is used for indentation. It also gives the misleading
impression that it's trying to "redefine" what a tab (the 0x09 ASCII
character) is when it says "tabs are 8 characters".

It might be misleading, especially for some autistic readers for whom
English is not the first language and whose tendency to interpret things
more literally might be present (i.e., my very own self).

The present patch clarifies the tabs text on such aspects.

Signed-off-by: Bru Moreira-Guedes <codeagain@codeagain.dev>
---
 Documentation/process/coding-style.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process=
/coding-style.rst
index 007e49ef6cec..9a0205fa7ed3 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -18,23 +18,25 @@ Anyway, here goes:
 1) Indentation
 --------------
=20
-Tabs are 8 characters, and thus indentations are also 8 characters.
-There are heretic movements that try to make indentations 4 (or even 2!)
-characters deep, and that is akin to trying to define the value of PI to
-be 3.
+The Linux Kernel uses the TAB character for indentation, as in the K&R
+style. Tabs are meant to be viewed as 8-characters, and thus
+indentations are meant to be seen as 8 characters as well. There are
+heretic movements that try to use spaces for indentation, or make tabs
+viewed as 4 (or even 2!) characters, and that is akin to trying to
+define the value of PI to be 5.
=20
 Rationale: The whole idea behind indentation is to clearly define where
 a block of control starts and ends.  Especially when you've been looking
 at your screen for 20 straight hours, you'll find it a lot easier to see
 how the indentation works if you have large indentations.
=20
-Now, some people will claim that having 8-character indentations makes
+Now, some people will claim that viewint 8-character tab indentations makes
 the code move too far to the right, and makes it hard to read on a
 80-character terminal screen.  The answer to that is that if you need
 more than 3 levels of indentation, you're screwed anyway, and should fix
 your program.
=20
-In short, 8-char indents make things easier to read, and have the added
+In short, 8-char tab size make things easier to read, and have the added
 benefit of warning you when you're nesting your functions too deep.
 Heed that warning.
=20
--=20
2.39.2


--x33xvo4wnlnrxfu7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQTUrsHCxGmQ5vyKRAZtd3tyEY2kgUCY/5+MwAKCRAZtd3tyEY2
krmkAQD1QDLQJcRslQMVJbW50mTPcpWozUfxmCqQYu1oT20srAEA6YtGC+RrWYt1
52F2OO1UWSe5uGR1fFCWxkeeFfiOEgQ=
=E2XU
-----END PGP SIGNATURE-----

--x33xvo4wnlnrxfu7--
