Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5467061E925
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiKGDNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiKGDNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D868710050;
        Sun,  6 Nov 2022 19:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63E5360E9A;
        Mon,  7 Nov 2022 03:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CE7C433D7;
        Mon,  7 Nov 2022 03:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790774;
        bh=vck/dTgRsPMhwjpYT1+4UTPXDqEFhAKxsL5FdT6aRow=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KhzCg2IjGdhpw9djl11UOrBZs72NVxGc0aoPliVNs7rz0iQlsY6FzrGfkX6lNW4H4
         lrDilBpoOtHuEyJJkQl7Srsbj3/bAtfDfrrCDQQPLrDZL4Tzp5Nzrq1wZncGlwXMs0
         se5GxXbT8ILXuYalgz1j1V99rAMUyDCVHZsowzlj8Ui+bD7aEREg6k1EAol4TqGfPQ
         9jLMR+EylSYYrIgnjoHRU8pSenEiYDe+sKaXKVyYpJ/CyB6bCWO65inZu28+/gM3gF
         ojpEJIk9hK1n0TZwdk5HSRX8QLI4H+mZt/IqJTQrSRPzSMFcGp8f+e8lqHHnufRpRJ
         QaJRwBqx/nE4g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: pinctrl: qcom,msm8974: convert to dtschema
Date:   Sun,  6 Nov 2022 21:12:12 -0600
Message-Id: <166779074258.500303.319566337229601023.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221017012225.8579-1-krzysztof.kozlowski@linaro.org>
References: <20221017012225.8579-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 16 Oct 2022 21:22:24 -0400, Krzysztof Kozlowski wrote:
> Convert Qualcomm MSM8974 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> 

Applied, thanks!

[2/2] ARM: dts: qcom: msm8974: align TLMM pin configuration with DT schema
      commit: d6e437c5895e09c0e6876a6809b604c411d37c4d

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
