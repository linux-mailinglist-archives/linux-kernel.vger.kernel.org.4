Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C59568A8CF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 08:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjBDHkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 02:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBDHkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 02:40:47 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC688F2A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 23:40:46 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id ay1so5220956pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 23:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YzBD3RjkEQVXJjAd0KjuXJvflPQdSU1uG45LcQ+axyA=;
        b=RENpDL0ormsJ7IFq6XOd33iTswafvREQmPa21GqLxJNFQC37/1N13rjNCBT7deojSy
         ZbkMTw3VYSxFIlnCvRVDCRqmvYxg68C0rMnCqqvSMY6tKd0gjbSZLrOxlV0npZSCLx4G
         Ki8QZYdm9dQAdoN3atlUHhLhnr9NXrxlPPdlLj5A76ECh2Mr4FA1cTf9wJTvyS6xrLEe
         OBL10SqFxg2t7+yDgsVwcb7YaNiCcWxJLYmVFL2bJNVYsFdXd4Ri8/Ob6i9Rp4qjPrq5
         8JDx1Q7ItLHT4lznnpPdXR9/ymGt/jRDwtfMQ0dgUmkmMsJAOPvZMMhavafPvIC2MIOD
         3zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzBD3RjkEQVXJjAd0KjuXJvflPQdSU1uG45LcQ+axyA=;
        b=2AOtYe3IG/ruQ2r2qH8K8Dqlo/81H7HE3hHd65itNFXZMOo25OgjOf7QHiDrw6vN8G
         hZYMBdDKrkiSQdAgHdY0yndN80k4+Mu7199cqnTHskYzA3rSA4I2+tVUoRzC9tfYFV4M
         EW9WH8DNb0nAGsM6Yz2GWlpbdcpXaLHMh8ahbmDtxEQfziIZDiY7uMDgAFqX87R5zH6y
         ndU5zZyhkZ46ehJHaVKSresG/VnNKREvUwowv9+nxiU9b6fwdKsxsKScSZUeI8tlcV1B
         qZ5v6MSrzq9x68Kccvt1tKK4g8riKTofBod8SneX3qRe/bmtwznVUTBl2niEO03v4JMN
         txDw==
X-Gm-Message-State: AO0yUKVl5RUJmY5uMTanr1tMeQnpXBR5E3N07vGduMJASdKn/TRm4ut0
        jDLYN+qqTYDTny2L8f84Cqg=
X-Google-Smtp-Source: AK7set8f0i9EA2P3Rw+dA8chIk/luv7g0KrwFPb+ge3eiVKIkln864swiKltUWk2WX1RAHyR31htCA==
X-Received: by 2002:a05:6a00:1493:b0:593:92b5:d99f with SMTP id v19-20020a056a00149300b0059392b5d99fmr15602140pfu.32.1675496445847;
        Fri, 03 Feb 2023 23:40:45 -0800 (PST)
Received: from debian.me (subs28-116-206-12-54.three.co.id. [116.206.12.54])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00170100b00593c1c5bd0esm3047340pfc.164.2023.02.03.23.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 23:40:45 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 245E310544C; Sat,  4 Feb 2023 14:40:41 +0700 (WIB)
Date:   Sat, 4 Feb 2023 14:40:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Regarding checkpatch camelcase issues
Message-ID: <Y94L+WNGGfvrg6Mg@debian.me>
References: <Y93eQqaYdL146Z65@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ivj1S5qjuJSsAg1Z"
Content-Disposition: inline
In-Reply-To: <Y93eQqaYdL146Z65@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ivj1S5qjuJSsAg1Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 04, 2023 at 05:25:38AM +0100, Guru Mehar Rachaputi wrote:
> Thanks for your support.
>=20
> I wanted to confirm if each checkpatch encounter for camelcase issue shou=
ld
> be fixed in a new patch?
>=20
> For example: If the issue is with same variable, then multiple
> modifications can be made in one patch.
>=20
>   -> above example is OK
>=20
>=20
> For example: If the issue is with multiple variables, then multiple
> modifications can be made in one patch.
>=20
>   -> above example is NOT OK / NG
>=20
>=20
> Please confirm me if my understanding is correct?
>=20

I guess you have generated a patch series, then check it through
checkpatch.

Indeed, if checkpatch complains at a particular patch, you need to do
interactive rebase. Make sure that rebase todo list contains "edit"
lines on commit you want to fix up. After that, fix these complaints.

When you're done, regenerate the patch series and make sure that there
are no checkpatch complains on it.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ivj1S5qjuJSsAg1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY94L8wAKCRD2uYlJVVFO
o7jzAP95k4n/aGC4fwMnL9mTEDmSh8/gjE0F7vHOUPzIevrIlQEA7sQ+Q5aaZuxp
dmk2UwL1HJVw+rJcqhwTcl41yGmDYQs=
=pqbf
-----END PGP SIGNATURE-----

--ivj1S5qjuJSsAg1Z--
