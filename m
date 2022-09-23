Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AF5E7CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiIWOMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiIWOMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:12:33 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80026F1906
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:12:31 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id a20so47405qtw.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=jigkqPPzf/H5aNdoNosNYAVSQSu3V0CC1JsZZy4DU3Q=;
        b=rqOOk7/NYyaOxJYVOmirDCJJ2ngotTr9LJOwiaXHsTfFxq/BHhllKaSbpdIrvTX3jO
         qmGXkmnrN15o0E98V5pFOvSJfDzRioO7VukNYR674xN96GXL2S+lFYS5Oqvng97lbiDf
         HIwDnDjNwPUXW0ybaVeTJ5PLEK55YWLz0kN6+htpzV4xQwSHX9k8yXuhlP/EKUvVMica
         jp8tRRGnMf3Fd7wiwxdF6y7nddifPJ6tvi++t/oXo+XVLH68nhWHeF0FlOdAD4Q7O5OI
         VZjtJkOnyE7Kros/FY+ntfCc/u14QAO0Wby7FUlvACboNV5WbvZ1Q8bNpn/GKTyrQISJ
         Y+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jigkqPPzf/H5aNdoNosNYAVSQSu3V0CC1JsZZy4DU3Q=;
        b=3TQqWyxsdL+bWDdtZikd290BStQiu+Uq3qEPc2qD68qYDFXrfCMd+3qWmhDKcdy3fr
         OLAhOXh22rGe6VPpxmLgZKhrbB9MwtZPBAjgLI5o6z5zw/0nXHfwxfvqfDxG18azF/gI
         Jwmsd3if9dd/CF4UG7lCR5zBLNJGvYmw/lG4hOXAwqD103DaBbHJN2bJVdQ1FOGWMeN7
         fnvGNY0CHhumk5rXoPOb/55TPNR1LNUR/MGqXKN11P/TJkehnNIF16XOA7U+ciWbwnBk
         MyPNGuERsb34SoPxXrGQUi3F/BsFATcYIA5dZL4n6bME7AZzf/LtoTig5ci3t6dOp8Rn
         DFmw==
X-Gm-Message-State: ACrzQf2gFvDPYHKjToTseJeRlzNJWrzfZKfjyHRpzNrFvgy+78vxh6tz
        A9KRfOXJSnGB2yzC/PPMYq0mzw==
X-Google-Smtp-Source: AMsMyM6ctE2sNUK/Rfz59Gn1Z1oDRk5BgvPFfJ7ZBmmNAhFDB2c3IMpLL33qTe1hRdO4/nVvIAby4A==
X-Received: by 2002:ac8:5c8c:0:b0:35d:4c5:7e2a with SMTP id r12-20020ac85c8c000000b0035d04c57e2amr7327175qta.293.1663942350518;
        Fri, 23 Sep 2022 07:12:30 -0700 (PDT)
Received: from fedora ([204.156.113.250])
        by smtp.gmail.com with ESMTPSA id v6-20020a05620a0f0600b006bc0980db76sm6152790qkl.126.2022.09.23.07.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:12:30 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:09:32 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v8 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Message-ID: <Yy2wDPITCZ/J01Xr@fedora>
References: <20220922170402.403683-1-jpanis@baylibre.com>
 <20220922170402.403683-4-jpanis@baylibre.com>
 <Yy0G9a5S3OzwyEwW@fedora>
 <2f3e5036-caab-f892-a4ad-b852f72db331@baylibre.com>
 <Yy2aAMv5PRjsJ4s2@fedora>
 <923f5876-d692-7e0e-f351-f0e05869ccd8@baylibre.com>
 <8a60b6a0-9289-0d89-c543-02386a721bca@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XPKB3zJM2TKbw2gr"
Content-Disposition: inline
In-Reply-To: <8a60b6a0-9289-0d89-c543-02386a721bca@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XPKB3zJM2TKbw2gr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 02:32:26PM +0200, Julien Panis wrote:
>=20
>=20
> On 23/09/2022 14:17, Julien Panis wrote:
> >=20
> >=20
> > On 23/09/2022 13:35, William Breathitt Gray wrote:
> > > On Fri, Sep 23, 2022 at 09:23:26AM +0200, Julien Panis wrote:
> > > >=20
> > > > On 23/09/2022 03:08, William Breathitt Gray wrote:
> > > > > On Thu, Sep 22, 2022 at 07:04:01PM +0200, Julien Panis wrote:
> > > > > > ECAP hardware on TI AM62x SoC supports capture feature.
> > > > > > It can be used
> > > > > > to timestamp events (falling/rising edges) detected on input si=
gnal.
> > > > > >=20
> > > > > > This commit adds capture driver support for ECAP
> > > > > > hardware on AM62x SoC.
> > > > > >=20
> > > > > > In the ECAP hardware, capture pin can also be configured to be =
in
> > > > > > PWM mode. Current implementation only supports capture
> > > > > > operating mode.
> > > > > > Hardware also supports timebase sync between multiple instances=
, but
> > > > > > this driver supports simple independent capture functionality.
> > > > > >=20
> > > > > > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > > > > Hello Julien,
> > > > >=20
> > > > > Comments follow inline below.
> > > > >=20
> > > > > > +/**
> > > > > > + * struct ecap_cnt_dev - device private data structure
> > > > > > + * @enabled: device state
> > > > > > + * @clk:=A0=A0=A0=A0 device clock
> > > > > > + * @regmap:=A0 device register map
> > > > > > + * @nb_ovf:=A0 number of overflows since capture start
> > > > > > + * @pm_ctx:=A0 device context for PM operations
> > > > > > + */
> > > > > > +struct ecap_cnt_dev {
> > > > > > +=A0=A0=A0 bool enabled;
> > > > > > +=A0=A0=A0 struct clk *clk;
> > > > > > +=A0=A0=A0 struct regmap *regmap;
> > > > > > +=A0=A0=A0 atomic_t nb_ovf;
> > > > > > +=A0=A0=A0 struct {
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 u8 ev_mode;
> > > > > > +=A0=A0=A0=A0=A0=A0=A0 u32 time_cntr;
> > > > > > +=A0=A0=A0 } pm_ctx;
> > > > > > +};
> > > > > Provide documentation for the ev_mode and time_cntr members. You
> > > > > probably need a lock as well to protect access to this structure =
or
> > > > > you'll end up with race problems.
> > > > Hi William,
> > > >=20
> > > > How can I end up with race problems ? pm_ctx members are only
> > > > accessed at
> > > > suspend (after capture/IRQ are disabled) and resume (before
> > > > capture/IRQ are
> > > > re-enabled).
> > > > Is there any risk I did not identify ?
> > > >=20
> > > > Julien
> > > I was thinking of the ecap_cnt_dev enabled member. The Counter callba=
cks
> > > may execute in concurrent threads, so races can appear when you access
> > > members of the ecap_cnt_dev structure in these callbacks.
> > >=20
> > > Take for example this section of ecap_cnt_enable_write():
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0 if (enable =3D=3D ecap_dev->enabled)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> > > =A0=A0=A0=A0=A0=A0=A0=A0 if (enable)
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ecap_cnt_capture_ena=
ble(counter);
> > > =A0=A0=A0=A0=A0=A0=A0=A0 else
> > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ecap_cnt_capture_dis=
able(counter);
> > > =A0=A0=A0=A0=A0=A0=A0=A0 ecap_dev->enabled =3D enable
> > >=20
> > > Suppose two threads try to enable the count capture. A race condition=
 is
> > > present where the two threads could see ecap_dev->enabled as false and
> > > both proceed to call ecap_cnt_capture_enable(). This results in
> > > pm_runtime_get_sync() bumping the usage count twice and we're left wi=
th
> > > a mismatch the next time ecap_cnt_capture_disable() is called.
> > >=20
> > > William Breathitt Gray
> >=20
> > OK, If I understand well there's the same problem with IO access with
> > regmap ?
> > Julien
>=20
> [ERRATUM] It seems that some spinlock is already used by regmap API.
> So, only the 'enabled' member needs a lock.

Keep in mind that although individual regmap API calls can be considered
atomic, the order of the calls made could be a point of race if there
are concurrent threads. However, in your particular driver it looks
you're fine as long as access to 'enabled' is protected.

William Breathitt Gray

--XPKB3zJM2TKbw2gr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYy2wDAAKCRC1SFbKvhIj
KyNpAQCvH/rPZZz1R4Vh3ZDkM0LwoAjB6xLQsH7OrXS24uapFgD+L+lRKRh0hTw2
DUe0T8mhULo6o9b3NMlQEXOY3diuQQU=
=RAH6
-----END PGP SIGNATURE-----

--XPKB3zJM2TKbw2gr--
