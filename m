Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D077174CBB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjGJFF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjGJFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2EAE79;
        Sun,  9 Jul 2023 22:04:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C43260DF2;
        Mon, 10 Jul 2023 05:04:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA66C433C8;
        Mon, 10 Jul 2023 05:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965477;
        bh=MxGrENumOFffk+N1Xf8T4/vqc4pNVU5wJSNvpWSso2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWGj0JGEhTsia7pT2aUpeoBifY2DvwSn2MivdNctqNd/7boxR/IkSm2UkWrDrPSPW
         /Jl9/3O9RvGY8Lelfm1EseT3KZaZAJpSDiS6kdAh0ByXES7xY50HA2QqlM0piDNyKa
         Y6qLXtlqqzf8GEFF7FEKlRBUh6Vt84GualeIJmZz8FMy5K9IgFzZ/OMS0f6hqTNznW
         m484ohYkE+IxtX78QA05+4uoXQA+v8Rh7anQwt03W9VdjrsUHU2iOMlOUzz5SdoKNf
         MQKURFT71u+gJ3G4ewQf/MCuSj7Sen/puxbpUR5LU7VWyxATI0F8uXuXP/pCb3UGOF
         tVzwXMvJN11og==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix cluster PSCI suspend param
Date:   Sun,  9 Jul 2023 22:07:17 -0700
Message-ID: <168896565989.1376307.9376526006212734705.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705-topic-8180_sleep-v1-1-c5dce117364e@linaro.org>
References: <20230705-topic-8180_sleep-v1-1-c5dce117364e@linaro.org>
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


On Wed, 05 Jul 2023 17:00:05 +0200, Konrad Dybcio wrote:
> The value was copypasted from 8150, but 8180 expects a different one.
> Confirmed with both downstream device tree and Windows DSDT, not tested
> on hardware (sorry, I don't have any).
> 
> Fix it.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: Fix cluster PSCI suspend param
      commit: 9c31a3f5abc9eeb6509d06041b1e5f12deb39c4d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
