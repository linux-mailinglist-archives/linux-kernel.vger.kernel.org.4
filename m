Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01876C922D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjCZDBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZDBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE99EC1;
        Sat, 25 Mar 2023 20:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 877E460C82;
        Sun, 26 Mar 2023 03:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FFFCC433D2;
        Sun, 26 Mar 2023 03:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679799669;
        bh=nSfw0kjiNzoXi4EGYiHl5//xYiTQCf4jcCZo+tOchPQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CTOAWR6AKhsODcwWfR45G7vVJ2GURz4rwjbRqJMeAcnr8efNLhLoL4lgz58RWF/p0
         MvWuQnyPVc427U66gWMLsmDzA504GMeNu8YrOE7b0oNL+/ng7MLzY43YrM4t42SxXG
         2kxkAbTg/+D8VXtXL6/8f5HcQoa3ZtSZc3MC3WyLY2xk+NxGROrMpZ0R/cOFiVvEUe
         pdX8KEf2CjKBbS8QiLQKf8zrzTVV7D4I97IjEHJQloXBKZ3gck3djuLgeZ3neJ9wNk
         Mznqti0A8ei2ROflfZoXtJpNjMnbg2npANAaQtGf86MjkiwYmp82XTZX7OE4nd8sux
         dQdI+Dan8AEdQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/5] arm64: dts: qcom: msm8916-thwc-ufi001c: add function to pin config
Date:   Sat, 25 Mar 2023 20:04:17 -0700
Message-Id: <167979983769.3004671.15307182890891287980.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
References: <20230324202244.744271-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Mar 2023 21:22:40 +0100, Krzysztof Kozlowski wrote:
> Bindings require pin configuration nodes to have the function, even if
> it is GPIO:
> 
>   msm8916-thwc-ufi001c.dtb: pinctrl@1000000: sim-ctrl-default-state: 'oneOf' conditional failed, one must be fixed:
>     'esim-sel-pins', 'sim-en-pins', 'sim-sel-pins' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> 
> [...]

Applied, thanks!

[2/5] arm64: dts: qcom: apq8096-db820c: drop simple-bus from clocks
      commit: 704e26678c8d50d8988e30a47edddbb361e9e973
[3/5] arm64: dts: qcom: msm8994-msft-lumia: drop simple-bus from clocks
      commit: 5574a5022df4cf67fdcf8c94bfbafb2cc296beee
[4/5] arm64: dts: qcom: msm8996-xiaomi: drop simple-bus from clocks
      commit: 338958e30c6897b7978019b5ea3fa1897cd511ba
[5/5] arm64: dts: qcom: sdm630: move DSI opp-table into DSI node
      commit: a2e5260d07555834d14431399cefdd3220b917d6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
