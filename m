Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE4D698131
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBOQrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBOQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:47:20 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1A71F488;
        Wed, 15 Feb 2023 08:47:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c1so19380883edt.4;
        Wed, 15 Feb 2023 08:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWUISe+0HJ9YU1Zk8I5ieMOKSVMFYOw4cw3Zj6d7n2s=;
        b=C3Mgb3sIx6xX2jPwuKfRtQaIior7RYVYX08b7O46Ieeh37jS2SeyTCt7yGnGUxmXmS
         hZnGh/uPnB40FGL4d/VnpaAmkHDW6KYgQXomkpbO1uHUsXwsh1nYJoOLWiYUSkxGGrCt
         NofgdYJf+nMTLRjTx71WQ+r/bPcupTY/2/CX5TZ46CihnGT6Rnusj4U48vXuujcwAKXL
         wCLmJcOuHn3IeSEuvMeQc4psEGNlBHiVhYw1R2UaGtD9k6s7Z4T11PLMkaY/FiGJmB4C
         Pr8Hljw+phfFgIu0pH1GwKZo4k3IQe6Tli/omSPqTjpbP9engMOGahhJcdjQxvaeoBe4
         44HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWUISe+0HJ9YU1Zk8I5ieMOKSVMFYOw4cw3Zj6d7n2s=;
        b=UKlG/us9eGsqXbfGm2P2Er8j6wOcjbqs65Bek+1QGFh5LbcVxCktY4rFle3RZxp4Qz
         rdRWDvTKvNd7N+TkR2fTb7WW8KWyrnIvrnJWO2MsakUoO8m/tk6bNitNGsZC0SBUXQul
         uWS/Etts2rtJxTbmVQ7fstuu/bxi1uswPxwvMx5UXfi3tZrqr6n2PZmHo4TP1323XYDn
         qTMrpS5Dw1Yv3SbBxiWuyYH8IujPPupnwr7YRUqnd0t+jlMUWw/DOa0mMMHzl9RTQJg1
         JJagZXN4fd0+nnAMGUCzsQ0yvRWIhaeUS70HUubwhzYL0RrTyYNunGEMLdoGWmZKoMsm
         EfHw==
X-Gm-Message-State: AO0yUKV8d8tKzc7qptVzj+mQYia8NA1rTfzbQv4oy+C0WQLJ6gapv97M
        3sFPketcBWhH//FouM/g13zEupm3wvFv7xXV6/0=
X-Google-Smtp-Source: AK7set86MN3jsbNFlFmIEMts91fMfvzW7bAkwAoBMxjT7ynQy+L/J2YSrZeR8z0+U8QTQmAF0s6EnZNWKpsjxtLhpQE=
X-Received: by 2002:a50:bb4c:0:b0:4ac:b5d8:6b2d with SMTP id
 y70-20020a50bb4c000000b004acb5d86b2dmr1535972ede.4.1676479638430; Wed, 15 Feb
 2023 08:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20230114132508.96600-1-fnkl.kernel@gmail.com> <20230114132508.96600-4-fnkl.kernel@gmail.com>
 <20230215111652.lyhebfntqlibtmex@pengutronix.de>
In-Reply-To: <20230215111652.lyhebfntqlibtmex@pengutronix.de>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Wed, 15 Feb 2023 17:47:07 +0100
Message-ID: <CAMT+MTRydNiYnhBJYVCoS5iXnhr7MywCV0t7FanHWwbwv2TrbQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/5] arm64: dts: apple: t8103: Add PWM controller
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marcan@marcan.st,
        sven@svenpeter.dev, alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 at 12:16, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> This missing newline looks wrong.
>
> Otherwise the patch looks fine to me.
>
Do you want a respin, or can this be fixed when applying the patch?
