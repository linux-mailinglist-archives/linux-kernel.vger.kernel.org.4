Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA8B72F098
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbjFMXsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjFMXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E251D1FD5;
        Tue, 13 Jun 2023 16:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCF463C8C;
        Tue, 13 Jun 2023 23:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09712C433C0;
        Tue, 13 Jun 2023 23:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699954;
        bh=6OewYCVI5dDH/gkBN6v58uE+abpblECwvwqpz7QKooQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qZ1fDfju9O3w9vQ5oO3M0h7sZHrJwUWwr0vUO/Q7BLiwYQMktQ+v328Q5pOektsPb
         7uCuSW8oIlBE/k+oDcvWS/+CniIekR5fhfcp/+3rF4CXiE/KM8+MUthDHL7NCzWi2I
         bffG4UkQJAe9bMWxLtfRVul8bmexC+IAzaFQSjDZ7vmzti8OeE1aPJ6AGzNqAO9YSO
         i+7/tRsGgR7dH29uwwyLh3zAKR8nRYMMWlXacv0cUBh3aqLO4i7cpPgdPAFVjr93BD
         JmkngJFrLvuQoEV8NOi4qfR0CwMRgPsziDw7flwKvCIzkCVQAQnxnDqSUmQD45qm+X
         sAnbQOCMVfIEg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        thara.gopinath@gmail.com, linux-arm-msm@vger.kernel.org,
        conor+dt@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v4 0/3] Enable IPQ9574 TSENS support
Date:   Tue, 13 Jun 2023 16:48:56 -0700
Message-Id: <168670013500.1400697.11869919128133800197.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1684920389.git.quic_varada@quicinc.com>
References: <cover.1684920389.git.quic_varada@quicinc.com>
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

On Wed, 24 May 2023 15:06:08 +0530, Varadarajan Narayanan wrote:
> This patch set enables tsens in IPQ9574
> 
> Depends on
> 	https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
> [v4]:
> 	Drop the sm6375-tsens and qcm2290-tsens related bindings
> 	fix as it is already posted
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: ipq9574: add tsens node
      commit: 2e0580e10e919b544d7be1b2b8fc48fc7dff1322
[3/3] arm64: dts: qcom: ipq9574: add thermal zone nodes
      commit: 581dcbe60b6390c633f318a29db41d1df642e6d8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
