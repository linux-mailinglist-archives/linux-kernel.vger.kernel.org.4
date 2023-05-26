Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37375712DA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjEZTfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244035AbjEZTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:34:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386DFD9;
        Fri, 26 May 2023 12:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C6B6530B;
        Fri, 26 May 2023 19:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9AAC433EF;
        Fri, 26 May 2023 19:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129690;
        bh=G09ZTIzKPzsQdcjQ3fudG7fCISo/vDgzr6/S0QbLDvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gnttz+lvElRqBZa2N186qi7hx3sQxECPv03Vz1Eq7Ubfo2Q2QNrQLcFYbfNuxhd4R
         NR7AujtVFgTBXibXxhFd07Disw4ZSeNMUk93gvsgF7h46oT+CcACIZh82f0ujii0xa
         s8huHn6tRzKoEv7ZWeD8gqYWfWnS7ZsU3vjtfdQ2ciFpFSQJCOpJ61yY+8Pbrp7Y+L
         I8iz/bOcZ4duiodJhjmBxtp3Qhe0w1zIiNoXnSe2ENUw5fOQ5S6n6NQ38mZ4Ihm5eg
         7YztvvTdfTPHLLiXw9uoloYIKIsyJr2xi2+lDTo+mGmwe66EMleO4/4hHREZyp25a6
         HN29Fc7QBJb5g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_arajkuma@quicinc.com
Subject: Re: [PATCH 0/2] Add initial support for RDP449 of IPQ9574 family
Date:   Fri, 26 May 2023 12:38:31 -0700
Message-Id: <168512991479.248818.14593270187862446581.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516135013.3547-1-quic_devipriy@quicinc.com>
References: <20230516135013.3547-1-quic_devipriy@quicinc.com>
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

On Tue, 16 May 2023 19:20:11 +0530, Devi Priya wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 449 based on IPQ9574 family of SoCs. This patch series adds
> support for Console UART, SPI NOR and SMPA1 regulator node.
> 
> The series depends on the below patch sets which adds support for
> SPI NOR and SMPA1 regulator nodes.
> https://lore.kernel.org/linux-arm-msm/20230329053726.14860-3-quic_kathirav@quicinc.com/
> https://lore.kernel.org/linux-arm-msm/20230407155727.20615-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document AL02-C6 board based on IPQ9574 family
      commit: 2e4cd263b97d0254e6bbd88b2feb4df6c4a9ad0d
[2/2] arm64: dts: qcom: ipq9574: add support for RDP449 variant
      commit: aa261f13dae60850be30de95c7eb6ffb6059a6b7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
