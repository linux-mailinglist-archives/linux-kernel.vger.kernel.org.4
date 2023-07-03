Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C56746404
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGCU25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGCU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:28:55 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AC4AF;
        Mon,  3 Jul 2023 13:28:54 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51d9695ec29so4578206a12.1;
        Mon, 03 Jul 2023 13:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1688416132; x=1691008132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btFntjY0O3IvQAR+9HWAi9QrudxEpvSJmgYuJTKvtTI=;
        b=P/2IY1xgAl3/k1IG0imh55eAHTfrSdB5GD9jlHerOgWmBqtOW+2iTqhMRvaBCZn8bM
         epXKrQtZswPggaRgmebsXPy72F+87TqNgiEOv7/hjwRsf+5xGlkxaj1Cavn29gHcSiir
         8gVjUY3iaDSvWlBwXKP6/N2mfnwyjsdylTfL3N4WXOoeJhBTyksduxZdYRDVPEenxK41
         e7SjW1T+8QA091QNxC3ef3O50hzyAnpO6vn0k2/vxl6IIj/Bt3c9RwPCRhvNAxlURxIC
         CCX37YvD0MP45pfZ65cUCKYZk+mbQiIYMD+R3ij+Bb3zWnHRGCS2HtFxiWVyqej8iNbq
         TAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688416132; x=1691008132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btFntjY0O3IvQAR+9HWAi9QrudxEpvSJmgYuJTKvtTI=;
        b=h7nyxsQncaiTALpy875/tYSGKMTaJqo8HNqS0VP85EhpS9DQ2xcludw9+3n4z3Ecc/
         eb1YQjcq4oz0qzA9oHg9YyJVJdNJ53x1+UbNjcvWE48VI1ViWy6Ltb2GMc8Ykl2pJzPx
         E9hpw4m9cSrxuWl2plA+AcvGr+xT6vfFOfcRKgTj4SWH7jg7ElaRmOMQipLRN4ks59+R
         CV1knf/gIBUhIYh9J3cLHML+kcgd7T9vi5gUVN++OZf4aQO+6Jo+bMINNe0dVQ0y7ry2
         Xrj+fi4ADrk2udsdePEVL5FAhxHXijE4KMCgH8g3QPOJX4Z028MQKG9rqBdPMeBzWbb8
         Yd7Q==
X-Gm-Message-State: ABy/qLYbqxGix9yULsrJNDcKzWnWl5JfbQJBDf9qNzoTlrK5uMogWP3u
        YxusgPknzTvY0JaviIBw1EKntmOcPIIXlh8g+pg=
X-Google-Smtp-Source: APBJJlEouvycMaNq7SW8pfQsXaQaCcJyu1kZ1tJurr0d+7z68IgdVSBIE6WLPsH2RfuMtgVa8aYFuKsE0q+6bUbE7lc=
X-Received: by 2002:a17:907:76ab:b0:992:d013:1132 with SMTP id
 jw11-20020a17090776ab00b00992d0131132mr6440806ejc.1.1688416132254; Mon, 03
 Jul 2023 13:28:52 -0700 (PDT)
MIME-Version: 1.0
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <CAFBinCAJ1E6JKmFTuaJwGpd_MBzHMZ0mMj-1AE3TNeB2_72nZA@mail.gmail.com>
In-Reply-To: <CAFBinCAJ1E6JKmFTuaJwGpd_MBzHMZ0mMj-1AE3TNeB2_72nZA@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 3 Jul 2023 22:28:41 +0200
Message-ID: <CAFBinCAWsurgCqxCJMP_xo-uj-FsPpYK-6e_6KAGMdDJB2adFA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Ziyang Huang <hzyitc@outlook.com>
Cc:     ulf.hansson@linaro.org, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jun 19, 2023 at 9:51=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello,
>
> first of all: thank you for this patch!
>
> On Mon, Jun 19, 2023 at 7:36=E2=80=AFPM Ziyang Huang <hzyitc@outlook.com>=
 wrote:
> >
> > Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
> > HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
> > freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
> > Then we set rx_clk_phase to 11 or 15 which is out of range and make
> > hardware frozen. After we send command request, no irq will be
> > interrupted and the mmc driver will keep to wait for request finished,
> > even durning rebooting.
> I think this is the exact same problem I reported some days ago: [0]
> Ulf is questioning whether we properly support 52MHz clocks correctly,
> so I think you're onto something!
>
> So this is an excellent finding! I can confirm that using rx_clk_phase
> of 1 makes my Odroid-C1 eMMC work again :-)
>
> > So let's set a common value - 1 just for initialization. Then let
> > meson_mx_sdhc_execute_tuning() to find the accurate value for data
> > transfer.
> As far as I know unconditionally using value 1 can negatively affect
> other devices.
> I'm assuming that you're testing on an Odroid-C1 or similar board with
> HS200 eMMC:
> On those SoC + eMMC combinations we do support. But on other boards
> (for example Meson8b EC-100 / Endless Mini) there's no HS200 support
> because the eMMC is connected with 3.3V IO lines. So tuning is not
> executed there (if I recall correctly).
>
> What do you think about adding a special case for the 51MHz "actual
> clock rate" and adding a comment that it was found by manual testing?
> For some reason (that I don't understand) Amlogic's vendor driver
> maxes out at 47.22MHz (presumably because they limit themselves to
> using FCLK_DIV3 as input only - but I don't get why...).
Did you have the chance to look into my comment? I would like to hear
your opinion on this topic!


Best regards,
Martin
