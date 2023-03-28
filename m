Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42136CCC13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 23:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC1VWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 17:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjC1VWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 17:22:45 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03311BD6;
        Tue, 28 Mar 2023 14:22:44 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so16475760pjb.4;
        Tue, 28 Mar 2023 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680038564;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/xIQy0+A8zq3DrF5z48P1QzrBmuhb1Zz7wkOxJIg7hA=;
        b=SiAbb8S/MRqEbNMnvQ8YN/aGHLMQj0nWQQRYLY/rQqj9DGdnb5p+WZ9RDbjzwb/7va
         MjGFOI+IQ7TtwUF+L+r1BTCqRhVHESYMLWe6iPTyYuV6c6ZZRyCmAPZ6URZislp9VbXt
         7oU+wUd7EZq5zzVL/g2XnyqORAgubocOhw2pSX3CTW8uOL1YsLiTjUUBnnou4ZzWpuZW
         07w5mJdCV+tPIw2+/psHNX+2QRJfiV6SbI4I9G0BAAMPgo9BWK+3HHw6EM+ZA/jAdLbl
         vgUAi75mzIYlzM2OWL5eypox16e+o15mztwSXdzurz2pSVzb4HsC4Fq8mrY7Bejj+uTD
         G9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680038564;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xIQy0+A8zq3DrF5z48P1QzrBmuhb1Zz7wkOxJIg7hA=;
        b=effUkTcg8wRNqjvP7PiaH1WfYRSdu5lqMzjBFrdY0c5Q8CL66iPRVr1ZXpBM9mD/3N
         GL048MaBQvbJRZFY7tx6UkpGtMU5fHW7ok52BZD+X5mmfuuVxg98+qEQDSXOUhZ1bXBg
         JL3KXRxV/pYrNzX3eo1P1Ha5jiScmTKE5UcGIlnQFkN1E6p0tanvjARNHlRK9MFPiRL6
         EdZqBc9bLIVmEtUihHI6xknDmfZNKhkNkQUOac/YlBPZsXfJKiv7zw2OwWjhjFTFcL4S
         FtEcwmQmq4JQej1miLWbBlQd4YoA6LizZ529cmJ/5Ms+0AJaYv8zXhrr4OHfzp3YCiir
         8+Kg==
X-Gm-Message-State: AAQBX9d0JU6f1c9AfEJL4rAYv/SSB4NFelB7ptG07M06qZqrQzZ58Xjq
        3UbjD5gUxYl2ez+Pu9ddxtc/kjGeoODGT6eWJ2Y=
X-Google-Smtp-Source: AKy350ap4nJ00eJQxyVs5SFbU7vw1IHgd6XMWhheSRWrHMmPQ6mDFp3+8uRAGoCJJMHex8TOrhqnKwMih2QRvlPg3fQ=
X-Received: by 2002:a17:90a:9481:b0:234:ac9c:5daf with SMTP id
 s1-20020a17090a948100b00234ac9c5dafmr5432085pjo.2.1680038564265; Tue, 28 Mar
 2023 14:22:44 -0700 (PDT)
MIME-Version: 1.0
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Tue, 28 Mar 2023 23:20:06 +0200
Message-ID: <CAEwRq=pkZZD232BbWnSc_5bHkMeLcMW8UK6+RiOz5YcEUVVzEw@mail.gmail.com>
Subject: Re: [PATCHv7 00/11] Introduce RK806 Support
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        lee@kernel.org, lgirdwood@gmail.com, linus.walleij@linaro.org,
        Linux Kernel ML <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tested this series through the collabora repo at:

https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux
commit ID : 1676b0dc5719f8f8bb48620bc71570e29d18801e

on top of which I added the Pine64 QuartzPro64 DTS from:
https://github.com/neggles/linux-quartz64

I took 2 commits from there:
9783cb904f4e30850c017f22e4160d164b571a01 (the rk806-dual)
01f523af0fce727a0e0a37029bbb2d45626d209a (the qp64 DTS)

The SoC ethernet, SD card and  eMMC are working properly,
the serial console is also OK.

You can add my T-B:
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>

Regards

-- 
Vincent Legoll
