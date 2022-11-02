Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141BD616AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKBRaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbiKBRaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:30:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C93317418
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:30:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l14so25581708wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+rK1oS5b52BUstGwWG9rUx1UdvvX13i+yEKBaYvTNQ=;
        b=VD4MJW+qcwgnBm9szQ6+h6/LW+4yTBmfI3sFDOf2xthoO7MmLBx1eTeGY3MeeFuEb7
         oGNDRpU1BzApBH2MZ7e8VOXw2pp0wZ9ZsMQRbrYBFsQ2ikSt4M+RrDX9Hi6CuZNFkmKy
         tAWUw0M1kWfDgdW6vEA/N0WAdFI+Kh+s8LFASUK3kbZhooz33+bdWnMNuPkcCQL4Y++K
         pTQ1TnPNk4ModOIomsgcehbQmISc7NNLnEaBEfs8grDehp7C8gg9+Safmkl/71BkP4IR
         1mXl5xH+AfW6hfVHd1RyE13RPzYwn6/rJTE0W+Db0wRzHuqQSA3uaNExWFkBh34KGDNU
         KZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+rK1oS5b52BUstGwWG9rUx1UdvvX13i+yEKBaYvTNQ=;
        b=tiHGm49qGnPa+s2XjpVI64zb/RU4VYIw7xSicoPoEuDFl4pmakOVN/eGRSIY+fMYAe
         FHnzl1pcnsO0o1L7IvjpqG02AG0ZKuz0fEk68jtM2nCOLm3Ml0mDwwt3Xybzt5hcB+Oz
         kBTOqMDEmj/fsrsdu99/g57oGYo6nKG4HYHiTs3UTDNqTICuL7znP8Q41GfDZaMZUZh8
         qa3u5dE3i+CfzrsL1AYJaltzN7Pga/+uRnW0zZmZZAd4H6RxsUIDrNeDCJiKgVA1+ubv
         jwTVOhNUOHjFpOeGloeXw0Oq34t9elVHkiVQILQXCaYudyBpBvHtsbv82G6d2APhE9nI
         1Bgg==
X-Gm-Message-State: ACrzQf3KAo4N6gG/+aRDRZCwzDLaFFvsI2UMhSyp4TQrZBmrnse4mJP6
        lekYhAyzXFVZvUIrGmFTXfrOFWRwN13mZoUwc4JEOw==
X-Google-Smtp-Source: AMsMyM4+uiTjeEtL+Z6dWj5D18OHpZ4bBgrqXby9zaGCPTR2QKHUYJzfcJMmInKTZJQKz5CYR/UtzCeAgzxhi5IkKQA=
X-Received: by 2002:a5d:6743:0:b0:236:6301:918 with SMTP id
 l3-20020a5d6743000000b0023663010918mr16200534wrw.247.1667410205063; Wed, 02
 Nov 2022 10:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221102112451.128110-1-peng.fan@oss.nxp.com>
In-Reply-To: <20221102112451.128110-1-peng.fan@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 2 Nov 2022 11:29:53 -0600
Message-ID: <CANLsYky1j_BMD-Dg1Lath4bftE-0qPEod7fxcaN3UkKUpjP7dw@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] remoteproc: imx: add start up delay
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 at 05:23, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V2:
>  Rebased on linux-next
>
> V1:
>  https://lore.kernel.org/lkml/20220609123500.3492475-1-peng.fan@oss.nxp.com/
>
> There is case that after remoteproc start remote processor[M4], the M4
> runs slow and before M4 finish its own rpmsg framework initialization,
> linux sends out vring kick message, then M4 firmware drops the kick
> message. Some NXP released Cortex-M[x] images has such limitation that
> it requires linux sends out vring kick message after M4 firmware finish
> its rpmsg framework initialization.
>
> The best case is to use a method to let M4 notify Linux that M4 has
> finished initialization, but we could not patch released firmware,
> then update driver to detect notification.
>
> So add delay before linux send out vring kick message. It is not good to
> use a fixed time delay in driver, so I choose to get that from device
> tree.
>

From where I stand this is a hack to hide the lack of motivation to
enact the real solution that is outlined above.  I also wonder how
these problems were not caught during the testing phase.  Either find
a way to upgrade your firmware or keep this in your internal tree.

> Peng Fan (2):
>   dt-bindings: remoteproc: imx_rproc: add fsl,startup-delay-ms
>   remoteproc: imx_rproc: delay after kick remote processor
>
>  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml    | 4 ++++
>  drivers/remoteproc/imx_rproc.c                           | 9 +++++++++
>  2 files changed, 13 insertions(+)
>
> --
> 2.37.1
>
