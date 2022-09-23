Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A5A5E7146
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbiIWBNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiIWBNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:13:45 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA786115A58
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:13:33 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-12c8312131fso16379251fac.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2BBAQBVpQ8fXKmes7SQw9/PDpetGobnws+Vor3/B+A0=;
        b=V1yvgkxoyU/dThLL9TTrsz8DBaGhI/bZIBapBaw5bStsYTbBrSlbORj/zYoEKopoz8
         cvRGXpv9D3hFZzdHPeKXQX+wUNOtINR1v7flrGgfyWcjXUkAi9vguzc6dybjHcXxASH2
         qPi/DVTY2Sdp9+cnzaXsYASKeDi/vtfO5dSCCDPXlqjeedSXuCw0Q3ult302E/KOmZ4r
         rQB8SPV8YM3NkRSM3R3YkUnnH88FrX5DhnHYxrzkNOIv/pjEKIBVlf1arCOTiyVETyN3
         mu9CdaK13/N1cyb3D+GYjxGPj5s9/0M4sfkbfAT+tXiNxywf9Xc8UsuAB5fucbAbHQxL
         PxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2BBAQBVpQ8fXKmes7SQw9/PDpetGobnws+Vor3/B+A0=;
        b=RdYYVlc+tGXpD2L4v6IAjS9qyntjIVedpnX2mnUBH1v6vcsj16+duLwcKiouh1Wxsd
         iExrEiTEQcxAGcV1ZujNqoAILL47z5GNAMdSXZZDkPBYQRA2OwEUbPBRllbj+pnDcDUA
         Qk+cUXS61OiSBZzGgaUZYsHow3yCjn7ANFjV2n40WHg46WLWhYck0DTSEkFLswTOWXCa
         13APjCySZjWoNvMhvCgaRd5LqRGke9l1ISJ7FwieK1soXD0WzZCxioMLs1N3x6vvw9lt
         tkm/yUOCN5kNXpe5ZPpE2W2l1jsk0Eo6tn7txfb90xW7n5zbGn3uJYzXKv8gXi9aPQ4Z
         WPJw==
X-Gm-Message-State: ACrzQf0xO3TyiiYKoRJZuw3AgvVd0KBZPbkh1kuw/nZLr3wodeqEiu5d
        oqKaEB8GcaV9BxkCv5iQmVHnJTz8fa+g6g==
X-Google-Smtp-Source: AMsMyM4y72P7l45Eoh9rVYWaDDqTIPviU+AVVtECUCPHTW7UrA53sCd5HY2mhu2iysRQXSICYV7aOQ==
X-Received: by 2002:a05:6870:639e:b0:127:bbc2:223e with SMTP id t30-20020a056870639e00b00127bbc2223emr3665823oap.167.1663895612843;
        Thu, 22 Sep 2022 18:13:32 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i21-20020a056820013500b00432ac97ad09sm2780618ood.26.2022.09.22.18.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 18:13:32 -0700 (PDT)
Date:   Thu, 22 Sep 2022 21:08:05 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v8 3/4] counter: ti-ecap-capture: capture driver support
 for ECAP
Message-ID: <Yy0G9a5S3OzwyEwW@fedora>
References: <20220922170402.403683-1-jpanis@baylibre.com>
 <20220922170402.403683-4-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8oIR1Oj1QlTXqeTr"
Content-Disposition: inline
In-Reply-To: <20220922170402.403683-4-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8oIR1Oj1QlTXqeTr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 22, 2022 at 07:04:01PM +0200, Julien Panis wrote:
> ECAP hardware on TI AM62x SoC supports capture feature. It can be used
> to timestamp events (falling/rising edges) detected on input signal.
>=20
> This commit adds capture driver support for ECAP hardware on AM62x SoC.
>=20
> In the ECAP hardware, capture pin can also be configured to be in
> PWM mode. Current implementation only supports capture operating mode.
> Hardware also supports timebase sync between multiple instances, but
> this driver supports simple independent capture functionality.
>=20
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Hello Julien,

Comments follow inline below.

> +/**
> + * struct ecap_cnt_dev - device private data structure
> + * @enabled: device state
> + * @clk:     device clock
> + * @regmap:  device register map
> + * @nb_ovf:  number of overflows since capture start
> + * @pm_ctx:  device context for PM operations
> + */
> +struct ecap_cnt_dev {
> +	bool enabled;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	atomic_t nb_ovf;
> +	struct {
> +		u8 ev_mode;
> +		u32 time_cntr;
> +	} pm_ctx;
> +};

Provide documentation for the ev_mode and time_cntr members. You
probably need a lock as well to protect access to this structure or
you'll end up with race problems.


> +static void ecap_cnt_capture_enable(struct counter_device *counter)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	pm_runtime_get_sync(counter->parent);
> +
> +	/* Enable interrupts on events */
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
> +			   ECAP_EVT_EN_MASK, ECAP_EVT_EN_MASK);
> +
> +	/* Run counter */
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MAS=
K,
> +			   ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK);
> +}
> +
> +static void ecap_cnt_capture_disable(struct counter_device *counter)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	/* Disable interrupts on events */
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_EVT_EN=
_MASK, 0);
> +
> +	/* Stop counter */
> +	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK=
, 0);

Shouldn't the counter be stopped before stopping the interrupts?

> +static int ecap_cnt_count_get_val(struct counter_device *counter, unsign=
ed int reg, u32 *val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +	unsigned int regval;
> +
> +	pm_runtime_get_sync(counter->parent);
> +	regmap_read(ecap_dev->regmap, reg, &regval);
> +	pm_runtime_put_sync(counter->parent);
> +
> +	*val =3D regval;
> +
> +	return 0;
> +}
> +
> +static int ecap_cnt_count_set_val(struct counter_device *counter, unsign=
ed int reg, u32 val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	pm_runtime_get_sync(counter->parent);
> +	regmap_write(ecap_dev->regmap, reg, val);
> +	pm_runtime_put_sync(counter->parent);
> +
> +	return 0;
> +}

The ecap_cnt_count_get_val() and ecap_cnt_count_set_val() functions only
ever return 0. Redefine them as void functions and eliminate the
unnecessary returns.

> +static int ecap_cnt_count_write(struct counter_device *counter,
> +				struct counter_count *count, u64 val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;

You should return -EBUSY when the requested operation cannot be
completed because the device currently performing a task -- i.e. the
requested operation would stall or otherwise fail if forced. In this
case, the count value actually can be set while the device is enabled,
if I'm not mistaken; the count just continues increasing from the new
written value (i.e. no stall/failure). Therefore, there's not need to
return -EBUSY here and this check can be eliminated.

> +static int ecap_cnt_pol_write(struct counter_device *counter,
> +			      struct counter_signal *signal,
> +			      size_t idx, enum counter_signal_polarity pol)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;

I suspect this check can go away for the same reason as above.

> +static int ecap_cnt_cap_write(struct counter_device *counter,
> +			      struct counter_count *count,
> +			      size_t idx, u64 cap)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;

Same comment as above.

> +static int ecap_cnt_nb_ovf_write(struct counter_device *counter,
> +				 struct counter_count *count, u64 val)
> +{
> +	struct ecap_cnt_dev *ecap_dev =3D counter_priv(counter);
> +
> +	if (ecap_dev->enabled)
> +		return -EBUSY;

Same comment as above.

> +static struct counter_count ecap_cnt_counts[] =3D {
> +	{
> +		.id =3D 0,

The id member is for differentiating between multiple Counts. You only
have one Count in this driver so you don't need to set it because you
never use it.

William Breathitt Gray

--8oIR1Oj1QlTXqeTr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYy0G9QAKCRC1SFbKvhIj
KxouAQCf2abb4CAphtgGkhQHIiAbAAbJAjCL1/3/eLHnBeBuwgEAl3EJhEc2Xmrp
jmOjd5jNtDVQnvB+NsoZnflvSxpU+gQ=
=XTZc
-----END PGP SIGNATURE-----

--8oIR1Oj1QlTXqeTr--
