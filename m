Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF666BC463
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjCPDS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjCPDR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F1C96C03;
        Wed, 15 Mar 2023 20:17:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66C7BB81FB2;
        Thu, 16 Mar 2023 03:17:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43694C433AE;
        Thu, 16 Mar 2023 03:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936673;
        bh=Wk57dwbrCOg+FxfNA7ozQtUZAL9QXmcmd3RcIXWJQNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNRnW3koBvvsyKrCpUihpstpIP+sqnUYqCAaDSv9ql3m1SSozgS6KQoWWnARANomE
         XIv99rvtZeICxcQY+qbI3Dikr8m2vh14bdLMroxr/qAviBsaruXJ9Kqhq2STrdvqBW
         XP4Yf2ejj0HcO+z0H74CDxBckI50M2PKdvXbEiUp0KOkihnRJmjVpDtKqiMN6Lm0Je
         SRiNwZ1rXolw8bLJIPFgbQCWZiis4wFD/GOStZJ8c/kvukjc/GkErK4r9+bkgZeELH
         IB2gbs/IDS6OHI71hPTqGoqgASGyf5PIP4wlaYmxvTrl6xGqXVFfwtOCWUNn+zjHrW
         Q1fH7B2x27I9Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: dts: qcom: sm8550: various DT fixes
Date:   Wed, 15 Mar 2023 20:20:57 -0700
Message-Id: <167893686411.303819.14530526070856919556.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308-topic-sm8550-upstream-dt-fixups-v1-0-595b02067672@linaro.org>
References: <20230308-topic-sm8550-upstream-dt-fixups-v1-0-595b02067672@linaro.org>
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

On Wed, 08 Mar 2023 09:32:51 +0100, Neil Armstrong wrote:
> Various DT fixes to enhance redability and unify the DT style.
> 
> No functionnal changes expected.
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sm8550: fix qup_spi0_cs node
      commit: 7629c7a525d163f2a3a08e260a69ff25163ab357
[3/3] arm64: dts: qcom: sm8550: misc style fixes
      commit: f03908b23f84ecd49f12facf4acf34c3ad24f27a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
