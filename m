Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7970A6CC1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjC1OBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbjC1OBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:01:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6480D50A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:00:01 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r29so12294105wra.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680012000;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV//EvN5VWGb8SfUPOB9U4N0xtHSlciNsKaOFZxrxK4=;
        b=4shH9I4lUneiCAv/WWHI/+aYoULUDi7/DWClIZRJaycfbJLk9rMqYZa9ZLOtaL6dJ7
         PEUosXnY9H+z9t+CC9p2OGvR8n3dDv7yVBHvDbESROi0o2dENIXTcBVD1KrvLX4AhRIi
         IxjJYZuevZlpkRXfifw/cIBKOOoff2u1hoepzGcA7SUrqVwTsjsx91NqLA6UjnRLiDCH
         WelD6HYYW/TTBZztIddivAERSkuOTBq5ST/sCSl2iWyU5PBounh78ljBzKAV+psRtovk
         k8MJ65+vwyMv1mRK1MUZxvjFeQCLojyV3Il4vVpI3Z5ngAihUrw5pQnSnDGIsVRGWC5N
         CXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012000;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eV//EvN5VWGb8SfUPOB9U4N0xtHSlciNsKaOFZxrxK4=;
        b=pdbEtLS9STROA247/IvLsAHg4Z5JsR3RmSftjqxxizNbkToeTLaPsStyrKwcGyFou/
         3HpqCP4JZ3ebhRg19j/k48eFLLKcahHX3QLrCVPdKkj6Aq4rwRfVEd1NawlFz2AtJssp
         G0CV0Dd/O+aZQafl1CRHLZ8mqHwwZcGd13q1AvmhZVDafEEjnGT/Z/TD+lmjButBgLeL
         MYwEn9FO60fFVrKYDkg7VkVqDGMAOTeDuC7sunGmyTdEo1jGCkfO3gXLbTwramzRspBm
         IKO6oWY0i+xCjkFOubCUQpl5vdsIcL646AD2QObXIrS9b7Dy0BzfMsiFUA4GJcSjnaAs
         60Yg==
X-Gm-Message-State: AAQBX9dSKP81x9toAoXaU83z4qA90JXWkyhXpSnt2xyiBj/6yFFU09xY
        mcB+t2mz/RFDZF0W0cxDzZZCyA==
X-Google-Smtp-Source: AKy350aEv76ZvmQGS0luC/FyqA5xPY4en5meBrNymKWlHJ12eRvvLXQsj+Eg12yTo7KS8EqE5LK4oA==
X-Received: by 2002:adf:e8ca:0:b0:2c7:1d0d:7184 with SMTP id k10-20020adfe8ca000000b002c71d0d7184mr14430611wrn.11.1680012000283;
        Tue, 28 Mar 2023 07:00:00 -0700 (PDT)
Received: from localhost ([2a01:e0a:28d:66d0:910e:c4d8:1565:354])
        by smtp.gmail.com with ESMTPSA id g16-20020a5d4890000000b002de99432fc8sm8155245wrq.49.2023.03.28.06.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 06:59:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 28 Mar 2023 15:59:58 +0200
Message-Id: <CRI2JTK76CHY.PX9MOKSRGSE5@burritosblues>
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
 <CRI1AQ7OIF6F.2G26C7VQKL5P0@burritosblues>
 <20230328133429ff45c492@mail.local>
In-Reply-To: <20230328133429ff45c492@mail.local>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Mar 28, 2023 at 3:34 PM CEST, Alexandre Belloni wrote:
> On 28/03/2023 15:01:05+0200, Esteban Blanc wrote:
> > On Tue Mar 28, 2023 at 11:29 AM CEST, Alexandre Belloni wrote:
> > > Hello,
> > >
> > > On 28/03/2023 11:14:46+0200, Esteban Blanc wrote:
> > > > +	/* Start rtc */
> > > > +	ret =3D regmap_set_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> > > > +			      TPS6594_BIT_STOP_RTC);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > > > +	mdelay(100);
> > > > +
> > > > +	/*
> > > > +	 * RTC should be running now. Check if this is the case.
> > > > +	 * If not it might be a missing oscillator.
> > > > +	 */
> > > > +	ret =3D regmap_test_bits(tps->regmap, TPS6594_REG_RTC_STATUS,
> > > > +			       TPS6594_BIT_RUN);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +	if (ret =3D=3D 0)
> > > > +		return -ENODEV;
> > > > +
> > > > +	/* Stop RTC until first call to `tps6594_rtc_set_time */
> > > > +	ret =3D regmap_clear_bits(tps->regmap, TPS6594_REG_RTC_CTRL_1,
> > > > +				TPS6594_BIT_STOP_RTC);
> > > > +	if (ret < 0)
> > > > +		return ret;
> > > > +
> > >
> > > This whole block must not be executed when the RTC is already running=
,
> > > else, you are stopping a perfectly running RTC.
> >=20
> > I'm not sure to get your point. You mean that during probe, the driver
> > might encounter an RTC device that is already running with a correct
> > timestamp? How would this be possible? A previous bootstage or the
> > driver was removed then re-inserted again?
> >=20
>
> The whole point of having an RTC is that the time tracking survives a
> reboot so yes, I would expect the RTC to have a valid timestamp at probe
> time.

Oh. Oh I see. I did not think of that. I will add a check for that.

Thanks again,

--=20
Esteban Blanc
BayLibre
