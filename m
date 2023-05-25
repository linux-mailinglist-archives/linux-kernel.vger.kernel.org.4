Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011217104B9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239474AbjEYEzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239192AbjEYEyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED11B4;
        Wed, 24 May 2023 21:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7818D642A6;
        Thu, 25 May 2023 04:51:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E6BC433A4;
        Thu, 25 May 2023 04:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990286;
        bh=wD1FqhzbOSB/i3/YOdGNz22XSL73pfL5krAHkQ0kDK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kpUEmyY1pvWVQMKpafH623ucP16HiUO2EKfatKj6wSQbhsbEWjkc4+Hqs9u7nEKAZ
         1skKMbxUFPRoeh3l3oGd/jFJUxo/bsA0Fm4GNHvQw5yIcGlrlBtAKNvxgF0luhFF8s
         jwPvmr6hDivSgGYuDs2AUvFevNImJ5fP6a8/vgfonEtOA89hkDrB9J8K/S5CyrMcYH
         U+l3KhtBy4rGweyudDFbKLPpJMwTB8SJP4INRfKzWFZYd6LPddsGot8PFCj78Qdc1n
         xqD0jywYuXiz0tqkmuaskXrNZBMLpFO0VuCzDjWvXDJFTUk6fNuIjBo61ANyT3avXw
         yUUEtdjiY8dUQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Patrick Lai <quic_plai@quicinc.com>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add WCD9385 audio-codec
Date:   Wed, 24 May 2023 21:54:06 -0700
Message-Id: <168499048185.3998961.16870079154403319685.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512160452.206585-1-krzysztof.kozlowski@linaro.org>
References: <20230512160452.206585-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 May 2023 18:04:51 +0200, Krzysztof Kozlowski wrote:
> Add Qualcomm Aqstic WCD9385 audio codec on two Soundwire interfaces: RX
> and TX.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550-qrd: add WCD9385 audio-codec
      commit: 83fae950c9924112ee08792370934e7ab3acd782
[2/2] arm64: dts: qcom: sm8550-mtp: add WCD9385 audio-codec
      commit: a541667c86a9a0510d17f01461072a80fd6cfffd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
