Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA71712DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243249AbjEZTf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243668AbjEZTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:35:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7E19A;
        Fri, 26 May 2023 12:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C15E86530B;
        Fri, 26 May 2023 19:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C3DC4339E;
        Fri, 26 May 2023 19:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129698;
        bh=QC/gLQrIWF9SsSIBK579yYw1z9IgxvBWc5x6hhQBn04=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a22nk2VlvKG7gmt2/QXazV8GVFIaAk72DMrTBwzN96Wf2sf1CWYUWs29j8Bh2Wk3s
         Wy/ZO/6YC0YOHe9ewaLy00J6izsLgU3wEnQMmOX3mjNVr2JpCLdi+0k3qVKvCZKyeY
         8BTf3hkTms0qcQhW0/OriWPTTN4TTL3vv1itluEVvqglfyM1XLMdcSu9Pj1JmdW5Ac
         JxY//zjBHjoKKcUnd1AGH0Xfovx8xdQA77aEE3OTKPkf3ZA6+jlkd9WUNpElTwWGwV
         67BVRopSCSZrg6chUSCAcPCv+bcDHrgNN/ZBCtxv1D28XVErJ8gYXgLh1dMZuXtqug
         EqTFByVDVaHFQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@linaro.org, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, robh+dt@kernel.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] Add few device nodes for IPQ9574 SoC
Date:   Fri, 26 May 2023 12:38:37 -0700
Message-Id: <168512991478.248818.9749939495960565023.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329053726.14860-1-quic_kathirav@quicinc.com>
References: <20230329053726.14860-1-quic_kathirav@quicinc.com>
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

On Wed, 29 Mar 2023 11:07:24 +0530, Kathiravan T wrote:
> This series adds the support for QUP peripherals, PRNG, WDT for IPQ9574
> SoC.
> 
> This series depends on the below one
> https://lore.kernel.org/linux-arm-msm/20230328102013.21361-2-quic_poovendh@quicinc.com/
> 
> Kathiravan T (2):
>   dt-bindings: watchdog: qcom-wdt: add qcom,apss-wdt-ipq9574 compatible
>   arm64: dts: qcom: ipq9574: add few device nodes
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: ipq9574: add few device nodes
      commit: 9ef42640504e09ecc79530b6e532ebf48305516b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
