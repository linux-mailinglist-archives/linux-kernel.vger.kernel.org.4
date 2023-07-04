Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8024A746836
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 06:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjGDEDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 00:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGDECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 00:02:33 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE346E7A;
        Mon,  3 Jul 2023 21:02:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-557790487feso3620416a12.0;
        Mon, 03 Jul 2023 21:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688443324; x=1691035324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXPJYPo99iw+nT4G16KHkVbpbdJ+upvLJqGBpDeZzeY=;
        b=k9MUwBajjYbdCeb7GTBmEic31Qz1nDFqbmSe/SPRV0WR9lS3G4wTU4ilP/flo9Q2n/
         NVfspHFdGhh5YKwuWJnav1XJqhbkMgfowoeH0utnhCoIPGDLnY7hy2PzDmqx6fYXBpUD
         IlY+Pe8UjHobAWhWkAkMsE+mtmJhrc/7X2CjXdEqm3uO1aVlVe+vCdJ7/BF1BDrea261
         jvuE56hETGIawpsptYxgO0vtkINKdxhzC8kWqcb428s+u9MyJIGAepWQLMGgImf9KrvA
         Sx57uafxbK+8/3TrS2CMaIl6fhUdJqj3E87NdUbfxwPMAS01kjFuPKtTGkF14GqlvEDH
         Oh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688443324; x=1691035324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXPJYPo99iw+nT4G16KHkVbpbdJ+upvLJqGBpDeZzeY=;
        b=JaCt7vkAuJ7tfDcfUbnAHWWCxOs5V2+AmUppumubnCLitH3AbQh4TEAsgJ9/3bZcUN
         g226ofilsU9fkrbmP9jV9EYXUSpRMo2wMQL2Vrvl4wqw/T0/QkC7QYsdBkL7TPMcH06j
         YSc4sAh8HtNnwl5NL5WMLv5ZpBspnatSVZ01ZEf1PAw/wT6sk6dJSwv1CIbWyxqe20xx
         z5caEyczJDi9y/9GpBAKMYH5XZENUO6FS8ecVdzRV77l7WZufuqUJchFMxFPaGxveCYP
         WFFJ8o3WcpIDscYHF01or4p8JDiAw18pKuCCcdpDJBmfwbhTln+n7owYdJs36VefHGo6
         HsLQ==
X-Gm-Message-State: AC+VfDzwHrnjAv4zqZonUeHfBzLyr4nTikMTjhzXYXYy94X9kSqLuj0R
        4P86Bcd7ZhNDigdgO0zG7SViYlI786dr+qnO
X-Google-Smtp-Source: ACHHUZ5JBnTieP65izFYRX51YsPqO3oGyFrnqmLSE5VxExVpG5DyR0FjCV4dCWLVv4lfYLYAyh4q8Q==
X-Received: by 2002:a05:6a20:734e:b0:110:9210:f6b8 with SMTP id v14-20020a056a20734e00b001109210f6b8mr16071464pzc.35.1688443324144;
        Mon, 03 Jul 2023 21:02:04 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001b7f95fbec1sm14393093plc.78.2023.07.03.21.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 21:02:02 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 09B70819702B; Tue,  4 Jul 2023 11:01:56 +0700 (WIB)
Date:   Tue, 4 Jul 2023 11:01:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Budi <budikusasi@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: Anyone please do big favor, help
Message-ID: <ZKOZtP72vmF8d6yi@debian.me>
References: <CAH0GyZDWhSo+otkEPRDwvHyE29N5ZjhpFT5m4jRnt6buV8gEpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bTRtgpGUIlP+T0Rn"
Content-Disposition: inline
In-Reply-To: <CAH0GyZDWhSo+otkEPRDwvHyE29N5ZjhpFT5m4jRnt6buV8gEpA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bTRtgpGUIlP+T0Rn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 04, 2023 at 07:46:23AM +0700, Budi wrote:
> Please one sincerely help, I need huge help
>=20
> I build kernel but there's few absolute interrupted compilations
> resulting in few .o files are defect, cannot be recognized
>=20
> In 'make' and 'make modules' this'd be no problem at all as  is
> capable of resuming whole the process
> it's solved by deleting those .o files and then redo the build again
> which will complie those  particular files only

In that case, you should `make clean` first.

>=20
> but in 'make modules_install, it won't be
> real case is within Kernel 6.3.9 package
>=20
> So how to modify the makefile in order to be able to copy/install the
> just built modules in pause-resume fashion so after few particular .o
> files of modules deleted and rebuilt with pause-resume, then the
> modules copy/install is performed on those only, not the entire
> modules

IMO, again `make clean` first then rebuild the whole world (just `make`).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--bTRtgpGUIlP+T0Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZKOZsQAKCRD2uYlJVVFO
o3pQAP9L5cfMbC4TPPaRsv+7jpoRoCwaDfhhGU8tqZlHdA8UcgEAxQKepM5oA3Dx
ocO6vghV6C552Qoxes36OpGQ6Zpcpwc=
=Htzl
-----END PGP SIGNATURE-----

--bTRtgpGUIlP+T0Rn--
