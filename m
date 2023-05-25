Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D967A71049F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbjEYEzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbjEYExl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5A83;
        Wed, 24 May 2023 21:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AF9E642BD;
        Thu, 25 May 2023 04:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D265C433D2;
        Thu, 25 May 2023 04:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990302;
        bh=YZf72VNbah8S00sNKS32JtZ4PfsEFEbfvpF2uheSpjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YO2TJ4Kcisim7rOmGF03TFHQNGBYu6FxxSrr4TDStwTGl5iCpBYdWnyDFG7x4HEjG
         oubigVgG9mHqmX6FZ8Cui2HWxbSCsz45VtNlDW4E4r0GDibPG7GIH2hhrzslilmsoX
         HTZaXwbIjNvrvCrmgQxgsMEgGjGhB7n21u+8rhIJtZ4RQ+I6gZO1m22URnqGIrg5BI
         G7zLFClHX+jTWi4cIaEPGcV9/CzwzQi9j7Yb4GLWy77TcezmyoMW+8lI6u4Bl4gfZq
         sUGFVqLY4IO1nwYkUUtP6vGrftlkMeGuod2At/czVN35HZryELmD2Lh/Bl0fXbYWUw
         c+hw/IJEmHUnA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] Add GPIO support to PM8953 PMIC
Date:   Wed, 24 May 2023 21:54:21 -0700
Message-Id: <168499048184.3998961.10910306353238353863.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
References: <20230421-pm8953-gpio-v1-0-3d33e2de47e3@z3ntu.xyz>
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

On Fri, 21 Apr 2023 23:56:19 +0200, Luca Weiss wrote:
> Add support for the 8 GPIOs found on the PM8953 PMIC used with msm8953
> SoC.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: pm8953: add GPIOs
      commit: 5a60e72c3eff0747cc779b8067cd795acf6beecd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
