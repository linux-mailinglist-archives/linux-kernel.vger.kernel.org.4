Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5328D704091
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245749AbjEOWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245680AbjEOWAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:00:43 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1582244A0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:59:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-55a8e9e2c53so129799227b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 14:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684187971; x=1686779971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GMYm23l9ibyEA8HUJHfl/AvV67A+HY6Cv4WCVFopURo=;
        b=j1X7Qv96dW3f9LQR5chk1cefyZbq//+zHluPryhT2tj+SA/om1LC10EQWZ6hkH6t0+
         57HyfV64mL38B++LU3IVVwl9iZXIGJUeY/DwI/NTMJYUwdgwQYBSSVHxaFK9ryQiQiTt
         J8VpAtBb8lg0pyyHtHOKgGtjQbsms/PdxStFs0eDPYmLPYnHKSP/3TL3QnCbe83tBd6k
         cwdvTAe1zav3udbJjaftZkjXagyGA/9Y2pstMbTt9V+scX85esXJw8knvWHTIviuUJLQ
         DSsfnFV6YOvrCR6n1c1X8bWJOvzao9u06pa4rjXeUKlqytpdqBEalIFaOU+Szrp/baLH
         IzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684187971; x=1686779971;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMYm23l9ibyEA8HUJHfl/AvV67A+HY6Cv4WCVFopURo=;
        b=aYgt2l/fvG2aWBcAf94NXcdRngwy/ONfP4yW0VkNbLai5FlGmVPegN0112spKDaD+U
         gmWayY+VBcDGtU9KuUKEBMWYfaORhIeTWIJaSgpWkUsKw0GEzpx5dNZ+f0sksjjhAcMj
         U5JM8giAAXvDW7BxnQdqrsaRkHqfBnxuM5HIuiR3vaceOkmwWZIAznfFbPr9J8jUBPuz
         VmTnX+RcxZTxrh7KTB73xracUdWJ8Ew7KRGP3qilDvT3tE51DqkRwmNiehqg0qRy2tP5
         tfU7Uj4oUvir22MOv+0eKdxCDejbejUjMUqlD2lVs3RAxwIGUQVXbnh4QatFRl7wnkjJ
         Gogg==
X-Gm-Message-State: AC+VfDwM6yVBV3XpA4wsD3oe1Y1fj4ny0szCMSqQYmg8P3zvw26+HBIL
        /hBu60b9ccAVD3Jr5Nx2pydFYKHPqBhq0LtsSlP9OA==
X-Google-Smtp-Source: ACHHUZ5HTNMDc2UouI5L7kXNW7BWxFq3QX5bY09M90wdI7FXDh/qgp2Pl75Yn6yZLGmtyl8wfXAJg1GopJEz8kKUpb8=
X-Received: by 2002:a81:d54b:0:b0:55a:6dc8:e084 with SMTP id
 l11-20020a81d54b000000b0055a6dc8e084mr31032603ywj.17.1684187970898; Mon, 15
 May 2023 14:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <1684185928-24195-1-git-send-email-quic_khsieh@quicinc.com> <1684185928-24195-8-git-send-email-quic_khsieh@quicinc.com>
In-Reply-To: <1684185928-24195-8-git-send-email-quic_khsieh@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 16 May 2023 00:59:20 +0300
Message-ID: <CAA8EJprgavuxe+FqVg0vqL+ssaBDu6x1vkJybjAE6G6cpHOAkA@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] drm/msm/dpu: add DSC 1.2 hw blocks for relevant chipsets
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@gmail.com,
        agross@kernel.org, andersson@kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
        marijn.suijten@somainline.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 at 00:26, Kuogee Hsieh <quic_khsieh@quicinc.com> wrote:
>
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
>
> Add DSC 1.2 hardware blocks to the catalog with necessary sub-block and
> feature flag information.  Each display compression engine (DCE) contains
> dual hard slice DSC encoders so both share same base address but with
> its own different sub block address.
>
> changes in v4:
> -- delete DPU_DSC_HW_REV_1_1
> -- re arrange sc8280xp_dsc[]
>
> changes in v4:
> -- fix checkpatch warning

Two entries for v4?

>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_0_sm8350.h | 14 ++++++++++++
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |  7 ++++++
>  .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   | 16 ++++++++++++++
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_8_1_sm8450.h | 14 ++++++++++++
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_9_0_sm8550.h | 14 ++++++++++++
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     | 25 +++++++++++++++++++++-
>  6 files changed, 89 insertions(+), 1 deletion(-)
>

-- 
With best wishes
Dmitry
