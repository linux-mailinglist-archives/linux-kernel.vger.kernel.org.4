Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AD171044D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjEYEvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbjEYEvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6D6B3;
        Wed, 24 May 2023 21:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4341463C35;
        Thu, 25 May 2023 04:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9AB3C433A0;
        Thu, 25 May 2023 04:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990262;
        bh=YVOrLbbfmA+w49T2d6lw7r8o1hXHGy/j1QnuIpHqW4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYLpG8HuPKtYAg3/x8fasVrGBL57b1Wj1zvLNXcobJoHFtbb0mp2yuERnpub3HeQh
         tTTz8iTo40/dpHKYK6ygqM7Ct9dnP4aoQLqCEAClvbCFqgyRT0rJOERSxVh/LgW2Ny
         HMxzkfrwQCZ2NTybX/JKVj/PrFNslTMBIPgfZ4wNlNxFVz/8quuvU2rhQQIGA/Cuk8
         90Pnw6zeaibYO8xlQIF3lo8CI0iCARYWoeoKwZ+m0RNJBUTNZNhCmSexn25BBMeozP
         fVANBXFskJ7bE89xP5/PkPr5vq4yKDWxQCXJJnOkUxKsEwBeodM8a+pfcSjQR1UJHS
         mQJSia2sVTq6w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v3 1/1] arm64: dts: qcom: sm6115: Add CPU idle-states
Date:   Wed, 24 May 2023 21:53:42 -0700
Message-Id: <168499048186.3998961.5256675224405395921.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518080031.2509250-1-bhupesh.sharma@linaro.org>
References: <20230518080031.2509250-1-bhupesh.sharma@linaro.org>
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

On Thu, 18 May 2023 13:30:31 +0530, Bhupesh Sharma wrote:
> Add CPU idle-state nodes and power-domains in Qualcomm sm6115 SoC dtsi.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Add CPU idle-states
      commit: b5de1a9ff1f2f90c7c1b9b243e754fea6ce1a8e1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
