Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F55666E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240144AbjALJbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240063AbjALJas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:30:48 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2973B1CC;
        Thu, 12 Jan 2023 01:26:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qk9so43273165ejc.3;
        Thu, 12 Jan 2023 01:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PR3FCK8jevczBl2UhB85vtXZ48F6Lz73xrO5XCgZHBY=;
        b=agaiZqmWB85gcIkW3xiRxHarqMRlo3MPvklXc74QhW+qLarqWVvMvByOwal4ZoVi7E
         8iyTqNoWnYGn7thYTP+m3QuAVcQ2R3DBSkTf+Vyw011D7kATC6b9zt8755k9Bw+KnV6x
         xb0K4JJkl+fv3cl/rM1KIpd/3lKLl3AtG9A48P/WxKTzDr/LYCYagOjS3VhNnWfEEpD5
         QwsgvvW9cQM9GiBXdtNoaANVD/hdTccNoGLYUizSndxci+EgV6uv2gC5v/kF12stwWFc
         aNmuh48/+vTiIlV2HUzb+Lw2SVKYxYpCX00gBeHmJS0MrAiLnt6yTsTPq5KbLZUVx4yO
         YG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PR3FCK8jevczBl2UhB85vtXZ48F6Lz73xrO5XCgZHBY=;
        b=RHXCX2sJpZDRJ8VxLQNKD7m+wjzcQOAHictvskDN6f/8k97/9GqWiNdu43sPSa7ozm
         01BeETM/KxKcIUCq83H2+tEoOxXkbMuARzckXPSsDfwkpLpXAKAOf8SZm9Fx0PxpazfQ
         D2zaqljx9u0IWOHpPsKzDRygLSd4eAGPo0ePc4Tw1QiHEaMH8fylxKZ+JuPE4lAZCM3q
         kWYfpH4CheEhFj/LIBrUx/1UEn1VAf2Supev8gLGc84TM/P3+hrt1kGbU980YxVbCNxs
         Scl73SzV+Ip2tjNxKZsVz71vfGjsiJiUlZhCgS+j8mLyzEh12+35Ops67IPeldXazsoG
         OjeA==
X-Gm-Message-State: AFqh2kpd9Nu/9cyTtxpizOI6heUDraNOcF+OBzReKgC55mw6semYd4Zn
        zLQ0Rle+Qy+UKle420uODTF8z5tZyWLhaZIc+hM=
X-Google-Smtp-Source: AMrXdXvXFyga8myPB2cyI62NtveSMPiuxqKxMwiHFG2IB1BstYfcKsA16ul35E8scVqCz+anEG94J8GjIC7LrQAppiA=
X-Received: by 2002:a17:907:a485:b0:7c1:5422:c39c with SMTP id
 vp5-20020a170907a48500b007c15422c39cmr5129541ejc.130.1673515571298; Thu, 12
 Jan 2023 01:26:11 -0800 (PST)
MIME-Version: 1.0
References: <20230112083746.9551-1-lukas.bulwahn@gmail.com>
 <20230112083746.9551-3-lukas.bulwahn@gmail.com> <4d2f2b81-b7ab-4ad6-84cc-f3a3c932880d@app.fastmail.com>
In-Reply-To: <4d2f2b81-b7ab-4ad6-84cc-f3a3c932880d@app.fastmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 12 Jan 2023 10:26:00 +0100
Message-ID: <CAKXUXMzRk1aK-_kELB7dZXAS711HuiF4TGaf_BgDK=dhY=iyVQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: pxa: remove further dead code after pxa93
 support removal
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jan 12, 2023, at 09:37, Lukas Bulwahn wrote:
> > Commit 150ccb6f9a89 ("ARM: pxa: remove pxa93x support") removes configs
> > CPU_PXA930 and CPU_PXA935 and uses of cpu_is_pxa93x() and cpu_is_pxa935().
> >
> > Remove some further dead code in ./include/linux/soc/pxa/cpu.h on top of
> > that commit above.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>
> I had this in an earlier version and ended up leaving this bit in
> when I reworked the series to not drop support for PXA310 and PXA320.
>
> You are probably right that we should not reference the removed
> Kconfig symbols, but I see that this causes a regression
> unless I also bring back the change to
>
> drivers/mmc/host/pxamci.c:                              || cpu_is_pxa935())
>

Thanks for the insights of your previous attempt. In my janitorial
work, I am just triggered by references to removed configs and hardly
have the resources to test all the various arm pxa configs. Let us
keep it as is for now, and see once your clean-up has settled in
mainline, if we find a good suitable further cleanup patch on these
code parts here then.

Lukas
