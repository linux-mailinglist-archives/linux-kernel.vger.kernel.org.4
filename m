Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064E872DFE3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbjFMKlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbjFMKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:41:44 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849F8129
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:41:42 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so9263196276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686652901; x=1689244901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qo000+tMfEFV9hbsc5XmyKHzqMjtEWqkHh6QiK4Kq7s=;
        b=qMUmc60ww/4ajFHunUj0BtpTP4X/HfcNS3MKa4p2WgG2GkirJ5wh6AVhkXSgMZN22z
         Tg+cUHVX38Krjy9r4TeuuGEiMhAQMFwvuEb/rFTmPb5YkHJksF1qkUfriT0Dobk/idEl
         wc2TkevY8VmKoolqfq0bQMGg2nt2igg2mPb6rQQ2S6A8w6ZIVK400+ylusIvzoqeyOMN
         2zdFbL1mSc5HYsluM4+o0IqHq6GyJY1FB/FJ9BAttq+pxouPyZ0r1cq06YOMXYbaUzW2
         eCV3XdPDUpjnhod6HsdQssXqwRPe7SAXr8liMzszzJJIuk0pB7NRiOUZWv1Wqeyg6SL+
         7sEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686652901; x=1689244901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qo000+tMfEFV9hbsc5XmyKHzqMjtEWqkHh6QiK4Kq7s=;
        b=gHDx5SrwGF2yNvxFBvMP/n25msQbLxc2zbzPoWRId5/THqQTj+5FIGNsgedOjf4MRa
         mDOFZEzTc1gzx7y7z7HZGoLRpmDT3uSA7RJxeWg7sSm9F/Hhr+2HPZuNoTkRljClkIve
         SK2mx5nEa09ZGeekrIp2IjQucYoyK/rvdVE++bi89F+DWgIk0A4RZzQLNpyTKhbfM9Op
         xmzC8RR9h86jBWkO+yrauSIiwasbEQ+UvPtXP51PG1rxisuB4WLJwxbOiXNtyUkLytHB
         O7NQXXua0V3ysr800M8APAruh1INFhcqy1P+DFIsClvHM5PC95OKk6NOspSn4Vv3c2W6
         wLEw==
X-Gm-Message-State: AC+VfDw1cXaZFm9EVBs/dLnVGIQEu6xYtEBfZ+zPwhPCT15hWtCHa+8j
        Vrcvv1eahU+4I5+Viw4rEOx1qfttxvBqBgoMH7tQ4A==
X-Google-Smtp-Source: ACHHUZ7wXx9rL56M5TKSV8kIC35q0vxCnpiKFzxTQQHuOUbix+dPl8Nt63ZFe8Rva1rLJeB/BK0wLo7CntP9BKwy9aY=
X-Received: by 2002:a25:8d85:0:b0:bac:ada7:140e with SMTP id
 o5-20020a258d85000000b00bacada7140emr1130861ybl.9.1686652901179; Tue, 13 Jun
 2023 03:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230613095624.78789-1-frank.li@vivo.com> <20230613095624.78789-9-frank.li@vivo.com>
In-Reply-To: <20230613095624.78789-9-frank.li@vivo.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 13 Jun 2023 13:41:29 +0300
Message-ID: <CAA8EJppgSg8TJOABkrNzBRYnyu33XuJF4DYmp2d++Pifx0Hpqw@mail.gmail.com>
Subject: Re: [RESEND 9/9] thermal/drivers/qcom: remove redundant msg
To:     Yangtao Li <frank.li@vivo.com>
Cc:     glaroque@baylibre.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, thara.gopinath@gmail.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        edubezval@gmail.com, j-keerthy@ti.com, f.fainelli@gmail.com,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 at 12:59, Yangtao Li <frank.li@vivo.com> wrote:
>
> The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
> print error information.
>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c    | 4 +---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 4 +---
>  drivers/thermal/qcom/tsens.c                | 4 +---
>  3 files changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
