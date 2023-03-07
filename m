Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE96AD620
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjCGERT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCGERI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:17:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563A5708E;
        Mon,  6 Mar 2023 20:17:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F72611C6;
        Tue,  7 Mar 2023 04:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C069FC4339B;
        Tue,  7 Mar 2023 04:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678162626;
        bh=DilGv0iS2+GpIZwSii3dmgg9dyvNwEbnIowIeChZY1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U5hFYZndgPjZ5aQSgA0292GMyrQXK8B+JwXAejXpIyQ8rA3cJ+fG5NCp90964VZwk
         TVSZC7bGRA6p3+DPsIEKR3VSO1o6m4FyvDFrWr4exBAddxY+Fp6rD1eHbZ+HGh++fA
         bsSiok5aUw33JmTBA2VWTflvCZF9uaLRBRSTFyQ6oq/S3oivU8SCGCuE2Y6uWev7wj
         bAUCFuJ2h01Dgrc390h3WyONOXd0eKPrHgOG/JJQZvJ91uY+wZpoZiTI6b+3v7Bffn
         kG/PhpSFxtvW7jjH3qY0iWrMALo0nYFm+1Ccn9PVtkzdh4Yze+NALD3XtXhyxLXhQK
         8CzeV+z1Dq3dg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Un-enable SPI5 by default
Date:   Mon,  6 Mar 2023 20:20:29 -0800
Message-Id: <167816282863.1458033.9741049894018415299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230216124921.3985834-1-konrad.dybcio@linaro.org>
References: <20230216124921.3985834-1-konrad.dybcio@linaro.org>
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

On Thu, 16 Feb 2023 13:49:21 +0100, Konrad Dybcio wrote:
> The commit mentioned in the fixes tag erroneously enabled SPI5
> unconditionally. Undo it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Un-enable SPI5 by default
      commit: 205c91fb6aca5f8bad5346181575a7ef78e43cea

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
