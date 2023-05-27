Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728F471325A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 05:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjE0D51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 23:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjE0D47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 23:56:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31EE13A;
        Fri, 26 May 2023 20:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B4F64FFC;
        Sat, 27 May 2023 03:56:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D07C433A1;
        Sat, 27 May 2023 03:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685159816;
        bh=4zcimyS/54SHaXCgjVayQysRRjyw89yeexS2g/HYPQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZdymY8jtinU9Ye3KJ1Ni2MSmdjQ+0DS+gUlrGxzHOgvYrN87z+QBhVRNZu2wwNAZ
         5rTyB6+z4hzdwigVJ8sQ7f+PqKTj/v7j0L8PKkKmnFknozWh8rBUKPtoj6cqvQByae
         Oz31NQ2ZCVTRCbCEOU/siO36j/HXmK3RqexpwIXMI2hYrL1tulOR26UK9jq4aHZFJd
         iOnH6B/3I3gvJ37A1rZmVWDn4JA2LIZHB/ZgCfNEchPCSWaCPSH9hu3sRstgteaLSD
         ZQyCT53c1gKjC0gbL5Z4ijqY8eJ+rdZvRt7ZW4a2M8B+LamwIjOMFCj8bBx0DYP4pP
         eRIODLwRB2Wmg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     conor+dt@kernel.org, robh+dt@kernel.org,
        Shazad Hussain <quic_shazhuss@quicinc.com>, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH v1 0/5] dts: qcom: sa8775p: add missing qup id's, i2c,
Date:   Fri, 26 May 2023 21:00:38 -0700
Message-Id: <168516003597.405989.11870529361948309917.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526133122.16443-1-quic_shazhuss@quicinc.com>
References: <20230526133122.16443-1-quic_shazhuss@quicinc.com>
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

On Fri, 26 May 2023 19:01:16 +0530, Shazad Hussain wrote:
> This patch series adds the qupv3_id_0, qupv3_id_3, i2c, spi and uart
> nodes that are missing on the sa8775p platform.
> 
> i2c11 is enabled for A2B controller and audio port expander.
> 
> Shazad Hussain (5):
>   arm64: dts: qcom: sa8775p: add the QUPv3 #0 and #3 node
>   arm64: dts: qcom: sa8775p: add missing i2c nodes
>   arm64: dts: qcom: sa8775p: add missing spi nodes
>   arm64: dts: qcom: sa8775p: add uart5 and uart9 nodes
>   arm64: dts: qcom: sa8775p-ride: enable i2c11
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sa8775p: add the QUPv3 #0 and #3 node
      commit: 07e3e17205794c8df6b55c65117ca6a6502a37d7
[2/5] arm64: dts: qcom: sa8775p: add missing i2c nodes
      commit: ee2f5f906d69d96350c2b59fddef75a76d23e877
[3/5] arm64: dts: qcom: sa8775p: add missing spi nodes
      commit: 1b2d7ad5ac14df4657e629a0b681fd966d43a74e
[4/5] arm64: dts: qcom: sa8775p: add uart5 and uart9 nodes
      commit: 445a523d462432dd9001c899e2c3ced60d23994b
[5/5] arm64: dts: qcom: sa8775p-ride: enable i2c11
      commit: a1f6bef21355da77101eca1a35c30408ad74ef67

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
