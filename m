Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E7F62BADD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238815AbiKPLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiKPLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:05:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429B52EF4B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:52:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so16996049edj.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jmDzdOcJCZVFEJz0cGwp78BZmKtS5/OHvJ4gcqeQ22U=;
        b=EPRG7osZR2L/3rHtV1b9dGX3T17rHFXmQU4zzbKNX42jRXbXowHCVomW9FwUGaM2r7
         LYIaZDA+k7YlaBCM8mr1imuYBEqlTmhT94UfgxNUlF6CpZnysa9lDUTQEDM2pTqyBukU
         qg38moV/kYoxcYAHoehRSCis7Bkuu42chBmryhv4yZjqtCGquzjMUF6QW4ilLCqDoqBu
         K2cU8PYsJItfRVia9c9Nrmqbj7+yqvqJzvrAm8FwazSKl2BQacUDhjza8CWDHqEn0f5I
         rl5+CYTiHV4BcqwbmjrWj7WJQyPOn1rqbndhF/6JKTrY1cGYOkQT3yHB9H4U6gKPh5e/
         /thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmDzdOcJCZVFEJz0cGwp78BZmKtS5/OHvJ4gcqeQ22U=;
        b=SGkm/4Dq9N6Q3u39T2NS4scyrVPEWGQMmuvbREfSMo91OQffGplsHfZ8bVHpMazS8k
         lDfB+Jx9wQX5nBYEzK0aQD1bT2TOYc/Ctwqu/syLzcrhx3Ll48HU9Daga1fjqeDwF8dE
         ZQbj7GJ9mFXYdmq7lgcEXQcLhsWQ4RC/rNc8A3cFQxPpH4yUnTb6P04wcVYtcdmOE77Y
         gV9paqlmNO2sCwSnaQjTRq+6aGL/hbOOuXN9yG20pN7WJats0s87O64vGxfDpIcEZmdU
         Z6p9jiWUlupyf2ffM+/kr6rMB7bX15uLPGyo/DdzocAYLfEYo/1yAN6jCSDWwEriEyAc
         4Dfw==
X-Gm-Message-State: ANoB5pnYQo1Wl6+FrJPkviACtwScb2qHNYjaOoSJ1SFODpNGC07UWNIX
        KbxAYU6vdiVJde2qWKHSSstOn0W9Kzwhyyh93iYLxdzxUM58gA==
X-Google-Smtp-Source: AA0mqf64irImFpuxWfnuQVwe5pGIad2p0If0h7oh7065tcZjwfzMlUBDf1yRl9o/jLlSJRaOIU8hV7LxOrNP3Ko2F7I=
X-Received: by 2002:a05:6402:b7b:b0:463:ab08:2bc6 with SMTP id
 cb27-20020a0564020b7b00b00463ab082bc6mr18384756edb.143.1668595919878; Wed, 16
 Nov 2022 02:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20221021084708.1109986-1-bchihi@baylibre.com> <CACRpkdYdmG5cFenESg36BwVpJ7FDJunPH1Z8dJjHwmu+NW-etA@mail.gmail.com>
In-Reply-To: <CACRpkdYdmG5cFenESg36BwVpJ7FDJunPH1Z8dJjHwmu+NW-etA@mail.gmail.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 16 Nov 2022 11:51:23 +0100
Message-ID: <CAGuA+oq8XrvNrDdW6JZS7UyhM4ZCk-RvpMUnw-bht9d6nJr3jw@mail.gmail.com>
Subject: Re: [v2, 0/2] Fix broken SET/CLR mode of a certain number of pins for
 MediaTek MT8385 SoC
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     sean.wang@kernel.org, matthias.bgg@gmail.com,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 3:44 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Oct 21, 2022 at 10:47 AM <bchihi@baylibre.com> wrote:
>
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > On MT8365, the SET/CLR of the mode is broken and some pins won't set or clear the modes correctly.
> > To fix this issue, we add a specific callback mt8365_set_clr_mode() for this specific SoC.
> > This callback uses the main R/W register to read/update/write the modes instead of using the SET/CLR register.
> >
> > This is the original patch series proposed by Fabien Parent <fparent@baylibre.com>.
> > "https://lore.kernel.org/linux-arm-kernel/20220530123425.689459-1-fparent@baylibre.com/"
> >
> > Changelog:
> > Changes in v2 :
> >         - Rebase on top of 6.1.0-rc1-next-20221020
> >         - Delete MTK_PINCTRL_MODE_SET_CLR_BROKEN quirk
> >         - Add mt8365_set_clr_mode() callback
>
> Patches applied, no need to resend for small issues.
>
> Sorry for taking so long, I wanted some feedback from the Mediatek
> maintainers but haven't heard anything, so I just applied them.
>

Hi Linus,

I'm sorry for the delay.
Thank you very much.

Best regards,
Balsam.

> Yours,
> Linus Walleij
