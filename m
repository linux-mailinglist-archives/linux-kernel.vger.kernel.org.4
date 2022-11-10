Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00483624432
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiKJOZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKJOZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:25:08 -0500
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6A29377
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:25:06 -0800 (PST)
Received: by mail-vk1-xa2c.google.com with SMTP id r13so525692vkf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 06:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8l2HBFTrpDnnIgcOQ592snBPjsf4RD70cv9dA6b7lHw=;
        b=b6FeEIbwGLERqlXrAhntHxjPwc4hpS+h4tc/n+ldDt8a4OwxLKBSOQdS4a+nvyqis8
         Piq+gweJsdW1kiNQavJCsd9E0fcCZrzv4UYPvgif4U8fABvEdDuFt6+T00sotrknfG49
         BfHBmlkmZ2/xSPbL6kgfMZdUocYWWaKhMYa/sTbBlUczazGO7ekEBIjUuHM/J/nDInfL
         LoWPN62ews5MRP+A4E07LfUul0RyEMwMtZhAq6PJzjJ8CPl8DEVLc15vupbIFex9AfNB
         rNhKKv+V4o0vBPpJbH08NK0Q3xQtmb+dtxyls7if4h+heBZeZtl2uPpKk4dY6xuhrn+1
         v3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8l2HBFTrpDnnIgcOQ592snBPjsf4RD70cv9dA6b7lHw=;
        b=R5z4KrMvSy3a55J2sJx/SC3mCnFtLCUYR84TP98gKJWcFpQTBRcjqW9FU1Iru524Mv
         lIzFT9ijJl/cu4KF2yc/5s0XNQ+uofARaCQHp8sfvvhpLma0XGTb5HdWCzgPMblE/Vuk
         VDpH72f2pRbaEBzP8qUriKLfd8ACa0ksBSTh1B7odKk6iZFcr2Xy1mWrIB5MZ/Rj524J
         GO1un33rqCN9ZQvyE2k5r2sxTTuzEB/NyKFqHCEBHaeAXdk4WC/MGtpNdjjksHE/bhby
         Vm5kistMSww5v/VoJ1KTJ+JA7baHBsyRxROtT351Tb5PgBVuu+ry1RHWAAh3t2ldMy3B
         VLVA==
X-Gm-Message-State: ACrzQf0G7Y9hhkQrC4sPNdP3OoLrx7NfbLI3sxOorxRc079OAAoZPc4s
        tPqWK66pWdFcIFTPtjEX+tTSSyRc7LkVDKyxlF9Dyw==
X-Google-Smtp-Source: AMsMyM5pIjsuekXRjCdKjRIEeTWrwBNiYMNUoJ4ZKJ8V9nzQigybl4K/UMPda0VjOe4syPWlj288QfpUh5P9kMN4tHA=
X-Received: by 2002:a05:6122:2219:b0:3b8:7fbd:9554 with SMTP id
 bb25-20020a056122221900b003b87fbd9554mr12826647vkb.27.1668090305647; Thu, 10
 Nov 2022 06:25:05 -0800 (PST)
MIME-Version: 1.0
References: <20221107172921.514125-1-nfrayer@baylibre.com>
In-Reply-To: <20221107172921.514125-1-nfrayer@baylibre.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 10 Nov 2022 15:24:54 +0100
Message-ID: <CAMRc=Mfy-aQ==3Aug4kjdHb2Aa6X3d3MBdh62wBjE0FtCnZXkQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: davinci: add support of module build
To:     Nicolas Frayer <nfrayer@baylibre.com>
Cc:     j-keerthy@ti.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, glaroque@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 7, 2022 at 6:29 PM Nicolas Frayer <nfrayer@baylibre.com> wrote:
>
> From: Guillaume La Roque <glaroque@baylibre.com>
>
> Added module build support for the davinci gpio driver
>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
> ---

Applied, thanks!

Bart
