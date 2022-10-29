Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02F6122EC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ2M2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ2M2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:28:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259F1647C7;
        Sat, 29 Oct 2022 05:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCC93B80B71;
        Sat, 29 Oct 2022 12:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E57C433D6;
        Sat, 29 Oct 2022 12:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667046496;
        bh=VVwvlVygdKwTbHKrtKh28DGiG0bxit5DZwviW7+DTKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tfoKtddsfNLSfZ1vM/moqVhqoxD3fLJlncvyNUqfCUqOZGI4GtUXVSiXIJdTuHXjj
         PQ2IVgQ3KKt5zmITJUcuuaJsq/QVrdWyjY6xfZ0tgcRBtKsUJmBiuVOfOFMnqF2JOB
         GFqEOWnP+5MX79pHuy7xyogNFbRpFXJIfzbZH0pWHAdEGMiPRnGRmquxg8ffS9R/HY
         KbhuiD4OvYrTzl12mg6Hi41O7jwK92lW5HJ9tBJvDAdo6rbBsZX41oRWKl/g1fIIiR
         4P0K1MEBDAMep/LSeEKtZUw/QOUH8rIlQ57JiQXmDM06xEtl3Nasc7aVvBQey+4AOY
         D6ZZGOc+Vxiow==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-13bef14ea06so9126133fac.3;
        Sat, 29 Oct 2022 05:28:16 -0700 (PDT)
X-Gm-Message-State: ACrzQf0D7rYGGfNi9m/babSxbMrNh+JftRIDpXwyRkNcASand8QGUJp+
        RXkzWuyPH07v0Jhyfqym1uz5GTlxdMumU10klVA=
X-Google-Smtp-Source: AMsMyM5DizOgzDMGfZpH5zCYphhNFuQj0tYt1nOuhcJ3RIhLSkbHR0Ama0k8b3YkbF/XttXuHM0XMl0mCMQWxtqTVHo=
X-Received: by 2002:a05:6870:e98c:b0:131:8940:e7b with SMTP id
 r12-20020a056870e98c00b0013189400e7bmr2187832oao.53.1667046495632; Sat, 29
 Oct 2022 05:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221024111902.1338095-1-heiko.thiery@gmail.com> <20221029122326.GV125525@dragon>
In-Reply-To: <20221029122326.GV125525@dragon>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Sat, 29 Oct 2022 20:28:04 +0800
X-Gmail-Original-Message-ID: <CAJBJ56JoubZ_XMWbgC-BVWtf_79ZJLaHwYsEjFWqAtxwAjFKSw@mail.gmail.com>
Message-ID: <CAJBJ56JoubZ_XMWbgC-BVWtf_79ZJLaHwYsEjFWqAtxwAjFKSw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 off-on-delay-us for regulator-usdhc2-vmmc
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 8:23 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Oct 24, 2022 at 01:19:03PM +0200, Heiko Thiery wrote:
> > The delay is not required and can be remove.
> >
> > Fixes: 5dbadc848259 (arm64: dts: fsl: add support for Kontron pitx-imx8m board)
>
> It looks more like a clean-up than bug fix.

Never mind.  Just saw the discussion on v3.

Shawn
