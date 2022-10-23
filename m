Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D566093AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiJWNgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJWNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:35:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E92C6A4B0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:35:52 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h185so6570863pgc.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7z7YqZZVbpAlAQvHExqoCDqTGuVoNoLe8669wm15dZQ=;
        b=X1QU2qo7zbp0vSQFgaWQd9/E/APQZawGwjkDIxtoMead8XocGOf60T2kMam0HO3bLp
         pnYd5zmI5vPm2MYUDGEcqdXPXq48gb4MyDs3OSUJAG3nDGM9Mhpn0pSUKVyi1tqZAZTP
         7z0+oGGDGCrHTBtYyFkuHfOgIN9CVrwmpFls4rxjigNVJeWAomb4fq9sTUYeQ4k3Vdgh
         kdo21BJsD66YrssTxjOmhXYRrTYYzqWaIZx5aqZxBk7ckSnaynCjvc2Eb0rjARQlj52w
         pVQs/eioAjjTWmH1PACCwVOgbW5pXvp9uqj4BGbppp9AVEyKZWzs6qq/baTwbKREIc3j
         sFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7z7YqZZVbpAlAQvHExqoCDqTGuVoNoLe8669wm15dZQ=;
        b=cKNgor5d/gAJox0is6KLBViu0PxgPyM418k0NtoRbjduKAPljBjPH4dbbv9eKHbvb3
         aARReuYuBsJru19Xee+N1OCBoWJu5Rkk4IOAN2sHicsLuIgEn/ES451b8DLSVii8lRhI
         4ihmgU+R065U5Tvb478Je5keIQ+fDShd1fLp0s51ePpzw8k5u7/j4lpmFwMlLNBsW5tZ
         X0S85qAlDN1uONI4RV4NXNYig6UG+aXDdmArah27azoGywD1Vhoj+zANDxUhu6rzNyvN
         nXTUdhZozZ/+/bbLCpUVifZ9mL3GeY20Vsd90bElnrfxVP05QQZnuaSuGDv2b72rkAbL
         pdpg==
X-Gm-Message-State: ACrzQf1QjI9g2p6MvyD2Fg3MIdEeju/yWSyoX67IcVEih9scQ7Y20DFS
        J4ollJnhW7Z8bhbaZtCXkUM=
X-Google-Smtp-Source: AMsMyM5K8ktLCq8rquQ11MICFwPrZxwfEWif2dHkxiDXAgW3bgpbFWSAvGNz86OG1fZWT3TkhiS1aA==
X-Received: by 2002:a63:1b58:0:b0:45f:e7ba:a223 with SMTP id b24-20020a631b58000000b0045fe7baa223mr23273411pgm.548.1666532151686;
        Sun, 23 Oct 2022 06:35:51 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id e1-20020a17090301c100b0016eef326febsm4772754plh.1.2022.10.23.06.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 06:35:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id C6FC81005FC; Sun, 23 Oct 2022 20:35:47 +0700 (WIB)
Date:   Sun, 23 Oct 2022 20:35:47 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: remove commented debug printk
 messages
Message-ID: <Y1VDM2kWIi1I5dqI@debian.me>
References: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="poWQKV2hrqk2xXjk"
Content-Disposition: inline
In-Reply-To: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--poWQKV2hrqk2xXjk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 22, 2022 at 01:03:42AM +0530, Deepak R Varma wrote:
> diff --git a/drivers/staging/wlan-ng/p80211netdev.c b/drivers/staging/wla=
n-ng/p80211netdev.c
> index e04fc666d218..6bef419e8ad0 100644
> --- a/drivers/staging/wlan-ng/p80211netdev.c
> +++ b/drivers/staging/wlan-ng/p80211netdev.c
> @@ -881,55 +881,42 @@ static int p80211_rx_typedrop(struct wlandevice *wl=
andev, u16 fc)
>  		wlandev->rx.mgmt++;
>  		switch (fstype) {
>  		case WLAN_FSTYPE_ASSOCREQ:
> -			/* printk("assocreq"); */
>  			wlandev->rx.assocreq++;
>  			break;
>  		case WLAN_FSTYPE_ASSOCRESP:
> -			/* printk("assocresp"); */
>  			wlandev->rx.assocresp++;
>  			break;
>  		case WLAN_FSTYPE_REASSOCREQ:
> -			/* printk("reassocreq"); */
>  			wlandev->rx.reassocreq++;
>  			break;
>  		case WLAN_FSTYPE_REASSOCRESP:
> -			/* printk("reassocresp"); */
>  			wlandev->rx.reassocresp++;
>  			break;
>  		case WLAN_FSTYPE_PROBEREQ:
> -			/* printk("probereq"); */
>  			wlandev->rx.probereq++;
>  			break;
>  		case WLAN_FSTYPE_PROBERESP:
> -			/* printk("proberesp"); */
>  			wlandev->rx.proberesp++;
>  			break;
>  		case WLAN_FSTYPE_BEACON:
> -			/* printk("beacon"); */
>  			wlandev->rx.beacon++;
>  			break;
>  		case WLAN_FSTYPE_ATIM:
> -			/* printk("atim"); */
>  			wlandev->rx.atim++;
>  			break;
>  		case WLAN_FSTYPE_DISASSOC:
> -			/* printk("disassoc"); */
>  			wlandev->rx.disassoc++;
>  			break;
>  		case WLAN_FSTYPE_AUTHEN:
> -			/* printk("authen"); */
>  			wlandev->rx.authen++;
>  			break;
>  		case WLAN_FSTYPE_DEAUTHEN:
> -			/* printk("deauthen"); */
>  			wlandev->rx.deauthen++;
>  			break;
>  		default:
> -			/* printk("unknown"); */
>  			wlandev->rx.mgmt_unknown++;
>  			break;
>  		}
> -		/* printk("\n"); */
>  		drop =3D 2;
>  		break;
>=20
> @@ -943,35 +930,27 @@ static int p80211_rx_typedrop(struct wlandevice *wl=
andev, u16 fc)
>  		wlandev->rx.ctl++;
>  		switch (fstype) {
>  		case WLAN_FSTYPE_PSPOLL:
> -			/* printk("pspoll"); */
>  			wlandev->rx.pspoll++;
>  			break;
>  		case WLAN_FSTYPE_RTS:
> -			/* printk("rts"); */
>  			wlandev->rx.rts++;
>  			break;
>  		case WLAN_FSTYPE_CTS:
> -			/* printk("cts"); */
>  			wlandev->rx.cts++;
>  			break;
>  		case WLAN_FSTYPE_ACK:
> -			/* printk("ack"); */
>  			wlandev->rx.ack++;
>  			break;
>  		case WLAN_FSTYPE_CFEND:
> -			/* printk("cfend"); */
>  			wlandev->rx.cfend++;
>  			break;
>  		case WLAN_FSTYPE_CFENDCFACK:
> -			/* printk("cfendcfack"); */
>  			wlandev->rx.cfendcfack++;
>  			break;
>  		default:
> -			/* printk("unknown"); */
>  			wlandev->rx.ctl_unknown++;
>  			break;
>  		}
> -		/* printk("\n"); */
>  		drop =3D 2;
>  		break;
>=20
> @@ -1007,7 +986,6 @@ static int p80211_rx_typedrop(struct wlandevice *wla=
ndev, u16 fc)
>  			wlandev->rx.cfack_cfpoll++;
>  			break;
>  		default:
> -			/* printk("unknown"); */
>  			wlandev->rx.data_unknown++;
>  			break;
>  		}

Shouldn't these printks be guarded under CONFIG_DEBUG_KERNEL instead?

--=20
An old man doll... just what I always wanted! - Clara

--poWQKV2hrqk2xXjk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1VDLwAKCRD2uYlJVVFO
oyncAQCxZQScet80h1V0jIpeJeicBZGgSrtnUhtAia3r9SOb0AEAobtYi8GrOk/3
jJZ/0L5cff15DnBaSAb6Wi3y5TUryAg=
=8oiv
-----END PGP SIGNATURE-----

--poWQKV2hrqk2xXjk--
