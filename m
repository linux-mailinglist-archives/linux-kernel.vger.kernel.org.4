Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAA66E6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjAQTQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:16:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbjAQTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CC35C0EA;
        Tue, 17 Jan 2023 10:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0CB39B819A8;
        Tue, 17 Jan 2023 18:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C8FC433F1;
        Tue, 17 Jan 2023 18:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979884;
        bh=AHzeX7dhYVX8yBaB/Cs4tTTqnXDv+F8AxK25ujOVHVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fum/BmfBmvu9u0Cmsn5P8M9R37HAr+Cxh3lNmmrJmFU57NmWoM5IMw/LguM844xjj
         AOUyzoUzqwFDwZsPBfFgix4jShTR0C7BSV8R7w+DBUoiC/84j7hiqeX9hujUBmPjJB
         c2sG9nkm6Oe/R4Jfdnhy5kqTarCQGe8xe2ez+MtrJubwCPAFAo4DtOu5XxstgYWTLG
         UY8/cLGXHAGznk77CwBLE+1XNa5xKrHUz0dxRXxHLsPYo822q+skb24JFALkguyNxt
         XK+u5CrFwq3CvdX8Ft7zs7I9wQnEM0/Tdcqo4sb7+BehwkbGWDqyerbtnxXZS2ONyY
         5wR4c7Qr7ej2g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org,
        daniel@ffwll.ch, robh+dt@kernel.org, airlied@gmail.com,
        konrad.dybcio@somainline.org, agross@kernel.org,
        quic_khsieh@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, swboyd@chromium.org, sean@poorly.run,
        dianders@chromium.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        quic_sbillaka@quicinc.com, quic_abhinavk@quicinc.com,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v16 0/5] Add data-lanes and link-frequencies to dp_out endpoint
Date:   Tue, 17 Jan 2023 12:24:29 -0600
Message-Id: <167397986258.2832389.13013328519954175656.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1672163103-31254-1-git-send-email-quic_khsieh@quicinc.com>
References: <1672163103-31254-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2022 09:44:58 -0800, Kuogee Hsieh wrote:
> Add DP both data-lanes and link-frequencies property to dp_out endpoint and support
> functions to DP driver.
> 
> Kuogee Hsieh (5):
>   arm64: dts: qcom: add data-lanes and link-freuencies into dp_out
>     endpoint
>   dt-bindings: msm/dp: add data-lanes and link-frequencies property
>   drm/msm/dp: parse data-lanes as property of dp_out endpoint
>   Add capability to parser and retrieve max DP link supported rate from
>        link-frequencies property of dp_out endpoint.
>   drm/msm/dp: add support of max dp link rate
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: add data-lanes and link-freuencies into dp_out endpoint
      commit: 26c5aa54f5973a3b1181939811f231faa638332a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
