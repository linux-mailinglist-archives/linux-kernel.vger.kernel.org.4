Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1D3644B6C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiLFSVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLFSUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B2E3C6DA;
        Tue,  6 Dec 2022 10:20:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 858D961849;
        Tue,  6 Dec 2022 18:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBD5C4314B;
        Tue,  6 Dec 2022 18:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350801;
        bh=ZLi2DBIpMW2onW5gpj5GU/8rcinddPdR12rrncjotk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VYWty6gvVY3/1eNgX5QPC4gzlppNbUJAG3bQZUof+2EBR4/CcxEqUATE9PAGdtYH6
         dIPN+viBUHAzHJgsPWn4KDYhFZ6gUUQrPOJc642Z1bRRDGHKVvc7yc2um9rV88FBOy
         NTe+M3Jqst270irnIaKtirUSc/WjHgTp8E5SuyNyL3ZeBe9LnuQOx419ZT79cM3CYR
         rmB0aoEyK28eGDO/CbEnO17XtI674XFfbl4FfPoeWAt7wD/rj7cVlgY26PS2HWUb4p
         USYwiAJH0cIcVbMvCgcghKRq8nDHdnnJtMJtiSz3jz+pvUwmSsb+6exj8JEIumdxTu
         1KMszpHulCvNw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@linaro.org
Cc:     robh+dt@kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        patches@linaro.org
Subject: Re: (subset) [PATCH v2 1/4] dt-bindings: arm: qcom: Add Xperia 5 IV (PDX224)
Date:   Tue,  6 Dec 2022 12:19:06 -0600
Message-Id: <167035076333.3155086.14594755962131891984.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221114095654.34561-1-konrad.dybcio@linaro.org>
References: <20221114095654.34561-1-konrad.dybcio@linaro.org>
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

On Mon, 14 Nov 2022 10:56:51 +0100, Konrad Dybcio wrote:
> Add a compatible for Sony Xperia 5 IV.
> 
> 

Applied, thanks!

[2/4] arm64: dts: qcom: sm8450-nagara: Separate out Nagara platform dtsi
      commit: 1620676b85f1fde182440bf5a74b80766ece4f07
[3/4] arm64: dts: qcom: sm8450: Add Xperia 5 IV support
      commit: 7d54cdf5640ca29e7fdaa8528e09f719b685bc8b
[4/4] arm64: dts: qcom: sm8450-nagara: Add Samsung touchscreen
      commit: d409e44d2ec672ae9c1513485f850e17af829916

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
