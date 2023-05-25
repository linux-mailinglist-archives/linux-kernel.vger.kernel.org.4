Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8804710463
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238717AbjEYEws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbjEYEvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6308CE5E;
        Wed, 24 May 2023 21:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AEFF6429A;
        Thu, 25 May 2023 04:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D8C433EF;
        Thu, 25 May 2023 04:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990273;
        bh=CFNk/NopntWjywZYcuyAqFPdFOupjyE5qhXNH2BMsfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pIcF01E8RFD7wGPGh7evljs8zMrHZknYuJgHgBKjoCWQd7nJQnlg+RaOCC32DPACC
         nkMJh8YPVRSsyJvacuXnLO4ERQI6qdRU4GnlkgbS2dBqg0up7VAbagpARMDH/7Ix2b
         BN2bFaDQILbbet3ZTEe+Um2JfZJPr0cajo5yVQwYaxeQgsTzeXnOm5Rx3LW7CfOnyW
         SmgbJx3jJK/bMmnkOk0dWb61QY9/Ou1vl33291W0jcaDykqLdJIBwc3Xo08WAwalQo
         NfHPWEE8fEe7cB7Ze96YsW7ErVbtvEsmPX6mDqH44krrK9nJRrBE05gnzxRpS2713i
         W2HyniF4tZqlw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, marijn.suijten@somainline.org
Subject: Re: (subset) [PATCH 1/3] dt-bindings: power: qcom,rpmpd: Add SA8155P
Date:   Wed, 24 May 2023 21:53:53 -0700
Message-Id: <168499048176.3998961.13502074304116334855.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
References: <20230214095435.2192153-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 10:54:33 +0100, Konrad Dybcio wrote:
> Add a compatible for SA8155P platforms and relevant defines to the
> include file.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: Split out SA8155P and use correct RPMh power domains
      commit: 8c67e554754ca669911625412ae9a6cd8cee1c82

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
