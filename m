Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C7C6323EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbiKUNi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiKUNgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:36:50 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6581C287C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:36:47 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i131so13576217ybc.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7fETgmcg+RZComtgQK4VwfLsjYwDPSbBGi7QkQgS63M=;
        b=LgTESlEs9kToX/T0EAmm3YEataEKQTY6/rVzfeOL26hCaO0wGF6F6n6D4JElc8z7Of
         sOQBcg3tHIClk/OC72lCdNPyDk87eyNNMw+VtsQclxzechHDagZsuHbJ4NgyCR9+d6CW
         yGjN+Of3fewohlDiHN5l6BFFBNtUC7FeHJAYldH43t694E4cTAwVi0XElCBzq6GL3hUz
         /9aoYJlhpl1JncmfZJTkLVsypQn1GA2HXtZSS8OCGrbtub+ExLPoxzqD47CkaIDzJZcA
         tTXX/WWcXtDZLkO1If1IJ+jplONoaBx4W3Cx7ml7bbzv8KaPFbJD7YM+Bm2jaWBbjEUG
         8zqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7fETgmcg+RZComtgQK4VwfLsjYwDPSbBGi7QkQgS63M=;
        b=ldEioIesUrszSchXsw5nmP6NgBQys/irxfz49gp91w2qrvZ1v3xrRX9zcx2mC0YoBv
         viiZFqqy/5aOlwLs1jAVlbgEBAeP9CnwwfnLYhQmM0ybvI3wCQPTIKPByr7pG2rpPa3c
         V3mTWsEp3DVo7Ahwkf1KRXYUKCk1GhARVql1qUz4bH8x9eWaJ2IDcoJEx0XQ3PotD1FH
         OrTIQ0uAmffxVsct5nwcXUcb+hNE0vtB1MiHYNb05lKPt+Pxr4vCVSvMvHwMCoiNI+YL
         PmkQigDL/clWAomvZTsBGmzn0pQVRvtZ6y8i1wqPHmNPGwXI7aeqxGoENcIkAl2t8tPB
         1bsQ==
X-Gm-Message-State: ANoB5pm/bWN8XjDERnBvdTENExS+eu6em++Ct6ePrHpXcgjCq2tnRV41
        elUtdCm/W8yjKf5IayOg8o4jcNRyXrWDUXgnZr6YRA==
X-Google-Smtp-Source: AA0mqf57H3TO9gZIjfO4a+5v5wlwnlsXcU4w0wfFyEkE0W+ApaZ6mcQuJrZnYvZNfAXNLxOMMQKfDP5zl7cFfFTYcgI=
X-Received: by 2002:a25:1843:0:b0:6dc:b9ec:7c87 with SMTP id
 64-20020a251843000000b006dcb9ec7c87mr590091yby.322.1669037806948; Mon, 21 Nov
 2022 05:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20221121132608.230645-1-renzhijie2@huawei.com>
In-Reply-To: <20221121132608.230645-1-renzhijie2@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 21 Nov 2022 14:36:34 +0100
Message-ID: <CACRpkdb9Aw-8wXUFYnBy_LOpuTeB2RpnUB+QwWQiZ9R6BcwbGw@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: pinctrl-loongson2: fix Kconfig dependency
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     zhanghongchen@loongson.cn, zhuyinbo@loongson.cn,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        yusongping@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 2:31 PM Ren Zhijie <renzhijie2@huawei.com> wrote:

> If CONFIG_PINCTRL_LOONGSON2=y and CONFIG_OF is not set,
> gcc complained about undefined reference:
>
> drivers/pinctrl/pinctrl-loongson2.o: In function `pinconf_generic_dt_node_to_map_all':
> pinctrl-loongson2.c:(.text+0x1c4): undefined reference to
> `pinconf_generic_dt_node_to_map'
>
> To fix this error, add depends on OF to
> config PINCTRL_LOONGSON2.
>
> Fixes: f73f88acbc18 ("pinctrl: pinctrl-loongson2: add pinctrl driver support")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>

Patch applied!

Yours,
Linus Walleij
