Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7150A61E907
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiKGDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiKGDMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91552DFE5;
        Sun,  6 Nov 2022 19:12:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C291B80D91;
        Mon,  7 Nov 2022 03:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E326C433C1;
        Mon,  7 Nov 2022 03:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790766;
        bh=9/AsxXnijfTLUh1a5w7PmiD/VENiJxRi5sQjZwSWcqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pv+bE+gfF2MZiuWVdVUQle8IJCEAcy3QJZTmoEcIdXsEnd8dSVT7e/Ag9u81uSOeI
         225CRRreZEyaDbLf0IC13rqjiuB5/1Dynzx7RgY5oTJgGxWlYajLxA/kpy0V2D/dfH
         UN5pVELoaQCdeAdbJYFQJucsGIMTqI7eBw0MXpsX8W362bTQ8oiEqo4NbT85ddmeu5
         F0jFAR18VcceQUE8EJKL9wC0lg+NJP3EjkiReWj/mhdfd+YTe48W1UdLtVvmKu6SpQ
         alEuX0R/LUZ1dfr6l7q1m6eZ77iHHB58o3oKIsOeg1pKQsxQN74nSKlyQf0nC3SGU5
         q0Kyjbn1+dQmA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     dmitry.torokhov@gmail.com, broonie@kernel.org,
        Andy Gross <agross@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        linux-kernel@vger.kernel.org, bgoswami@quicinc.com,
        srinivas.kandagatla@linaro.org
Subject: Re: (subset) [PATCH 1/6] arm64: dts: qcom: msm8996: fix sound card reset line polarity
Date:   Sun,  6 Nov 2022 21:12:03 -0600
Message-Id: <166779074266.500303.5490507913872370004.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
References: <20221027074652.1044235-1-dmitry.torokhov@gmail.com>
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

On Thu, 27 Oct 2022 00:46:47 -0700, Dmitry Torokhov wrote:
> When resetting the block, the reset line is being driven low and then
> high, which means that the line in DTS should be annotated as "active
> low". It will become important when wcd9335 driver will be converted
> to gpiod API that respects declared line polarities.
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: msm8996: fix sound card reset line polarity
      commit: 76d21ffc5d425bf7ea9888652c49d7dbda15f356
[3/6] arm64: dts: qcom: sm8250-mtp: fix reset line polarity
      commit: 15d9fcbb3e6e8420c7d1ae331405780c5d9c1c25
[4/6] arm64: dts: qcom: sc7280: fix codec reset line polarity for CRD 3.0/3.1
      commit: 1caf66104c02d327a2467a69ab18fb24b44e9715
[5/6] arm64: dts: qcom: sc7280: fix codec reset line polarity for CRD 1.0/2.0
      commit: b8f298d4f69d82119ac0d22809a17c80b1f188d1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
