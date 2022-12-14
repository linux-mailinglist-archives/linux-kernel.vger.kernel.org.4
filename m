Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A397A64CDEE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238965AbiLNQZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:25:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiLNQY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:24:57 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AA426AB4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:24:56 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id d13so128585qvj.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qzHb3BYDSLSeUMZDJLd4YwGNahPYdTjmV1gUzzgVQTg=;
        b=Uh5P7zpQgXEWxW1yCKq8l4r7aYvvs5EwqgE9tk50OnhMd1AWo/TjP9sa2pEdbtd/Gy
         S91yNAO3GMaFLc4aPQSaT04uSP5SoknrYroFjjzs6baSgHctFlTyXyKzuqgVwk+197WK
         MaOJxS6w+iPfIv7qVayiZ5+GfYUPZhHD2EzT5lSZnPTn84a8yCFs7G3Ro5nQ+Fu0FARR
         Fz9hkKGBS+CJASGmO6PIre4+BJq9VXgK4dEr68B5eJajq8nnAUa/5qyXeNmQM3RA35Jq
         zjymxsb9jbMKA9mX8s5UNTEyYGDZU2FWErkLyHot7dCTfxQHXWZR7oJC8JpOShGqs1xg
         z04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qzHb3BYDSLSeUMZDJLd4YwGNahPYdTjmV1gUzzgVQTg=;
        b=ldMxau/Z0j0BF4ZVr+0r8yg+v33I2kOK3P6lo5fcsjAXUy9l6m76Z4YP+jMp2trXIP
         9Nd9k8ANGqdTOZBKdBzWelfDLdp4HSgsAu9abzGgtPmZGajLskNe6yp0QtelIK9Sq9m7
         nxMkwpC+0JPj56MTDAgt9dzACxjznU73hJmy2+18bcsTNvLK/bSK9yi1LJSizNJ88UuI
         KEnJjLZ29PvfUUAcm5CfgMt6YiyK0gHRqFugNNMp6LG+w5setf0hNWJVu5CkFvBX8WVt
         VBMmzgssaL7w3QfSvXyLvraCm0DrhHUnElSQWih2XlPW3lr2EIg+0nKDKZ1Dio6O1lcU
         aQuw==
X-Gm-Message-State: ANoB5pk4yBaLjVQqvfM1e4H+ouJ/ui6gNFmwL5qyoiQcOpcxeimVhBDP
        an/egujyqXQaMx4ywSBKrkmAPsHW7kxf+Z9VZpltcQ==
X-Google-Smtp-Source: AA0mqf4I7+dqEp8Ts4WiOrOEP1nUHBKOIsR1x/ajRXrn5iXGgAYO8eATEuZxTtsFodMwxU0WCz/2LbpZOML5tyJc5Pc=
X-Received: by 2002:ad4:4f85:0:b0:4c7:2ab:b0f3 with SMTP id
 em5-20020ad44f85000000b004c702abb0f3mr45261640qvb.69.1671035095508; Wed, 14
 Dec 2022 08:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20221214044058.6289-1-David.Rau.opensource@dm.renesas.com>
 <Y5nb7ik1cCKo+FlR@sirena.org.uk> <CAG+cZ07erTzV8Re-xo8GixpsEhK28Q6wHxQeE0co+sWgQAFgGA@mail.gmail.com>
 <Y5nkDEcgbZ2vNEsK@sirena.org.uk>
In-Reply-To: <Y5nkDEcgbZ2vNEsK@sirena.org.uk>
From:   Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date:   Wed, 14 Dec 2022 17:24:44 +0100
Message-ID: <CAG+cZ06PHgrLebLESbitdkupYcyZ6twr4uv6iczNxp5ztox-EA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: da7213: Add support for mono, set frame width
 to 32 when possible
To:     Mark Brown <broonie@kernel.org>
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>, tiwai@suse.com,
        perex@perex.cz, support.opensource@diasemi.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 3:56 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Dec 14, 2022 at 03:31:26PM +0100, Piotr Wojtaszczyk wrote:
> > It was a single patch, with no deps.
> >
>
> It's flagged as patch 2/2?

That's wrong tag, initially I submitted this as a single patch to
`support.opensource@diasemi.com` and now it comes on LKML after
testing by David Rau.

--
Piotr Wojtaszczyk
Timesys
