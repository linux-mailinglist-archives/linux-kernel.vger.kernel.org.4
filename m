Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071AE6A46C9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjB0QMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjB0QMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:12:34 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C96722A2A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:12:31 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536c02c9dfbso188992507b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uog+NC3JDX/3s4EEtusxfV7GL8cg3o3rXi47XL2zYCU=;
        b=Gls/FT24wIDqw26A+35LedSLf7NuYWn6yBxWOp62zMIfBwD96VL75IXnSlFsREuqYo
         qqO0Lz/Wzz5Hj6iHZcmRZOSeEfOfdcWrppQh7PAi7c6zYUyRInHljeLQOthAvCG3bNYE
         CUtpnLIP+bYo/symJuOQHu3QRd1pYhA8sM050=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uog+NC3JDX/3s4EEtusxfV7GL8cg3o3rXi47XL2zYCU=;
        b=Fp758230KYCvaQl5Y3YSmIXVCXoHfhdCxsi555RWjrT1XGypRpMMNG+Nl4yDzLIT7j
         w5FV2GIWmjpYwocOpAodZRAIhiUQglUlCTsMuiO+XsWICqyWE5x9cUFjTlQX/u9p0rMB
         8Nm+wUh1s4J4DqaE2DupuqfhuUJwkTrYoR59mocy24Ps39i1cEc291a8bDqsRvqu9nSV
         6DOFEex+2WBtW/3pnbhC+fZJv4SXPJE8oaLlGLSprBwMDZctGOJ5vkrUW277oEUaZSUY
         yg5OaqTgp6efBaR/dNkTG4Kk+/EGV1fAiJ7+fUBYQ0pF95XDJSPKLeXFH5Bburn/ACBC
         pVcg==
X-Gm-Message-State: AO0yUKX4DZ1vq5cLwa4LuRgyW7q7tvrrad5O8sOpZ/RsUpFjYPY/ojS/
        BOIubUXSeYXtwnoGeX9hHp2Mx3Y548Ix85YdEmPNOg==
X-Google-Smtp-Source: AK7set/+umnF+0qsxKl5X8OIztsVGHe3kI/eFvpRVMUjBST0vTyvdYJ88amXAAJTSSmIvMwvDX6p6Y8TT11gxODv5xc=
X-Received: by 2002:a05:690c:31c:b0:52f:184a:da09 with SMTP id
 bg28-20020a05690c031c00b0052f184ada09mr26898ywb.2.1677514350621; Mon, 27 Feb
 2023 08:12:30 -0800 (PST)
MIME-Version: 1.0
References: <20230216-topic-drm-panel-upstream-maintainance-v1-1-ae1cf9268217@linaro.org>
In-Reply-To: <20230216-topic-drm-panel-upstream-maintainance-v1-1-ae1cf9268217@linaro.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 27 Feb 2023 21:42:19 +0530
Message-ID: <CAMty3ZDCOHsei6yHxunk=zhEy7LAu20TwwFNiYmwWTM8NXLgbQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as co-maintainer for DRM Panels drivers
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 3:28 PM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
>
> Add myself as co-maintainer for DRM Panel Drivers in order to help
> reviewing and getting new panels drivers merged.
>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Thanks for doing this, I'm acking since I have potential involvement in Panels.

Acked-by: Jagan Teki <jagan@amarulasolutions.com>
