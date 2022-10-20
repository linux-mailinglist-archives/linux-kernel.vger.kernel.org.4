Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6FA6061BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJTNfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiJTNfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:35:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057E7153805;
        Thu, 20 Oct 2022 06:35:33 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id pq16so19791946pjb.2;
        Thu, 20 Oct 2022 06:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDDImz2rsoo4UtZtPdwMftLLZrVfqbqY4KCmjbbdHXY=;
        b=i8vZcs+k0jmouKy/fTKgLB1LoR+zELNtS04vonxIiX1NVX8ToNPdbZnONWpty1Rcbe
         pc51YqnqUgMD7ydfjBDsHzjWs+X6NYBjv+2GHsK2Hv6vk+Y49c7yTIxut+eJjlayGBb/
         Mp4HeJZ1zN5BUJwzgdsKAH6kt3pmjotQe7vVc1TrGLcJxwr2pGqDcB8N3I3tb+9eCjKU
         ITgaAUUErOHKXfbCgVaURGnQ55KmQQbZ2GqKPvIfESd5sNZrfELwFTB07h6alkpzdCNC
         p2W6SouEwULZdzwUk7ub9lOU7P0kELhTLDMVMrFLU0ozhnSuULejZnSMiG+/hO/mKBSz
         Nwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDDImz2rsoo4UtZtPdwMftLLZrVfqbqY4KCmjbbdHXY=;
        b=x8Uleb6WNH9uNDAnqmFYrrJ5IeAZKF2fmhflx4A4/eLdihBcN+hQes6f15wBJbLaz9
         z6NGM8a3PlKieeTFY7BCYMEZpUg2hnSdjAx3z6kHgHt6vNW3yixOK/osZej+w9QLvzXx
         lHrdy70dYKnOmdN0hHh9NpxQ77PlzPnvNUE7a5kZQMimIYG6nf/cMzIe4Qg5cGMjWvL5
         teit3WumJ9u2XFfNDkswazG2w9n0gxGTgUk3Nqb0QxLaccXieqQlfHU8o+/hZvVF7nUx
         a0c9fR/uqhbPN+XNj8a+6dSOtD/hMJd2eyt/mVjIy5//1+xllIwWdeCvh6N7TelasVTQ
         cdjg==
X-Gm-Message-State: ACrzQf3s0BsiM3g6T8/A6VkzkY5qqnjLFC86PBiKCb0oXMcJMSkasovX
        U/ptHwQuCaYJwJvGswObY0I=
X-Google-Smtp-Source: AMsMyM7m40THty99keXaBvUqJAddHs4vdXkL+iu9uaB7zFuCW2ms4DXuOyDJ+SXg9wvnt+4YH/tSdw==
X-Received: by 2002:a17:90b:4ac5:b0:20a:de32:366b with SMTP id mh5-20020a17090b4ac500b0020ade32366bmr15811968pjb.197.1666272932133;
        Thu, 20 Oct 2022 06:35:32 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-50.three.co.id. [116.206.12.50])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090a075000b002005fcd2cb4sm1887133pje.2.2022.10.20.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 06:35:31 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F22341041A9; Thu, 20 Oct 2022 20:35:28 +0700 (WIB)
Date:   Thu, 20 Oct 2022 20:35:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, robh+dt@kernel.org,
        frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: fix repeated words in comments
Message-ID: <Y1FOoJh3e32zS8x7@debian.me>
References: <20221019130200.60460-1-yuanjilin@cdjrlc.com>
 <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3NmMATSo5+wZXRpk"
Content-Disposition: inline
In-Reply-To: <9fb4c010-b465-e908-6868-d9e493a9688f@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3NmMATSo5+wZXRpk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 19, 2022 at 11:53:54AM -0700, Randy Dunlap wrote:
> >  /**
> >   * of_match_device - Tell if a struct device matches an of_device_id l=
ist
> > - * @matches: array of of device match structures to search in
> > + * @matches: array of device match structures to search in
>=20
> Hi,
> Rob has already explained this at least 2 times.
>=20

On what?

--=20
An old man doll... just what I always wanted! - Clara

--3NmMATSo5+wZXRpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1FOoAAKCRD2uYlJVVFO
oxtlAP42AqNdTIS4JDG0vvNRIIGBO2lHDD3G4/pk1WewW2Y9QwD/bpAcr38jzdNO
BtsupHxqOVhpPlbBlJGu2fKbbgIb5gk=
=TFUC
-----END PGP SIGNATURE-----

--3NmMATSo5+wZXRpk--
