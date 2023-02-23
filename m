Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD956A0576
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjBWJ4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjBWJ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:56:23 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEDB51FA5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:56:06 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id g8so9384456lfj.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nwjx+ZOED7Wobs6quU4tNJOEoXoe/5qPUT1I33Kgdms=;
        b=gWRVQNR0H0qODu8fPV4Bd2TdTdahh7pXPWiNR8Lcb7m/uB7aE8M/fcjQrBx/9NEV27
         h/Ml9IBS0DVJvhNqB+oVnJtcIih88SGv7F3B/mfdyw+oEgzxW73mgOrqZ/sHIKN1H96Y
         R24bUdO2FwyjUBALkZvcScf/ce+kypTjmvfPmuYm7MqbRJWIxNgN3R/Eoa3Sok5vgQ27
         d+NKZT2+RUn75sKjgoNNTn3p/nm49FqWm5kJI2ZY2ZqHWYvdrMU1CLv2edAYfuQySYKU
         RGh7th6weBDe4JkDXbJjDVzm3vt5JM/nufX52O76//lYl2zUb0hlYZbESVjXS8cPskfu
         /BTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwjx+ZOED7Wobs6quU4tNJOEoXoe/5qPUT1I33Kgdms=;
        b=unI0Z75Zolqvlo9lbWVmP3xCKtaz9X4TeIdHRUnPv5uooM65BGWPzIdVjWfSjm4ziC
         E7RHDiwr2YYhkC8/XqyZYGcqSro+L9S2H1KCDqK9aeR+/nEPmTprx4do01GTnK26+AUg
         wxJgJIyYPuBhkbZXwAJUyC1B29u4xOcVIU49lrK3W1GP71Y0MnqcSBJkW/WNYiNFw/op
         CM8Vf4akom/W1pX4KN7XbPuFdHE9Tj97b58src7T6N84Zgsh6qDWOGkThkSlW/v/DBQr
         xQk8zWtnPCYi6BfNTo14O5ELHyDvrrc3zxKAEKuedzW/W+KUDHr36OSDpieNUUmuNDJz
         MjNQ==
X-Gm-Message-State: AO0yUKWPs8kvQf3hJcnDEaxng0uDZExcKpg/xGjBla3EjNdBWDmk2YiK
        IYvgSHSKQ4jnrKAPUAv5HpUmKWVoLxlz8w0P3KZL0A==
X-Google-Smtp-Source: AK7set/2IzEs80I6VQ5xxvoEXEeAkyLScM1pXX242UbJrr1zvk6DMp4+qZQdwr9tE4wvNNE3BUPg6FbszDw2vk3Zg04=
X-Received: by 2002:ac2:5a41:0:b0:4dd:805b:5b75 with SMTP id
 r1-20020ac25a41000000b004dd805b5b75mr3431425lfn.7.1677146164295; Thu, 23 Feb
 2023 01:56:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1677063656.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1677063656.git.viresh.kumar@linaro.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Thu, 23 Feb 2023 17:56:28 +0800
Message-ID: <CABymUCMhoKoFHy8K6-ohrcAbyTpDe0Hig3oUM_wH4Db0-9yx+g@mail.gmail.com>
Subject: Re: [PATCH 0/3] OPP: Simplify set_required_opp handling
To:     Viresh Kumar <viresh.kumar@linaro.org>, cw00.choi@samsung.com
Cc:     Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
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

Viresh Kumar <viresh.kumar@linaro.org> =E4=BA=8E2023=E5=B9=B42=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=89 19:06=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> The required-opps configuration is closely tied to genpd and performance
> states at the moment and it is not very obvious that required-opps can
> live without genpds. Though we don't support configuring required-opps
> for non-genpd cases currently.
>
> This patchset aims at cleaning up this a bit, just like what's done for c=
lk and
> regulators. This also makes it possible for platforms to provide their ow=
n
> version of set_required_opps() helper, which can be used to configure the
> devfreq device propertly.
>
> Jun,
>
> I haven't found time to test this through yet, though there isn't much an=
yway I
> guess. Can you see if these can solve your problem properly ?

Hi Viresh,

It looks promising. The function get_target_freq_with_cpufreq() can be wrap=
ped
to act as set_required_opps() callback. But my case is a bit
complicated. CPU opp
depends on both genpd opp and devfreq opp. So the genpd_virt_devs array nee=
d
to be modified or add another array for devfreq case. While genpd_virt_devs=
 is
bounded with genpd directly and coupled with "power-domains" list in
device tree.
Current required-opp nodes are designed to be aligned with the list. I
am considering
what's the best way for back compatibility.

Hi Chanwoo,

Do you have any comments on this proposal? This proposal arise because opp
lib reports error when cpufreq driver try to set required opp for
non-genpd case.
Another possible fix is to ignore non-genpd opp in opp lib. But a
unified and recursive
opp management looks nicer, just like clock tree management.

>
> Viresh Kumar (3):
>   OPP: Handle all genpd cases together in _set_required_opps()
>   OPP: Move required opps configuration to specialized callback
>   OPP: Allow platforms to add a set_required_opps() callback
>
>  drivers/opp/core.c     | 113 ++++++++++++++++++++++++++++-------------
>  drivers/opp/of.c       |   3 ++
>  drivers/opp/opp.h      |   4 ++
>  include/linux/pm_opp.h |   5 ++
>  4 files changed, 91 insertions(+), 34 deletions(-)
>
> --
> 2.31.1.272.g89b43f80a514
>
