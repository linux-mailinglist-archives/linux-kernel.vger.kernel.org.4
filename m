Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F170D609AB9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJXGrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJXGrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:47:14 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A93D5DF33
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:46:55 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id u7so5964275qvn.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lxnav.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKf+A6HhtX9mc2hAkoHaxtvJcmxghygi4kxKwGPcH54=;
        b=iwHnzLCm7oFOSTBLS3J2/nP0hfKORtPMV5RPaK1XwwLcMM+/ag2fq0iOotOa4f6I6j
         SwE1PIETbxH83QXsJqYrNMqPSzAppnKgEii6EeWcV19D/hk/dEHFcwaPRqcPMsHUKZbN
         GXxBlBuQN/vjxvqG91b60BO2rgfh+7x4M7emg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKf+A6HhtX9mc2hAkoHaxtvJcmxghygi4kxKwGPcH54=;
        b=ih177rLxBQTtRh06msD7unnV6MdtBh1MZmbUSmWElsBrmUoF6imcJ6KRJrSET0W2Rd
         hGsnzoOao6dJ5RpYAea21NMHI9UVLGsntDdwek2q2mHdgz3h6Yg+qjeyLnBv5r8zcLm+
         WR0GoiqRHTkrY+9Ys44PHpjS+tL0clH5ZKah0jBx3fDrsSwYcUR6B/sl2kv6BHK0ZbYr
         qHcuZhWTkDKd0rkQV6GPs6Dun8LwPTIAf4J68uiBCmbEQ/PyxZPg+mxkZX77JRaOApTb
         1kOJtEbJIEa0VJdiRKopqtpg5JaUXa5YRDdBeR4xLT9OZQj/8I7tBQpznemGBYVPhR8+
         H1/Q==
X-Gm-Message-State: ACrzQf2omr8m5HCX8Wrl3djo2FInEMQWkKy6YWBFmGpXynnr0YeFOKSp
        HnlVGSbbg27opnHwADmJw4SL/HGxNKzX81Pg4dWFng==
X-Google-Smtp-Source: AMsMyM6FjMmilmr/1MGP2WwAanNef8DNvM6W2Bl6M6zASp15U5hmP3GXP7D3gEMuTBUdFJtU75sPsmKzeFZtkXvK6MM=
X-Received: by 2002:a05:6214:e4f:b0:4bb:769f:19a9 with SMTP id
 o15-20020a0562140e4f00b004bb769f19a9mr1781205qvc.2.1666594014701; Sun, 23 Oct
 2022 23:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221021135827.1444793-1-mitja@lxnav.com> <20221021135827.1444793-3-mitja@lxnav.com>
 <Y1K7hWKl0siEtaAl@gmail.com> <20221023121002.742bc48f@jic23-huawei>
In-Reply-To: <20221023121002.742bc48f@jic23-huawei>
From:   =?UTF-8?Q?Mitja_=C5=A0pes?= <mitja@lxnav.com>
Date:   Mon, 24 Oct 2022 08:46:27 +0200
Message-ID: <CACbQKWf2zfbQ5DvMZs50VVfQbmcGp63b9yg6aZ29NbiQ01QmFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: pressure: ms5611: changed hardcoded SPI speed
 to value limited
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 1:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
> Please give a fixes tag for this one as well.
> The driver should never have been doing this.

Fixes: c0644160a8b5 ("iio: pressure: add support for MS5611 pressure
and temperature sensor")

Kind regards,
Mitja
