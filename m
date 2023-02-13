Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45022694139
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjBMJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjBMJbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:31:39 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC9916AEF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:30:03 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id x4so13669968ybp.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fbCnS9qQOyU9623tJsn2QphhHvRbvyNNBbtC5U5z6J8=;
        b=odroHUcqkgcojn02dHabgYmZH3VY11+Urwb7RTpZ5NyCwDhI/MTiKdbotFjm2yzYBU
         8OVdx6KfYdT00gJY07OXJkj5tDo2fHRtR+a7ued0jN3bZjGm+bvqgGLd2iKkD+Iyce8Q
         j3UKTikpP5Tr49t/XOxZMhip5nxQnPvBV/Aj+VN9liszJnJDp6b5SOxTtEwF4hq/IH9A
         iTxmrUxzY2043+mlhVViU0qc/BSBZ5JBJW1Ni/MGuyGemOydRaaNQTwow0qHI/+vMRwN
         NtmQh1SF6nuLSPa2nfc+jJJ+N1VVk9gWT59iCdto60h8O6dnTth3+yLTJGNK5mnJnfDo
         M1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbCnS9qQOyU9623tJsn2QphhHvRbvyNNBbtC5U5z6J8=;
        b=5tIBt1F7kRvt5HX9mEhDvwYx1JrWRdA+/gMECtLseuGmSPLYm6sSVENHpN56moEX2V
         mPG+NsTEWtRGnmZymS1/5uUhSkIC4ZwFTZ9wSkDV2KnI3DkXRbm1Phr1F10R63X1lxGG
         9MsOPRtzoZKqEHaEC7ZMmsdwmnoUrFffSeN03vMbDDEpAFAdu0jzfqLiF/6VaRaSC+Ij
         ilXi0QwZoT3TttQSZmaa5tpufztznLiy78+GnGC5B/xhJp/dUiGotxbSiqi1lxBbCz74
         pRh+lmq1NjnjofBaE6N3ypXMajMbwMZHl+Bnb46zw+sj4QRcs9k9Hsb2hsYorYYAaX8m
         S36Q==
X-Gm-Message-State: AO0yUKV6c4/rv5y7b4JauHZzYE3OpmLAP+g1kv0qPSpobJmfOufwMXcG
        HZ4OLYxnZ+2eSM4S6c6wKzO74X+OAY6iOA++p5wU2w==
X-Google-Smtp-Source: AK7set/Q/aym+udxSJIugldGIX6aULPrP69cxHciJd6Aja2+B3PO2NjOVa2H35aSpgMPo6/GConlmtxbwpwEyp0a2LI=
X-Received: by 2002:a25:8e81:0:b0:8f7:f072:720d with SMTP id
 q1-20020a258e81000000b008f7f072720dmr1045699ybl.426.1676280600037; Mon, 13
 Feb 2023 01:30:00 -0800 (PST)
MIME-Version: 1.0
References: <b151531d-c9fc-cafa-4e46-e213a9892247@microchip.com>
 <CACRpkdbK8A9X4nCZEc53-wXU0Vgkc53j_r5rLQiSeoNbmvm8sg@mail.gmail.com> <961a2164-640a-86b5-980f-73668eb161e4@microchip.com>
In-Reply-To: <961a2164-640a-86b5-980f-73668eb161e4@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Feb 2023 10:29:48 +0100
Message-ID: <CACRpkdaKYN9eRtuOhBBp_50sR71AQvNSKtjAR1RZPhaKYhfJVw@mail.gmail.com>
Subject: Re: I2c GPIO Recovery with pinctrl strict mode
To:     Ryan.Wanner@microchip.com
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, alexandre.belloni@bootlin.com,
        Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        Claudiu.Beznea@microchip.com
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

On Fri, Feb 10, 2023 at 4:21 PM <Ryan.Wanner@microchip.com> wrote:

> I am trying to enable .strict in the Atmel pinctrl driver, and that is
> what is causing my issues.

Strictly speaking (ha!) that flag is for when you *cannot* use a pin
in GPIO mode at the same time as another mode.

Example: if you use the pin in I2C mode, then reading the GPIO
input register will *not* reflect the value on the electrical line,
because it has been decoupled physically. Then .strict should
be true.

The strict mode was not intended for policy, i.e. stopping kernel
developers from doing wrong things. They have enough tools to
do wrong things anyway, one more or less doesn't matter.

Yours,
Linus Walleij
