Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61137609C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJXIL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJXILY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:11:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301394E1A9;
        Mon, 24 Oct 2022 01:11:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id i3-20020a17090a3d8300b00212cf2e2af9so7329175pjc.1;
        Mon, 24 Oct 2022 01:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h0aI8dF+cHsEz/mkJBx1RzZJvaS62lxNWRBzoLBBROo=;
        b=a9CxCtIE91rL3S0HlKDZgWjEnDIdcbakTsxuHhMfYJuLFCG50P5KsFvQM0j7MO29Mc
         W6+/kCwJ3NPQ8jVtAxU5ba8tmIANpkFCcy0jr8gIjQ8GU9bpMTuzNea12Ww8vABTirUV
         wNGU37szhz6IhnWQrXNdF39m9dyC8ba8oq8ZEubChpL07TSlB0sVPn90I4DdinpQNxor
         OXUjZUTMLS3SxNkXYdtt6NhiRZAxsrFFRVOIxCn4WOt2+KMV/ALBfBVb8ylULSkI53ZC
         AMCHLiCEF9UK3dcdMkQLellxx7ysTKclLxpn219QNgugj1eqKH/ArCVmEK8U+YLc9UnW
         6Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0aI8dF+cHsEz/mkJBx1RzZJvaS62lxNWRBzoLBBROo=;
        b=6YAjsA14k/92+FvQpCMAW3CX/PHI8Ej1Z4ZOZ1Tdg6asVS41rAuNnPAEATzogpUFEz
         WDX4jlGzIzaZq2O25hs0jNy2tOboysZgXG+dWGWBRZkd5Z5QQ6UL9H1MMOdB5UIIm2Qw
         7eHydwQXFDmgSpI0OhIUoCOOleUDYCMlhL7D3sSegSK8Oyhc7vDYXSBB4eb/b4RqjqK+
         mD3ocU+0IKFPyqeH39In9mEgBwwYX1vWxvaO7fra0HdcmmXsZA0srDDyCsfA1nkXQH3S
         wbRKunIGc+YQuzLnnanxQ9R4MDW/yDhtOe+EZGQuwRW20W8of7G+VxU1tZOeLM5qlCWL
         kFBg==
X-Gm-Message-State: ACrzQf22CfEPozO7dhraxlIsAyonJZBqBqbjTcDchgpK98NmpPQpWOQe
        TMDHyMHqh3+X649eZUrdZXXMSc0FBatZ8Q==
X-Google-Smtp-Source: AMsMyM56+iKoFH47BE7ZmiMyH5SfvqhKKrjunRaxIqpsdw2uc3F60IVQJLZzpxuReAmO7F/FFB7+Pw==
X-Received: by 2002:a17:902:ecd2:b0:186:907a:a008 with SMTP id a18-20020a170902ecd200b00186907aa008mr9990077plh.112.1666599082670;
        Mon, 24 Oct 2022 01:11:22 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-77.three.co.id. [180.214.233.77])
        by smtp.gmail.com with ESMTPSA id 64-20020a620543000000b005632c49693asm19250823pff.202.2022.10.24.01.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 01:11:22 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3DC14103F1E; Mon, 24 Oct 2022 15:11:19 +0700 (WIB)
Date:   Mon, 24 Oct 2022 15:11:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Li zeming <zeming@nfschina.com>
Cc:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lxdialog: menubox: Add malloc allocation judgment
Message-ID: <Y1ZIp1ZAu0VzQ9Wf@debian.me>
References: <20221024055629.178198-1-zeming@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Jqf5YcVbJ9H+Bg3q"
Content-Disposition: inline
In-Reply-To: <20221024055629.178198-1-zeming@nfschina.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Jqf5YcVbJ9H+Bg3q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 01:56:29PM +0800, Li zeming wrote:
> Add menu_item Only when the pointer judges that the pointer is valid
> can function code be executed.
>=20

The if block isn't "judgement", but conditional.

What if menu_item fails to be allocated?

--=20
An old man doll... just what I always wanted! - Clara

--Jqf5YcVbJ9H+Bg3q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1ZIogAKCRD2uYlJVVFO
o0G7AQC+JNmvgd7Xtavhg1fIdqeBIRUmO5VQgsGYeJuzy31GuQD/dxyjt1FHNdlH
d/Ywux2565vF+dIYBI9ql9phYyVoiAw=
=+AEF
-----END PGP SIGNATURE-----

--Jqf5YcVbJ9H+Bg3q--
