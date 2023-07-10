Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B231574CBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjGJFHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbjGJFG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0785E4A;
        Sun,  9 Jul 2023 22:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B762A60E05;
        Mon, 10 Jul 2023 05:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56193C433CC;
        Mon, 10 Jul 2023 05:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965485;
        bh=T3fCHPlmOeb/zKXAe4HruV8GOh/qut7QkW4S4xr0XDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uNzeZok2qSks37OXOgwMIC9PR7uSh/CZJ5WACAseyTi0keIUZ0UEb9plsv3SEfI4/
         tN20cKQDu+HCpNg1YTU1s/jMRobSn+gUyXx8G1dAK9XnwdHzZ7w92D/2yxkxQOEWCb
         h+5/Ai1on/JJVK5KfQ3ZtDnKNX3PaOct/Za8uvp43nCgRbAuCH/F3yHl68IKwWMq8j
         lH6cCYX6spPuw3KA1x63M21Meh14LVwFBEjZY8kcs1ytwQe06ztFL1FrXHbEiCgbht
         M5leF1/++N+qunNia0nWOcK32w4rOlxqM9KpeaTunjBRwyq1mO6Slf4Kdjj+7rvFEr
         O6on/+Kz0nLwg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 0/4] SM8250 Edo pins, keys & pmic
Date:   Sun,  9 Jul 2023 22:07:25 -0700
Message-ID: <168896565963.1376307.1557038630212246516.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
References: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 13:05:33 +0200, Konrad Dybcio wrote:
> This series brings fixes to the GPIO buttons, adds gpio-line-names and
> introduces the SLG51000 camera on Xperia Edo devices.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sm8250-edo: Add gpio line names for TLMM
      commit: 40b398beabdfe0e9088b13976e56b1dc706fe851
[2/4] arm64: dts: qcom: sm8250-edo: Add GPIO line names for PMIC GPIOs
      commit: 6b8a63350752c6a5e4b54f2de6174084652cd3cd
[3/4] arm64: dts: qcom: sm8250-pdx203: Configure SLG51000 PMIC
      commit: 2de55db6bca0856ecbff5c288dc330af94c8e5b1
[4/4] arm64: dts: qcom: sm8250-edo: Rectify gpio-keys
      commit: a422c6a91a667b309ca1a6c08b30dbfcf7d4e866

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
