Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7320644B6E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLFSVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiLFSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587673F064;
        Tue,  6 Dec 2022 10:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BD7EB81B31;
        Tue,  6 Dec 2022 18:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B2DC433D6;
        Tue,  6 Dec 2022 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350805;
        bh=Q1MSZ++91CRbrwrQghepXeIDOvs+4sfj6zuWjU04mRU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AjeKFgiaFpjtOr+AhiIWZ1gJbAB0XaNzSs9Md8EuUUZheWKCuC/CWcCJGk0IhEwyJ
         RUc6r80gi+slXF77wssC/1QJ/RdnTm7yM+XdcxLKaI/hVkN2TyRxUSrowpBOuFngoU
         Y0lqR5Fieh4w9ILLMWxDynUIsXbvnkrwDjVFNuNQKobEUCSGFU9lEvkx4Y9G5JKLQ3
         Y1zzNpo95mw9C7P1H7Ak/J/Dkkwt3UK7ViisEuokzspD/hXC7ZAl8MiknUadigIOEm
         4AFKw3cJEYpCr4Q/+PEy4iWtLewntGVC3lsoU/GI0v0n8tsjmU6qJ10CkGKMYLd4Iw
         kjrGHfDZ68qoQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: align LED node names with dtschema
Date:   Tue,  6 Dec 2022 12:19:10 -0600
Message-Id: <167035076343.3155086.12056455316672302740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221125144209.477328-1-krzysztof.kozlowski@linaro.org>
References: <20221125144209.477328-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 25 Nov 2022 15:42:08 +0100, Krzysztof Kozlowski wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   qcom/msm8998-oneplus-cheeseburger.dtb: leds: 'button-backlight' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>   qcom/sc7180-trogdor-coachz-r1.dtb: pwmleds: 'keyboard-backlight' does not match any of the regexes: '^led(-[0-9a-f]+)?$', 'pinctrl-[0-9]+'
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: align LED node names with dtschema
      commit: cb3920b50b4da3dfdb6c84164091a03ab1eacb6d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
