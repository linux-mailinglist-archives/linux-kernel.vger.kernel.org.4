Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 000B16CC00B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbjC1NBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjC1NBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:01:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FAE4AF0A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:01:20 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n19so6916997wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680008479;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6F4MCsvT2C8gUcp99pkDHUUGuKfspVbwNGAoaBleYU=;
        b=FS54iuLIV/siHxesYVQVCWxxAiR29vD+YSeRvlBLKOYKXqt5cjNH6QhhssyXWfmAd6
         2F+PdbWh35dJAB/n6jrAWrBWwv0Q7phIaQRijZHwfJuW4r5hAaTRWzx+KqMxwAGLds0B
         WOH+Z9G4MZFfRAHwWoWksVryIrTxS8p2Q+pfL+LSIRQVkj8eEj+vblnfUgVLCBnXW+07
         T1xg5ZzTMDxVI+xe1Vt/ujbBi6Z+MRKUp1RTmDaVbBzGHa3w2XsBcErJduQTArwBCF0z
         aTxm2NFk2N1R8WauJrFW/tEkCbPF3z0n5FP6vUYjiGZ7ypFi5AmnhziwqyarQW9XWEUV
         OEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008479;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p6F4MCsvT2C8gUcp99pkDHUUGuKfspVbwNGAoaBleYU=;
        b=NWW9iT3pFcAXisVfnCnaJkG63cXSA/ctZSr5lSKmuES8Mcwy53BDNtQ08Ke5BlazOa
         z9Xwx49VreFTYyTGMM5rTPQMCUwaZoKCemjq9YWoK5EuDegWHooWyK1kKh92th7B61Uh
         DtrgR7xJ9JvOv72XZbHgQu9kBCONvvuCmjlYXrhnyx3idYQZEMp/pQ96IQlUw1qm+ady
         FaS7X3PLAVctZlXiARNjm32cuWHZl5435D1poPdnImANIaPhE/0W5zPVJybwzzOnEWuH
         vaYyvpUoi0iH0O67cH4pSDOzP2hDzMpEA8gIrz1ljM3/8H+gzjhirw05z9dC108qrh+U
         xxpQ==
X-Gm-Message-State: AO0yUKWGc+U+KlaZgNKca+OAm0eTzwCEgjeBY6Sq3Ad8w1PliKy+TjhB
        7CIEa1ogolCtIRYV1wZa/akVRg==
X-Google-Smtp-Source: AK7set94AVmLDp7FhfkLYgmKmsQOV0yFdLDLs8lyI/GV1MeXd4zV1cvkNUnKZMzy2BVHhZcFPUepMA==
X-Received: by 2002:a05:600c:4f91:b0:3ee:501f:c795 with SMTP id n17-20020a05600c4f9100b003ee501fc795mr16307924wmq.1.1680008479146;
        Tue, 28 Mar 2023 06:01:19 -0700 (PDT)
Received: from localhost ([2a01:e0a:28d:66d0:910e:c4d8:1565:354])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6091687wmo.37.2023.03.28.06.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:01:10 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Mar 2023 15:01:05 +0200
Message-Id: <CRI1AQ7OIF6F.2G26C7VQKL5P0@burritosblues>
To:     "Alexandre Belloni" <alexandre.belloni@bootlin.com>
Cc:     <linus.walleij@linaro.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <a.zummo@towertech.it>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <jpanis@baylibre.com>,
        <jneanne@baylibre.com>, <sterzik@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH v2 1/3] rtc: tps6594: add driver for TPS6594 PMIC RTC
From:   "Esteban Blanc" <eblanc@baylibre.com>
X-Mailer: aerc 0.14.0
References: <20230328091448.648452-1-eblanc@baylibre.com>
 <20230328091448.648452-2-eblanc@baylibre.com>
 <202303280929448e41808d@mail.local>
In-Reply-To: <202303280929448e41808d@mail.local>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 28, 2023 at 11:29 AM CEST, Alexandre Belloni wrote:
> Hello,
>
> On 28/03/2023 11:14:46+0200, Esteban Blanc wrote:
> > +	/* Start rtc */
> > +	ret =3D regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> > +			      TPS6594_BIT_STOP_RTC);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mdelay(100);
> > +
> > +	/*
> > +	 * RTC should be running now. Check if this is the case.
> > +	 * If not it might be a missing oscillator.
> > +	 */
> > +	ret =3D regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
> > +			       TPS6594_BIT_RUN);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (ret =3D=3D 0)
> > +		return -ENODEV;
> > +
> > +	/* Stop RTC until first call to `tps6594_rtc_set_time */
> > +	ret =3D regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> > +				TPS6594_BIT_STOP_RTC);
> > +	if (ret < 0)
> > +		return ret;
> > +
>
> This whole block must not be executed when the RTC is already running,
> else, you are stopping a perfectly running RTC.

I'm not sure to get your point. You mean that during probe, the driver
might encounter an RTC device that is already running with a correct
timestamp? How would this be possible? A previous bootstage or the
driver was removed then re-inserted again?

Thanks for your time,

--=20
Esteban Blanc
BayLibre

