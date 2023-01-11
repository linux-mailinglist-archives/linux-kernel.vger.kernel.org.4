Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ADE665397
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjAKFVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjAKFST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C3F13F3E;
        Tue, 10 Jan 2023 21:10:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD4FD61A32;
        Wed, 11 Jan 2023 05:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86250C433F0;
        Wed, 11 Jan 2023 05:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413809;
        bh=FMmooJC82133mh4+J+zRHYqZUoPMaXsCh3d+8hHdSTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJb6WIHkpxE6Wu9jp9LU3N0Msami8xEueJu2cAW0m7Qep2j2VPtrQ/PX70f4uC0+G
         RQZwoMXHrzBsZvn0sB3du5LT+inTUysGDiIm7a6/Oi5ZAMH/QYdc/xmnfEpUybI/dB
         bdxW5TvPAG6cPACu/CoAXJU+pF9qAVJc9z5mOVtILrh7OAER6EgzYPnGvAuS9wDd9e
         vlu3S1D8k2KyHbV5+WOSSHo3aHm2rzE8N83rylCVxeumwP6n39gcVxrX+F9nbLgEg1
         oAbmsz5aoPjkghMpZW0oODvPz3+/7+BadkDQMykGLPS6cSyJwYGI+uMHcwobPii1bN
         wSNSkFsvJka8A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@linaro.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/6] arm64: dts: qcom: sc7180: order top-level nodes alphabetically
Date:   Tue, 10 Jan 2023 23:09:34 -0600
Message-Id: <167341377721.2246479.14083887855032501187.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
References: <20221212100232.138519-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 12 Dec 2022 11:02:27 +0100, Krzysztof Kozlowski wrote:
> Order top-level nodes like memory, reserved-memory, opp-table-cpu
> alphabetically for easier code maintenance.  No functional change (same
> dtx_diff).
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sc7180: order top-level nodes alphabetically
      commit: 41d31fa487fe684ef130d002956b7915584cbabb
[2/6] arm64: dts: qcom: sdm845: order top-level nodes alphabetically
      commit: 3bd21131d884b58c0c14926a710241c521352346
[3/6] arm64: dts: qcom: sc7180: move QUP and QSPI opp tables out of SoC node
      (no commit info)
[4/6] arm64: dts: qcom: sdm845: move DSI/QUP/QSPI opp tables out of SoC node
      (no commit info)
[5/6] arm64: dts: qcom: sdm845: move sound node out of soc
      (no commit info)
[6/6] arm64: dts: qcom: sm8250: move sound and codec nodes out of soc
      (no commit info)

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
