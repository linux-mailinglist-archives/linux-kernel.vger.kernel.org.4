Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB866A212
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 19:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjAMS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 13:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAMS3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 13:29:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BCF7F9C6;
        Fri, 13 Jan 2023 10:25:21 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw16so42357757ejc.10;
        Fri, 13 Jan 2023 10:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BkJEBPpFp0pdf+2AA0OV5kVpWpuYa4Hsr4hU8c+OCE=;
        b=SOzKAJLf6d4epJGp9iSEVY1rLx7EVFkFbKY7h/gVewp5IkmEp/0OSNPIYQGVq7QV/4
         s+r4OZ6Z/3XqyK6voJzbW0m+ckU1i+GBuXalixtnPyv6uVFpPDIvkdPsgfRopZz7b21C
         ly+3L+DU/ihrp0ZRj8shyvbM+RlJnB3dRWbVNbym/FA59O15U868GTaYXjt6vM+YZf49
         cimoE93fXnAIb7z4TPFqaHjSBrca1PUar53r/m8PH9T2V+4mw1dBCgSo5AAoU9CkewWX
         xmPM7ev2nOPcL9BbGt5Mk6Wq5Goo2wqBDhqXVQ1c0HFu7cc0khDVvfrnYCntWkif0JGZ
         66Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BkJEBPpFp0pdf+2AA0OV5kVpWpuYa4Hsr4hU8c+OCE=;
        b=ksEcFA8/2MYq4AQcvPIbYqIkIFT0o8GFBrPYVrhW1M2xIN1BCHlCVihck/QboiQ7Gl
         s/wet+E6VBVqkSggbLszz7a7KyZyhHzaoSGq1CXEvhwpOOCUBLDB3XzHBJqfBZSfYDoj
         B4Ul7OFL5+r1ey6D9P0EwzqTjvqeutAZbZ7OIOYZjn/iOY52IPp91gfw8j8ac9+RkIg0
         cWp7X6HSzDvvQ64PdxoXzMVK2z5P1Q6mRiVWzScCs+aiDQyiQW+fw/dXC5yo1S0D6llg
         oJr4lvwF95xwMdKmJxvfll9nm/rw8S/33aHrx2Yuyd1CxFE1mFzUx5660hl0UnibIsNo
         CPyw==
X-Gm-Message-State: AFqh2ko6qK9NgFZhidElMf4eWdNukLJZrLt3AmOEzUGHYYt4Y3cr3c5p
        64YL3X+qBLWFWHmUy+qZ5Dt7YtBNVzXMqFj+wu0=
X-Google-Smtp-Source: AMrXdXsX3njBYJXQ3IXRoza4QRwgA+qz3BIB5sslyCQZSLsG2ysEexM7uipsJPOW96T/wVpgX5LDy66TmR+XdKUT6BA=
X-Received: by 2002:a17:907:98cb:b0:78c:1f2f:233e with SMTP id
 kd11-20020a17090798cb00b0078c1f2f233emr9837860ejc.307.1673634319796; Fri, 13
 Jan 2023 10:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20230106135839.18676-1-fnkl.kernel@gmail.com> <20230106135839.18676-3-fnkl.kernel@gmail.com>
 <20230110230618.pfz267jj5ne34ava@pengutronix.de>
In-Reply-To: <20230110230618.pfz267jj5ne34ava@pengutronix.de>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Fri, 13 Jan 2023 21:25:08 +0300
Message-ID: <CAMT+MTToR+0_CmVBuGfLemALUv1XuevObAMB=TQXV0Vd7HdW5Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] pwm: Add Apple PWM controller
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

On Wed, 11 Jan 2023 at 02:06, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
> > + * Limitations:
> > + * - The writes to cycle registers are shadowed until a write to
> > + *   the control register.
> > + * - If both OFF_CYCLES and ON_CYCLES are set to 0, the output
> > + *   is a constant off signal.
>
> How does the PWM behave with *APPLE_PWM_CTRLAPPLE_PWM_CTRL =3D 0?
> (typically: drives constant low)
>
APPLE_PWM_CTRL =3D 0 implies that the APPLE_CTRL_ENABLE bit is set low, whi=
ch
turns off the pwm signal (constant low). I do not think that it is
necessary to explicitly
specify that case in the comments.

> Can you please rename such that the (maybe new) name for APPLE_PWM_CTRL
> is a prefix for the (maybe new) APPLE_CTRL_ENABLE and the other register
> bit definitions?
To make sure, you want the register named APPLE_PWM_CTRL, and the bits name=
d
APPLE_PWM_CTRL_ENABLE, APPLE_PWM_CTRL_MODE and so on?
