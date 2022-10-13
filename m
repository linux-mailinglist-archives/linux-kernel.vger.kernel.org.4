Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED975FDEE7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiJMR2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJMR2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:28:06 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467945F70
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:28:05 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so2403398pls.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K56PYMumQFT+Kqv2jEfiK9z/Mpa6NRNPKKY3GuP3uGc=;
        b=pIbunMeSeEOpZsxh6fxt3AcVgXmPDzebl4GAweSIrQcrgdJ53xAl3ZITGQ3R5WFuBi
         q4CJuuzikH8DYy02KRidfwfgYpqlw6Wui5J9+yLSrCsx+e35miwL1EMmq64Z/CbWtd+k
         VpkTQjimuG7jTGk4y9i7a20pzdDpGZ1OlOU6UgiM+YIokHgax0NgLdQZ4p/jhcywhigR
         6TdOPkSpHGTo5jsQ8WGCAQmWrmSfliJXhJ7hGI2BUOlroBpNh1dk+RFpUR62PIiUZzWa
         DlMITLXLKfaa2faXgGYtqT0z2Aiv4UNrTcvxSsHzGtIn3Su1tkSOakotTP+Heg1YCesg
         u5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K56PYMumQFT+Kqv2jEfiK9z/Mpa6NRNPKKY3GuP3uGc=;
        b=XSyLwAN+5Box4dsvcPF94NEjcuSsXf/d0c5swYeg3lPxk58xJvRnRs4vjcodrty9ij
         ylMbfA4OpH73HsWmwg7zkLgFlT4ulQ/M5RAG0RqWlhvuP4UvTwwqjS1uDJEPLPWYK/lP
         ciHqvYOILxMUp+ry2jzjefifmzB1UXH4vsncMbKOKTLxpcn+M9o2FKPAgOePZGS0ER9u
         e+hweE5dNNwpyQkiG0ycqEUXxGSZ8hH2bv8wJrCCG2oxcmRP9BJXZHPAchJ1KCthPZvi
         0Wijs4u1rKverWtysrJ7MqJbQrl/f5VT7fWY1svRxAfqxym/wnTa+mNOTTWTdH1nnXYN
         hJog==
X-Gm-Message-State: ACrzQf1157YRNAcBMt/JSa2QrEoYcbcgfJ2Jv382p/XSh2MsuzbQmrpJ
        yJZDwuQrQSMoOZ1L3PzHXLTB92lttQhC0w==
X-Google-Smtp-Source: AMsMyM4KzBztKFdlO5sJBaox8mmo3i1obdj9GnRLV4WG+jh9/GiPNZVtz2GtlsyYQzVgBNCxREqJyQ==
X-Received: by 2002:a17:90a:c782:b0:202:c73e:5488 with SMTP id gn2-20020a17090ac78200b00202c73e5488mr12195532pjb.202.1665682084293;
        Thu, 13 Oct 2022 10:28:04 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:8592:25b:645c:f6b6])
        by smtp.gmail.com with ESMTPSA id t16-20020aa79470000000b00562641bc0b5sm2231168pfq.132.2022.10.13.10.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 10:28:03 -0700 (PDT)
Date:   Thu, 13 Oct 2022 10:27:57 -0700
From:   Benson Leung <bleung@google.com>
To:     hellojacky0226 <hellojacky0226@hotmail.com>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>, patches@lists.linux.dev,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rory Liu <rory.liu@quanta.corp-partner.google.com>,
        Scott Chao <scott_chao@wistron.corp-partner.google.com>,
        Zhuohao Lee <zhuohao@chromium.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: platform: cros-ec: Add Kuldax to the match table
Message-ID: <Y0hKnYlG+PI8rj43@google.com>
References: <SG2PR03MB677773B78B639FE3D4523291D17E9@SG2PR03MB6777.apcprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d2gDIgcvN2a0PK8j"
Content-Disposition: inline
In-Reply-To: <SG2PR03MB677773B78B639FE3D4523291D17E9@SG2PR03MB6777.apcprd03.prod.outlook.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d2gDIgcvN2a0PK8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rory,


On Tue, Sep 06, 2022 at 11:30:16AM +0800, hellojacky0226 wrote:
> From: Rory Liu <hellojacky0226@hotmail.com>
>=20
> The Google Kuldax device uses the same approach as the Google Brask
> which enables the HDMI CEC via the cros-ec-cec driver.
>=20
> Signed-off-by: Rory Liu <hellojacky0226@hotmail.com>

Acked-By: Benson Leung <bleung@chromium.org>

Thank you!

Benson

> ---
>=20
>  drivers/media/cec/platform/cros-ec/cros-ec-cec.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c b/drivers/m=
edia/cec/platform/cros-ec/cros-ec-cec.c
> index 3b583ed4da9d..3998e56616ce 100644
> --- a/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> +++ b/drivers/media/cec/platform/cros-ec/cros-ec-cec.c
> @@ -221,6 +221,8 @@ static const struct cec_dmi_match cec_dmi_match_table=
[] =3D {
>  	{ "Google", "Moli", "0000:00:02.0", "Port B" },
>  	/* Google Kinox */
>  	{ "Google", "Kinox", "0000:00:02.0", "Port B" },
> +	/* Google Kuldax */
> +	{ "Google", "Kuldax", "0000:00:02.0", "Port B" },
>  };
> =20
>  static struct device *cros_ec_cec_find_hdmi_dev(struct device *dev,
> --=20
> 2.25.1
>=20
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--d2gDIgcvN2a0PK8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCY0hKnQAKCRBzbaomhzOw
wunFAQDyPPwgZVuprOVNbVYL2kk1o1JfSAAfQ7pb3OwgmiUIaAEAhHzNDX2QqxuG
CRpkLW+1CcQtYrLfjlyJaio8MEapCAA=
=dGCp
-----END PGP SIGNATURE-----

--d2gDIgcvN2a0PK8j--
