Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F92568FE9B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBIEZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBIEZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:25:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44511AD1D;
        Wed,  8 Feb 2023 20:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD837618A0;
        Thu,  9 Feb 2023 04:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AE3C4339C;
        Thu,  9 Feb 2023 04:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916510;
        bh=2hrb0V7AqlvNT7z6kFUbdE429RqpKctz7rzmkLMY6ng=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JnAlRG8JPZs2I9QvUIsqxE52X6zc0oS09N9A7ukn5Yrw10vpTnIWdsYEHZb0DyfQM
         tCI+5hdmLOjzulV9W36bAozTbfDOCe7lsEMOevaxEnspkV6t3G5tsuSzJ4U+uNzYT1
         8YPqRIe5ZVvzwa4yZE4JSmzMLYoSq/s8vqNIbJNC0xtI2cMgDTSMv1XfFyeDhiwO/V
         F8szAXyN5qK1GOjBQyDDyKWq5Fo4Q6w3fCPEpv5/i6rIFAMnWYJ06aujBw77Tz/ytI
         WEUO5w6ys6vxY9AOaLOrejnsQsoINn/EAuZWza7F+EoT+zB8NQeCT2V2zCCVLYd8/1
         UcAlKXYOOZo+g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Foss <rfoss@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8350: fixup SDHCI interconnect arguments
Date:   Wed,  8 Feb 2023 20:23:06 -0800
Message-Id: <167591660369.1230100.16495180472901688441.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119105434.51635-1-krzysztof.kozlowski@linaro.org>
References: <20230119105434.51635-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 19 Jan 2023 11:54:34 +0100, Krzysztof Kozlowski wrote:
> After switching interconnects to 2 cells, the SDHCI interconnects need
> to get one more argument.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8350: fixup SDHCI interconnect arguments
      commit: fc0ff3e702013c8af39f9967daaef1e565f7d165

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
