Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744C55FB9D7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJKRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJKRpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:45:20 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C843F13EB1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:45:18 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id a2so9413392vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NhUfh06C/An6YGnLWkAPjWZ5V+4TW6TFgUY2N8yedlQ=;
        b=jwJ7b5n4OHJ38hRs//PlrNs39qZE2d2GR4KT/tnJ6P0VN//vN/+KQ5Ptcug1fpGepz
         Q7mhuK9txLhRSb+IhG96/TJBZebtUk1/Oe2igsN6irT4lNzacB/n3vekLgHwJciSv9eI
         ar4EWFfW1X0lUmxB7h/JuUPIE0qoKCzvbFB7V0bsfU/IjEp2c19l3TH6aiPgjsXpdYc7
         HrLeyv8hpdhv3dDMW06WTnSCEiYhFP1wFKG2q2YwbP9MGDdT+jPmCo0A/v9lntj6NWuQ
         GjJJlRsupfg10nF0iGgwFh6T5SIj/UytZeh/vEeuSafWWnLrbI6jlBV7E54pAHXisPwY
         sG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhUfh06C/An6YGnLWkAPjWZ5V+4TW6TFgUY2N8yedlQ=;
        b=O0r70Kxl41D9vQagHodZqXCSAdvgY8HcSlCU4Ety3wOTOa7XYGOXsjBcpG6fT1s0NM
         SKbx6jOVZKoB4kWz88AhW3KO39j48t3AYhyFFuu5yivWN5v6da3zEFNJ2gItY/HcPAvw
         zMwSgUq4dQ/nUnsHk1kTKVqldpW7blRGx//o4CfXnGXGV3Hw84aUJOuNjXXFjYfdso4F
         S44QLuoCclBwaL2EV57YyttO+UwB3k/0g63h1mpGuZIir8086Gfzi49COOJvqRadAran
         2liSIGQECiK3P2cGbVzYyGJag/++RrxFqQY0sjNPMeFHjgiDKYM7GYUslF7QHYkhFUeH
         vTAg==
X-Gm-Message-State: ACrzQf34HBMOWr1ob2iDsT9XXqW+rRl7mxMUYiJ/ZvcO0NiOwtTEUuPg
        ZbwO1GEMOrRxqz47vv5lqxkeEYIW/IcfOnfKQGlpL/sQ
X-Google-Smtp-Source: AMsMyM7iE3eSMLYqCcU4IwkKgRxu0ZhToC4peZYWOaSvN9PvpNYMIpRu5Teh0pjvZr7qcF9IbM7NEt589XVuO419lZ8=
X-Received: by 2002:a05:6102:3172:b0:3a7:319c:ffef with SMTP id
 l18-20020a056102317200b003a7319cffefmr12116685vsm.80.1665510317370; Tue, 11
 Oct 2022 10:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221010092014.2229246-1-xiaolei.wang@windriver.com> <20221010145726.GD92394@ediswmail.ad.cirrus.com>
In-Reply-To: <20221010145726.GD92394@ediswmail.ad.cirrus.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 11 Oct 2022 12:45:06 -0500
Message-ID: <CAHCN7xJbwhpL8sp6rn6D5G1PnLJTvaow_b0hF=Lv_AzcWsd4DQ@mail.gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Add an event handler for TEMP_HP and TEMP_SPK
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Xiaolei Wang <xiaolei.wang@windriver.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com, steve@sk2.org,
        geert+renesas@glider.be, chi.minghao@zte.com.cn,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 9:57 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Mon, Oct 10, 2022 at 05:20:14PM +0800, Xiaolei Wang wrote:
> > In wm8962 driver, the WM8962_ADDITIONAL_CONTROL_4 is used as a volatile
> > register, but this register mixes a bunch of volatile status bits and a
> > bunch of non-volatile control bits. The dapm widgets TEMP_HP and
> > TEMP_SPK leverages the control bits in this register. After the wm8962
> > probe, the regmap will bet set to cache only mode, then a read error
> > like below would be triggered when trying to read the initial power
> > state of the dapm widgets TEMP_HP and TEMP_SPK.
> >   wm8962 0-001a: ASoC: error at soc_component_read_no_lock
> >   on wm8962.0-001a: -16

Thanks for this.  I saw this same error, but the audio that I use
didn't appear impacted, so I just ignored it.

> >
> > In order to fix this issue, we add event handler to actually power
> > up/down these widgets. With this change, we also need to explicitly
> > power off these widgets in the wm8962 probe since they are enabled
> > by default.
> >
> > Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
> > ---
>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Tested-by: Adam Ford <aford173@gmail.com>
>
> Thanks,
> Charles
