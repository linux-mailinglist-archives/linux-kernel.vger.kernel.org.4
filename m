Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19171694B11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBMP0O convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Feb 2023 10:26:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjBMP0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:26:12 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D910423;
        Mon, 13 Feb 2023 07:26:11 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id qw12so32822979ejc.2;
        Mon, 13 Feb 2023 07:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aa38NYMz1XXOSVlpmXem5dRN1dL2OJwDoaPX2ECr5xA=;
        b=CMZUBRJLx6wBBXGP0IzYzSG0Fy5NyYojMlLEutc/f62N8TTWlUudU8Z5vIRQ9oQ0Ny
         LAJsHkujrzCdX0dQR0FrDStz1MmCHb69IfqpcpRIszePlCe6jm04N+K1fehNz4xtLHvh
         81b6KqacoQQ9fuCzIeFI03k4I4h637lc8bfdEuEcnKFNsD3KjApraXMeQZH64UGq1AUD
         tknxD3csh42vmttt7nKhZaeHffbwmwPo7vwUbBrsd8sH/3w6CXkcf+7kya2YQa17MN2I
         m6IV9TIPVZGT2HJMT+pEp8BNv96pUPrH6UQBass9FWaVkTM6IzwQXnJQLgJkweyDJYjL
         1U7Q==
X-Gm-Message-State: AO0yUKXRj31WZBAxxEzdcUQQSZ1IYYxkcVpiTawR5NxzBl8oEHNFowFy
        FnfTb2gCrX3URIZjP16/68lr/io3aB6w3HW2pPCZSMMB
X-Google-Smtp-Source: AK7set/vtpXL/B8ZkBIim5ZWjxk81HFbgJYdWzBQORo0ay9JGge9f0/sPBCxSN85rgLuS9E325KEddvtjRBXOAWHlw8=
X-Received: by 2002:a17:906:487:b0:8a6:91d9:c7ac with SMTP id
 f7-20020a170906048700b008a691d9c7acmr4875377eja.5.1676301969873; Mon, 13 Feb
 2023 07:26:09 -0800 (PST)
MIME-Version: 1.0
References: <76fe1e13-761c-1153-b913-ed2c41c8d807@linaro.org>
In-Reply-To: <76fe1e13-761c-1153-b913-ed2c41c8d807@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 16:25:58 +0100
Message-ID: <CAJZ5v0hMCnjjV1vCzCag0RK1owU6F401EXnda_e2yraS4rNrqw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal material for v6.3, take 2
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        yong qin <yongqin.liu@linaro.org>,
        Vibhav Pant <vibhavp@gmail.com>, Alain Volmat <avolmat@me.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 12:10 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> The following changes since commit 61b7614c114c817f9f326282c2f7a728bf0051a8:
>
>    Merge branch 'thermal-intel' into linux-next (2023-02-09 19:57:59 +0100)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.3-rc1-2
>
> for you to fetch changes up to f8da73d02bfcf6d61513912035150d91c14ea1e9:
>
>    thermal/drivers/st: Remove syscfg based driver (2023-02-13 11:42:35
> +0100)
>
> ----------------------------------------------------------------
> - Fix missing thermal_sampling_exit() call when unsubscribing (Vincent
>    Guittot)
>
> - Add the LVTS Mediatek driver along with a relocation to the Mediatek
> folder (Balsam Chihi)
>
> - Add the r8a779g0 RCar support (Geert Uytterhoeven)
>
> - Fix useless call to set_trips() when resuming and add interrupt
>    support detection at init time on RCar gen3 (Niklas Söderlund)
>
> - Fix memory corruption in the hi3660 thermal driver (Yongqin Liu)
>
> - Fix include path for libnl3 in pkg-config file for the libthermal
>    (Vibhav Pant)
>
> - Remove core header inclusion from drivers (Daniel Lezcano)
>
> - Remove syscfg based driver as the platform is removed (Alain Volmat)
>
> ----------------------------------------------------------------
> Alain Volmat (1):
>        thermal/drivers/st: Remove syscfg based driver
>
> Balsam CHIHI (3):
>        thermal/drivers/mediatek: Relocate driver to mediatek folder
>        dt-bindings: thermal: mediatek: Add LVTS thermal controllers
>        thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver
>
> Daniel Lezcano (1):
>        thermal: Remove core header inclusion from drivers
>
> Geert Uytterhoeven (2):
>        dt-bindings: thermal: rcar-gen3-thermal: Add r8a779g0 support
>        thermal/drivers/rcar_gen3: Add support for R-Car V4H
>
> Niklas Söderlund (3):
>        thermal/drivers/rcar_gen3_thermal: Do not call set_trips() when
> resuming
>        thermal/drivers/rcar_gen3_thermal: Create device local ops struct
>        thermal/drivers/rcar_gen3_thermal: Fix device initialization
>
> Vibhav Pant (1):
>        tools/lib/thermal: Fix include path for libnl3 in pkg-config file.
>
> Vincent Guittot (1):
>        tools/lib/thermal: Fix thermal_sampling_exit()
>
> Yongqin Liu (1):
>        thermal/drivers/hisi: Drop second sensor hi3660

Pulled and pushed out, thanks!
