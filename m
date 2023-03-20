Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12C06C0E52
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCTKLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjCTKLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:11:18 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806C61BD9;
        Mon, 20 Mar 2023 03:11:15 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id bz27so609177qtb.1;
        Mon, 20 Mar 2023 03:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679307074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVu+5LM+n5S+m3afYfpgcD0EeRGmLNpp+tXakDwzmT8=;
        b=beWuDmyL+NNsrvkK7dFnUmnYw04XKdrb13EeNF9Px9lt6H5FFNrH6JdvPf4+NOVRbW
         UmEdZ9NJTRhTvjGJuV7GLe5wwPXQw516KPGlgxFMg4AXNDkjB2z1HJp0v/+9ebI8ynBX
         3qtKBzEtxu+8mh1pAR6BgraUkxLRQqtUCn0O63niGzZnYvNrFB8RUEzftYvWxoqqkPtC
         C34/aZNEmUvXUiBrAEkti0IENYv63XGjTczE1c8SH6OGJTYPhk08alV3aJsJ1uW88fzA
         wZeiSGiM1C34wXrunmox3djy4K8/HHe0utwlH785SRutcG1OeSvBigKYkBkMgUxc08wZ
         BYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679307074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yVu+5LM+n5S+m3afYfpgcD0EeRGmLNpp+tXakDwzmT8=;
        b=Nc6U3exIHFIHQSqrOmLLcXSkGCs/ltdJ9nYhKz4LN34xHU6nRJsgPdqry+SJEDiNlG
         r8q3y1MMqM969hKriPxLCg1dJdfuEFSisz3/u3TCT8VIOaIv9FL4JOyBTa7ijkScLhiN
         nhalfLcJjmUpe4oWxsueRbnnr/QFyRRw/19leMpkAsdtlGMR4fOnPmRaarOIy/2yPpJK
         74lVcLHICIeANdtXT0be/1pzKzFAVvdA7Kh9zZI0C3F6e/Q/G83TpqQxgZ7Vbjrf1ZHq
         33cmBqejdCjpYWuRJ4n7XcY2AVPbNO4qydWrqG+pCuql+U1cK6SKgdvuzeYqZ9TYRTBf
         VoUg==
X-Gm-Message-State: AO0yUKWn2vH2ii4fSLGj1hNNrVjeMKdklv3DHyvAn0cOO3Ty3vFrBYh/
        E/GzoxKWUT99VBLZB4YLDgHSz1M4Of0aYYG4k0U=
X-Google-Smtp-Source: AK7set/N/c1j9jpxMoJtOx8hIYRYm3z6xjz0i0SNt/oDvYWlcoKOLY50Y1BWLlTU5klU113E28kOdzETszUS/8JqKvY=
X-Received: by 2002:a05:622a:1aa8:b0:3df:58e7:4aa5 with SMTP id
 s40-20020a05622a1aa800b003df58e74aa5mr1704739qtc.0.1679307074525; Mon, 20 Mar
 2023 03:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230319115925.1317654-1-sensor1010@163.com>
In-Reply-To: <20230319115925.1317654-1-sensor1010@163.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Mar 2023 12:10:38 +0200
Message-ID: <CAHp75Vf9kwhbZaGjZeN5Jq0Wr_yJtDdj9N48-3o79AMORqmS3w@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/gpio : Remove redundant platform_set_drvdata().
To:     Lizhe <sensor1010@163.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, geert+renesas@glider.be,
        info@metux.net, rjui@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
        sbranden@broadcom.com, shc_work@mail.ru, j-keerthy@ti.com,
        hoan@os.amperecomputing.com, fancer.lancer@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        kaloz@openwrt.org, khalasa@piap.pl, keguang.zhang@gmail.com,
        daniel@thingy.jp, romain.perier@gmail.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, grygorii.strashko@ti.com,
        ssantosh@kernel.org, khilman@kernel.org, mani@kernel.org,
        ludovic.desroches@microchip.com, andy@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, jonathanh@nvidia.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        michal.simek@xilinx.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-unisoc@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
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

On Sun, Mar 19, 2023 at 2:01=E2=80=AFPM Lizhe <sensor1010@163.com> wrote:
>
> platform_set_drvdata() is redundant in these functions.
> the purpose of calling this function is to place data
> in *driver_data. but the data is not retrieved in these
> functions

You need to:
1) split the series on per driver basis (not all of the drivers are
going thru the same subsystem);
2) improve English grammar and style in your commit message;
3) carefully explain in the cover letter your methods of finding the
places you think need to be improved.

Before that it's a waste of time to look at your contributions.

--=20
With Best Regards,
Andy Shevchenko
