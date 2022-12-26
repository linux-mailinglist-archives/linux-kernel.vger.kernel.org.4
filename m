Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B94655EF4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 02:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLZBCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 20:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbiLZBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 20:02:14 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A39D50
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 17:02:13 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-381662c78a9so135792477b3.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 17:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6qPC4qxo3yBgn1ai+A7o0gR/AVUuKAKRGb4SXB7gqyk=;
        b=N1gUfiimu1nNZ1XUyXkaMhUu++kW8uB6S9xSElvpLmsECZi0D/nDNhUj1jGEOaB9G/
         r53Av3AJdNTPQfEVxTmzbl35nN93g2UvDuCeqcL1tIftEGy2C8AXhNOavkwQ/0CdqfQ7
         R9b+VHftBEedjXMZ5qMhw0MCKLDUJSUx2GoZQEAshbtW2U89k9bKf/Z18806C33Hug72
         McS0ZfiArT+N9W/CV2QsP/PPZOnkeQbr6unXjcbZnpmt5qS3/NH7ULIVmTh2keX6p3Tg
         SDeLMF2FtMA044ZRTdTV2/56oie5Amm1QwNUjaglZGyS8OeO77u5r2VERjR5s5zI16OP
         f7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qPC4qxo3yBgn1ai+A7o0gR/AVUuKAKRGb4SXB7gqyk=;
        b=VHSLeXY2PnkqODWIzsnjSqKkjX4teoEAPUEjYKfA00mSU08W++xJ86ya529YhdLaR5
         VsbW/gMPScVZ4Q+mapPNoCzlSFF43PWwFEhvyCWYQMLck4gkay2NS2HbSMOyeTUbHRzI
         r5HZTXP0JJY2Ii5Ip0MFSs0mOWok4vyYhokWpY/doFJOgj8/QynlY8N2HhMbgkmYXClf
         UaocXPBIw/nLWFWh42/Oc/e7LsVB5g3atsNwgM6U9GvFOITz/Gb0TtltgHBNrhqoFwmg
         g+njBBfBIwEIhP38jWOnT8MI2hh19L3JZszds5Nx1Q6rkF/D199PP7m3c52OXmkWvNz3
         wUug==
X-Gm-Message-State: AFqh2kpqNlBe35JZOSBX9bzUIm1WndzMMA9ddeG/MtnJt0x7yIRtuszD
        MZ4cjbt+V53ciGQtM4Guk4nnjma7N9i2tsv2nw6h+Q==
X-Google-Smtp-Source: AMrXdXuTPM3wf1Jxgk3375zqX+X14hc27VUZ8ViJWeSwe7vHbQ8k+PmnBI4StZ7XCiyl8oOCjA4N1R4SwrpJYGBra9w=
X-Received: by 2002:a0d:eb8c:0:b0:3d2:61bc:e6a with SMTP id
 u134-20020a0deb8c000000b003d261bc0e6amr2194412ywe.132.1672016532678; Sun, 25
 Dec 2022 17:02:12 -0800 (PST)
MIME-Version: 1.0
References: <20221225040821.8395-1-steev@kali.org> <20221226004727.204986-1-steev@kali.org>
In-Reply-To: <20221226004727.204986-1-steev@kali.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 26 Dec 2022 03:02:01 +0200
Message-ID: <CAA8EJpoCG6yo2+2RYvx4VbS4xmhZBZ6wNdz-a8C=3uOwyo+3Kg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: c630: Fix firmware paths
To:     Steev Klimaszewski <steev@kali.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2022 at 02:47, Steev Klimaszewski <steev@kali.org> wrote:
>
> The firmware paths were pointing to qcom/manufacturer whereas other
> devices have them under qcom/chipset/manufacturer, so fix this up on the
> c630, so we follow the same standard setup.
>
> Signed-off-by: Steev Klimaszewski <steev@kali.org>

Thanks!
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)


-- 
With best wishes
Dmitry
