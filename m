Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DA1728D18
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbjFIBbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjFIBbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:31:15 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9E730E5;
        Thu,  8 Jun 2023 18:31:13 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b29f53137cso245119a34.0;
        Thu, 08 Jun 2023 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686274272; x=1688866272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqSIVqIbhvB4rmJOey1iHJ+X1yWJ58Fl1SFIwWhVA8w=;
        b=jsUAJXrHmW4EpzF1ONbKjs3hnU8sOZKSA8s1tpTQA+xcSNpKPjVYPmPwN/lBKPHOSt
         tZca40zD+Ss49oe38g3y5akjy1auIU8Hy7GgpuZxKLcPNU6BNk1tJ5PAuXHEZ6pnBJox
         rLCVqlGT5zsdYEsI7l0AQg20hUMEfWMHHQLNbgk/Z68SS5rRUmGmHJ1ndXAV7Y6/JnQk
         wILVdaMiwHbzgAOkmJe1/3cv9By5e7Gu+F8JS7DUDUDEz8+QjPUlDuaTf8KbDbqEropQ
         EIP0nEu/FoDtUmogtkXcsD0xBjx9YEBoCt/lFp7TsHZ1WPRcQ+uPe/PiJ1Y5L2tgyZrP
         fh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686274272; x=1688866272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqSIVqIbhvB4rmJOey1iHJ+X1yWJ58Fl1SFIwWhVA8w=;
        b=LryrT6scDbrgwdEPgpRKDlaQTIS6L+nao72S9rs2Pibnmq9VWXC+kTIcUdeKjuycYt
         8wv+CiRVAE0BA6JIoReYQkUW6HCuQn9UdkyCMJNdK8Q0OSIrE97pJ5FY1WUyrgAJZ5+g
         a7HEo3AAjhwawK7Ez03CHou3+KgfZ7i3IVvn+TasSFta3wlzVtowvtK2TgQ5Zd9a3o+w
         q50+IgPOEUZDU2ee1ttP7b0S+5nSWsYpECh7MNNfihawh9bcKUB8CGdE/SckxhuwSxTR
         CzEiKWOe9y+/Y5E8PqZYvxLu2xQ80pwYM3uL/v0WPQLhPjy9oqesubxb3z4Y6peOY/A+
         Tpvg==
X-Gm-Message-State: AC+VfDygnEAKiCfb3y94Ou/ae1A++vzDap1Hgl65Vl4mqN3w1yoqGL0/
        LQFHnvgh7HWzTnj1L0CCWv2JHHzflQA=
X-Google-Smtp-Source: ACHHUZ6gG30QgCfWIj0+/u7njvliCHLsh/OCuKU7WfVIO108gqyszdDpvJLLjmJmvkUNb5TMWxOCTA==
X-Received: by 2002:a05:6808:1a06:b0:39c:7d2a:435c with SMTP id bk6-20020a0568081a0600b0039c7d2a435cmr232083oib.6.1686274272491;
        Thu, 08 Jun 2023 18:31:12 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-24.three.co.id. [116.206.28.24])
        by smtp.gmail.com with ESMTPSA id m8-20020a17090a4d8800b00259a750fc89sm3551439pjh.33.2023.06.08.18.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 18:31:11 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7B4C6106A94; Fri,  9 Jun 2023 08:31:08 +0700 (WIB)
Date:   Fri, 9 Jun 2023 08:31:08 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     YYang <iyysheng@gmail.com>, jdelvare@suse.com, linux@roeck-us.net,
        corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, YYang <iyysheng@gmai.com>
Subject: Re: [PATCH] Documentation/hwmon: Fix description of
 devm_hwmon_device_unregister
Message-ID: <ZIKA3MNR1t2HvnHo@debian.me>
References: <20230608224231.1156-1-iyysheng@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SkxO4Mw1tUNGMQAP"
Content-Disposition: inline
In-Reply-To: <20230608224231.1156-1-iyysheng@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SkxO4Mw1tUNGMQAP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 09, 2023 at 02:42:30AM +0400, YYang wrote:
> From: YYang <iyysheng@gmai.com>
>=20
> Use devm_hwmon_device_register_with_info to replace
> hwmon_device_register_with_info in description of
> devm_hwmon_device_unregister.
>=20
> Signed-off-by: YYang <iyysheng@gmai.com>

Is your SoB address gmail one (sounds typo here)?

--=20
An old man doll... just what I always wanted! - Clara

--SkxO4Mw1tUNGMQAP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZIKA1wAKCRD2uYlJVVFO
ozpvAP0ZNtMzsuVLNqpN2YGo0fQquHjfI80lWbvv+5Ntg7Eg7AEAnP02qG+MXcdp
0YZUc2EMyxgYJVgnJzTDNc/Z/RhkvQs=
=p3Nb
-----END PGP SIGNATURE-----

--SkxO4Mw1tUNGMQAP--
