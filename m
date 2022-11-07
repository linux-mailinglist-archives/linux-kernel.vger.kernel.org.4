Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0768461E96B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbiKGDPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiKGDO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D604A12639;
        Sun,  6 Nov 2022 19:13:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41FC760EA3;
        Mon,  7 Nov 2022 03:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E51DC433D7;
        Mon,  7 Nov 2022 03:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790795;
        bh=0C/zbEncLKIgdwTUgPdnJzB1OdI/BNrdVQy8KMAVTnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rzKEHCYTm6agWkPhLLAlZIT8HDWZmylleqE+pLE5GDaVzmWR9BuSGQ/Bu+D2JAXHu
         7Y8AiNYgXrEpl72oyueU+IEB+LGdEWJGMtivC0/TA8o9L+pIn2MYICjdBXoBAL8dMJ
         8oEwnkRl7qOo8rF4ZZBadbN0C8gDk/R3zez07spjI8/15iNKEADJCIX98DG53pqoLh
         bSFNe5Vm7wshc4eyLXYIDXX+KT3XOAooItL0gnZB6V0qVYzoLQYFQic1NI7Wz+LmwU
         JHuoleNNFJlZiLM/cGtYDzaGWZZTvISSWwrPRroGhwnk8qBd13Q+/FxiemGTO3iwc4
         hx9gmjwAwAfVQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
        konrad.dybcio@somainline.org, alexandre.belloni@bootlin.com,
        dmitry.torokhov@gmail.com, lee@kernel.org,
        quic_c_skakit@quicinc.com, Andy Gross <agross@kernel.org>,
        neil.armstrong@linaro.org
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 00/11] arm: qcom: mdm9615: first round of bindings and DT fixes
Date:   Sun,  6 Nov 2022 21:12:32 -0600
Message-Id: <166779074262.500303.9983316398546692832.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
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

On Fri, 21 Oct 2022 11:06:36 +0200, Neil Armstrong wrote:
> This is a first round of trivial bindings & DT fixes for the MDM9615 platform.
> 
> This first round focuses on trivial changes, the remaining work will
> mainly be .txt to .yaml transition of old qcom pmic & co device bindings.
> 
> 

Applied, thanks!

[01/11] dt-bindings: arm: qcom: move swir,mangoh-green-wp8548 board documentation to qcom.yaml
        commit: f4ec5f28af13e2b8e62ae173cb6827e137cdd8cc
[02/11] arm: dts: qcom: mdm9615*: add SPDX-License-Identifier
        commit: c69af934db18ad165b1dc84f5450fa55afb34acb
[03/11] arm: dts: qcom: mdm9615: add missing reg in cpu@0 node
        commit: e58bdf93db08c16dd06bc1967e978708b44d9c83
[04/11] arm: dts: qcom: mdm9615: remove invalid spi-max-frequency gsbi3_spi node
        commit: 75353420d0d0abe3a57cedf4a6cfa00ea05842a3
[10/11] arm: dts: qcom: mdm9615: remove invalid interrupt-names from pl18x mmc nodes
        commit: 3627dd180c67d3e589c38a10b4be29a0352a70b6
[11/11] arm: dts: qcom: mdm9615: remove useless amba subnode
        commit: 10de96ba6d4287220962cdd82826b6a14af90e2e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
