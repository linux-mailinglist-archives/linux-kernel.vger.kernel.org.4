Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164236B0E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjCHQHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjCHQHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:07:16 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3BF73897
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:06:13 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cw28so67776960edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 08:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678291571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUOD/X3MLXbaSFinuRbww5tKoyJ/4JSfYyoEzJIPkIg=;
        b=Rg3SgBcpYBK+DKWE8tmQoSeFokOAj8h+6SfVAZZrcMVcD1fjv6zoukEd68kmJVfB1U
         rtXl4gzwdGPBeGN7Axms/raMcUjg+U4TcKeexu2o2C6K54xuOZ+iYw5YPoB0ybO69NAs
         1BP0+07mCjH3lHUXfQOu6PGKlpFp5PRHRoWkBIQRuLGd6OGNVB4gHXQU+uK9FXdJyEI0
         rG+nmhLXy2sMKceLAOZBGMYYSiXtfsD+p3vfnP0o4rupbtGQ+cmLlLpn2wYFhHFXCK8S
         NjL/0QKisG47gol+EKvwZeR3en4zINPSMlki3pGW4LjfiddGJAPjK4JdvB0vm5k7Fbmz
         08+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678291571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUOD/X3MLXbaSFinuRbww5tKoyJ/4JSfYyoEzJIPkIg=;
        b=mDhpwX0qBDkRcbOvUcxa16WgzBUX0Rp6uqPujdwKZ3q23U/CSrxUcXh6zwBByIuGh/
         uMPHDOZXOK963OROItY0CuvyUQkRi1RuRKjRs/ehP0lgsSRSfgn/2RDD0LdE0sRRVKeH
         5rlx6JqJxD2VTpB1lA/Pws8U4uo3nL4vCHDDKzmnEnPBHUXNlEheWvP5sVtGC3lo3KmC
         wuLhfogtIgudWWaCKoRKfGEOg4A7S3c/rvNIsPwmhzyI9lLkAZmKJ9/tU3AbjfANC/Y+
         MeLSO/h2WH2KD6CBxmGGkGzQlxJwwbrU4KW4Uy3JiWPmpaMEY5hGbIRwdLIko1KawORA
         pbvQ==
X-Gm-Message-State: AO0yUKWkeOahq6NOYBapeZgYlMzgvqplbOJB9VSNmtwmcqlxpC6QjzUq
        L+m0H28zH5Ph9CMUCSjtB3P7vnqivBeSYLbBMD0p2w==
X-Google-Smtp-Source: AK7set8DCQYR6EeCLCdicp+N7+vPQpFqmFvqGYAUUsZf3YwgIQkfZ7vvmfspmzmc3Ic0/+IpWN2QQYksgERyDGcPThc=
X-Received: by 2002:a17:906:1850:b0:8b1:780d:e43d with SMTP id
 w16-20020a170906185000b008b1780de43dmr9541197eje.13.1678291571683; Wed, 08
 Mar 2023 08:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20230307154524.118541-1-bchihi@baylibre.com> <20230307154524.118541-3-bchihi@baylibre.com>
 <6b1e9d19-b176-280d-0277-492120e3a1fa@collabora.com>
In-Reply-To: <6b1e9d19-b176-280d-0277-492120e3a1fa@collabora.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 8 Mar 2023 17:05:35 +0100
Message-ID: <CAGuA+or+r-RwrD0htS=fMsAi5rGaWRCb8ZFdJRRZ7cayL3w_Wg@mail.gmail.com>
Subject: Re: [PATCH 2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain
 for mt8195
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 10:15=E2=80=AFAM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 07/03/23 16:45, bchihi@baylibre.com ha scritto:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add MT8195 AP Domain support to LVTS Driver.
>
> Please mention the documentation changes in the commit description.
>

Hi Angelo,

A new commit will be created for the documentation in the new upcoming
series for both SoCs,
as you asked.

Best regards,
Balsam

> Regards,
> Angelo
>
>
