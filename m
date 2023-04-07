Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB56DB751
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDGXhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDGXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6ABE195;
        Fri,  7 Apr 2023 16:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A33865573;
        Fri,  7 Apr 2023 23:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0BFC433EF;
        Fri,  7 Apr 2023 23:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680910642;
        bh=qxLOQAYL/rKYkW1O5vcLJ0Kauj0wkLn2NCdQ8YKUeJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b0TiDUSibHIubmybzDVTCErKopxm8t3+h46BrdMI9G7hI7tKHCZRUqiRj0AqaS6bi
         r9dYVzjdg3zLmYvoCOsS2MKeRMI1r3wNBxoqgnXDUMNDYxOhvNLlBvelLNy2Rj9+dC
         5HI9t0capkVL929bPm3JKO19/ZzfexCgJTXb2hOgsCX9xLxLm+yQj94LupRMrYGG1v
         p2g6gKD+iWDBab1e8hGkjJlpELORwR6i8Npu4/mu4OV4osAxfEP+OhyFuE50rxylaD
         vuECS8oQibBNz2YBajIJzMg7X4d/4Y2xysqs+d0EydjOi9kd9nCJjRSuqnGz+Y2i7i
         LlSVZ14oQfPVA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Cc:     Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH v3] arm64: dts: qcom: sm8550: add Soundwire controllers
Date:   Fri,  7 Apr 2023 16:40:07 -0700
Message-Id: <168091080212.2759405.18025554204311427981.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405061129.143553-1-krzysztof.kozlowski@linaro.org>
References: <20230405061129.143553-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 5 Apr 2023 08:11:29 +0200, Krzysztof Kozlowski wrote:
> Add nodes for LPASS Soundwire v2.0.0 controllers.  Use labels with
> indices matching downstream DTS, to make any comparisons easier.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: add Soundwire controllers
      commit: 61b006389bb7af6da29be4b1c2b93708ffe383a4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
