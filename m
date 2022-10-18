Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6B602230
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiJRDLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231184AbiJRDJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97749AFC2;
        Mon, 17 Oct 2022 20:07:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 915B261370;
        Tue, 18 Oct 2022 03:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E24C43470;
        Tue, 18 Oct 2022 03:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062434;
        bh=WOSB6sGd9KXigO1ib9PytmE0wzW1hIZQiHeHeNCfodU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AZ2CFQbAdes4nAzCvFtOPEKAf716HjHYYdL4glm9RXfg0nBVkubeq4dOqjqzA3MlW
         e28adrRuhiFpZHbCMED2ZO3VtYrnSMSw3j80jpizDrymLfUyFfyokZ+VELhpagRnxE
         DQtzqITOs+69g6pyju8K3kBJ145coZ6I68wnLPCbpuOq2SxgBNNE7V3uC3Pdk1kVTE
         8bN6sYatNLW9OKMWM9IyOLDtUkjgKpX9eJJCYnfBXsEgI8sHYeFKrbVzgaUHPS6KHD
         JVyrxv8oiMTFPiyOry8lqYJWi3w73+URcQned41vJzFkLSSdTVofa2IRviAOWOu4AL
         t/2CO+St+EJFw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     robh@kernel.org
Subject: Re: (subset) [RESEND PATCH v2 1/4] dt-bindings: soc: qcom: smd-rpm: add PMIC regulators nodes
Date:   Mon, 17 Oct 2022 22:05:46 -0500
Message-Id: <166606235847.3553294.6530961896750547882.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
References: <20220926092104.111449-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 11:21:01 +0200, Krzysztof Kozlowski wrote:
> The Qualcomm RPM over SMD contains devices for one or two PMIC
> regulators - already used in several DTS files.
> 
> 

Applied, thanks!

[3/4] arm64: dts: qcom: align RPM regulators node name with bindings
      commit: 372698e8df2619bf76b047c9a600d1f659d7868b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
