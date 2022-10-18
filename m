Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5EE60221B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJRDKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJRDIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C3E9AFA7;
        Mon, 17 Oct 2022 20:07:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F2686120C;
        Tue, 18 Oct 2022 03:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BC3C43144;
        Tue, 18 Oct 2022 03:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062425;
        bh=5+6TwNTJu0Ra6uvNUFLOD+X4wY5eUNHgQ3fE0THbzZg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=FaEhGKWd0tMmixoh/0Nt0bpGhB38cV/vGHUmkWGXuCGwOrL2pgmyz+RrhAc041utZ
         X+AvTGVjPn2UoCdn25pjkz1JTkKxcN8GWS8za9ONoPZuuOp6SMB9LvS7t1TJdTb/1+
         ebgiyOBEaGp8PkGG65258kogGarIIRoycOAZ6s/L2S5xGsu3BGl1VJn9g0XiGnSNXn
         TXec8GR3Du7CKbTBakZ+yj3u3LkqhvCNB9dU3QAtlxTAW6TPkY0eq1x9d1A/LgjfL6
         1RVRJQSB1LpHJlkst1sd+hKdPXNip4SkRRP3oQV96kS8oY/rx+K1Er8hAx0tQP9Iks
         uCW/+Xmgbs20Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org, robdclark@chromium.org,
        devicetree@vger.kernel.org, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        srinivas.kandagatla@linaro.org, sudeep.holla@arm.com,
        wuxilin123@gmail.com, mollysophia379@gmail.com,
        Arnd Bergmann <arnd@arndb.de>, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v2 1/6] arm64: dts: qcom: sdm630: fix UART1 pin bias
Date:   Mon, 17 Oct 2022 22:05:39 -0500
Message-Id: <166606235845.3553294.8699493037486900869.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221010114417.29859-1-krzysztof.kozlowski@linaro.org>
References: <20221010114417.29859-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Oct 2022 07:44:12 -0400, Krzysztof Kozlowski wrote:
> There is no "bias-no-pull" property.  Assume intentions were disabling
> bias.
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sdm630: fix UART1 pin bias
      commit: 780f836fe071a9e8703fe6a05ae00129acf83391
[2/6] arm64: dts: qcom: sdm845-db845c: correct SPI2 pins drive strength
      commit: 9905370560d9c29adc15f4937c5a0c0dac05f0b4
[3/6] arm64: dts: qcom: sdm845-cheza: fix AP suspend pin bias
      commit: 9bce41fab14da8f21027dc9847535ef5e22cbe8b
[4/6] arm64: dts: qcom: sdm850-lenovo-yoga-c630: correct I2C12 pins drive strength
      commit: fd49776d8f458bba5499384131eddc0b8bcaf50c
[5/6] arm64: dts: qcom: sdm850-samsung-w737: correct I2C12 pins drive strength
      commit: 3638ea010c37e1e6d93474c4b3368f403600413f
[6/6] arm64: dts: qcom: sdm845-xiaomi-polaris: fix codec pin conf name
      commit: 58c4a0b6f4bdf8c3c2b4aad7f980e4019cc0fc83

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
