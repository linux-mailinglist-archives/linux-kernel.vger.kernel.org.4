Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C4D968A6E7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 00:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjBCX0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 18:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjBCX0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:26:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15AA6BA1;
        Fri,  3 Feb 2023 15:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CFEBB82C4F;
        Fri,  3 Feb 2023 23:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C786C433D2;
        Fri,  3 Feb 2023 23:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675466782;
        bh=Q5g8PSh1zSKFvJTbAZ547zknZ1HdU7Xx46yuow9NTHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aD7SedxVfkNqU8z1wNCRjhgdXwkMCjRC8juKxEKd5F3RD6tmvcybpVwYpS7/EfXVw
         nduyAWuSR/wNhEEoSzupN9ZiiTEJcThkj2szGBB6bJLsjdCh6Brm85YuQ1cc34cNdS
         r0h3vwAoKxDwarosQ778/jM8LQnEi9wPd4lFvy2zfZ+gYcNltVPJQK1euoGJjG2+8V
         NMimPMkmXoGmDiVOlcb9cI9DZp8TGuDOpWiwaHEmkR9LBp5uQbqeWgLXAo5Mo8JZEA
         mHosWCf4mX9ug7Nnt46gVpBykf2CnokJ+jSNsxq6QIWNRwjyyN6izpVRENuVYkDKRE
         KfvmGjkmIQc+w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>, robh+dt@kernel.org,
        agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        dianders@chromium.org
Subject: Re: (subset) [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD Pro boards
Date:   Fri,  3 Feb 2023 15:28:41 -0800
Message-Id: <167546690943.378525.11095474745334895422.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221216112918.1243-1-quic_rjendra@quicinc.com>
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
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

On Fri, 16 Dec 2022 16:59:17 +0530, Rajendra Nayak wrote:
> Add compatibles for the Pro SKU of the sc7280 CRD boards
> which come with a Pro variant of the qcard.
> The Pro qcard variant has smps9 from pm8350c ganged up with
> smps7 and smps8.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sc7280: Add a herobrine CRD Pro SKU
      commit: f816cda0ab2b0250e225dfda41c107733a74faf7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
