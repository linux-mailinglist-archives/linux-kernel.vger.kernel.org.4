Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31018710496
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjEYEyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239324AbjEYExN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650521708;
        Wed, 24 May 2023 21:51:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44CE1642B5;
        Thu, 25 May 2023 04:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02A3C4339E;
        Thu, 25 May 2023 04:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990296;
        bh=DXs1OyXxrKzJD6hNUJVt7fNP1u8bkAbGuGVAOaMgRr8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CTstyJQdjIc6OBRghvUIH+a7EEf2O8k9Oopyat9e9FM+puGUySSb2UmgC1SdaUFqa
         ZP0hUS3j2i0ude0BLv2nq0c9Te174EcckRfNlAA4+fA3lSm0lPbLhkEsDo2kh8k08N
         HrPldln3wMEo6O3Uwz43ZxKD5gdms1DvovjHcOrsfK5+ZGEpqcTJiUZvNy53xHkLAN
         mWp2+C6L7KuvLHsDnCuKcjnEBLEbIxa0DQIs3rogA8zM+jsXXbrwmEbAssSZcLJgHj
         6sj4qFCWG6KNAVxE0RNzyt7ZycMp8BWI9qYTz2gZ4YKa+KzxTFlvTKlDDyJ6Ygt6QD
         RvjH87k/wZ+qg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 1/3] arm64: dts: qcom: sm8550: enable DISPCC by default
Date:   Wed, 24 May 2023 21:54:16 -0700
Message-Id: <168499048186.3998961.17823902051773417905.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
References: <20230516154539.238655-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 16 May 2023 17:45:37 +0200, Krzysztof Kozlowski wrote:
> Enable the Display Clock Controller by default in SoC DTSI so unused
> clocks can be turned off.  It does not require any external resources,
> so as core SoC component should be always available to boards.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8550: enable DISPCC by default
      commit: 5ef00c06ea5e4e0de1f63d2c620f671750f73f9b
[2/3] arm64: dts: qcom: sm8550-mtp: drop redundant MDP status
      commit: fbeffa580e30fe7fb748e4ccc39c2b18a137c055
[3/3] arm64: dts: qcom: sm8550-qrd: add display and panel
      commit: fdb0038e96659f08dae575aae6b4b6b22884d17b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
