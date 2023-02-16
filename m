Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D48699EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjBPVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjBPVZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:25:48 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB984BE89
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:25:47 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c2so3675038qtw.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UYVK+TYQ7T+40iOERLRbI3lik8ViyoScUmSDe4nEJPQ=;
        b=LW2JpHUXRf42KNNf5rBSmJp7D8Shg3U/PrdW5zCQupgqF0nBNH7gF//pYiA1YI03n+
         N8XZHW3iRLRhTHV93G5VzHzR0g5rTzQBXe4SizZuve8U0/+9ArVTjU+C+eKyHKxNwbfR
         Wojm21r5gHfeoRaaCsjd8tBYqkMrHXIDKJSSqz5dcYpd2aps8Wh1lxC+a7+lMpZMf0s6
         +pdZAaAzjK6IgV82yupRMnYqq+zFbw6yGbfHXjjl7y8HRxyV6TOTZEj4SMXYKjD4LMu6
         TfzLp837TMVXLVfbYghor9pYuCXveQGt3Z5G4GKqnb6oUqm5YBwjykOrCPwhezL+rxLI
         MKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UYVK+TYQ7T+40iOERLRbI3lik8ViyoScUmSDe4nEJPQ=;
        b=PLsbW+oeiuDLoC3K/BbMbz6Byd3DMIRNoTzVpwBiT5JWoXYo06uhtPaLX+esCh7rTk
         y0Gc7AtCOG+Q53eAEXTw1vpYcq6FPzAM69s9zalPSJxJwTLkpwDHWqrtxktT5K8+LxGy
         Tc8fM7E+FIs8RsAasl9IMLtuG5cu9nThCh+erLncsn1i8C0FjgdesSLDSrANeJWyqEk9
         hEPyTKeKevBPvKcfQM73AT0LKIQYiYp/r8guu4iezQTDl4WN6ZvOwKtqhCf2ND6tDLiA
         K2J3FPU2eZVOYobKkW6RGlxQ2KJzxkoUm/7/PpciHyNcSzJz22SSPr5Rw7/ej4fad566
         K53Q==
X-Gm-Message-State: AO0yUKXQHboUJYqOPSEQ+htz4rSUPoT8DxtIqhb2qbtZhAUmz0O9L7i8
        sE28wyz2uUGu3YAtZEw2+FyUMRdFGHranaE7
X-Google-Smtp-Source: AK7set+vcFZvHrIiQKOiLL2FaV0aJNClQyghLwOyIquAsrom4y6wsRQEvwHru8STblU0rgR3pM2NNw==
X-Received: by 2002:a05:622a:607:b0:3bd:a75:1b9 with SMTP id z7-20020a05622a060700b003bd0a7501b9mr4697541qta.41.1676582746643;
        Thu, 16 Feb 2023 13:25:46 -0800 (PST)
Received: from ?IPv6:2601:14d:4e80:336e:6940:faac:fba5:1dee? ([2601:14d:4e80:336e:6940:faac:fba5:1dee])
        by smtp.gmail.com with ESMTPSA id c4-20020a37b304000000b0072771acaf09sm1907424qkf.126.2023.02.16.13.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 13:25:46 -0800 (PST)
Message-ID: <224b230c5c8d3037b650602b5743bbf217369ecb.camel@gmail.com>
Subject: Re: [PATCH] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to
 quirks
From:   Joseph Hunkeler <jhunkeler@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 16 Feb 2023 16:25:45 -0500
In-Reply-To: <Y+5Ym5rUWLK4TOAf@sirena.org.uk>
References: <20230216155007.26143-1-jhunkeler@gmail.com>
         <Y+5Ym5rUWLK4TOAf@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-16 at 16:23 +0000, Mark Brown wrote:
> On Thu, Feb 16, 2023 at 10:50:07AM -0500, Joseph Hunkeler wrote:
> > Enables display microphone on the HP OMEN 16z-n000 (8A42) laptop
>=20
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

Hi Mark,

I apologize, I don't fully understand what you're asking me to do. I see
the typo "yp:" was supposed to be "yc:". I took a quick look at a few other
submissions. Are you suggesting I change the email subject from:

> [PATCH] soc:amd:yp:Add OMEN by HP Gaming Laptop 16z-n000 to quirks

To something like:

"[PATCH] ASoC: amd: yc: Add OMEN by HP Gaming Laptop 16z-n000 to quirks tab=
le"?

If so, do I edit my original message as new, amend=C2=A0the subject,=C2=A0a=
nd=C2=A0resend
as-is? Or do I reply to the original message with the amended subject along=
=C2=A0
with the full contents of the patch body? I know you said there is no need
to resubmit to fix this, but it's is not=C2=A0clear to me how to do it with=
out
resubmitting.


Thanks,
Joe



