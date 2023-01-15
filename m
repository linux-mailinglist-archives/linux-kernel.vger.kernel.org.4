Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EC66B406
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 21:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjAOU7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 15:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjAOU7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 15:59:00 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFC013511;
        Sun, 15 Jan 2023 12:58:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jl4so28404076plb.8;
        Sun, 15 Jan 2023 12:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hIcU6hD2bPR8TQFXwHfTxxDj4xDaU8U2IsQoMFuFoUQ=;
        b=Nj2rCwPgW4gEprwaYPjcwVnX7liNhlAKiGJ+x6k8XsMknRtgMd4WBTkEQE1CmXgG36
         u8wkpGmvmxIOwsIqGso+GsFD51XjTMOc8rDZja68vS61yoYEuplprdLXNHqS7QvdWMLF
         bEgIf7L8e9Z6Lk2j2jioIFYOfXh4sSbMBSAVQl+olDZbsijjhjZ1cMrHsK+rGVLY9zbC
         rRqQODW1rdJccV8oRM8ZiBj2efZ7TzpsHwXGMoxBEKfzYVMZIivV0nwoE7Rx9/OoebA6
         i7TrK/9eBAxlYTaUJoP91Ep+vqMSjy7jtU/Zra+ev0QTLu8snEKpuivUznhgRpQhs2IK
         r6YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIcU6hD2bPR8TQFXwHfTxxDj4xDaU8U2IsQoMFuFoUQ=;
        b=RubuGn5nW9gvNBXjEPKnx34y3g7i9KDhV5qkInxFwUEPVGxGOj3KHXeeE3TmMb4zT0
         poOvlPp83SFXLOrIgsn7JWblnRiyesXKuJdmHBLJztIPWX4xUwsV2Ml7wxLCDznN6kWJ
         R25d1VPGolBsf96sOlQK6VKz40y+GwrY+iK44QWXNdDpHq7nSmWK7SwuORak7MDpW/yC
         h0hIpqNoqMoIgcd8gnt+KuTVIDybUttgbrjzoTPLA9f3nr1Ae50qZZQFvJhidSrd1nAa
         HFRiTXz8vdjuPkQDLJsL6/WK5iLMOAzLBesphxTwo7CIPqqfVVvOhip0l5EYV0QcXwF3
         +wDg==
X-Gm-Message-State: AFqh2kqEe7cNs/KFoIZTRG2GYca3j6jfXMAJxbduzBRGeevwEbU9JDpB
        y8SDODb5zvpuoQMBVfrAwzUBx95lmWes0dXt4iO4dWLNvLc=
X-Google-Smtp-Source: AMrXdXvtenTyA0EVGUaSf/CqTdkRK31Yovm6GBrYGLDUip3ReDbwysumhvlAV7E0BRBLKOXLxzYqNCacxo7ylDU318k=
X-Received: by 2002:a17:90a:cb11:b0:229:5037:d9 with SMTP id
 z17-20020a17090acb1100b00229503700d9mr398473pjt.195.1673816338805; Sun, 15
 Jan 2023 12:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20230115103217.9232-1-pierluigi.p@variscite.com>
 <CAOMZO5CdG=Tx98DVYo9QZFM7Y65b0KGLNc=XskYDuRqORBiLSg@mail.gmail.com>
 <CAOMZO5BLoCibdbmBV5Sysfc7seCnYu7Mvu+Yar-YUvDrjJuNCA@mail.gmail.com> <CAJ=UCjVX212EdAoCe62BxA9T6CEs-jXPwfXMN_gjd5=Z-8w3zA@mail.gmail.com>
In-Reply-To: <CAJ=UCjVX212EdAoCe62BxA9T6CEs-jXPwfXMN_gjd5=Z-8w3zA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 15 Jan 2023 17:58:47 -0300
Message-ID: <CAOMZO5DGGgPTCVps8XGgUR992VKyKaQxY6cu6L1q-0mX0KqUGg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
To:     Pierluigi Passaro <pierluigi.passaro@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, pierluigi.p@variscite.com, marex@denx.de,
        peng.fan@nxp.com, marcel.ziswiler@toradex.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eran.m@variscite.com,
        nate.d@variscite.com
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

On Sun, Jan 15, 2023 at 5:54 PM Pierluigi Passaro
<pierluigi.passaro@gmail.com> wrote:

> I have a temporary SMTP configuration problem with my company account.
> As soon as it will be fixed, the patch will have no changes, will only change
> the SMTP mail server: is this warning so critical ?

You can manually edit the From line of your patch and change:

From: Pierluigi Passaro <pierluigi.passaro@gmail.com>

to

From: Pierluigi Passaro <pierluigi.p@variscite.com>

and then send it from your Gmail account.
