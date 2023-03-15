Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375516BC13E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjCOXdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjCOXdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE05A26C0D;
        Wed, 15 Mar 2023 16:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD8B61ECA;
        Wed, 15 Mar 2023 23:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCFCC433A7;
        Wed, 15 Mar 2023 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923151;
        bh=zsCo8PRAuCu3L013TIzei1I1N89ExJiAAD0ecw4R4F4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UciPNDUS6kF+uIPY9e2FQujq7cWrlrafJlk+M9iomXDcA0+Oztux3Ig+xy/ESi1Iz
         3lKItyOa3X8jWkuI8Qkg4+2aR0E3AYINImuCl5CoHRf6h53njpyU3oVsw5HVoO6VWp
         jI2Sf5FMl+bndzOlm43Rr8zUyCCWlqRpYiqEa1yHsL/Ac94cMeKfQ733qqCqmO4WAP
         RogKGUHk1RSmVLTqeld0z965bisOx9WznKRDaerNri/WNZDPtyMu9DIltlitpPHSjR
         5op7xgeNnyQBP96fl2DHnt3s0rsyY5j1aBaW92YXd9QsltQiHBYMddhS18C1YWlvd/
         Qej9zoYjWr1aA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pm@vger.kernel.org, marijn.suijten@somainline.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: power: supply: pm8941-coincell: Add PM8998 compatible
Date:   Wed, 15 Mar 2023 16:35:01 -0700
Message-Id: <167892332565.4030021.17653631572421416966.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
References: <20230214090849.2186370-1-konrad.dybcio@linaro.org>
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

On Tue, 14 Feb 2023 10:08:47 +0100, Konrad Dybcio wrote:
> Add a specific compatible for the coincell charger present on PM8998.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: pm8998: Add a specific compatible for coincell chg
      commit: 0d589dc92fca4679186a949194fc7c452d37c575

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
