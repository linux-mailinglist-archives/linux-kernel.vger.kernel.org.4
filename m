Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9EF66BE04
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjAPMlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjAPMls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:41:48 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6F11E2A3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:41:47 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id o75so30141557yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q3MQLN2FVf89PtdSK/SXvJTM2uY9pjB6eoFrd2d8V0=;
        b=Nx9K/ryTCyCNNyCG0hr3uPueDPLJ9yT/j+dfRqkdEeVY0v70RE1jJmAUq8QCqmXMo5
         tWbPesQ3lXZtsZjcMwP82+Z09qwlBdwjA78sIY1WRIjfAdIetH52yAh2F+I0biUe2nWj
         Q3bM1qmyCMH9kf/UA9GqOCFDgYusRxMA2dbMV1/BuvHeyl99CKYizxNteIBiCz+aZobn
         J0yTRskYKI3sfAJCDar+WywFTW6nbUT2Z3NdlHAdxkhfX1qeVFE2H4hA9Du1H/5cIhD1
         UdvQ4EeVunOfzL+2gqiYL8s2POePCfD5xSFP4WwgM9oDyDvtJoVXwCDe5iAn2qNuvO+9
         tIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q3MQLN2FVf89PtdSK/SXvJTM2uY9pjB6eoFrd2d8V0=;
        b=fgM/VqZ69UB4X0WUSbDJhMji/VsfuP7zbPeS7+tyrOGdoMaUbrbuaMnpElzG1wJYpy
         QBQjo0NFOe6/gHT2QDOrR9H0cU09iuoBkyNwM0O+MbP0ffoE0ntwe+nBFEKpnRK1JuW9
         Dm8L1ilSyF3HqMh7nR23UMnaHYF49K7Eqv8FzUV66HcL5PAnLS6AfX5eYUyOlfq+FC/x
         4aStGOdteMBzK/0NKcFB/Fd/ZCWbwTU/52kFrXsiEyJZUhLTIzt3EOeGojKXNn/iaS0E
         3xDTxUJUFE5pAy7uHHcfzQtT5wIj5vjY1H3bBWygEEfFjYY9Zzo94V0dTNQfu5FhrE3I
         j/jQ==
X-Gm-Message-State: AFqh2kpr/8XiqjX31aT8dyBjakEDxPg7Eg4xn1Drq38sUTNxqDCWxBL1
        9ioA9+T7rqFPg844gYpDYkHEijdlO1B1nP/f/O3tqA==
X-Google-Smtp-Source: AMrXdXvWBNr9LsH2Oq+FdwkLMqD0NN3kPT5Lh3tsKMGtsEzOMK0Y25yk/EwL58EFlCY6bz+Wsacjqd1Fa1DGPOToRVk=
X-Received: by 2002:a5b:a90:0:b0:70b:87d5:4a73 with SMTP id
 h16-20020a5b0a90000000b0070b87d54a73mr7101911ybq.584.1673872907033; Mon, 16
 Jan 2023 04:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-511-uwe@kleine-koenig.org> <CACRpkdaViC8T5qFRW+=+rGST=nr9beQJqTP7d42OoYUnhPhqig@mail.gmail.com>
 <20230111095142.2i36vjytm6wthntl@pengutronix.de>
In-Reply-To: <20230111095142.2i36vjytm6wthntl@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Jan 2023 13:41:35 +0100
Message-ID: <CACRpkdaxt87XnQ=QejN+XGb+s5q35FDKZoVa0=HMaK6G9_1d1w@mail.gmail.com>
Subject: Re: [PATCH 510/606] pinctrl: mcp23s08: Convert to i2c's .probe_new()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@kernel.org>,
        linux-gpio@vger.kernel.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        Grant Likely <grant.likely@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 10:52 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:

> Thanks. Is there a reason you picked #510 but not #511 other than having
> missed there is a 2nd pinctrl patch in my series?
>
> If it's only that
>
>         b4 am -P 511 -s -l CACRpkdaViC8T5qFRW+=3D+rGST=3Dnr9beQJqTP7d42Oo=
YUnhPhqig@mail.gmail.com
>
> is your friend.

My bad. I applied 511 above as well, helpful with the oneliner!

Yours,
Linus Walleij
