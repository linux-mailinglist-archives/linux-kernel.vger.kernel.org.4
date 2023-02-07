Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053A068E379
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBGWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBGWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:37:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB2E18B0D;
        Tue,  7 Feb 2023 14:37:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6AD861323;
        Tue,  7 Feb 2023 22:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5D8C4339C;
        Tue,  7 Feb 2023 22:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675809432;
        bh=P/j9FremlEniDh+5z4OLZc9/d9eizPzjrG/+jYcUjFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aIxGR8de9at3sLqsFQR8qwsqXwZfFHJEyZUZcZdmdku+j731I0qtNC10C/UgQ4n9D
         /gKsvNLcNxbs/qDKAKqR3Xga715Rtpq1Uwwwag6/X6rfKgZ4evQuBSuuRbufqmXQZx
         Rjj+rcs8d0dOamCXYYEd6f3d38NsaH5k4E/Nge08XPMgQVsVExaQ/0vGIGwVsYETgm
         Zyyqspiq3mg5pCrEG38PLb9dMWKUhPwOeve0giAgiGAhQmJkAKqWZcJ6mvzrxQEIUE
         2ORC/m29kwB5PhPZTC2lWZq4TNEoA37NZKiXZehEUsub3n0rPvW+H6TzHeoYAPHNDX
         oR7l2phZDPNpg==
Received: by mail-vs1-f48.google.com with SMTP id g8so2677630vso.3;
        Tue, 07 Feb 2023 14:37:12 -0800 (PST)
X-Gm-Message-State: AO0yUKVy+b/x97THDHD/qejBDdhxI8cqUUWH+hLoZkkEbTHXeS4Cuv3k
        AkGp46cJjQ/1YuCW7iOJQAegPQSgxNVD0kwyyg==
X-Google-Smtp-Source: AK7set8CTKpK37ejmlVmUa1pDbSyYbK30K628/7kCIC7xileb97NUKAyVKF2Xl4q+KD7x4yI4c594dn+El+Gpklm5jM=
X-Received: by 2002:a67:d514:0:b0:3e9:107e:cc55 with SMTP id
 l20-20020a67d514000000b003e9107ecc55mr937433vsj.6.1675809431022; Tue, 07 Feb
 2023 14:37:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1672730839.git.chiaen_wu@richtek.com> <664b47539b9773425556f569e40d687e33799c53.1672730839.git.chiaen_wu@richtek.com>
In-Reply-To: <664b47539b9773425556f569e40d687e33799c53.1672730839.git.chiaen_wu@richtek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 7 Feb 2023 16:36:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ4gueN3UFfea5JC6xfPjaH6a+7+dioTw=s0W-gBf6Anw@mail.gmail.com>
Message-ID: <CAL_JsqJ4gueN3UFfea5JC6xfPjaH6a+7+dioTw=s0W-gBf6Anw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND 2/3] power: supply: rt9467: Add Richtek RT9467
 charger driver
To:     ChiaEn Wu <peterwu.pub@gmail.com>, sre@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, chiaen_wu@richtek.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 1:30 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
>
> From: ChiaEn Wu <chiaen_wu@richtek.com>
>
> RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger
> for portable applications.
>
> It integrates a synchronous PWM controller, power MOSFETs,
> input current sensing and regulation, high-accuracy voltage regulation,
> and charge termination. The charge current is regulated through
> integrated sensing resistors.
>
> The RT9467 also features USB On-The-Go (OTG) support. It also integrates
> D+/D- pin for USB host/charging port detection.
>
> Co-developed-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
>  drivers/power/supply/Kconfig          |   19 +
>  drivers/power/supply/Makefile         |    1 +
>  drivers/power/supply/rt9467-charger.c | 1282 +++++++++++++++++++++++++
>  3 files changed, 1302 insertions(+)
>  create mode 100644 drivers/power/supply/rt9467-charger.c

[...]

> +static const struct of_device_id rt9467_charger_of_match_table[] = {
> +       { .compatible = "richtek,rt9467", },

This does not match the binding. Probably the binding should be fixed
if this is only a charger. In that case, '-charger' is redundant.

FYI, 'make dt_compatible_check' will detect this.

Rob
