Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C706BC1A0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjCOXli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjCOXlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:41:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD3CACB9D;
        Wed, 15 Mar 2023 16:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70B0DB81FB5;
        Wed, 15 Mar 2023 23:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803A3C43325;
        Wed, 15 Mar 2023 23:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923173;
        bh=v2/8J7xGzzoMS4ou1QINsReCB09bsP+fjMnbDKHp+4c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Veqdk3XcW4vIj+sOlJIX8TWVFhG2TaQbp+9XCLQXeWKP1YGYYXv+Tz4qkqL922qRM
         7YaVPwUBeCxGpvmw+i5TGJzeaeB9Ql+RHrkwmX4nZ4Sm0bx/kOiqZ4+b5e/meuWG9k
         VaI5C1H8sTqwX5c/OhPaNVkOxxBd/fFjrttoZI5+7632Lg8UOqgFdoqo9GNiMn6Bau
         1ToYdovEixnFJtUPxEfshWeNk+EP2Do+8EuAVzD/F3+QYSzNpTciidPVWZwdTgzISY
         lkJ8Nb3903ejYMy2viyoEF6raiqg8bQ18vN5J/ow84W09Ea0KWShxnjX9SR/vbxnI+
         EHjCakwTuywhA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        agross@kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: Re: [PATCH 0/2] socinfo support for IPQ9574 family of SoCs
Date:   Wed, 15 Mar 2023 16:35:23 -0700
Message-Id: <167892332567.4030021.2869386250711103647.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <1678774414-14414-1-git-send-email-quic_varada@quicinc.com>
References: <1678774414-14414-1-git-send-email-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Mar 2023 11:43:32 +0530, Varadarajan Narayanan wrote:
> This series adds support for qcom-socinfo for IPQ9574 family of SoCs.
> 
> Functionally this series needs SMEM support added in
> https://lore.kernel.org/linux-arm-kernel/20230216120012.28357-1-quic_poovendh@quicinc.com/
> 
> Varadarajan Narayanan (2):
>   dt-bindings: arm: qcom,ids: Add IDs for IPQ9574 and its variants
>   soc: qcom: socinfo: Add IDs for IPQ9574 and its variants
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom,ids: Add IDs for IPQ9574 and its variants
      commit: fd972da1b228974f788c115d37abe209828ca5a9
[2/2] soc: qcom: socinfo: Add IDs for IPQ9574 and its variants
      commit: c6653d8f24f4bcc255e3ffb28c629ff5d0e0ba13

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
