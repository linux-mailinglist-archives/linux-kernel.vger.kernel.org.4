Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABD76BC148
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjCOXdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjCOXdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FC1A17F7;
        Wed, 15 Mar 2023 16:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE1E4B81FA2;
        Wed, 15 Mar 2023 23:32:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB6EC433D2;
        Wed, 15 Mar 2023 23:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923149;
        bh=7AqCs+fbXu9Eie4yOV0p4m7yDokgbYH429t18YH3V5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CABmZQ1KQusGovhzHzdNwLotHul3CbReqzozRpaQZOInZ0Fb4zilIj/poQcP31NC2
         nEMP4opEnKpsPy/EgRTOrH/1/jZA9Qx6PaqjOJ6wMV0a3LdkI4TXmTxwr786IL0jbq
         ZU2gBARsdbPKNmLbROOw7rGQad1oRtb8u6jRr91mnaZAq3ZQZz9KisWaRxASi2g6uO
         KWD+p8sMeyjksgeH8t9EhL1YQlOWi+xUDDaYOABAg4lXva7jokLgvwGhKbBd5XhxDV
         CVqD5RvqnWcDX9DoYeYRueeifLL+Bb7gmrqHkNykCGPxIUuZ7GNpcOQRENKRUt/tS/
         NxGNVvZjqYl/g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] QCM2290 socinfo
Date:   Wed, 15 Mar 2023 16:34:59 -0700
Message-Id: <167892332567.4030021.6544920130268786045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230314-topic-scuba_socinfo-v2-0-44fa1256aa6d@linaro.org>
References: <20230314-topic-scuba_socinfo-v2-0-44fa1256aa6d@linaro.org>
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

On Wed, 15 Mar 2023 11:17:25 +0100, Konrad Dybcio wrote:
> v1 -> v2:
> - Sort entries by ID [2/2]
> - Pick up tags
> 
> v1: https://lore.kernel.org/r/20230314-topic-scuba_socinfo-v1-0-acd7a7ab9d46@linaro.org
> 
> Add missing SoC IDs for QCM2290 and its robotics variant.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add IDs for QCM2290/QRB2210
      commit: f26e18bda9e3b069fbb07a2827597952a6d0afe0
[2/2] soc: qcom: socinfo: Add IDs for QCM2290/QRB2210
      commit: 18290c2eec4be239318cb4e01cafe12217e36de8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
