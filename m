Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81546572CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiL1Eim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiL1EhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462CEE08F;
        Tue, 27 Dec 2022 20:37:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25013612FD;
        Wed, 28 Dec 2022 04:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C60C433F1;
        Wed, 28 Dec 2022 04:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202233;
        bh=dMgjHMFP/udaIvqjMjU8io9btLdmjvs7GtVLXgVGp6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+bZRBdVjoV+bjQ9hCJ03IOrk0Ami4+aO/rmwdaa1YQ/8MiOFxCYic21KPY8qWJxQ
         RTcXNOy5U08c/WHTTets2KXNMw06JYjf83fSiPROB8ApJUDVUIykZ3SzaNSqknIxme
         VvsijYF5PunxfWSpI+R8hNkfewBFU9FUG7GcPFSgiuG2kJ60ubF/se8vRD1iqPSAEt
         QotUXWW2xkKTR/6ai+R/vo/qwhPgJw3gn6LyIIBZgvcSVHCcQ7seu4bKPF5shLyeAI
         9OELShqMGspHYwZsFR9j3WGMOAAyaMg+H5GTLOseza/6hJK4Laez0rw9cEdjcxOG2b
         0Vd/bQ4mtPoJg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca.weiss@fairphone.com, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm7225-fairphone-fp4: Add pmk8350 PMIC
Date:   Tue, 27 Dec 2022 22:36:48 -0600
Message-Id: <167220221223.833009.8034444531024706668.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221207084045.270172-1-luca.weiss@fairphone.com>
References: <20221207084045.270172-1-luca.weiss@fairphone.com>
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

On Wed, 7 Dec 2022 09:40:45 +0100, Luca Weiss wrote:
> The PMK8350 (which is actually a PMK8003) is used for the RTC and has
> ADC for thermals.
> 
> Since the adc_tm compatible used in PMK8350 is not yet supported, skip
> configuring that and the associated thermal zone for now.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm7225-fairphone-fp4: Add pmk8350 PMIC
      commit: 582e7c1026fa848a918a1db159bcae7c5fa7f0ce

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
