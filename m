Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421A620600
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiKHB27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiKHB2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5052AE12;
        Mon,  7 Nov 2022 17:28:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66A2F61373;
        Tue,  8 Nov 2022 01:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B505C43143;
        Tue,  8 Nov 2022 01:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870886;
        bh=0kejGq3dHPnVBzNKmG3SGZa6SxAISssjDuv4XNWwTAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCJCjB0OqLNHvcLwVWxnQOEk+UWrjaPYQF6DtBtsoM30H8MrUvavsK9dIvO7YyOqy
         3yAO0HpWeerVi21oqE8t0hGAzhUgeOs4gllUVoQFFBNjnbWTDVQuLwLSBnjhwWG4g/
         YCicOuVPRswPmUHJiQcqElXTJk3Db0/v2vZ+rFc7bg1ULFcxD0mtQYk1I/fwZkl6xk
         XoIuaSY6ngYX48Remq7qslJNViia0PureaDT/k+hxqPOULFoZ4Ez60zLroSByLR4Ia
         MFSBli2d0uYW9V0xg2RCkZHx7qq/tbk4R9+7CgNS1ZpSgeryTHUxmf1kSIuKeWyIjg
         NBHCBXkCuvvjw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, quic_molvera@quicinc.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Cc:     robimarko@gmail.com, devicetree@vger.kernel.org,
        quic_gurus@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] Add misc support for QDU1000/QRU1000 SoCs
Date:   Mon,  7 Nov 2022 19:27:36 -0600
Message-Id: <166787084680.599230.1171387994487492434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221026190549.4005703-1-quic_molvera@quicinc.com>
References: <20221026190549.4005703-1-quic_molvera@quicinc.com>
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

On Wed, 26 Oct 2022 12:05:44 -0700, Melody Olvera wrote:
> This series containes firmware, SoC, rpmpd, and tz-log bindings as
> well as pmic, rpmpd, and socinfo support for QDU1000 and QRU1000 SoCs.
> 
> The Qualcomm Technologies, Inc. Distributed Unit 1000 and Radio Unit
> 1000 are new SoCs meant for enabling Open RAN solutions. See more at
> https://www.qualcomm.com/content/dam/qcomm-martech/dm-assets/documents/qualcomm_5g_ran_platforms_product_brief.pdf
> 
> [...]

Applied, thanks!

[2/5] dt-bindings: power: rpmpd: Add QDU1000/QRU1000 to rpmpd binding
      commit: 8aa5cac4a2e05019fed4cb7187829add0c5aded6
[3/5] soc: qcom: rpmhpd: Add QDU1000/QRU1000 power domains
      commit: 94949a014fac048591dd478a4126ce8cca6f8123
[4/5] dt-bindings: arm: qcom,ids: Add SoC IDs for QDU1000/QRU1000
      commit: 3b1611f252bb8871f2e171758f8462704b7d8d52
[5/5] soc: qcom: socinfo: Add QDU1000/QRU1000 SoC IDs to the soc_id table
      commit: 759dcdf24903f61bc46064e0f7dd8a68ea1a6376

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
