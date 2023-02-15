Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD1B69744D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBOCV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBOCVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:21:55 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D892D14C;
        Tue, 14 Feb 2023 18:21:54 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so5257056otq.13;
        Tue, 14 Feb 2023 18:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C9F4iY3btRt75ZWMpdvjlvs4Sb+cW9vz/bhtoAdi2ws=;
        b=hFmnwJ+1S4HuoKmZ96SoSAaoOxfMJ3ThCa0hO+YyEbvtgfXTnSKmLBiLIXCuZzUyJs
         +t7XUoWphpXzgsNF5WGFzibmEXR5T6qeyBszh9Dvp4A0DFeVdFgYMcl1h4eXEZP2UQ2l
         zQbBA14fLFFuQj9ocqvqh5D7TAKqP0JbvM0Inme79Je95htKp9zNH8DKXNCs/iAddADf
         E07ng1QfEuwZfRQRQjjETDfKYz1HDhMD8N1Yn27Ty8gogjSEDGJ+S9K6h1CKA2OsZgse
         qgBAg4wQ8zkHqjQ5Vtr5mwVK/4hUFHM/FfvYxKIazoA2Lba8mQ6zkGHOXgPgqGb1YXp6
         t4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9F4iY3btRt75ZWMpdvjlvs4Sb+cW9vz/bhtoAdi2ws=;
        b=TNPeXpMOUBYC7CEDY94UJXVJV5MWpXgSkx6H3P3SeyaBfeGHp6+GogE2qxV1m7HHFW
         AcjiNHdfHTsfHMaT2/5CJeo/TShriEjAWQshzePx+8AnLWnrz16eQMbMdQzP/mnuU7Rc
         1Wcsd4zFcDPChq/uI6o8V+fkFzHPA86OdymMZ4SRRUzOmBunsARsMxmzeAxh9p4X4O0i
         NAc65toRzoxqdiMZoiz6zgTtSlCVMTBmtcFYTe2ir2v8oD7OEBxeT2Z/YdIC0mxKkugs
         2xgkV0aALG6WSe4uPa3KMAQyG6i7UwZ7q+Px0IrTYF440bJvEn/01kdBw5JmXBOdKwQI
         SOMQ==
X-Gm-Message-State: AO0yUKUwThKeU7OGzh/+ygswpcOYmTn47I3h5l8hFXMsIPtCdGLglqlg
        z1RT4F0lJTNmdYFLX8KKFiY=
X-Google-Smtp-Source: AK7set9M1tUek+vwI8Fd9E5B4jCW3AykvKSGg4l6vE/XSGlP1e7M7J5txjIO4jg295+qCPS+NpIY9g==
X-Received: by 2002:a9d:5d13:0:b0:68b:b972:481d with SMTP id b19-20020a9d5d13000000b0068bb972481dmr307754oti.8.1676427712729;
        Tue, 14 Feb 2023 18:21:52 -0800 (PST)
Received: from illithid (ip68-12-97-90.ok.ok.cox.net. [68.12.97.90])
        by smtp.gmail.com with ESMTPSA id g6-20020a9d6206000000b006864b5f4650sm7272247otj.46.2023.02.14.18.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:21:52 -0800 (PST)
Date:   Tue, 14 Feb 2023 20:21:50 -0600
From:   "G. Branden Robinson" <g.branden.robinson@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH 1/1] rseq.2: New man page for the rseq(2) API
Message-ID: <20230215022150.pxuhdbx2zdwjpems@illithid>
References: <20230214195442.937586-1-mathieu.desnoyers@efficios.com>
 <669eb324-aef6-0583-c8a4-f54a93ee4d6d@gmail.com>
 <20230215012054.twzw4k5et6hxvi2j@illithid>
 <82ced680-8c2c-75b7-4368-16e602353f32@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sqcg7udkho3m3gy7"
Content-Disposition: inline
In-Reply-To: <82ced680-8c2c-75b7-4368-16e602353f32@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sqcg7udkho3m3gy7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

At 2023-02-15T02:52:03+0100, Alejandro Colomar wrote:
> On 2/15/23 02:20, G. Branden Robinson wrote:
> > [CC list violently trimmed; for those who remain, this is mostly man
> > page style issues]
>=20
> Ironically, you trimmed linux-man@  :D

I didn't!  It wasn't present in the mail to which I repled.

This did puzzle me.  I guess it was an oversight.  You might want to
re-send that message of yours, and/or Mathieu's, if it lacked it too.

Or maybe it doesn't matter because lore.kernel.org finds all.  I just
used it to track down an exchange between Michael Kerrisk and me that
GMail refused to find even though it was in my inbox.  It showed me only
one thread, didn't highlight the specific message that it thought
matched, and showed me the _wrong_ thread on top of everything else.
The word "constraint" was in the thread I wanted, not in the one I
didn't, and even when I quoted it I was served up an incorrect match.

Clearly their AI efforts are going swimmingly.

Regards,
Branden

--sqcg7udkho3m3gy7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh3PWHWjjDgcrENwa0Z6cfXEmbc4FAmPsQb4ACgkQ0Z6cfXEm
bc4SlhAAkdu2kySJxGyRl+8sNWol+r5yCwWZ9CSJZPdl/0IC+ASGF61fdh/R9jPh
LL08l5wV6pZJic3EN+ZefKKGlbfpqaaQ/ZoNuv8cOXn0H4ga/qWyg4L5Spn2/Gx7
ffVXJz/AfOanG3v/VC9TPvi8uajsmJdsVYGCXzVq4VWN2dJvl35/VIjy6UhmqJKl
EuCRQ4/T9N30de9FK4WotD6e35xmqqfPMDk658z2N9DGH5TY/jqqzrkCgmEuskA0
8fNaRguo+y1cCWfVz47q171SlDUDWL2viMysGo7jppJieYEi4S5zTGd3WUsNN/NW
5Gi48bcsU4PVcysk7rMUcItiEVLfNiUlDhCmDvFuceIzD+xYD/Dtm3a1L7HctagG
mo+hlFjV0X1z+MkdyGIIXZykxhNMjOW7YXV2RSN2k3SFDZWHFegrNeKgUTK4iYw+
RkCEQdyEa7PccDa/3fA9TT1REgmweW4DKHF1tX0XT88kvKTWWg5LBpEyop3VwSvW
GLw9v/CDrA/ikCl54d2LvRjbR8YKmfKgimLICSYwrukmHp4YDSfXr551W8f57f1/
X/ZjZl/7RmbWjoww1j3NOfGnN9oYvLsV87qm9W7oPxqebj1ZXFq0/Pb0SIUTk6OX
ZkAYAIJRzP+9yZvgz9iFJuBLbFWga87cEY0pjgBQqELRLeCJaBY=
=PQv3
-----END PGP SIGNATURE-----

--sqcg7udkho3m3gy7--
