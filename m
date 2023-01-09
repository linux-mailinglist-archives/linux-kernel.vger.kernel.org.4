Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E465F662775
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 14:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbjAINmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 08:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237199AbjAINlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 08:41:23 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842B813F9A
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 05:41:07 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-476e643d1d5so113153907b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 05:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wb+6yb9R61KlmNa9GN1pcRJN6n/iQC03fh18uG53PKA=;
        b=swT77g+So+NgP7caEaJ6O9ceSvAdYk+grZZiOdQV8nih+XkgHPW7A1TWMvnMwHbSNC
         XqAtNGmfyio1WtOyZIRvGcgGb2eBRASgE9G+7Pw2dyezmZQmG4dfWaSr6fUhcs0/KT5v
         +JV7tPij9h4iR3nAu8cOH/6K3NPmKzzsiLM4Z7CcEOYIhm0wRBeKCHnRA44v2/GbdF4b
         7bSlU7Az9OQa5+N6lSzPP7L8iN7RhBvi08OPLMxBU6QZyQJ6/l7gUx2Snjw2EG9jAv4M
         sgFVwN2VeGNFDSGNLoNjdxOFJt07YngBnF4zOEI0++UbrxFkpN/QsO6MEzGwRuxoKLlB
         emuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wb+6yb9R61KlmNa9GN1pcRJN6n/iQC03fh18uG53PKA=;
        b=RKQJ4hgfZM8YJJ6vEGNwe/GGZOGhn/By8UmZjQBQrfb9+yW8WHHyOn8RgWK87qjDyE
         SHyDytoloZaLeHMIDTGlaJx/OuPziiY/uhcisJ3TUTH2mv4TSZSzP7eeD/c9hXdNaz3t
         Ll6VTBjVeSSCFHqS9DtQjj17X5WJtnJalwrkoYBqScsiITvG1DUos9C+oIEKwGsdw8PL
         jgb99Au6Zn9nfdfhmwx0G9lZGLlsNjuLTajzLxylmCn2nOR07e2O7rihTsPHaVJRextP
         3id7d6gHdJvM/gkvyr4KUfXmy3UPVg2GFJgya+3Gs3z/kWb4BQqxtQ4Av2QRNWKm8dHv
         7IAw==
X-Gm-Message-State: AFqh2kpk1a0as8mGZcCVhhU1ZMlo3RIdz+6OuJUmZ4ZoQbctMZq7fleI
        MkHJYhGaQLPvduEfUL89Qdakm17MHRgP+FU7RnNX4A==
X-Google-Smtp-Source: AMrXdXuJafcJBxWgNG3iDYwIGn5e2BoBODHe1CP6aoQRnVBj1JCScwi0X3vdopUmL/zUqBF2EfnzZsWU+EzxIPXPaS8=
X-Received: by 2002:a81:484c:0:b0:36a:de9d:825e with SMTP id
 v73-20020a81484c000000b0036ade9d825emr1495965ywa.477.1673271666804; Mon, 09
 Jan 2023 05:41:06 -0800 (PST)
MIME-Version: 1.0
References: <20221231164250.74550-1-a39.skl@gmail.com>
In-Reply-To: <20221231164250.74550-1-a39.skl@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 9 Jan 2023 14:40:55 +0100
Message-ID: <CACRpkdZoU8AXbQ7QDfuf6yUTZFPDE-L6ZLRB8jE-KP4YqbHpXw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: pinctrl-msm8976: Correct function names
 for wcss pins
To:     Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 5:43 PM Adam Skladowski <a39.skl@gmail.com> wrote:

> Adjust names of function for wcss pins, also fix third gpio in bt group.
>
> Fixes: bcd11493f0ab ("pinctrl: qcom: Add a pinctrl driver for MSM8976 and 8956")
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

Patch applied!

Yours,
Linus Walleij
