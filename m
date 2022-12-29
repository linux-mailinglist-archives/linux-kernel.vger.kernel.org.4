Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A81A658F9E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbiL2RYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiL2RXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6118140DD;
        Thu, 29 Dec 2022 09:23:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64DE46186A;
        Thu, 29 Dec 2022 17:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91937C433D2;
        Thu, 29 Dec 2022 17:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334626;
        bh=vXZz42vBy4NTuSOw0w/VQKB5txhxb7nLQ6ic+zOL0yY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JW426D2JCegmHx6OxCzMuBSTmFSJqUnegLuKz58qKcpy3u/1hRMfPYi/NB0Mqpt14
         XijrzQ2H5uJY8zlV3W1P9lmgFPOUz1spnNLZfEi/EEDK8JRqHj8tBn/lgXg+SIl6cx
         XHOnKXq35I54pFxAc7OXQaW30AB9oQf1FIUI7q1A17I6/88/djTSU9lmIInFvY6dFV
         HbQ3Rd3dEfAs9I8TZ6G5mFiwSD7nl5DSg6KE2xcMSJK8HCGPMx0cFtLVHi+jYInvtl
         GAhKC/DHjAaK7FuInrRC6V50qPCpg9bkcxqGOhWm3wy5ZnKq2gbybICCOpAmDecMZe
         4thujMZbsiwXA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, krzysztof.kozlowski@linaro.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     quic_abhinavk@quicinc.com, airlied@gmail.com,
        dmitry.baryshkov@linaro.org, robdclark@gmail.com,
        robh+dt@kernel.org, daniel@ffwll.ch, sean@poorly.run,
        marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: display/msm: Add SM8150 MDSS & DPU
Date:   Thu, 29 Dec 2022 11:23:25 -0600
Message-Id: <167233461761.1099840.9860716141082316097.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221229100511.979972-1-konrad.dybcio@linaro.org>
References: <20221229100511.979972-1-konrad.dybcio@linaro.org>
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

On Thu, 29 Dec 2022 11:05:08 +0100, Konrad Dybcio wrote:
> Add bindings for the display hardware on SM8150.
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sm8150: Add DISPCC node
      commit: 2ef3bb17c45c5b83204a845bbe4045eed11bc759
[3/3] arm64: dts: qcom: sm8150: Wire up MDSS
      commit: 98874a46686b78d2f303de1a898b7b7cc611e30c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
