Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334E56A8162
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCBLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCBLm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:42:29 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC028865;
        Thu,  2 Mar 2023 03:42:04 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id q23so9592441pgt.7;
        Thu, 02 Mar 2023 03:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677757323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NG7UNqNB86Y8R/UV9apCD80Y3KO/Y3+JW11TcbCbY0E=;
        b=MyapnYJpTgBTS1uMCkafwF8fcsoQWw8jsFJM8bRR1leU+Ekq7z8Q89/d87kuLp8r7z
         IewW32Ll9kXsDsjfFQ8rBHHVGdRwQmNA0qWjdv2+FZg8+y8TawGIQTso12LD9qauHnF9
         ZFFECucZxa2Fyacx/WyrSwu91khNJvigZ4KM6xHYgcuIS6Mkk26SkNNczY106Kc2iSG+
         rXUeW7EYCmQDdIG0qZ4Vyhz/mVPCtFCgb+lPa5teb/92YHDLWU7DUy+0pF04WTrtiPa1
         gfjMc5oF4ycUpXmNd0T2JIRMRJh/mOij+tOWVo2yOWUMf6jv74Dk0fH83RjftHtaE0W5
         8fRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677757323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG7UNqNB86Y8R/UV9apCD80Y3KO/Y3+JW11TcbCbY0E=;
        b=jmE2GsNwuGjv1eZAK/YG/Jg587SaDVv4LV27EroezPBqoXzIgkL7AAXAE2XzGXrKck
         ZSgan3YAugv3uIbcQkyGNTiHCe1tqmUXacOe46JDvfui0zUPfD7CEIC2N2TVYx6n9IZo
         I8fcZuaA3HG9vML0daHOaCf6z3zWk18iSLPI5/iVeAPq98W/aM56HV+mMxSGMuiVzV7F
         7tNzJOULHwsVQxAePKU7KdQ5irVEw5Smk/ser/wRmWm1SXYsN9pcQ8HJ4oiKqTJUKeKY
         p8954pGBnyWdS9cbNR0K4XR92c1fa7dwhHunhQcO8bcpHy2BPHHGR82AjH1NEBxCpZZX
         LzYQ==
X-Gm-Message-State: AO0yUKV6M/B+2aMdAK3BlMCacmqTF3MnMZnj4fYfGI6bFJiH55WAhDUO
        Jto4A1D0F+5M0B4RQsHtIjbDNOMr9b+5tZADSDs=
X-Google-Smtp-Source: AK7set8Y2YSnzKuxHDb8Ua/PIx+5Ws8Q40mHDasHqTEzKBbF+I0sI//PiBTLOMC9TG69qvqDtdlUuX56UpZ0oFd0COc=
X-Received: by 2002:a05:6a00:1646:b0:5a8:4dc1:5916 with SMTP id
 m6-20020a056a00164600b005a84dc15916mr3586535pfc.2.1677757323528; Thu, 02 Mar
 2023 03:42:03 -0800 (PST)
MIME-Version: 1.0
References: <20230302072132.1051590-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230302072132.1051590-1-linux@rasmusvillemoes.dk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 2 Mar 2023 08:41:51 -0300
Message-ID: <CAOMZO5DiH1f0u2cs7zKyFU6bMBLHTRpqMFuPCB=T8ZzyJxDT2g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: freescale: remove generic pin config core support
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Thu, Mar 2, 2023 at 4:21=E2=80=AFAM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> No instance of "struct imx_pinctrl_soc_info" sets '.generic_pinconf =3D
> true', so all of this is effectively dead code.
>
> To make it easier to understand the actual code, remove all the unused
> cruft. This effectively reverts a5cadbbb081c ("pinctrl: imx: add
> generic pin config core support").
>
> It was only in use by a single SOC (imx7ulp) for a few releases, and
> the commit message of dbffda08f0e9 ("pinctrl: fsl: imx7ulp: change to
> use imx legacy binding") suggests that it won't be used in the
> future. Certainly no new user has appeared in 20+ releases, and should
> the need arise, this can be dug out of git history again.
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Yes, this makes sense:

Reviewed-by: Fabio Estevam  <festevam@gmail.com>
