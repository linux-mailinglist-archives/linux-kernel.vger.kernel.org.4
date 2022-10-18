Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7886021F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiJRDJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJRDHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FF69AC09;
        Mon, 17 Oct 2022 20:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E14C6136D;
        Tue, 18 Oct 2022 03:06:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D8BC433C1;
        Tue, 18 Oct 2022 03:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062415;
        bh=JFNICyKeny+tINq324fO8epEvYuRC2wZJfQlwrtzGZ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FwCLPkvJIo44h/z591PLBfx05Fm+YPRJIJVDwXb6iT7kQqOjlSUNCgPoBn9o1Yik7
         pqkxoWHbUyrn/NhraWMcPJ6UiC7MRKzjB/cJAC+x/CoaMPDMz5fvoHZvWj4rFXUz7A
         +cqk87fNeQcPcymq9Nr5AcGe+yhP6ejOm7pVXM0JZG3wnyClhjseybe6KC8cl+Uc9/
         I75yJNJf81sMLkEb7BvZTSF/R6pJYnFHp63Kd8nzwoJAC2LT4Vnes1X/+XW2EXHNWw
         48+EfkvO1ms7aHuf42uhIseYqYd/hAgvb8R++OiB/t3i2W/d9TBUcQMpfufDoa117r
         ksmFkjsaexh4g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     alsa-devel@alsa-project.org,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        srinivas.kandagatla@linaro.org, broonie@kernel.org,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 00/12] ASoC/qcom/remoteproc/arm64: Qualcomm ADSP DTS and binding fixes
Date:   Mon, 17 Oct 2022 22:05:29 -0500
Message-Id: <166606235836.3553294.657732618044727508.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
References: <20220906121655.303693-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 14:16:43 +0200, Krzysztof Kozlowski wrote:
> Dependencies/merging
> ====================
> 1. The DTS patches are independent.
> 2. The binding patches should come together, because of context changes. Could
>    be one of: Qualcomm SoC, ASoC or DT tree.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[01/12] arm64: dts: qcom: sdm630: align APR services node names with dtschema
        commit: aa27f316de7fbf3155ffde20a6daa4041d15ac5e
[02/12] arm64: dts: qcom: sdm845: align APR services node names with dtschema
        commit: a3692a5edc5681d47fede71efeeaa065ebcad8d9
[03/12] arm64: dts: qcom: sm8250: align APR services node names with dtschema
        commit: a22609bf9fee17f9045b5b1847f2585200cd1920
[04/12] arm64: dts: qcom: msm8996: fix APR services nodes
        commit: c05b95d3286734c83e384240eb41d9867ce11027
[05/12] arm64: dts: qcom: sdm845: align dai node names with dtschema
        commit: 074240974e08a50faf434fa61c8bb7859871c774
[06/12] arm64: dts: qcom: msm8996: align dai node names with dtschema
        commit: 6b401d49395c3fbb082e84c1df3ad77495876c18
[07/12] arm64: dts: qcom: qrb5165-rb5: align dai node names with dtschema
        commit: cf4a15e409ff1287506fac51c343821d846fc1bc
[08/12] arm64: dts: qcom: sm8250: use generic name for LPASS clock controller
        commit: e0b6c1ff512db643050e4a09020d7c0b69c82807

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
