Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866096B73A6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbjCMKSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCMKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:18:25 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E813D57
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:18:23 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id u5so2721081ybm.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678702703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gZElpO4EuXJE9p3z5b7ZqWafaTVA/ucRgdB/RvFA7g=;
        b=qE/HxIQGLuV03VCMH4TtqQV2IOeZxlrQdT7RcyYNuo7npfTwHPsMFbaxIc8AbBM5q3
         cRF6RzeWIJ2E0I5QBfOZeRouZBBIuKL7deWgV2UQOSwD3az+9ZQQtIKwoJJlzFwElflL
         TB/qxW4y84XgFGWyJFZ+h9jzibRPfkX+ccf0C8vd8b6KfLELpy/208la6IqYjGFgf/Xb
         /cYl8U52pN7FB9GT0Gh0c7r+CCtJ6rSgWo80yrS/2brw6yvwp1CHjcGXBIaCHl4MPgap
         W/hmmVrSbSLCIH78tVlxIsiZZTN7H9cLHgIO3v6D2jal2EmYSUIGCH1RNYW/nQ858ybX
         ci1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678702703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gZElpO4EuXJE9p3z5b7ZqWafaTVA/ucRgdB/RvFA7g=;
        b=2OZZkFtt/H2PYJfSBxMwIvSciK0TG/XEAkK0qfMmPUFX3jdSOlv7lGDCkqCYBw2aAS
         87fTW2XoXR/ruSV0g5kFOUzysbIqEYuZpyhTL7Cfu1qEQG+W+xXHQ6ZHIlVHU+sUX1JW
         AHhw1KH64hWFe0p9oRA9EATzmOVuCj8odketcj5Iq9g4+cs0+toCLkWETTWl44xiNwpA
         iRIjom6/raGOD3oUkXXDObhc6+XvMeTT1E58z+PNzHmbUFeAnB8NRi2G+CevbXC9glDz
         8y+Ma7jWF4ziucc+BmZ6O54oH1naCKO3ZLaiT+ePJNz96q3wgy5yR0wTFt0VL/5VueA5
         w5AA==
X-Gm-Message-State: AO0yUKW5ruLphaSIKOvvUBFSjUTVGZac7h0FGGZ9zJC2paZh0qxjQ8yw
        ACTpP4sxOo1aK3cghE2u1M63/HbUoxoMfw4RoYA/s1Jw13Fx5RyP
X-Google-Smtp-Source: AK7set8Fpcchib38Rxpc3TcFSS2UYZRMNKBDx8pfM337EtRW1wD0UNbhukRY+0V5Yr/Mibfghy1u6bbqRIOIeEj9FdQ=
X-Received: by 2002:a5b:384:0:b0:a65:8cd3:fc4 with SMTP id k4-20020a5b0384000000b00a658cd30fc4mr20642371ybp.5.1678702703068;
 Mon, 13 Mar 2023 03:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230312132702.352832-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312132702.352832-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Mar 2023 11:18:11 +0100
Message-ID: <CACRpkdYZPbszZfvJVr9B+iSjU1BgbvuH=jpAnm1XeoZeuNm5CQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sx150x: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 2:27 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The driver will match mostly by DT table (even thought there is regular
> ID table) so there is little benefit in of_match_ptr (this also allows
> ACPI matching via PRP0001, even though it might not be relevant here).
> This also fixes !CONFIG_OF error:
>
>   drivers/pinctrl/pinctrl-sx150x.c:833:34: error: =E2=80=98sx150x_of_matc=
h=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
