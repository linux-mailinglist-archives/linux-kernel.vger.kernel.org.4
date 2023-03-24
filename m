Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD36C8520
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCXScC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCXSbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E945221293;
        Fri, 24 Mar 2023 11:31:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62C5CB825CD;
        Fri, 24 Mar 2023 18:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4606C433A1;
        Fri, 24 Mar 2023 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682694;
        bh=+7BSN+9BvmOvAAo9V2NpbKi/q8UqqQhIUVAYwcGE2aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qiY0wjIyffj2xeDoCudnICqvCwDQvs+K0dUznZ9uiAV2MYjy/Du8zKNmkHm5jmO2D
         epazi3J1ULnMQSAJiIWWDVk0RDNPWrTkcrDR4F+gIGA1FqKC4GZ/SjhStWXALRIY/g
         MeUKW5pYAmAyYPDmPKylxXrp/KVzKxtsKOCQGvb9T+15r2Q3/lQ84mfVdE7fJbKu5g
         crykpuswce2vCRBN+8+ohruR/QcGrSpFVCsrfl9aoHjLC9j0hZQj5gcbtEXS+1s2/D
         rR6JgWEwNkzQiRyCr08hZAkNaU2+UZxVNueYgFTwURlwhPVi09Jn05nvIo564aYrZ6
         gqXFv8653X9Ww==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@gmail.com>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH v6 0/5] arm64: dts: qcom: add DP Controller to SM8350 & SM8450 DTS
Date:   Fri, 24 Mar 2023 11:34:33 -0700
Message-Id: <167968287204.2233401.6225559348974279493.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
References: <20230206-topic-sm8450-upstream-dp-controller-v6-0-d78313cbc41d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2023 16:06:31 +0100, Neil Armstrong wrote:
> Switch the QMP PHY to the newly documented USB3/DP Combo PHY
> bindings at [1] and add the DP controller nodes.
> 
> The DP output is shared with the USB3 SuperSpeed lanes and is
> usually connected to an USB-C port which Altmode is controlled
> by the PMIC Glink infrastructure in discution at [1] & [2].
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: qcom: sm8350: switch to combo usb3/dp phy
      commit: 2458a305e80ef736ae03e6ca0bcae4c3f6923163
[3/5] arm64: dts: qcom: sm8350: add dp controller
      commit: a2802008af93b70165a80624082c695d89f51eb2
[4/5] arm64: dts: qcom: sm8450: switch to usb3/dp combo phy
      commit: d3054cec1e9ea475e53280724db62b62e25669d7
[5/5] arm64: dts: qcom: sm8450: add dp controller
      commit: bdd2f4ce5e762d5aede6c30ae161e377536dae1c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
