Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1210C6572C4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbiL1EiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiL1EhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D277DF7B;
        Tue, 27 Dec 2022 20:37:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 130E6B8109E;
        Wed, 28 Dec 2022 04:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28863C433F2;
        Wed, 28 Dec 2022 04:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202225;
        bh=gyWbyf+iiCLAOkoffxUbwGmzlonRhgnDy08LHRJhglg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBYH16f48YeYxNA6amH75hKtuczAq0LsydolZV4P6D1CFHBGQNdBTqk30NVQq5IM2
         xROJcjx9XngwNgSwy7E0n1WhIoXoBnYfbktlmOiPw11pzVYi+wrN/cG52ZwNuCNff2
         PsboExn69Umjqz0guLdY+fgj3C+ML9uDWlCuOSlS+MZa4s5olvaO/c/GHs2cBhFpn/
         nUt6FXR1xic7+IV8Ia+4KquFYUE1k1KObzDYzerSS/LFIxw2FCCwYGj6WZuvt2WW4R
         Q1e7MKH37U+t8UIWqPzLjzZ3U4GhOZQV7c/86IojkR31hC3lQIWUd4iO+Ii6G+AWOb
         1X2nMe85ooq/Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, patches@linaro.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add thermal zones
Date:   Tue, 27 Dec 2022 22:36:40 -0600
Message-Id: <167220221226.833009.17872992868601417504.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221209124026.178764-1-konrad.dybcio@linaro.org>
References: <20221209124026.178764-1-konrad.dybcio@linaro.org>
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

On Fri, 9 Dec 2022 13:40:26 +0100, Konrad Dybcio wrote:
> Add thermal zones associated with the on-SoC temperature sensors.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Add thermal zones
      commit: 53cb681199f4d8454335742f0c84b36ddc7483ed

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
