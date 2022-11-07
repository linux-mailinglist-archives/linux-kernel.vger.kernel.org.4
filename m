Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E261E90D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbiKGDNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiKGDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B46DEE10;
        Sun,  6 Nov 2022 19:12:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F99A60E97;
        Mon,  7 Nov 2022 03:12:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD04C43147;
        Mon,  7 Nov 2022 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790768;
        bh=nb5A3EqnQs2RKPKMjrPQI3q9RY4QgAJRM1NjBuS4AaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hSS6yXB8V2U0cRN9iLNlOfQAzVaOmFvIgHog55ho+VGhswf0XrDrV7fOdxY9m8Nav
         qqrvqPJa7EdoPB10KXdZehVUK0ZrbVlfR1zmChmSjhysbYCR0FMNE077U/GSCxefXe
         PBgB+GwmRQj32j9szyetcid9HO7VatjGzvqr+SYsJWR+jvtq/imSRTNa93lbUvHXzb
         AlMm9iTpjzWZMRz04KUrUkmlEN3jp8gAbsnIzgpythFvRatDIqeTYEp9IYYLuLabs1
         bPxhfN+RO49q0Z6KNSbq9Uvt/lWOIMUD8v5OtA0fGANTuKWGE3lKc4XhMSUPCvrQTV
         MLc5DWk74EGSw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: drop bogus DP PHY clock
Date:   Sun,  6 Nov 2022 21:12:06 -0600
Message-Id: <166779074265.500303.8868564150569748149.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221026152511.9661-1-johan+linaro@kernel.org>
References: <20221026152511.9661-1-johan+linaro@kernel.org>
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

On Wed, 26 Oct 2022 17:25:09 +0200, Johan Hovold wrote:
> The QMP pipe clock is used by the USB part of the PHY so drop the
> corresponding properties from DP child nodes.
> 
> Johan
> 
> 
> Johan Hovold (2):
>   arm64: dts: qcom: sm8250: drop bogus DP PHY clock
>   arm64: dts: qcom: sm6350: drop bogus DP PHY clock
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: sm8250: drop bogus DP PHY clock
      commit: bb9f23e46ddcebe1bc68a43a0f7acfc1865a6472
[2/2] arm64: dts: qcom: sm6350: drop bogus DP PHY clock
      commit: 95fade4016cbd57ee050ab226c8f0483af1753c4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
