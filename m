Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CBA696B80
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 18:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjBNR2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 12:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjBNR2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 12:28:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C25313D73;
        Tue, 14 Feb 2023 09:28:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 336D0B81E44;
        Tue, 14 Feb 2023 17:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF507C433A0;
        Tue, 14 Feb 2023 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676395697;
        bh=13vIi1ckUu3/aumbSCkzljgpO2EtfLful4/vNSEbxF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aT2Bl8Ny5fS4v3KYPoPJxFW/YcawNoaYqRbr5Qp15/YcCzqFruiSGB2x4ZM9KCZRm
         a1HKnFgKfY4wJF5PINp3cQFnSHlJmiKDNkpaHNyDa3LFl1lz2RyUIlwkQQkVDL+Li6
         oACppWOj+5Gq64KivVEcKgD1WnUeyD0qihZzIw+zAL58Yi5gOKJhEYckpjYLKg5MPd
         J+H4BbWAK63jhCJ/wp4uJv1b5eU3G1GsEKCZDvGn44CydakZKxH2A20695hvfzGgQi
         G2cA/QkOd2JYS+HPLpK5sZkeT8W8tpwvGj2pcLIisQyM+7NI68AtwdV2zl85lM2NoY
         jMbX33woNACWQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Banajit Goswami <bgoswami@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: (subset) [PATCH v2 1/7] arm64: dts: qcom: ipq6018: align RPM G-Link node with bindings
Date:   Tue, 14 Feb 2023 09:30:15 -0800
Message-Id: <167639581474.996065.4144950480631659648.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
References: <20230208101545.45711-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 8 Feb 2023 11:15:39 +0100, Krzysztof Kozlowski wrote:
> Bindings expect (and most of DTS use) the RPM G-Link node name to be
> "rpm-requests".
> 
> 

Applied, thanks!

[6/7] dt-bindings: remoteproc: qcom,glink-rpm-edge: convert to DT schema
      commit: fdafdddf7b2f5cab8d233ef97f1fad8ec7d2e7a0
[7/7] dt-bindings: remoteproc: qcom,glink-edge: correct label description
      commit: 6f9c2f19a8743c880903a031c7f3f3c534d4b813

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
