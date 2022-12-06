Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A707644B70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLFSVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiLFSUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:20:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F35BE08;
        Tue,  6 Dec 2022 10:20:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 562E6B81B30;
        Tue,  6 Dec 2022 18:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6620CC4314A;
        Tue,  6 Dec 2022 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350807;
        bh=lgYoD8/i4UnJC2BPfJWsDzYIgY0gjLUfb/4Ehqnsjwc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U0CKr3LGuugRcsc0zcWe6vl/C0zyENsAqYIOHex65VXaiAKrxjQUHAjoKSku0uiUN
         D8uyXJp1Dj0eXbolBqQaPKdVrH5LDi2Ij1wJ80/gPhRPgczAGlkiLRKRbF7M2TTZwp
         9S1tHbi/RNmX8ZgqL97+EP3NW6dZHoMM06BjcaXdrgEo1C107l41wKX6u5KAdEZ8po
         b9BENf74I5gd4vSIrbAR7DlzkFlzDEjf0ki+l31781MZNanjmkXIqLxyhEvEywKFD4
         eW3XCqJteGDLSYa/meaoumXIkV/tePQ64CLxUZiJ6qVKGZF3SQnQo4no/JMaLBzfgJ
         rIT+iaSHXHASw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH 1/6] arm64: dts: qcom: sm8450: align MMC node names with dtschema
Date:   Tue,  6 Dec 2022 12:19:12 -0600
Message-Id: <167035076354.3155086.4457425583543050504.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
References: <20221204094438.73288-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 4 Dec 2022 10:44:33 +0100, Krzysztof Kozlowski wrote:
> The bindings expect "mmc" for MMC/SDHCI nodes:
> 
>   qcom/sm8450-sony-xperia-nagara-pdx223.dtb: sdhci@8804000: $nodename:0: 'sdhci@8804000' does not match '^mmc(@.*)?$'
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sm8450: align MMC node names with dtschema
      commit: 4b660ee5d0e9b9c8c61ceea285fd437bc0f3c673
[2/6] arm64: dts: qcom: qrb5165-rb: fix no-mmc property for SDHCI
      commit: 1821f483f666049eacc5812c5cae36c29659c1ad
[3/6] arm64: dts: qcom: sa8155p-adp: fix no-mmc property for SDHCI
      commit: f50f5a817777185c7d0bbc03e2dafbde25e98428
[4/6] arm64: dts: qcom: sda660-inforce-ifc6560: fix no-mmc property for SDHCI
      commit: 6e36e6c6b3d15442b0fed406f2449f00e0a01c1a
[5/6] arm64: dts: qcom: sdm845-sony-xperia-tama: fix no-mmc property for SDHCI
      commit: 796d8eaa165a8573dcc0a966c7845c67f7918e27
[6/6] arm64: dts: qcom: sm8250-sony-xperia-edo: fix no-mmc property for SDHCI
      commit: afa8e18bf674f00c8c3a73e295ff2f6aacdad82a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
