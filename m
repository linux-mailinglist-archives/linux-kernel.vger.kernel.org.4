Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9070D204
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjEWC7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjEWC7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AB0CD;
        Mon, 22 May 2023 19:59:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6298062E64;
        Tue, 23 May 2023 02:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29966C433A0;
        Tue, 23 May 2023 02:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810771;
        bh=sHwOonoR0NQ+fCDd9MdvczFnfwxGdJNBppf2LHYDFsw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jqYwgARkPY1jqqIKFL19URNU5S3Lwv1bDAsOyWXDkDAokEJT7JNBVuxHgWBEk77nq
         7EXe2uKNV5r93QkHpjZwXtapDD+RRexRACphruCJ+gh5Te8DFYO6RzzHvg84/Lm+53
         x6mh88/UOqol3haZcp4kETBMCZ8f1XXU2gbROtyf+QiQ+s0lTYHWX2HXXuqYX81lAV
         9DnxvjvnHWByu6CpocXnzj0F3ne/5ehpWH9zNgeTr6IbmYvhvvAsvqdrfz9v8PwfO+
         kPoXR2qKKx61d18RAmKh66cxJI7+yCA/Z/rnozkDBjNacFrVSXMOgRiG5UVdZOrSoO
         PhDtSmOTtOasw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sc7280-idp: drop incorrect dai-cells from WCD938x SDW
Date:   Mon, 22 May 2023 20:03:19 -0700
Message-Id: <168481094821.1229550.15503908575400426987.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230220095401.64196-1-krzysztof.kozlowski@linaro.org>
References: <20230220095401.64196-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 20 Feb 2023 10:54:00 +0100, Krzysztof Kozlowski wrote:
> The WCD938x audio codec Soundwire interface part is not a DAI and does
> not allow sound-dai-cells:
> 
>   sc7280-idp.dtb: codec@0,4: '#sound-dai-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sc7280-idp: drop incorrect dai-cells from WCD938x SDW
      commit: ca8fc6814844d8787e7fec61b2544a871ea8b675
[2/2] arm64: dts: qcom: sc7280-qcard: drop incorrect dai-cells from WCD938x SDW
      commit: 16bd455d0897d1b8b7a9aee2ed51d75b14a34563

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
