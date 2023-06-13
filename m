Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B70E72F080
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbjFMXrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240275AbjFMXrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FC0296B;
        Tue, 13 Jun 2023 16:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5EAE163C7B;
        Tue, 13 Jun 2023 23:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073E0C433C8;
        Tue, 13 Jun 2023 23:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699936;
        bh=AMsd3sxADqpJqD+mB8eeW0S3cwb3hDi/Y81Gt8oCQVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEBNMkY4MFiHfRwdaH0CIEVLuyHoWZU/F6mI/YsWNtktWHu+U1APZEvo5D0kCm8uD
         pBv+W7ipUjXbPB1baW6s3IXhFpM9jDks5bCItq28KV0H5Uh79Dq9Ky1zjGG1FVINne
         d6D/IB3D8dfzKhcfYEjC/3SUzxUW7WGXsyER1kN4U90PLYEZ/FiH8vm2kfARoxrpv4
         jS5QV4TVY6w/OngD5aKcCezE59mvAhDGJiOH14WN5MsnBC8GLNCU/fyE+3l12IEHBY
         20kD7ur+N7PVH6hSTEfmm0MGjtk473SdPscazyJd7Ug97H7jDVtunNTZ3MoZWdw2vH
         5iT38VQqK3LVQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: Add missing interconnect path to USB HC
Date:   Tue, 13 Jun 2023 16:48:40 -0700
Message-Id: <168670013502.1400697.13657615350747337280.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601103817.4066446-1-abel.vesa@linaro.org>
References: <20230601103817.4066446-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 13:38:17 +0300, Abel Vesa wrote:
> The USB HC node is missing the interconnect paths, so add them.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: Add missing interconnect path to USB HC
      commit: 11a1397bbf69e408223bb691858a0fcd295a8f76

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
