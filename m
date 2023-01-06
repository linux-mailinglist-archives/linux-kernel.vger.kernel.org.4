Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A58C66045B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjAFQhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAFQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:37:11 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BDA78A4C
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:37:11 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id x65so1954000vsb.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 08:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U6DPKtnnubn7cp1x+z7ypPgzF/5jLUida/HMoHlW1OM=;
        b=Salhp+COCaebM55FY5+LBraYdA2Xuahbs21t7DCHMDek/SAFYz/nDc/xzYjmWAUYb7
         cg4y5MHRVU3iqkS5/Wh1y5rE74WU/hdTUrkpYNdmtli5Y5G7D1Vq9FSvXXF5E98xH/Ts
         h436EHxiLD4ylW/8/+WqbowlUxUpcwsFR6YoqZNvge7wkRFHnGEYgNowRpmU/0C89kCw
         BtRmos6YfEorIrFGyd2Rv5cO+wNbU/bg95vvu3EVdtDAO6X7JTtPILkK/Ouxmf/RsZK/
         AUg4pG8qiqThXVatdgxZUCuN/CuLc1nDN7Kcir6hPumJuf6zHO84zj2HTByC76kDVrLg
         J43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6DPKtnnubn7cp1x+z7ypPgzF/5jLUida/HMoHlW1OM=;
        b=bD2igdGI+grEYOkAehV2uR+neioFLEldMzvS0+x2qT0zVDXPqsXLjPZG9szdCHKfOL
         GSVp9eaW/VovXPvUkSdNoSnCJwYx65H9Xm5CRMfkk3kVFZWtDoXHKWE1DLLnmAQiAqxQ
         5eeFzsScDKEP2gyGaFaEeDT0XJJWJn6IBqu+xOGmWG8cdWOtclaZrntZeIWMzgXz2vgz
         aNwZ1owEC3ftR21/QqHwdI+ynUVPZyJ3749QPtfIeWcnnSDepfmBv0FjiTWpdto1U5FJ
         4EvrkhCcqxRP19YMwHC72q94zKwo+WHGjgqBceVGS6FuMqbJV41OStLRYy/XQvu6MVJq
         z2KQ==
X-Gm-Message-State: AFqh2koEBQb47NWspSxHrIpElIepEmasBBfoMOs52IDX/YRxupcCquWl
        eirX7Fnu5fehPcvqp3AjcSQZsfLz6ea4GPNc3sTUiA==
X-Google-Smtp-Source: AMrXdXtawvIVy/nhj1pykTwuqk4FalIzTrt+TMnwddptCrL7lL4soYhTXMKLtjDe3JzEoCcb4azjY6XAlDHb7K+t0yk=
X-Received: by 2002:a67:e111:0:b0:3ce:8fa9:1ec4 with SMTP id
 d17-20020a67e111000000b003ce8fa91ec4mr2137113vsl.73.1673023030130; Fri, 06
 Jan 2023 08:37:10 -0800 (PST)
MIME-Version: 1.0
References: <20230106100719.196243-1-brgl@bgdev.pl> <Y7gsiW6lAsz/krsV@sirena.org.uk>
 <CAMRc=MfsUxuv6d4GXgf7aTDr3Af89JX1Na_+jWcQQGn2hngWzQ@mail.gmail.com>
 <Y7hJbjnbcxZnh/9M@sirena.org.uk> <CAMRc=MejZsbL=Ef=hNV-QGcrcgCepKfnAU4z+CFXFf8Wn09M-g@mail.gmail.com>
 <Y7hNj+O0Y5NNNcna@sirena.org.uk>
In-Reply-To: <Y7hNj+O0Y5NNNcna@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 6 Jan 2023 17:36:59 +0100
Message-ID: <CAMRc=MfdXUM6rVZrvCaU4Ye2T0DpYwzV2W_gn1w1AYAEm-R2dQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] spi: spidev: fix a race condition when accessing spidev->spi
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 5:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jan 06, 2023 at 05:27:34PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Jan 6, 2023 at 5:16 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > The complication is using a semaphore at all, it's a pretty unusual
> > > locking construct and the whole up/down thing isn't clear to people
> > > who aren't familiar with it.  Given that there's no clounting being
> > > used rwlock would be a much more obvious choice if the microseconds
> > > of extra concurrency is meaningful somehow.
>
> > I don't have any numbers, it's just that in this case the rwsem feels
> > more correct. My opinion is not very strong so you can apply v2.
>
> Like I say the semaphore in particular feels wrong when we don't need
> the counting, we have an explicit reader/writer lock if that's what
> you're trying to accomplish.

Let's go with a mutex and see if anyone complains, if so, we can rethink it.

Bart
