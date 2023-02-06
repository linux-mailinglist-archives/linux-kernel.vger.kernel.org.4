Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C6268BEAF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjBFNtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjBFNt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:49:26 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569AD279A0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:48:52 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-4c24993965eso155593997b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZEsDz8JqzcQxEyNloRUuUyODpBrbuLkFE7LQ8IcNZCU=;
        b=xH87vXgsJaOnGsIGgW9wI+ScZ/GPFObVj+xGFamLZ5jV1vXYWO8tC70Ok2ER3C1KQw
         CUSmdFq+83JrTb47Bz82VjfD1xW3JrzQ+e798Lth3apiZoJy3m6ASKLCEDu0Eg6/D6m/
         yM/1P/hMcCBcZT+5HGd/etmh5fzruFzTO7CwwLHvqctdHDgFVecStviI9NLpCfar1GTz
         6dNUSnBJlYtV80KSre8ecSnkaV5Y4YWOTn8wOLTYeMQDUqOiwaE7lkcBfAjjlxfCpOjv
         k4+AJOjQPblFRsb03Yl4wcFdB6GfPm31x7LiWDOY8EVbXBL6HIzgOuA7QYKzRGM5fEif
         2Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEsDz8JqzcQxEyNloRUuUyODpBrbuLkFE7LQ8IcNZCU=;
        b=B1ipjgzeZ+DdPZY/oFiJlJFOa5NE9jiay8bcWFzJt2JGui1CTUgahx5SolBzlBHtQO
         Gdl73IveZ+bF6NrIL1mWWXjCNK4RYxRunjETF05KsngZhBv5Vb76kRq/L4Isy0EftXk+
         UmGoostJVsMlmo4RMUx3VVdW49gcYCt+1iS3aIRtaG0kChDvjPMd1dKAKWDGbnVr/bVI
         ynWhXTtBdP5cJTvCyUMtWX7fS1ALe0Jzbsvl6WqH7q292UFMgXTIpq7Sc6dPWWucj60B
         2HxmysO7gH3kyNcuhpWKfuSkcMy0adCUoh08IKIYtgvgdF8Tgn/K+tSVp5STkrGrXDVo
         4OKA==
X-Gm-Message-State: AO0yUKWyIE5VIMHb7kJiHG5GJLvpdNizG26mLwdiqSalylgv+SPQzgBo
        8hA7/banQv0fHhYPInvexFxyPMDNviS+o/uzFBJgz+Ln8AtYyg==
X-Google-Smtp-Source: AK7set844VkS58x6cC0fcxFQwqxyaYdgkpQak+2ac2FW7BseyHk4HLrq21ZpqMEdGgBUr0XOndfQEfyvp/6DduaZnYs=
X-Received: by 2002:a0d:e846:0:b0:52a:8896:6dc7 with SMTP id
 r67-20020a0de846000000b0052a88966dc7mr99301ywe.130.1675691330634; Mon, 06 Feb
 2023 05:48:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1674693008.git.daniel@makrotopia.org>
In-Reply-To: <cover.1674693008.git.daniel@makrotopia.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Feb 2023 14:48:39 +0100
Message-ID: <CACRpkdbSyXqe7H43qd-Cx9qGbyW3uHZF_DpXVMKmnZGS7Bx4pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] add pinctrl driver for MT7981 SoC
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
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

On Thu, Jan 26, 2023 at 1:34 AM Daniel Golle <daniel@makrotopia.org> wrote:

> The MediaTek MT7981 SoC is the smaller sibbling of the MT7986 SoC.
> While MT7986 is already fully supported in vanilla Linux, only few things
> are missing to support also MT7981.
>
> Add pinctrl driver including devicetree bindings for MediaTek MT7981
> which together with the added clock drivers[1] completes support for the
> most basic features of this SoC.

Bindings reviewed, the driver is vert straight-forward and slim, and
no further comments, so patches applied for v6.3.

Yours,
Linus Walleij
