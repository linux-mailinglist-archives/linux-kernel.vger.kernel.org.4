Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED238644B21
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiLFSTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiLFSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:19:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D14B4AA;
        Tue,  6 Dec 2022 10:19:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E130C617F2;
        Tue,  6 Dec 2022 18:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B368EC43142;
        Tue,  6 Dec 2022 18:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350775;
        bh=XcahCzh7rqFyMPOaTF5CxS4INkOPvrEMpsdtzekxdFI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbuMJz3seiX1w9sByDMv4kQwnYfrPRU8U5robCi9VAo9lXV9Jv6nD2tx/KF3HJrNu
         fZD0kGuAs3qfnld+YU11nhwAGDF4Oo7nUAHXzDJ9SoylqowPOSHRE6PJdjMsMDBDKG
         emEkC95CvvXXZHPvjTi9RAb0buy7Ui/H+pJ5/TG08gtx0X8IGefDF/kcuZmSp9npy9
         5KinsicPdpF4h514r2s9d/z7dgGKfM9PWXXJbrRKhfXEfS+x+84aMoEdXUllY2FvfI
         DXVkh7TJocMAo2vkfAf4z2wT1qGCymAH8dWiIbX7UFkVUXvdQKxYsfCas8UKMRcEHQ
         k3hz0L724ng5A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org, abel.vesa@linaro.org, robh@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/3] soc: qcom: llcc: Add support for SM8550
Date:   Tue,  6 Dec 2022 12:18:41 -0600
Message-Id: <167035076337.3155086.12020717691610360812.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221116113005.2653284-1-abel.vesa@linaro.org>
References: <20221116113005.2653284-1-abel.vesa@linaro.org>
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

On Wed, 16 Nov 2022 13:30:02 +0200, Abel Vesa wrote:
> This patchset adds LLCC support for the new Qualcomm SM8550 SoC.
> Since the SM8550 bumps the HW version to 4.1, add support for it
> beforehand.
> 
> To: Andy Gross <agross@kernel.org>
> To: Bjorn Andersson <andersson@kernel.org>
> To: Konrad Dybcio <konrad.dybcio@linaro.org>
> To: Rob Herring <robh+dt@kernel.org>
> To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> 
> [...]

Applied, thanks!

[1/3] soc: qcom: llcc: Add v4.1 HW version support
      commit: c72ca343f911c3ba1b10163399f891ddb86ad109
[2/3] dt-bindings: arm: msm: Add LLCC compatible for SM8550
      commit: bbfdc82696e0aa76e9b31cb6c593ff0f96af9c30
[3/3] soc: qcom: llcc: Add configuration data for SM8550
      commit: 8c045cd21644a0acc815d3108018a8b6fd474804

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
