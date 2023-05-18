Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B68708B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 00:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjERW1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 18:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjERW1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 18:27:31 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860F0E50
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:27:30 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3f38cde7940so2504731cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 15:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1684448849; x=1687040849;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vU8ksk+jtxxnMDgtdtiecbd/wIkS7oMXlAmPO+mSVBY=;
        b=RXDflzXVa79btmY9YKDx/3jKvsvirY5KQ4ZN0yh8lpPk/N/npG/s4Mv0mCjfyDE3oo
         FkmUq67Qnl5kJfhH2LE4mwMIOAY4GaM2Cu2ongHY7TauYliJOo6cdSsBw210n0tVDWcf
         96UVudnuazhDErIYtHth/M5hDTDbBQBUlyTC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684448849; x=1687040849;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vU8ksk+jtxxnMDgtdtiecbd/wIkS7oMXlAmPO+mSVBY=;
        b=Dvcr3WSqRZ9Zv1J6ndeIC72jp8QYJ8Fz+0fWpsOJAdwQP1oPnagVGx6bEhYw2w966f
         7yocJ5XRO7eV8u57Ldd/aZZP7dngaqzlJgwVUe4YCwGfsESTqTQoJKhfqBUoio1FuQwz
         2AX5ap938u0MYyr9A6W8gr1zp+D5V45Fxm05NP1CDHwkLJk4Kenq4MDQxk/4o2QRkDQH
         8fPyK983b588jb/BqzFueJwjA8puk0wb7JzvoL2okm9k/20PE+S8DjmF6eoX00P59UBb
         zCODrKPetfsmrC73MNy7IKrLzYVWRrsgjixkVPPS4XmqTjpc3if/RCYdWA2n1NKaPSI6
         j+mw==
X-Gm-Message-State: AC+VfDxXAxhNDEZBCvhIPmb364V2du8myGhqwhPSqtsCPVqotcYf0Vja
        ZE2HGqBZJQgDTi+bYZcDPDin/g==
X-Google-Smtp-Source: ACHHUZ6VnpatSX45tf8Fu1MqP/Qs33jUzml3VIbN5SKXE2AMz65tNd0peIh4MmJQGsf0Krzutbopig==
X-Received: by 2002:a05:622a:1898:b0:3f4:fdaa:8e14 with SMTP id v24-20020a05622a189800b003f4fdaa8e14mr280385qtc.2.1684448849562;
        Thu, 18 May 2023 15:27:29 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:9fd5:7d6d:b75c:c88d])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a01e500b0074fb15e2319sm688529qkn.122.2023.05.18.15.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 15:27:28 -0700 (PDT)
Date:   Thu, 18 May 2023 17:27:26 -0500
From:   Corey Minyard <cminyard@mvista.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Zhen Ni <zhen.ni@easystack.cn>, Corey Minyard <minyard@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the ipmi tree
Message-ID: <ZGamTgCU4JB8vWEU@mail.minyard.net>
Reply-To: cminyard@mvista.com
References: <20230519081456.0dcb82fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Rh1lKSV7H4dlHao8"
Content-Disposition: inline
In-Reply-To: <20230519081456.0dcb82fd@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Rh1lKSV7H4dlHao8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2023 at 08:14:56AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   7ab1f268ced2 ("ipmi_watchdog: Fix read syscall not responding to signal=
s during sleep")
>=20
> is missing a Signed-off-by from its author.

Oops, I rewrote that patch and needed to fix the Author.  Sorry, I'll
get that.

-corey

>=20
> --=20
> Cheers,
> Stephen Rothwell



--Rh1lKSV7H4dlHao8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/Q1c5nzg9ZpmiCaGYfOMkJGb/4EFAmRmpkwACgkQYfOMkJGb
/4EM8Q/9ETkEowWtDfGN88QdIiS6GfFYXkQ+ETPWzam1VtfGzXFrurMgOCk5Vz3m
UZcxL1fCgTfBc5V4PsUc1aPvSxetly+gV/3uwa8OBiKv8goHKxCN4It/UJhZk3YM
GtWPyngTrukq9xIZm9FMy82phedRJXUzQmBsQG4ZSh5BTjUviVO5w7mus1rSLLSS
FY6DRndh6wbQZ1NfdPSmiKb5ngh+0iroQlfiHhjbvP87T8jI3GwGecPVrFjis2Is
xQ4P8iMSxXeLoSFr7ocm82KwsRrgM90DN85e9Dnj5ZvjHKrzbat9R+Ubhpoz1Wzr
WRx8yW7pT1P/hWrCD8oV8bpHVdQj6pEz0kTIfd73KxYyMrd1cAy9+SnP84WKuOEY
dP5Tyw8lvCw2Lvflv+/MYfIE/28/n5Q6+ezA33s+lJkH3nFxZfZMbRy9epEPsT8Y
kE2Snx6VEVCo1yQDU6ZmqQvxGijSktjGZlDo2sLmthLKiJUUBWH6u71rlYZoSNH9
sRu+qkKUZTGAeFow4P/1sLDvXv5pu368k4yMV9CiW9zkWWCS1sVuJ3Ng9tMtg7nu
Hd1hc+S9kksWlD6oij2dIs1qxHJhFQfJ+ZTK/Bk68qrYAvcsvBF/EAAgVm5GP0BZ
fbJFszVQ7CcVd/BNuZu+2Qtrc49BBAHGlSxzJDSKfr+Y6w/8lA8=
=R3dT
-----END PGP SIGNATURE-----

--Rh1lKSV7H4dlHao8--
