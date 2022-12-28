Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80196572C7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiL1EiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiL1EhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6192BC83;
        Tue, 27 Dec 2022 20:37:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44CCF61238;
        Wed, 28 Dec 2022 04:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132A9C433F1;
        Wed, 28 Dec 2022 04:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202229;
        bh=HqtHfNbFIcx7VcBXirpwBar1yoI+sA1t+MoXty8P9OU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=K5vJNWIurYRdH6KeHYCjykqltwnpiqs8SzsFioCLkNgEelLLBli3vqK/hyetwwNPN
         oh2gPbmZ86Vi09T6yt64uWacQ46iEhGiCF93Cw5akbJ+q5LSBC66wQYO0imTN5661k
         RXoRyVFwp9jNkm3gLv3Lkm4KEXrvVlxH7rkjfKaXFTswut2rtmTZvTr8bpTG6n2eCi
         HHL74RM+/HHhAtfpPNcRLHDo+aYgr7rFt00W3lYSbq4Od+wxsDTnnwjO6ALEpu5RRm
         DA62gEs0x8i37Z1iaEopvQoPW64goL07Hf4k6Hnh4A3eb5RTKWl0yjFXs0BRm2XUHi
         1xBGLZjVTCNBw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: drop 0x from unit address
Date:   Tue, 27 Dec 2022 22:36:44 -0600
Message-Id: <167220221234.833009.18058685359524053781.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221210113340.63833-1-krzysztof.kozlowski@linaro.org>
References: <20221210113340.63833-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 10 Dec 2022 12:33:40 +0100, Krzysztof Kozlowski wrote:
> By coding style, unit address should not start with 0x.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sdm845: drop 0x from unit address
      commit: 1629063ec9d8a32111a63ce7250a7781376c492a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
