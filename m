Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E386BC149
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjCOXd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjCOXdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C43B80E0C;
        Wed, 15 Mar 2023 16:32:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE0D161EAC;
        Wed, 15 Mar 2023 23:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795F7C43446;
        Wed, 15 Mar 2023 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923154;
        bh=IgYAP/Fh+jEPfXJDXVgNyaUsD24xBf0DJBPlSxM0eCc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oxmlkcUr5leKF8LV9uOJ00v8G4OqHM5MbWO23gIPxFgYH9T6PeZsSwQn9ZzkoYfj+
         HcnwBSH1VU3HF3r8RfT+0LZaTfstxumflS3oW4vxFJ35p/mm8PIEhH1H4PxohYnhCM
         sfMxeyXJeuqw5GhBLr1hh0uKGgFWuL1jR4g7o78P0WFNVlTLpRm10byjR677qwftpn
         AEZlpp5TolSPDzD31BVvbCrvo001W9rG/m8ZrHW/TjdascnMylS+gTkTXHIFcP238D
         FKJ2A0h7GTqTrU98UuNm2qJLH3E5Q7BwNeGFtXj2QwH8LN+Xy1QXRgx5PTH+9KYZhf
         XDHJrEPzEGAdA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: arm: qcom: add QRD8550
Date:   Wed, 15 Mar 2023 16:35:05 -0700
Message-Id: <167892332564.4030021.15699697903072822582.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230210163844.765074-1-krzysztof.kozlowski@linaro.org>
References: <20230210163844.765074-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 17:38:43 +0100, Krzysztof Kozlowski wrote:
> Add board compatible for QRD8550 - a mobile-like development board with
> SM8550.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8550-qrd: add QRD8550
      commit: d228efe884692742e3a614c2386ee006aeb6551d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
