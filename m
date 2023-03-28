Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DAD6CB4C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 05:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjC1DRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 23:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1DR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 23:17:28 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20CC213B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:17:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id h12-20020a17090aea8c00b0023d1311fab3so11115970pjz.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 20:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679973446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jw7yReAk3VOvsGBhP66wJ4CRjXSFV5glxoiCJvxn66Q=;
        b=YT9ARZTQ8/OsxeyZ4/5E148b1pITYNsuOPPNNda85SA5uDUI6uCmqISFkIYyko0oaA
         boXjBYiyOnxzxICwMI8bH6RZVqgF1bqSrVkU7gbwX1ylSdGttG4ulHL+Blmotyw+mS0j
         6x7iO6W5Aa5/OqgnXfrKBCeL46PAq50+JFPwE4tQtO3ND0k/VPQFwyyflb2qtGg2kf27
         HGMSi5uLJubHx5NbTNYWv3Vq2/tDVsXi/noGGzOxbz8+BTOE2Nui4jqxUfFFmyGn2By2
         3ylgLxnAB/9LdZM+4Veosits9g8cIHHn7RTn3GKqwUsFirDgZ66To5Ukn47IYr0Lg95p
         tElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679973446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jw7yReAk3VOvsGBhP66wJ4CRjXSFV5glxoiCJvxn66Q=;
        b=4lrlRnQk5PYQFi9lN+9flj4BKGVNXuneHd4bmaqdMWIxSiDsKaCIUZJx0YWJ+7w8tn
         wOuKCgVaicUNrNEmjrJkQGiKo+GWQjS/OMaV/IOS7gH6MDqIS5W6yzlAtWFahp0ON9+L
         pK1XcNqQMiInro97pJzEPjgWAM/Mtib88sd4ujft3oxs7r98FUdW/U643u+s52nuoOfg
         TJpr2ys8gwVoZJFlJfNP4bhQIqhUEISAZ1U+7ox9G0wzA7DZhQJrBV5TKIKKqmJOSZDH
         Jn+/rTwKlfVrIG1xmz4+C0eh8Vrjzcp4+hnR2Tq1quOIPOplEi+ZwMwCRlZE3Yf1yVGB
         D0Tg==
X-Gm-Message-State: AAQBX9fY3gjjKCLKQZBuzwcvNHJkBMeSNSmMFAngCBh4JRfgrJl/Lvbz
        P3l/f5xwCZdsFOszkEJSYjDY7YWsbkO9kA==
X-Google-Smtp-Source: AKy350aTRGWQatoqr1FKxk8K1JhwCFFqLYb8lluUvee/jgxMMUiBM0lXk447024rzwh8tbdrBOe2CA==
X-Received: by 2002:a17:902:f550:b0:1a1:d70f:7114 with SMTP id h16-20020a170902f55000b001a1d70f7114mr17552846plf.14.1679973445978;
        Mon, 27 Mar 2023 20:17:25 -0700 (PDT)
Received: from debian.me (subs10b-223-255-225-224.three.co.id. [223.255.225.224])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902bf4600b001a04faf5442sm19940790pls.83.2023.03.27.20.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 20:17:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0294B10673E; Tue, 28 Mar 2023 10:17:21 +0700 (WIB)
Date:   Tue, 28 Mar 2023 10:17:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jerry Chuang <jerry-chuang@realtek.com>
Subject: Re: [PATCH v3 1/4] staging: rtl8192u: remove change history from
 comments
Message-ID: <ZCJcQStZ8h0m+XfF@debian.me>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com>
 <95fff39231ebb2bb683c2a8f252a93f4845fffb1.1679945728.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rGBHKbcGHi9rELHU"
Content-Disposition: inline
In-Reply-To: <95fff39231ebb2bb683c2a8f252a93f4845fffb1.1679945728.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rGBHKbcGHi9rELHU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 12:49:06AM +0500, Khadija Kamran wrote:
> Remove the change history information as it is not required in the
> comments.

(also Cc: original driver author)

What about below?

```
Remove obsolete change history info as developers can simply use git to
browse commit history of the driver.
```

>=20
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.c | 45 ----------------------------
>  1 file changed, 45 deletions(-)
>=20
> diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl81=
92u/r8192U_dm.c
> index 6a33ca02c3dc..b1ebb776fc42 100644
> --- a/drivers/staging/rtl8192u/r8192U_dm.c
> +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> @@ -7,12 +7,6 @@ Module Name:
> =20
>  Abstract:
>  	HW dynamic mechanism.
> -
> -Major Change History:
> -	When		Who				What
> -	----------	--------------- -------------------------------
> -	2008-05-14	amy                     create version 0 porting from window=
s code.
> -
>  --*/
>  #include "r8192U.h"
>  #include "r8192U_dm.h"
> @@ -274,11 +268,6 @@ void init_rate_adaptive(struct net_device *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	05/26/08	amy	Create version 0 porting from windows code.
> - *
>   *----------------------------------------------------------------------=
-----*/
>  static void dm_check_rate_adaptive(struct net_device *dev)
>  {
> @@ -1589,11 +1578,6 @@ static void dm_bb_initialgain_backup(struct net_de=
vice *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	05/15/2008	amy		Create Version 0 porting from windows code.
> - *
>   *----------------------------------------------------------------------=
-----*/
>  static void dm_dig_init(struct net_device *dev)
>  {
> @@ -1634,10 +1618,6 @@ static void dm_dig_init(struct net_device *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	05/27/2008	amy		Create Version 0 porting from windows code.
>   *----------------------------------------------------------------------=
-----*/
>  static void dm_ctrl_initgain_byrssi(struct net_device *dev)
>  {
> @@ -1850,11 +1830,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_ala=
rm(
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	05/28/2008	amy		Create Version 0 porting from windows code.
> - *
>   *----------------------------------------------------------------------=
-----*/
>  static void dm_ctrl_initgain_byrssi_highpwr(
>  	struct net_device *dev)
> @@ -2269,11 +2244,6 @@ static void dm_ctstoself(struct net_device *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	05/28/2008	amy	Create Version 0 porting from windows code.
> - *
>   *----------------------------------------------------------------------=
-----*/
>  static	void	dm_check_pbc_gpio(struct net_device *dev)
>  {
> @@ -2303,11 +2273,6 @@ static	void	dm_check_pbc_gpio(struct net_device *d=
ev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	01/30/2008	MHC		Create Version 0.
> - *
>   *----------------------------------------------------------------------=
-----*/
>  void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
>  {
> @@ -2552,11 +2517,6 @@ static void dm_rxpath_sel_byrssi(struct net_device=
 *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	05/28/2008	amy		Create Version 0 porting from windows code.
> - *
>   *----------------------------------------------------------------------=
-----*/
>  static void dm_check_rx_path_selection(struct net_device *dev)
>  {
> @@ -2871,11 +2831,6 @@ void dm_check_fsync(struct net_device *dev)
>   * Output:		NONE
>   *
>   * Return:		NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	03/06/2008	Jacken	Create Version 0.
> - *
>   *----------------------------------------------------------------------=
-----
>   */
>  static void dm_init_dynamic_txpower(struct net_device *dev)

The rest is LGTM, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--rGBHKbcGHi9rELHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCJcPgAKCRD2uYlJVVFO
o12IAQD9EmNeF/Bbc+GfRrT/b+ohjtRrSrUNupRvOW7St/eZkwD+OPQL8lzsHcFm
EyF0xex4v1wbT5V1teGsJVYg01xMbw8=
=avUM
-----END PGP SIGNATURE-----

--rGBHKbcGHi9rELHU--
