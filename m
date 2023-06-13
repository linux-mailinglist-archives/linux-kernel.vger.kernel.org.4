Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2732172F094
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjFMXsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbjFMXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C631FD0;
        Tue, 13 Jun 2023 16:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6767C63C82;
        Tue, 13 Jun 2023 23:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DBBC433C8;
        Tue, 13 Jun 2023 23:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699952;
        bh=zMyTg6KaBumWFyOKFqk/fYyhan7XIFKyUheHwbOaInM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUYCz7XMWPbMGctRqwxAvg7kb2kM4qGSRkio7OoJzHiyUXwZbzKOv/jfr9rRwkxnt
         4pGZffR9D/KKYOU8JPD2hg65o1uXp7wvLVs7kiAd+aEiWEeaz3Bo/pl1O8ROxOJGuj
         OTLdF7n2vrzDvsCkT8ni6SZOquvlFhPvWcpfzWR0PlsL4Jnf5xW8Iv8vGrRk0kZO14
         4sMWMmvrspvY1Io1qyPh54+f8n0wIosRqo0l9/bophtxHkQDJOKHwahZUpFDJVpwWF
         Xl96O6kPtM9sLTBI3dzCk2/kNhjHSE9z3gZ1pLiJkq6viU8Vhd75yLb0KWZvftK98s
         qzDfuV37b71qQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, conor+dt@kernel.org,
        agross@kernel.org, robh+dt@kernel.org,
        Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_anusha@quicinc.com, quic_gokulsri@quicinc.com,
        quic_devipriy@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com
Subject: Re: [PATCH V2 0/2] Add initial support for RDP454 of IPQ9574 family
Date:   Tue, 13 Jun 2023 16:48:55 -0700
Message-Id: <168670013503.1400697.3222021805998110269.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531032648.23816-1-quic_poovendh@quicinc.com>
References: <20230531032648.23816-1-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 08:56:46 +0530, Poovendhan Selvaraj wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 454 based on IPQ9574 family of SoCs. This patch series adds
> support for Console UART, SPI NOR and SMPA1 regulator node.
> 
> V2:
> 	- Change logs are added to the respective patches.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document AL02-C9 board based on IPQ9574 family
      commit: add687cbfc3482ca74949b91b251e76792d25652
[2/2] arm64: dts: qcom: ipq9574: add support for RDP454 variant
      commit: 2435d79033f5e7400195ed3b31585c0c053de553

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
