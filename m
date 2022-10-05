Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B25F513E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiJEJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJEJAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:00:39 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B58B31235;
        Wed,  5 Oct 2022 02:00:35 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i9so6627237qvu.1;
        Wed, 05 Oct 2022 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bFcEY/E5BYvHxMQ2XfH4xnysOEBmImdGkFLvik4AJzY=;
        b=NfktDo+qa9/7Fig1UFcwkllp7+G2MauCZZFqmWko49enFuBXZ3593ko1wv7CxmGth5
         IxcBl9GuukJuweb/CzTJn8J5oPT4FbpaxtMsFaBZ1DHcxMtA9HnGk5CQpvwuo7i158si
         FaW5qM++a1yxZMAJePJfBEmEF9em50T2irPY2F6VnGXv1F7W40LYnZADH1mw6V/3dBlH
         peGG5IKyuBlDoAg1peFHKMRKowh/JcEHHRGb4hMMEaO8Eyt1/nbyC63tuH74drGPiZu1
         BQS+gVZ3OtFJoiNlnbuGuYkhKiDvML5A+LC88XNbCWRo+iVexBDB+/P9d+RIA9uKndJg
         KtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bFcEY/E5BYvHxMQ2XfH4xnysOEBmImdGkFLvik4AJzY=;
        b=VFy4aLo1DwWspJ+KdoYbD6X33c10um2tW0Dz7XUUQoaym+7mKxc2YTqGkly0wOjVHo
         Cw2xCmZu7cV/532nQ21363YMN6/UKgEFOhqrlNlS3jZ8+O2btz+WXNXxsotN/Qj4WKTb
         heexTnBDqhHSwdUn8j0vIuaeqW3wjOTLQpuP5wzoMeIVZo86ZNjra/9ZubDvb6lPd0dp
         wDq0UlYKL7L77TotYRMcGEmnhfaAkuZgvL8PuempktbBvTuKjENomopwZ3ZVvEFS3B3j
         LHJPoy4T3Lz/9XpPrGDwrgr9v9yFOaB6Wqs+Bf6NHnFBYnH1hD8iqeapTXSuNCXMJ2nU
         WHvg==
X-Gm-Message-State: ACrzQf2Rqm1br8uJ86LL2vRTChkDKyDk3H84/XjITB67tWHCOREL+Vue
        BKX130Jq0QyPo1aPeJUakd0IioH2QBWzPInY40A=
X-Google-Smtp-Source: AMsMyM61Fj/fnFajeEN/tYSRNQs/vmZAUDDJZEH4jGw49cuWKOzFSPdDHaD2R2YLYYw+nq+O3/FkvKSTAx/Jj6tMc4c=
X-Received: by 2002:ad4:5be1:0:b0:496:a686:2bec with SMTP id
 k1-20020ad45be1000000b00496a6862becmr22619975qvc.85.1664960434585; Wed, 05
 Oct 2022 02:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
 <CAL_Jsq+YeZRizJFYuU7RPTcFRe1cDjLgsTidisJ_P5PNC4eKiw@mail.gmail.com>
 <CABtFH5Ld91S65RiDu4iSpFhAMiFWaQdj-yDRM79=WUkArpA0JA@mail.gmail.com> <9004b427-66b7-f783-9258-4f6b893899ef@linaro.org>
In-Reply-To: <9004b427-66b7-f783-9258-4f6b893899ef@linaro.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Wed, 5 Oct 2022 16:59:58 +0800
Message-ID: <CABtFH5LLxjaWHFLRGjVb9x1a_SJoHzD_GsOqn-e9uQAJ6mOocg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the interrupt order of
 the charger in the example
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        matthias.bgg@gmail.com, sre@kernel.org, chiaen_wu@richtek.com,
        cy_huang@richtek.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 5, 2022 at 4:33 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
...
>
> Eh, my patch was merged in July... and yours from September still does
> not use updated multi-led bindings. Was it even tested before sending?
>
> Best regards,
> Krzysztof
>

Hi Krzysztof,

I must apologize for checking our patches are based on v5.19 (I also
forgot to apply your patch before checking patches......), not the
v6.0-rc series at that time.
I will update the latest code and check my patch again and again
before submitting the patch next time.
I'm very sorry for this mistake.......

-- 
Best Regards,
ChiaEn Wu
