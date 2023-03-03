Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4AC86A9223
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjCCIGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCCIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:06:30 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A728B559E6;
        Fri,  3 Mar 2023 00:06:23 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so1514851pjz.1;
        Fri, 03 Mar 2023 00:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677830783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2GNgFypKn/0hc5Isav8O5f3I0hf4LLGb3YNTok/vC30=;
        b=Ux8u3jgY4xPsXvtIDLngtm6THaaqQKr8ISSap3TtA42a9SIGaO7kOXmvJtURJTC7eU
         ucpvgT3jdlM5QrvkTUaWCkj/ksmrJtpcp9sbpGb25MGQQ32ucJSJtaVBUnV+zGoSaOMU
         qdLfegpB4yjaX0JZE+a+Ke4gCVS00j3fmQAIoEX0OkimEozc3WaldkliB+2TfcxlD/TT
         b1fXh0LRXeaC/PKaECznitkJj4H8qUzZ4i9RWNUGCTUQlOhPhueSOEs86QjHHAwn6oop
         NLMCDRiHxdXEHxN40O9Km1m23oE3XntsDCWjxh7Z1Do6zWaNmt3DTnOnd6rJ7BKJj0+K
         qRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677830783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GNgFypKn/0hc5Isav8O5f3I0hf4LLGb3YNTok/vC30=;
        b=3yDu5pJHcmw0/k9bobJFv+2iDGzKP1lctxQC0SFDh1/5mam1GYUbowTruDwBm1PcnF
         U2476+Zp8uUUj7k3zBOky5HkB4gqiFjnoQkhxc/MNtNOKozbIZEJf0c7v8w2hG5nl2ZT
         m9S1N9943uJa3cDpiSJzMJko+w5tRPlWTc048KlGmJlP9PlFQ+8HzB7+MYKdpxJTnUL2
         jLhSBHqhiZA74VjvSWsO1jVNdqRfTYuWnv8oGxEC5YapZDAOWQg9QveLldduTXuXq31J
         opXH48mny6T81+g4kUfd1U3Obszo0eKrlT/M2n7hAgVSuxucuvSdcOUysRfX9ANn3Dvz
         a1lg==
X-Gm-Message-State: AO0yUKW4i+3jE3YbSMC5+NcoVEjuSXEiM7OMquiVa0Lr0QGdvKVOYed+
        WUG/TiG371+a8qmHBBW9AUg=
X-Google-Smtp-Source: AK7set/y0ZWmbann7eE3oSNJgm0cy1BGxnKo48BhulCfaGdm1imER6hOYVoRuA6vUXdoT5U9GtHDhw==
X-Received: by 2002:a05:6a20:8c97:b0:c7:5cb6:2ff7 with SMTP id k23-20020a056a208c9700b000c75cb62ff7mr1397114pzh.22.1677830782975;
        Fri, 03 Mar 2023 00:06:22 -0800 (PST)
Received: from debian.me (subs32-116-206-28-31.three.co.id. [116.206.28.31])
        by smtp.gmail.com with ESMTPSA id r7-20020a634407000000b005038291e5cbsm918858pga.35.2023.03.03.00.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 00:06:22 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 267F1106180; Fri,  3 Mar 2023 15:06:18 +0700 (WIB)
Date:   Fri, 3 Mar 2023 15:06:18 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Intel GFX Mailing List <intel-gfx@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Manasi Navare <manasi.d.navare@intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: Re: Linux 6.2.1 hits a display driver bug (list_del corruption,
 ffff88811b4af298->next is NULL)
Message-ID: <ZAGqet3U8AMm4Uf1@debian.me>
References: <6feae796-db3f-1135-a607-cfefb0259788@gnuweeb.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SfEzHmcCPaMIkdPc"
Content-Disposition: inline
In-Reply-To: <6feae796-db3f-1135-a607-cfefb0259788@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SfEzHmcCPaMIkdPc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 03:46:56AM +0700, Ammar Faizi wrote:
> Hi,
>=20
> Linux 6.2.1 hits a display driver bug (list_del corruption, ffff88811b4af=
298->next is NULL).
>=20
> Unfortunately, I don't know the last good commit and the first bad commit.

Can you please try v6.1?

--=20
An old man doll... just what I always wanted! - Clara

--SfEzHmcCPaMIkdPc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAGqdAAKCRD2uYlJVVFO
o6tYAPsHUCjEZzvaAnu5vqweP64uXu3vAHJpeX3chmv8QC747QD9FtDdYRCRW/a6
ed37mcnX36rkPmyFZayYgbJln2MDjgg=
=8ymv
-----END PGP SIGNATURE-----

--SfEzHmcCPaMIkdPc--
