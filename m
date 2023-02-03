Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5809B6897B8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjBCL1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjBCL13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:27:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8D99D4D;
        Fri,  3 Feb 2023 03:27:26 -0800 (PST)
Received: from mercury (unknown [37.81.13.16])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 48E056602E87;
        Fri,  3 Feb 2023 11:27:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675423645;
        bh=D98rQM+fEax85Ks9+tvSm7CBvWW2ns6/rMUaRFKi5+4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgigG2yNZAWiShf5dof1jWsDWNeeIjQhAOWVSIQvb0pbGiZydOcYLXfLib799rMOU
         hjW8Yu7nzK0Cs5NTxqtzsxEWOdgFXXtDWaIo10rbRXq7dSyL/s+afxQEj12U9Vwk0K
         Sa84VMkpXHiISS1XppOowGfzy2oXaStzzx99sZk6aVKcI0k9et9grM+8kJ4QRgUbAn
         eeaafo6lrSDpV2uCpHmIVuByoZb4PNwhJid2iwyhrrFhNXQ/wElrZEwgVwOVMGI50R
         dkkD492/87adSN54cXYeYOuqFKGiw96mFieOppiFEXc8wc+g2N4dKlGyoUhvlaOCxp
         4EybjSLSjRVHQ==
Received: by mercury (Postfix, from userid 1000)
        id 771131060930; Fri,  3 Feb 2023 12:27:20 +0100 (CET)
Date:   Fri, 3 Feb 2023 12:27:20 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 4/4] power: supply: Introduce Qualcomm PMIC GLINK
 power supply
Message-ID: <20230203112720.oa7e2psevbazicqo@mercury.elektranox.org>
References: <20230201041853.1934355-1-quic_bjorande@quicinc.com>
 <20230201041853.1934355-5-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ab6rsa56fkougaat"
Content-Disposition: inline
In-Reply-To: <20230201041853.1934355-5-quic_bjorande@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ab6rsa56fkougaat
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 31, 2023 at 08:18:53PM -0800, Bjorn Andersson wrote:
=2E..
> +static const enum power_supply_property sm8350_bat_props[] =3D {
> +	POWER_SUPPLY_PROP_STATUS,
> +	POWER_SUPPLY_PROP_HEALTH,
> +	POWER_SUPPLY_PROP_PRESENT,
> +	POWER_SUPPLY_PROP_CHARGE_TYPE,
> +	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_VOLTAGE_OCV,
> +	POWER_SUPPLY_PROP_VOLTAGE_NOW,
> +	POWER_SUPPLY_PROP_VOLTAGE_MAX,
> +	POWER_SUPPLY_PROP_CURRENT_NOW,
> +	POWER_SUPPLY_PROP_TEMP,
> +	POWER_SUPPLY_PROP_TECHNOLOGY,
> +	POWER_SUPPLY_PROP_CHARGE_COUNTER,
> +	POWER_SUPPLY_PROP_CYCLE_COUNT,
> +	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
> +	POWER_SUPPLY_PROP_CHARGE_FULL,

no CHARGE_NOW?

> +	POWER_SUPPLY_PROP_MODEL_NAME,
> +	POWER_SUPPLY_PROP_TIME_TO_FULL_AVG,
> +	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
> +	POWER_SUPPLY_PROP_POWER_NOW,
> +};

=2E..

> +static struct auxiliary_driver qcom_battmgr_driver =3D {
> +	.name =3D "pmic_glink_power_supply",
> +	.probe =3D qcom_battmgr_probe,
> +	.id_table =3D qcom_battmgr_id_table,
> +};
> +
> +static int __init qcom_battmgr_init(void)
> +{
> +	return auxiliary_driver_register(&qcom_battmgr_driver);
> +}
> +module_init(qcom_battmgr_init);
> +
> +static void __exit qcom_battmgr_exit(void)
> +{
> +	auxiliary_driver_unregister(&qcom_battmgr_driver);
> +}
> +module_exit(qcom_battmgr_exit);

module_auxiliary_driver()

Otherwise LGTM.

-- Sebastian=20

--ab6rsa56fkougaat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPc75UACgkQ2O7X88g7
+pr4fw//Z1DMQADqDkOFF9D967X8R7vHQhf+RCwXgMknxBdCaIw650zcMzdKH+9L
9PCr4nFXlHIqMUYaTaEFV5BTitoCPdKGCoQ0fKMzeHYvX/LYlZhjD3HYyhhOQaLF
iZRR5IuX1iW0TG6Kv0GKd8hZxHH2/VdaYZYUESAPJa6qX6/k/zc+D4AYc5PxRzuZ
D8avHBiwts+3zZnSaAlaNBh51jeHrfMGwZCU93gbySXhatHzQGDFatV1UNr34/j4
ZWPCn8pgCTBTIfg8qeXEDmteYwkHt61CBZu7j2A1h367g8pbz+KInZlZAMlipEHF
SK7EHwO30m5AK6Fz+kJKWiNxL80O1WqUwvoUCJ6tivPCFKEB+/FUjWs0GZ5OvZfX
i9R/dB0FXuACz59pPJkS8rk1q5lZtBgSHV1kgrI/dIgxFSf2y078UiJwX0JTSBhw
Rqk/VehvCHlXO1Qs3J3EOKiHu7l0VpSfQsRUBbLnichQQurg+/uzaJZ2OYULQ2do
+uQUrp/8gfl/a5lBN2r7P3YaBzEj3YHNEfRhAf9RW96XzUSe5nncv7cIu6ftfAtO
r6OK4Or2ntCuaTLATnllK+9fIKUPNArPh2ggU98ZBERXR0zsgGHwEZRGOYiYcswx
dU+1oqzEt3TDZq77KlVjZR6hlOwvOeHM/ExI763HwvolUkkttdQ=
=PQ0S
-----END PGP SIGNATURE-----

--ab6rsa56fkougaat--
