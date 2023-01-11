Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4866538F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbjAKFUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjAKFSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B02D13E34;
        Tue, 10 Jan 2023 21:10:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0859F61A32;
        Wed, 11 Jan 2023 05:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF47C433D2;
        Wed, 11 Jan 2023 05:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413801;
        bh=MF1tBZYpAirPa41ogHfkHDj1UFdM+E3tKd7X2BLN7p0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/LKhFxeMN1/ufSZ+SfvJex2RSNf/IQGjamJ2tY4yD9tasYiAs6I65KPO1WG+7t1G
         y1uLVHJ7OpE4S/pyNMDoUX9BRNdDZHLoYO0Os+ncuzjSEXrhmCrmnf25TYKw1ayYWM
         smBak2119o+oH4a4ujWiUXMn3+X4RDb22BoDeciDRZrXulNMOSHB0Wt/zzCNq45B/I
         79jFGvgT9pqsYAPAigBLiVPm43En/xNm+xAxO1dnsiO/AzJygWlRdN7GKet171icWy
         vJk7pWlD/0QvhVpTdHjanrGowe1+MxdHJieMH+3PdhbCtWRov76skI9P1WoUzQ270+
         wEpGRib9fP77A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        quic_gurus@quicinc.com, konrad.dybcio@linaro.org,
        robimarko@gmail.com, devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     quic_molvera@quicinc.com, quic_sibis@quicinc.com,
        abel.vesa@linaro.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: firmware: qcom,scm: document MSM8226 clocks
Date:   Tue, 10 Jan 2023 23:09:26 -0600
Message-Id: <167341377720.2246479.6269683759874106588.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221122092345.44369-1-krzysztof.kozlowski@linaro.org>
References: <20221122092345.44369-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 22 Nov 2022 10:23:44 +0100, Krzysztof Kozlowski wrote:
> Document the clocks (core, bus and iface) used on MSM8226 SCM.
> 
> 

Applied, thanks!

[1/2] dt-bindings: firmware: qcom,scm: document MSM8226 clocks
      commit: 8f3945a9adce3934943b365bcd5ae2932737f028
[2/2] dt-bindings: firmware: qcom,scm: narrow clocks and interconnects
      commit: c5b8840c895a5b0291ef84e3f13d92c3414033e7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
