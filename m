Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD1653A94
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 03:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLVCZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 21:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiLVCZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 21:25:42 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA2C310;
        Wed, 21 Dec 2022 18:25:40 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id t191so379921vkb.4;
        Wed, 21 Dec 2022 18:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfZ23cEJwXLKSr6nmgfag7ZLnBMhbp4IOiKmfURc+PE=;
        b=hDYZp3HwDVcSHM5PHuNPwkrEgXERdj/uYSRgKEqZyt/Yu2J1bYP8aOgDGPeVgBG6c6
         fs5xt9vU8j13TMUCVvHrcqTYPidhB2KsZgIV8AYRCchH8O11sQM/8u5RZGucOopdgboN
         629NNobfnlJLzVwOPDbofAZ/w7mz6h1DtD5DhLohFnDYY94LInD9QGrlrZ5SxA7PPjA3
         BtkzATZtCZRaL4tHx0RrC1vhP8ppzTHm5JTwDiYi1WXCHJBqk8+tjoGIsfUScZ2sDFib
         KbRdVp06XfOVtrzp6PtKIYewuSD3LOqeSFR1FU75uGo6zjC42dnHVaM8bdzlmQTwi28i
         28PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfZ23cEJwXLKSr6nmgfag7ZLnBMhbp4IOiKmfURc+PE=;
        b=xG1DRIf1n6PZU2edO2+JuB2xM4PfzLB8nbwAxHQVoH00AcFbkpd2jn3m1WjsWlO7F9
         pYkmcFLYQkcT5lJo0v9ChNPYhpp6BDKJJG+Rws31b30ADPgw5+YnrKN3ES9aJ+8sSALr
         BDk0IASo4ODQLhT+UkIC+4c+g15h9t7S3J503fOHkp0e1U8bIpzRBOtTtF7qxjEv3M1M
         584vmShp7Hm6CqCo/e7vbjNRJ65VclVVHNNVb3yGSyL4kH41FOcAxS5LBouZX9vrTwIJ
         mWwV6mTnQXwuDKUl06uYkc19GDz7q6VyxuEXOedkVi9sMsk/YD/iIyA91TmpzbTyxNYr
         o6EA==
X-Gm-Message-State: AFqh2krIUaenwZwIjE/xz5vpqNvbn1mKupn4uKMII9Ye/T3LMAwhGmQG
        5h/vSV5mYhqftrGGIy0HxNsP91Bp387lxrddQyLvHngYDW4=
X-Google-Smtp-Source: AMrXdXuRFuI8cdaqk75LHVOliXHJsNODxYmahNgKTZ4VEqZEVp6d3ggCrQ60MjROEkrT60IeZnkYPec1crXp7vRwtKA=
X-Received: by 2002:a1f:7344:0:b0:3b8:615e:f0a with SMTP id
 o65-20020a1f7344000000b003b8615e0f0amr432211vkc.34.1671675939369; Wed, 21 Dec
 2022 18:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20221220094055.3011916-1-milkfafa@gmail.com> <20221220094055.3011916-3-milkfafa@gmail.com>
 <44a62c49-1894-aee2-63fd-05b2e70a8aef@linaro.org>
In-Reply-To: <44a62c49-1894-aee2-63fd-05b2e70a8aef@linaro.org>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 22 Dec 2022 10:25:28 +0800
Message-ID: <CADnNmFrqJH5Vwk-R0M4yeoEK==UWMeMkUed+AiUKmh6aKAdcOA@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] media: dt-binding: nuvoton: Add NPCM VCD and ECE engine
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com, devicetree@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, kwliu@nuvoton.com, kflin@nuvoton.com
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

> On 20/12/2022 10:40, Marvin Lin wrote:
> > Add dt-binding document for Video Capture/Differentiation Engine (VCD)
> > and Encoding Compression Engine (ECE) present on Nuvoton NPCM SoCs.
> >
> > Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> > ---
> >  .../bindings/media/nuvoton,npcm-ece.yaml      | 43 +++++++++++
> >  .../bindings/media/nuvoton,npcm-vcd.yaml      | 72 +++++++++++++++++++
> >  2 files changed, 115 insertions(+)
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>

Thank you for your review!

Regards,
Marvin
