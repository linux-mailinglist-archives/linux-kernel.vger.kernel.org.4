Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1698710485
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239464AbjEYEyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238937AbjEYEwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:52:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C959310F0;
        Wed, 24 May 2023 21:51:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 657CE60E95;
        Thu, 25 May 2023 04:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AE9C4339C;
        Thu, 25 May 2023 04:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990280;
        bh=MD3Z3CBzRZhfffeqELSmUQV94EXVMQgnsx5X5pWikIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2A8QaJ9UE+sBkp8HT4xXTM0Vq0v7XBMjEHY7N6QO5oUiqy2+HkODZU+0cKvIJnN5
         2h7E7MEXbbYdizw0DejZuO9t2ZruDniJj0AasDKtBLjpKWSpTCeBh6MMWIDzyQSOlm
         //RRcSiRx6uSzPKWtsUDCX29kRGqsSrxU7tQmOAWiQ3I6DD+nrcISU/Y4kgb+7Neky
         0oakeLh4/WBtYqgNDFPOtKRPFNfj1gK+FdLpp7fSfJ9vkiqYNSmv77JV+4sOgBNBtt
         jwrPnsz8QS2136LPBSIDMkbw76DLY4lPtE0klqLfPJd2UPZeLPHvmcgtbCHODpyaWn
         H8JsnCtIoqwPA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v2 0/4] SM8150 Kumano updates
Date:   Wed, 24 May 2023 21:54:01 -0700
Message-Id: <168499048183.3998961.717721979982259269.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315-topic-kumano_dts0-v2-0-0ca7fa521b86@linaro.org>
References: <20230315-topic-kumano_dts0-v2-0-0ca7fa521b86@linaro.org>
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

On Tue, 11 Apr 2023 20:14:40 +0200, Konrad Dybcio wrote:
> v1 -> v2:
> - no-emmc -> no-mmc [4/4]
> - drop superfluous input-enable [3/4]
> 
> v1: https://lore.kernel.org/r/20230315-topic-kumano_dts0-v1-0-f1852c2a2378@linaro.org
> 
> Add gpio-line-names, set up fixed camera regulators and enable SDHCI2
> on Xperia 1 / 5.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sm8150-kumano: Add GPIO line names for PMIC GPIOs
      commit: 20fd55b2b0acd496cc6d3cb98832fe2438939ac4
[2/4] arm64: dts: qcom: sm8150-kumano: Add GPIO line names for TLMM
      commit: b949d8032fa287633faf895dc3669a7fd6720071
[3/4] arm64: dts: qcom: sm8150-kumano: Set up camera fixed regulators
      commit: 7a740ec3045bfa3b476ea94dd2d70bc3ac5d0a0f
[4/4] arm64: dts: qcom: sm8150-kumano: Enable SDHCI2
      commit: 644ab8bb42b596f16d01fb140088afb616f67cd8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
