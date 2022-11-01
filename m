Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2CD6150EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiKARkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKARke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:40:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F511C134
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:40:33 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id a67so22783732edf.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UQdrouDXKXfvnI6vdPyQG7nLFjbvZ8WIOoJP9jMXChc=;
        b=lFgWghOzmIXhCHIDDheWnJaQA6brf6Ly22UrhjqZiUag3kGziwK59twAeVx6M/gIM4
         1G483qrSC9Q6fuFyHU2lKN4COQZPP8ZwxzjuCZiT77Z7RYum2+l6jwXeWiWSr1117TKo
         u06hbFdGDtFaqYYTftQlDjY2nNx/EqNHovMtSMt9nt9xvURuZ8/qgSsSHUC9idCck9mG
         TCU57efWvoUlMn3e56Kp2q3lM0iCAX5SNVtKtcOUsXGuQvCqvPT4Cn7mCiYhK3GmbFhy
         pmlaexkr9bBUQtE++QK1cBdxvtTU3Vb0XPqQ/LweUXSV1AM6qU/mQ9ykdgF+mORzzNzE
         r81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UQdrouDXKXfvnI6vdPyQG7nLFjbvZ8WIOoJP9jMXChc=;
        b=zKrcu9ohDBdRyZMTNUycq5xebLqHxThA/RIeLMQazy6I2AWnDib2IC59Y2kFVQCmdt
         6xScKWL2DayEM5VzKBYgzh41hhFGMentmJL5Jw6ZtgNST95XWVsSwMRBk9nAj+ijgazY
         XRZzJODU4LGvD5LeYFcxxM6aashZTCMdDPWY5R+seMyq+FN6/foDgGGhOhS+uRm8RbLN
         aqSw2ovczh71Ri0uuuVB4GMAYNDft+67KtceY0zJbITMILFhqPlfdfCUeqTpJwiMMzMp
         nFaYo15VjjpnoarQb4HxCzZaEGVwIY9EGQtWsj0O9Gg0xWF7w+p4s5MQrMNkHGGMgx3V
         TiVQ==
X-Gm-Message-State: ACrzQf33QvW5REzNL81CNvYpzCx6As8kGFYhl1axbi+xfQlFGckQyQm2
        rHZrP1JvkJNTES0d2HPOOr38S5sywmzOBo16eh0=
X-Google-Smtp-Source: AMsMyM6cO7xf9Yoje6qJYFc9KxbVMTB4kjV40MW6U2wHClkuXh5MNse5Fajj12u+FfB2cWh/uoqvC60OYYPiFTGf2iU=
X-Received: by 2002:a05:6402:616:b0:463:e2cd:a88d with SMTP id
 n22-20020a056402061600b00463e2cda88dmr651298edv.400.1667324432069; Tue, 01
 Nov 2022 10:40:32 -0700 (PDT)
MIME-Version: 1.0
References: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
In-Reply-To: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Tue, 1 Nov 2022 10:40:20 -0700
Message-ID: <CAJx26kXrsELEkTGYJ31hVR7icfM=WARjad0bf=djeGCdLf7h0g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Various bug fixes/improvements for phy-brcm-usb driver
To:     alcooperx@gmail.com, kishon@ti.com, vkoul@kernel.org,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
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

On Wed, Oct 5, 2022 at 2:30 PM <justinpopo6@gmail.com> wrote:
>
> From: Justin Chen <justin.chen@broadcom.com>
>
> A few suspend/resume bug fixes with clocks and wake counter. Also improve
> port mode selection.
>
> Al Cooper (1):
>   phy: usb: s2 WoL wakeup_count not incremented for USB->Eth devices
>
> Justin Chen (5):
>   phy: usb: Improve port mode selection
>   phy: usb: Migrate to BIT and BITMASK macros
>   phy: usb: Disable phy auto-suspend
>   phy: usb: Use slow clock for wake enabled suspend
>   phy: usb: Fix clock imbalance for suspend/resume
>
>  drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c | 95 ++++++++++++-----------
>  drivers/phy/broadcom/phy-brcm-usb-init.c          | 90 ++++++++++-----------
>  drivers/phy/broadcom/phy-brcm-usb-init.h          | 11 ++-
>  drivers/phy/broadcom/phy-brcm-usb.c               | 28 ++++---
>  4 files changed, 116 insertions(+), 108 deletions(-)
>
> --
> 2.7.4
>

Friendly ping. Any updates on this patch set?

Thanks,
Justin
