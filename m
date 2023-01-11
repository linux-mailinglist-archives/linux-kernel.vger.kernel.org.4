Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5C66534C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjAKFTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjAKFSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764FF13DEA;
        Tue, 10 Jan 2023 21:09:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 134F461A34;
        Wed, 11 Jan 2023 05:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C325BC433F0;
        Wed, 11 Jan 2023 05:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413793;
        bh=Bgv0qyUsAY1R2n323ydyHsEQDBF/CY5c/y5fkz76Qms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnNLkxbgEDYQoDs06jt/gorzwwdSg8b4WXCmQvqZxGJY9u6YQ3rD3+47fjhxojOHX
         mNGnbSVxMD1Wd6V5wVQldHB7/GXlPXPQVWVDn5GJ+ZAyeDrfb7Gd1ubrQqo2uT+zQH
         ZcwHM6rhr4KP6wKta1qGcGDV0MWC4eCh+Qu85ZA1UvRpLzNPuTtkhd+Vsd5XOsL1ZS
         Jld6/CHSTocBrNIpBQ2xHTSRTlNnuYE59yiFGVSbGFb+/oB2mb0ipFMydYTWJTptbx
         va4SFgDWrDLSn3ehRPOo6g5HBzMdKTF/13ORm6qFaL5lCKLgXcKnJpSt6qq4EwCpen
         YRcZ/zQvO48uw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: sm8250-edo: Remove misleading comments
Date:   Tue, 10 Jan 2023 23:09:18 -0600
Message-Id: <167341377724.2246479.12451898629680827179.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221213132517.203609-1-konrad.dybcio@linaro.org>
References: <20221213132517.203609-1-konrad.dybcio@linaro.org>
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

On Tue, 13 Dec 2022 14:25:15 +0100, Konrad Dybcio wrote:
> As much as it hurts me, there is no FM radio chips on these devices.
> It seems to be present on Japanese models, but these are not available
> globally and differ in a few more ways anyway (such as a super high-tech
> NFC chip).
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8250-edo: Remove misleading comments
      commit: 2a87b555553e357460da6f3cbc95bd6eadc852c0
[2/3] arm64: dts: qcom: sm8350-sagami: Disable empty i2c bus
      commit: 71b4fb83a958881666f52d6275cd264ec909c7bc
[3/3] arm64: dts: qcom: sm8450-nagara: Disable empty i2c bus
      commit: 7ca5618520c6c8fd1419e2b057681d4f1d7b6578

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
