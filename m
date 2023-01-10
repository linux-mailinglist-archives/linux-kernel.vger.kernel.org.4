Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB1664BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239295AbjAJSxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239747AbjAJSwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:52:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D55565C;
        Tue, 10 Jan 2023 10:46:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5762BB8190F;
        Tue, 10 Jan 2023 18:46:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F0CC433F0;
        Tue, 10 Jan 2023 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673376412;
        bh=JI849nT88lxoZkEWBsgDtzg6+4b/b7ifEsghvmnHJ+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aqd07+YbnpHfldLx4yEvgWuqQuE4w6QZmnKOAy70NHZTFLbMOlBTNHP86VdxhdW1c
         k7SIFbzalCwXCOcHypiEvWqOSTCK5vCbanOlTkU2ip6mJIsOg0WtUHYsSp8dMzYga2
         h5Vw2NomJHw6xsO3W7wfUDnA62Mi8tmMXLPu2+orSidWSgYjwOHAT92d2jFwFlcwuU
         b5wH5ozCU9SlokLHyhbRWvxQ1+ckLyvQbwjpEliLCUCso2UeT+/+ZWW//lAqS3uK8r
         qkRkoNvSlgoy00WUvkHXzfX3BqbGEIq4d8CHSQ+PMOa9gKdw96I0Iyo794/Y+LEewb
         4vitfov5lbBrw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, neil.armstrong@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: add QCrypto nodes
Date:   Tue, 10 Jan 2023 12:46:49 -0600
Message-Id: <167337640562.2173176.342116544748293344.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115-topic-sm8550-upstream-dts-qce-v1-0-fe750dfa90f6@linaro.org>
References: <20221115-topic-sm8550-upstream-dts-qce-v1-0-fe750dfa90f6@linaro.org>
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

On Wed, 16 Nov 2022 11:48:35 +0100, Neil Armstrong wrote:
> Add the QCE and Crypto BAM DMA nodes.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: add QCrypto nodes
      commit: 433477c3bf0b7f00334f4157de2a21aa4d8e46a1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
