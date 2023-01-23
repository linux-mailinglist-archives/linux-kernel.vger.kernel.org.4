Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD5D6776BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 09:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbjAWIvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 03:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjAWIvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 03:51:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECBFCC2E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:51:35 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id z3so8244207pfb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 00:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiISKER2cajYz2bCimExOXsQ5HAHxxouMwQAgy2HZyI=;
        b=o2e4yRCob9Lq84tw2eyc3IGAPJWg1M40TrznoAKPdiucBrC1suvu9AbaL4Qmi3AGKa
         cMhoOAhREuZKcTBT7k5j3B3E9MKENRJPctcizcvdBv5hZSw1cKMiaOl7kNo/AOokum6x
         o5Zc7EGe2poi5/zaRpunao41udHvAIle2EOiAiauawE9AFGAvF8Z0XvmIdMK/EPHH7EQ
         5WUwrTYN1AqMdIvy8ihMAVX1WqbfxXd9BCm+TVUK9F610nc/Usn/Qbd+++hqkqxj9iwF
         wn2j57o0UQceEOcJLi1CxBofYe6TpoeYZI73LXc4S5B8hcMij/Op/DESYGGyuvx7tQHK
         kfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiISKER2cajYz2bCimExOXsQ5HAHxxouMwQAgy2HZyI=;
        b=htZXliTmNNhYvViHwgzu/Rm254Cq3I4Ul7YbIgM7w8HPYfAyYc67K3Wc8gwxWJOGs5
         CoyunGllJl7hiLfrlUds5wnDXlz+pVdOBIid2cF2mo/02t60wXMm6BKF/2wzDpl1dZsW
         rdFbduSjE4qR4OfeWwLpUPQvVv5C6b2EtejRCfc5O7PCx64W6z7smqLn/ZMwC+qOm/9V
         3CcseCctLqI/GJ05XWQ2UZfsEMpn9G6NjBe5HCG0pkBAXw+GZJZ7emdPPhT1WxhWmrHJ
         AvyLEJ2YuUtrNGprdSOJZcnN6nAvaH1AeVR1C8LQxhIUNkMVDcnJz3QTKDhoUJJfqgvp
         kdlQ==
X-Gm-Message-State: AFqh2kqjZLexf4yVegWMgZKr4ftl1vl66pCFpHP9aL6UOYVy+pJ/lsyy
        wwzp9gbmufryeVVU+txlh3g=
X-Google-Smtp-Source: AMrXdXuHK6w4cF3R/SFl7OpVG7zs3vYJISShgo/qm+Yx/BHz2XpY93T21ZtRInUnsxxy2YnaeG0Kfw==
X-Received: by 2002:a05:6a00:f91:b0:583:319a:4413 with SMTP id ct17-20020a056a000f9100b00583319a4413mr25567175pfb.24.1674463895090;
        Mon, 23 Jan 2023 00:51:35 -0800 (PST)
Received: from debian.me (subs32-116-206-28-53.three.co.id. [116.206.28.53])
        by smtp.gmail.com with ESMTPSA id u197-20020a6279ce000000b005855d204fd8sm30934316pfc.93.2023.01.23.00.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 00:51:34 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 62D3610504D; Mon, 23 Jan 2023 15:51:30 +0700 (WIB)
Date:   Mon, 23 Jan 2023 15:51:29 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Diederik de Haas <didi.debian@cknow.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Fix full name of the GPL
Message-ID: <Y85Kkax5+U4AUedT@debian.me>
References: <20230122191047.58769-1-didi.debian@cknow.org>
 <Y84wk+sw/gR7gNW4@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ppj6caC0vtIGHezG"
Content-Disposition: inline
In-Reply-To: <Y84wk+sw/gR7gNW4@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ppj6caC0vtIGHezG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 08:00:35AM +0100, Greg Kroah-Hartman wrote:
> - You did not specify a description of why the patch is needed, or
>   possibly, any description at all, in the email body.  Please read the
>   section entitled "The canonical patch format" in the kernel file,
>   Documentation/process/submitting-patches.rst for what is needed in
>   order to properly describe the change.
>=20

Hi Greg,

drivers/staging/wlan-ng/hfa384x.h (for example) has already SPDX identifier
that matches the verbose copyright notice below it.=20

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ppj6caC0vtIGHezG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY85KiwAKCRD2uYlJVVFO
oyRsAP9r4fI1i+oYi5Wai/ioVqUCHtoFkiw37gNH//1ig2mrHAEAphOXT4HP2Ssy
VyoweJSiY1uiYjBEDfwg1jtf7xuG+gU=
=ij4J
-----END PGP SIGNATURE-----

--ppj6caC0vtIGHezG--
