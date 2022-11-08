Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F90620FD9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbiKHMHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiKHMHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:07:52 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8E012A98
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:07:49 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id ud5so38059466ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0xYqr+Uz1wM4DuiLSGjwWjZGbL0AQqraqB70BN0+x48=;
        b=sZKkvBgctqD8M35VR3XU58po8c6M03W9+PWnejx2k7Ew7l2HLUIaWcyhtmzO/TnBK8
         1Eg+QxZrjCioYko8y6gTorCj07ht8zRw4G5lJ7pGbNRlv8zpiC+nToYPeaSOKver0+Y3
         p+vnG/k+zmG+RSU1WbnDm88jzbBcwXt6Htfeth+Xm3x5vDIWWq/0jAEs7E0+3JxVfdNB
         xcT9yN/D+HViBWTN6xQ68oa+h4EFk5RhnXD9uCxD50uC3akT7Qz2n8zGhvysGeshYNQZ
         XAxv79DwsFeiVlxjbYhvcCJwPbOiIFGc727NSjoriRm2GHAn0X7D1b9c03HzD3ZcAzNr
         U7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xYqr+Uz1wM4DuiLSGjwWjZGbL0AQqraqB70BN0+x48=;
        b=plVPj0Jf8C6wedTl+A9BF+ESeAOkXwSlvWMkQZFQ9RQf7Ca+K3Fi2anhkKSoE/i8g5
         1YmKRyG3kj0t396+9Vr59Kt7fWY5Hi/SGEisOmeL54pWDylQzWa1WKPE2y5SNbQDxkmV
         p12FdbQ4PMlxl0yi+jCdKdT1kWtiEXhOAbCTIH5pk/trQgRYn6Ahg/Mflp28QtRCud7E
         xT2IAT2kzBmHgd7MSJcl68//YleQygi+cMa+02Rb9P32tds33LVry0dRqw92iyZAuZuk
         /KzgPVQqk5pyVpLWYulIJ0S3JE0urbwUqorAg6s8prjlwjZBmB3qf809SAcI64CDt0B3
         psGA==
X-Gm-Message-State: ANoB5pnvDvjNFWv4QwnhLvnyT5Pa5sIBTtqZQl7fYMRiBDf19zgqvVg/
        4FczLpNZWBAVPBmbdYlfZLokapU6aYW0aN7/tNwmwqVBOp8=
X-Google-Smtp-Source: AA0mqf6RSnKeTfCNRJIBg0kmOP/JSg7vEVx+gUCbPvDOgdWTiuPrAMVe0Tg8Ee5TtvF2GMQNNi/AuJO5zOPeAYPLvbI=
X-Received: by 2002:a17:906:6acc:b0:7ae:658c:ee45 with SMTP id
 q12-20020a1709066acc00b007ae658cee45mr10844145ejs.190.1667909268497; Tue, 08
 Nov 2022 04:07:48 -0800 (PST)
MIME-Version: 1.0
References: <20221103080217.2533-1-zhuyinbo@loongson.cn>
In-Reply-To: <20221103080217.2533-1-zhuyinbo@loongson.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:07:37 +0100
Message-ID: <CACRpkdYpEtaKmq8mDhKDTGZyrLDhHbZXvhrDGztmKt-mnkkc_A@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] pinctrl: pinctrl-loongson2: add pinctrl driver support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 3, 2022 at 9:02 AM Yinbo Zhu <zhuyinbo@loongson.cn> wrote:

> The Loongson-2 SoC has a few pins that can be used as GPIOs or take
> multiple other functions. Add a driver for the pinmuxing.
>
> There is currently no support for GPIO pin pull-up and pull-down.
>
> Signed-off-by: zhanghongchen <zhanghongchen@loongson.cn>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v7:
>                 1. Add all history change log information.

Patch applied!

Yours,
Linus Walleij
