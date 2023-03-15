Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4DC6BC12A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjCOXdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjCOXcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D807827486;
        Wed, 15 Mar 2023 16:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D22A61EBF;
        Wed, 15 Mar 2023 23:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FE7C433A0;
        Wed, 15 Mar 2023 23:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923145;
        bh=5AraQrg6fKxla6IMXjwo4tHCQs6QKP5HjpoRjdNQ4lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fWqHafP+h1s3FJAD4sM8TTs+W2lUvjnhsxZqIMvDfFikgakEU01QNMmbst38deogh
         kD9Fx2ahTbgOBJEyfS6tiMRCZyzLzjV2SAkCeNl7gsG53A3RQKCGBCf+hUNTYLI/EL
         9j3YtCNuXHNTmbRYuKxsE4UADSeZAFKe168+lWmXV9q6dYI/S7LvwQ8TdqMtl54HKQ
         dqce0mGy6E0p+IaGVzbk8y4rjKbyFhz+P5pyYGFnXqiSX8yvwNLOXUH4A2Fn5lpOs6
         i0aHvQPdfA5Zh4gUub5dUzs2L+Ua7J/E+V0/zvhA9mTqBVyb1cB1u5hkG8gG93tQY8
         DiC1CUq1xL+dQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        krzysztof.kozlowski@linaro.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6375: Add RMTFS
Date:   Wed, 15 Mar 2023 16:34:55 -0700
Message-Id: <167892332565.4030021.783854785090558652.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230213175928.1979637-1-konrad.dybcio@linaro.org>
References: <20230213175928.1979637-1-konrad.dybcio@linaro.org>
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

On Mon, 13 Feb 2023 18:59:28 +0100, Konrad Dybcio wrote:
> Add a node for RMTFS on SM6375.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6375: Add RMTFS
      commit: 5a0c6d4349a7da252c9fa5fbc3d42b4e5ee1f334

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
