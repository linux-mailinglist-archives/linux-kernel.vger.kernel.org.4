Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C82E66D0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 22:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjAPVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 16:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjAPVGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 16:06:13 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED98C16317
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:06:08 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4d4303c9de6so245744167b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pTx0hKUehj5zlFMm8je22yYIdgmSFNrS9JKax6jHuBQ=;
        b=TslgB/uw5OZ7lyuSRs9ylD8Njzd6I2vt5fglIxu6Ub/uB0qGZeWMKHdRzW/HJG6lsZ
         9xudq/U89FOtQcaxBE/5/x5dQaTouirIBcV5OR4EjPzhRe+LZkgQDP9qIvSCuY0mQ9HX
         RyFMxumcmyTYFx0j5aP7D95hgezZubz0GDldGis8O0QWZJzKNthh0JJlEnAG3NUqd/RJ
         0BUN5TGqNn/6F/HSljpP0mWorX7FWgCtmTpyHqyfP6uDQyI7UZx637kHM9843bEVMKvx
         FTRs+6ehFNkgBYFYTwASZqnnB3kDCn2kjhhsVBatyQo/1i3GtGqbQIKE0Z4CMCMR9yWV
         kh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pTx0hKUehj5zlFMm8je22yYIdgmSFNrS9JKax6jHuBQ=;
        b=vKk35EkVV0fUilSCkJ4pI3xy2h1tVl/MWjRgBikrqtivmmXi+pwuYEnL7DK+zDlkuz
         tat9pix4xGcMs4UMrSOU0RPVdjeK8MAKepwvuMB5E8EmvfwpeuzfIwmyG21VAMEfm1rF
         r+/QBfInH276RCyzWY8GKkQGH4nkfmSmkHq9XfLPw7gSTeVff2///6q7/WIXULhsKKd8
         JiG4B1vAJux+xoWjoOHqPu5VpikuJLQYqt9rlr45ngDL5E461hJ1fB5QJHlylukHce/e
         MhwoW89LnjB4vbLlhQAePt90fmdr3+Qvk/aKqlYWtIXUnhdGMs3shzy5nFmcgCYxoP+k
         bV1w==
X-Gm-Message-State: AFqh2koLDgATqf6LFy1LucJM1UHbne4FF4hOlb8n8xw96IE9UFLPoVtm
        YYvzjz7aODXjRE7jnkiCU2oR9jtj2zUS9uVTAbAtIw==
X-Google-Smtp-Source: AMrXdXv9CEbf8RGoRc6TXpluqPTTq48HnVzFbmyL8U8sOQv2gZMYUAx7xB2dnKo3zWCRMrxZ3DXsJ6juWXp614GVzd8=
X-Received: by 2002:a0d:d60e:0:b0:432:2458:f6ca with SMTP id
 y14-20020a0dd60e000000b004322458f6camr103782ywd.138.1673903168207; Mon, 16
 Jan 2023 13:06:08 -0800 (PST)
MIME-Version: 1.0
References: <20230116204751.23045-1-ansuelsmth@gmail.com> <20230116204751.23045-8-ansuelsmth@gmail.com>
In-Reply-To: <20230116204751.23045-8-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 16 Jan 2023 23:05:57 +0200
Message-ID: <CAA8EJpreAtkY3RvUbU9JS4E3Ye=trc8MvyTLXp6PxPt71X0Jjw@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] ARM: dts: qcom: rename kpss-acc-v2 nodes to
 power-manager nodes
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 at 22:48, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Change kpss-acc-v2 nodes naming to power-manager to reflect Documentation
> schema.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 8 ++++----
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 8 ++++----
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 8 ++++----
>  3 files changed, 12 insertions(+), 12 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
