Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48D69EFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 09:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjBVIOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 03:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjBVIOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 03:14:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6DB1B540;
        Wed, 22 Feb 2023 00:14:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cq23so26721998edb.1;
        Wed, 22 Feb 2023 00:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xj/6AyELfHI0tKgaBGNk0fyFVeR5csP7/YL61ZGE4Xk=;
        b=eyrVUqnER8VYc2JyypJRTTLZWi2RuVoKQT8Xm298bWSpuBvRedvo6MZEcHXbdwUJdD
         FP94ARAJ4ey3XJTfTaXLkh8GTSxTzplteXVI6Xt8JmkeEtqo/8BLFl77N/WA7QX5P5wF
         FmXN6+J0VeqrYXjgwL7DsIf1jXDwluv2alBbRanVpC7TDD4KHhlPy0WZCGtl2BXNrMmY
         DIyqE7xqBqsjACJfjzzmMRXX5Zl/ID+U+olV3MwR91v+7TMOFTcq8V791ZEzfPTmn0QC
         f8kKfXcHcdwlkUoVe4sjjYh6b5HZ9xbCbn/aGfpiZv8cz1eKOD1lPfl2q4lYfmix7q+I
         G5Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xj/6AyELfHI0tKgaBGNk0fyFVeR5csP7/YL61ZGE4Xk=;
        b=47j4kvxko3eJR7Y3tgxGgEkOydTPH4ek5uWLpLWbN5M0BBBN/wYZ49Dnnepho77W43
         czk51Bgc8JElMC951iZAQVA4EgEMpkoFzqBfeOyZ6wK0akan7Fa/aRmW7kxRfZOkDDvk
         2muLM3TSdqIvXYUSsfpWsla/hVulqFmife/9mIY5cMKr/nuJhhMg4nORSRcAtWt6M3Yw
         WZWk9NyNn2TCh4LmIGCsH3XrIHli1CzV1/oO4rNPuWW6HhZQDB/lxXKMDk9RISCgqSf7
         HIRLPt/17kk8sXevYir4pKkzjHI/bktpelHzbesXTclw/56eBqrjlbXNZdla+JAWB6WQ
         wXrA==
X-Gm-Message-State: AO0yUKU0F3UNNJaAMnjY3CQjeZo1WejwHjVQUdbui4SFgIQS1OUctzGF
        WWbCK1VYMdEXHHNIw2gEBhl8xxV1IzLNn5ke5h0=
X-Google-Smtp-Source: AK7set+vh8ZSYnSuxrULngtfrZiKENvscmdFhJ7qS/OrAXSltDPmE4QBQ5fNy+vQLDfu9owooRq4qarjYjxuDzJnk08=
X-Received: by 2002:a50:9fa8:0:b0:4ac:b8aa:3ffc with SMTP id
 c37-20020a509fa8000000b004acb8aa3ffcmr3264891edf.4.1677053653220; Wed, 22 Feb
 2023 00:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20230221183211.21964-1-clamor95@gmail.com> <20230221183211.21964-10-clamor95@gmail.com>
 <Y/VIpVwFu5gUUcsz@sirena.org.uk>
In-Reply-To: <Y/VIpVwFu5gUUcsz@sirena.org.uk>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 22 Feb 2023 10:14:02 +0200
Message-ID: <CAPVz0n34MMs-AeHfuxpC3dL=0MKSqrSn3zgrCHbjozR183CWnA@mail.gmail.com>
Subject: Re: [PATCH v1 09/10] staging: dsp: add support for Fortemedia FM34NE DSP
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 22 =D0=BB=D1=8E=D1=82. 2023 =D1=80. =D0=BE 00:41 Mark Brown <=
broonie@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 21, 2023 at 08:32:10PM +0200, Svyatoslav Ryhel wrote:
> > FM34NE is digital sound processing chip used for active
> > noise suppression mainly on ASUS Transformers.
>
> This looks like it should be fairly straightforward to support
> within ASoC without too much work, and since it's in the audio
> path it should probably be referenced from the sound card it'll
> end up having an ABI impact on the card.  Take a look at wm9090

wm9090 is a sound codec, like rt5631 or wm8903 while fm34 is NOT a
sound codec. It is sound processing device which must be active only
when DMIC is used. In all other cases it has to be bypassed. At the same ti=
me,
it has to be set up because else there will be no sound on the actual devic=
e.
In the current state the driver sets up DSP and sets in constant bypass mod=
e.

> for a moderately complex example of an analogue only device
> (which this appears to be in terms of system integration).
