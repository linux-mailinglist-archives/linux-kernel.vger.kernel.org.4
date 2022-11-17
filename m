Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3162D6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239872AbiKQJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240026AbiKQJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:26:25 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B482AC6C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:26:09 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id f18so3580657ejz.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0g4EDLEtDgnBBPOyUYQ2dr/MAZ6qJQSPBk0Q+DqlDg=;
        b=U6Xn1tmRgEP+iOoHqH7pL0JfFVvxDSkevb4lZlOofuSTiJFrB2mCMfrdb78IDVIPuL
         T/E3iV802C60USeteFevWYf4IwZuRQa+WHhb81/DIgHRZxxDmrWJte75DZBsDysG6+VF
         8ZdOYQ+VlZtHpdGiR13aEf951nVu7lD0wp0KyPGE/Mqb1BkgBeNXP3MDoGJifa5h0k+A
         NMyQstFHrQ/czvqSlLMWgc84tNbuJjVU0dS+DUi8dKNI0imZfv/CbH7onQ+6/eJ/AJF5
         cM1yX5B1lzMA7xv3Fzmeli0ORFJiK++HVVdX8Y9+ICYS3lFrVfya2LB64TmYitOSoAQv
         pAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0g4EDLEtDgnBBPOyUYQ2dr/MAZ6qJQSPBk0Q+DqlDg=;
        b=e6wnV3rxVYOcimYpJBFffg2YMYIGMTUiAluS5/F+5OcANFInsVCWvQt/bZY8RlDeRQ
         2uPAed9QwsiZZx8hkF03RU37w8qQH21g5sFsyfebcsRfmueXrZ3jA26rNe3zHtJ/s8jZ
         eGmzHd8NBoOXvOwDtfF2BlCdR1lFXqNImdCEyjGb3fEZp/kQby6FBTa/7prvHTuy71Aj
         nAMV55LIiGGHhcwJ7MAP1rBqTAwfje6QWjh2wvwrbOIgc5+ui7z7Nz1rKMeMcoq++oFv
         N6n2TBKTRLKzTuItKixDAx+FmYLsP5W4F/ZParnaL52/gbPCqijzYCKks6OWyZvpFnml
         PYDg==
X-Gm-Message-State: ANoB5pnHil5zQOAZnCrkEH6HNZvTI2P1ee1TWi2Ai6+/Iw4YZQm5HVFM
        vCjpgcqA20UeD3yy/XKoHdO1oVPVSl/6Q2BHIP2a+w==
X-Google-Smtp-Source: AA0mqf7l7ukZ/SXh93B5lgna2wPGzns9s7lKHxDCNS2xUNQiUQGB4mpqRTQmGP4LTe5h2/x7RpzxoTPaAL5VGOvn+GU=
X-Received: by 2002:a17:906:ce35:b0:7ae:215:2dd5 with SMTP id
 sd21-20020a170906ce3500b007ae02152dd5mr1439941ejb.208.1668677167917; Thu, 17
 Nov 2022 01:26:07 -0800 (PST)
MIME-Version: 1.0
References: <20221114024942.8111-1-zhuyinbo@loongson.cn> <b3768259-68e8-fbed-ec9f-c43aa12b86b4@loongson.cn>
In-Reply-To: <b3768259-68e8-fbed-ec9f-c43aa12b86b4@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 17 Nov 2022 10:25:56 +0100
Message-ID: <CACRpkdZvG41ApNkxjeb8cSuoFGT_WfR-X-g9GdnhHp962-j6ag@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
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

On Thu, Nov 17, 2022 at 8:51 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:

> Could you help me to merge my patch. I just use the latest code in your
> pinctrl tree have a test about my v10 patch. It was okay. and my patch
> had adop other reivewer's advice and recently no other person feedback.

Patches applied, I think, you forgot to collect Rob's ACK again but I added it
back.

Yours,
Linus Walleij
