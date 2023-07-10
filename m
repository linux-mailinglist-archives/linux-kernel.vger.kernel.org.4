Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8AA74CBA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjGJFFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjGJFEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50211137;
        Sun,  9 Jul 2023 22:04:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72A3260DE4;
        Mon, 10 Jul 2023 05:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA580C433CD;
        Mon, 10 Jul 2023 05:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965472;
        bh=cshxreT6e4PkL8QAzh3+mNCugq5NHlXhggxXcFatLQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ubA7mxh+kcxEjX4FBa1yfFMyvgbZfkQbUvhH4HUU886sJnICvunuMdrUNe29GZDwW
         KdI4azlbbbFWrSEoo21Ftw9EivKibfNQt2vozAfC1iVgs6pINY/7MJYJ7EBFkbt3NQ
         gJZEONEEYvahYWKNoDg9+DvW+oT5zBMoAiEnYaU9LQAidMvThJMUsAkv5++NsbYIgQ
         yQWwaZmEBy/Nr/eRSNbrW2m7qBssbr1+qPJNsTGICjB+nVHeNb17mLTbI61/X2pyd4
         CAblQlY1UM4I9c2v5OrUq9pBlpcgAAP52ZC6yVLGEVS/AzO0yez1JESkKUCU21LoSe
         RpoBGzkjJNx5g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] SC7180 BWMONs
Date:   Sun,  9 Jul 2023 22:07:13 -0700
Message-ID: <168896565954.1376307.13612400236835674001.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
References: <20230616-topic-sc7180_bwmons-v1-0-4ddb96f9a6cd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Jun 2023 01:46:08 +0200, Konrad Dybcio wrote:
> SC7180 has been using static DDR votes for the longest time. Time to
> switch to BWMON (which accidentally results in up to 50% perf gains in
> glmark2)!
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc7180: Hook up BWMONs
      commit: adc16b84e1ea12fe527fba463db05452c9f06993

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
