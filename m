Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC126D7302
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjDEEGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbjDEEGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2E830ED;
        Tue,  4 Apr 2023 21:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440CB63AF5;
        Wed,  5 Apr 2023 04:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF530C4339B;
        Wed,  5 Apr 2023 04:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667580;
        bh=hEaErDu5fSOt+0cd2ChJ0Anyal99mcV0yfCmSzyt6dA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQS74kUaK5ZegEUoLCw1SyX12BV8j/sBduKk8KRLGSJCTkOE1p9tfFSjG4tMV1oIX
         cPdHjpUYH7N6tFBjHbByMh9UUxTnOLSCAzlLN0s6+StJ5wBBtx9ouM7b1rIK3t9XNd
         WX2vcjbVK4i0WuuFJlXgEC3RyfXJl7JJjS9/+r+obuY06sBf6rmz7/0cblC+TJwk+h
         zf5R98WpEJIU5/AUkxpemV3Uc9+62Q7G6MD8YFdrvfGIB2hjDojRWW+T5axQcVYmI8
         UyrHJwXKHO0Z/Sl0mUcSmoXGt+eOQEW4MDjGeoaW4HKOKsjwtpLessvuwCgXF7MecD
         93UfSUUapObFw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Joel Selvaraj <joelselvaraj.oss@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845-xiaomi-beryllium: add notification LED
Date:   Tue,  4 Apr 2023 21:08:52 -0700
Message-Id: <168066774413.443656.10543782498804265465.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313154226.136726-1-joelselvaraj.oss@gmail.com>
References: <20230313154226.136726-1-joelselvaraj.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 10:42:26 -0500, Joel Selvaraj wrote:
> The Poco F1 has a single color white notification LED. Enable the
> Qualcomm Light Pulse Generator (LPG) driver based notification LED.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845-xiaomi-beryllium: add notification LED
      commit: d20ad168b7d024d8cbe6b54e9c029537aa412576

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
