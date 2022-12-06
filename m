Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5DE644B80
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiLFSWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiLFSU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01B3FB88;
        Tue,  6 Dec 2022 10:20:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A2D6181B;
        Tue,  6 Dec 2022 18:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18B95C43155;
        Tue,  6 Dec 2022 18:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350811;
        bh=mEiPZJc9g9pfHnkBgPL+ygp75+OYsiiLEcUp0RovtpE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Ba5WX7gbX7EsNHk1uREKJ4vV4nd0ll52/B41GjnkZNnTUg4sm3lQIf3fQ8Wxaov+3
         M8PLB37Qx5g75qwx8HqsK7PfcLFVFn5Yd7uTlPgJF7yLXq0aK6uyUQHGON6lrXcyaz
         koL9PDM0889mvzl2X6ZmVuLK/gqWeUaCDB7/MJQvhpOUVnbUIxAyU71NO6O5hwvO0s
         m9pYJsh9tPMZctHfGsbqHROf9jzjzbDPGFv44rwSQKZPIndQXoNrjS4PaLPVcF7OMj
         ZUIGB22Uqt6hNFPCFhOAYy+uFAru4JIPHgnjQ94BMNUSQTbvAATpHPRz3c3VsW30xq
         VI+GuLLqPTHAQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v2 1/3] arm64: dts: qcom: msm8996-xiaomi-gemini: use preferred enable-gpios for LP5562 LED
Date:   Tue,  6 Dec 2022 12:19:17 -0600
Message-Id: <167035076344.3155086.5703359628028052472.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
References: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 27 Nov 2022 21:32:38 +0100, Krzysztof Kozlowski wrote:
> The preferred name suffix for properties with single and multiple GPIOs
> is "gpios".  Linux GPIO core code supports both.  Bindings are going to
> expect the "gpios" one:
> 
>   qcom/msm8996-xiaomi-gemini.dtb: lp5562@30: 'enable-gpio' does not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied, thanks!

[3/3] ARM: dts: qcom: align LED node names with dtschema
      commit: 3ebeed30209aa50505956076aff1cf00a6381760

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
