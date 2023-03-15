Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC39C6BC100
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjCOXcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjCOXcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA37B28E40;
        Wed, 15 Mar 2023 16:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B4D461EAB;
        Wed, 15 Mar 2023 23:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3639EC433A0;
        Wed, 15 Mar 2023 23:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923133;
        bh=7qehc5lRPD1XWts0JJ3oW/XGDrs7APtS/t/saNelVRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PaXwbDKxnf+1WRx1Q+gzLx6/az/Io7bJfpKWsjHD9iHFY3+1xP6yzdUwxH4MnV3L6
         XiZNkfDdBea0xxILXwmsa3JCCPUPVFD25ZAaaOv184rdsTYmAAxlUW0dVlX8M6boUn
         1la81S2SRToSrRoY6XV/cDuiFw+JTJelMWVVhIE8bIG/xAUBZ+Z8UPr+h4UAPTTI9M
         gQHQTzBW9jQB47jZzKKg5Kl08HrfR5b4AIsvFPYxA8eoA9Xk45ZDNKD8ToY8jAEFtJ
         dIYx/cIvjsuYWHyshk2M4PfZIprY0tDSVOEfRmnyiTZ7NE1Ey1umM5t9oiED4WdaKt
         x/0tU+860Qhzg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: qcom: sa8155-adp: enable the high-speed UART for GNSS
Date:   Wed, 15 Mar 2023 16:34:43 -0700
Message-Id: <167892332563.4030021.2619241042716020479.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309143551.200694-1-brgl@bgdev.pl>
References: <20230309143551.200694-1-brgl@bgdev.pl>
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

On Thu, 9 Mar 2023 15:35:49 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add the relevant QUPv3 node to SoC dtsi and enable it in the board dts for
> sa8155p-adp.
> 
> Bartosz Golaszewski (2):
>   arm64: dts: sm8150: add the QUPv3 high-speed UART node
>   arm64: dts: qcom: sa8155p-adp: enable the GNSS high-speed UART
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: sm8150: add the QUPv3 high-speed UART node
      commit: 10d900a834da29cf753f1e45f66982e322a177c1
[2/2] arm64: dts: qcom: sa8155p-adp: enable the GNSS high-speed UART
      commit: d97ba0b040b1aee7c2a7a7155b7752413a965d1f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
