Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE95620D31
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiKHKZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiKHKY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:24:58 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C6C21829
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:24:56 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a13so21791678edj.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3U9H2oDYo0jHZ5n7VD9WQgIXQHftQXj5Rvrab9Xb/3M=;
        b=FoICTrB0HokDj9Jr/RWi2HeiYU3xlqoZr/QJxMZBhg5PgaXUia0hn4SzasJunwTCQi
         a59ynF8QExOW/dv2VvDEGzEJ+4nEy2fmWW/CIKkF++Rvlh7B0mkvjIvBQ5UQ/+ZBVwLq
         0en6zt2YjQxJqsexkTC9HaxD5t5dEhp9BBx4GBInvt0LzgIBuIMZUp0NhP4czatc80P5
         ZnRfaPTyQkiWEBBkoVxs8b8umWvE1hkQpZzlqNQQzBa8n9YllreQs1gCq1gaEyXol0SY
         4gI2NFkG/zwVc7S4pTrIk/eoPajcxNRH3YCJnxzdgBggAUUMmopZOn4+5qm3/I4g2i6p
         0lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3U9H2oDYo0jHZ5n7VD9WQgIXQHftQXj5Rvrab9Xb/3M=;
        b=IJtSLD3RYcLx9jLlvGPIRzoXe0K+W4aYCvKH6dgDC1E97k7rFEhf6sbMXAjAIJd19F
         uGq6ee9TpMr5/j25+N6iIaNk6nr0zfKNlo14/oUZmJdjZ5rawUS1HPaE+2A4ddDP8MhX
         5nRK7Va5XgQNDBcSUYyk93chpQ/Adp1tuRfy3PQfO8QsCKmfT/PO3bWYhcOJkb/FXEtD
         2ONkiI/hD9rLW1jJD0M0Gmew3iGNxcdYDB2sbcMm8Ya8P5n+UXLgDHAkiFn8+guWKb4G
         Dtn62Di21ZoaCvONb1xS+1acIHmvJHKoOQdU3dIz2PgXevKugjpUzR/dydwaLJIO+w9T
         1CPw==
X-Gm-Message-State: ACrzQf16/Akk4vCJXaXxN+CYaU9JiOIyv4sOsyRj06rsOpVcMd+TBj9T
        V3Zf/bhWPuzdQGjlrZAcpJ30dw6RCWNGRS9pFP4iWw==
X-Google-Smtp-Source: AMsMyM4+kmlt812NqsehPqTcJthwr/1SzuUus2LC5jb9udkKVf+AcR8z9rgNjpkcnZ+q75/1Cp00Q60NPGoskvtIQ5Q=
X-Received: by 2002:aa7:d6d1:0:b0:463:ba50:e574 with SMTP id
 x17-20020aa7d6d1000000b00463ba50e574mr37142535edr.158.1667903094898; Tue, 08
 Nov 2022 02:24:54 -0800 (PST)
MIME-Version: 1.0
References: <20221027130859.1444412-1-shenwei.wang@nxp.com> <20221027130859.1444412-3-shenwei.wang@nxp.com>
In-Reply-To: <20221027130859.1444412-3-shenwei.wang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:24:43 +0100
Message-ID: <CACRpkdY5Eu6gb+nsw6Teg21C7PVUUKB8vpvPE_0y_qmqyK6_CQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: imx8qm-ss-lsio: add gpio-ranges property
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 3:09 PM Shenwei Wang <shenwei.wang@nxp.com> wrote:

> add gpio-ranges property for imx8qm soc.
>
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Please put this into the i.MX SoC tree.

(If that doesn't work tell me and I can queue it in the pinctrl tree)

Yours,
Linus Walleij
