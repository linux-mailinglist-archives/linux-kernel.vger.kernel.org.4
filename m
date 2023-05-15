Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41DC70225D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjEODb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238695AbjEODao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:30:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B38358B;
        Sun, 14 May 2023 20:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99FA460DED;
        Mon, 15 May 2023 03:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526EBC4339B;
        Mon, 15 May 2023 03:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121360;
        bh=YpeZvUjsH1mp/gooxw79l0tPMvOQAO38qph0hBOP1j0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dBiSueB9hr2HJ7F0gx6A/GX2v6vVF+egMl0wJ30LhuT2HLEl3lKdzlFXZCuJcFCk3
         ZW0rUmqGDfE4Sl/xoMX3+9wnJgi91GBJNLFEJnyv+vpWsLt7IqMVIm6xb08CxUakxa
         JAz11eUMNlaxobaHq+OPKbCglnSHUAqvv5DiYxtRnoQoVVJNWYhqoFZaTJVno+rwQb
         m35IlrMii8CHPwItNLMwTkc23z4ltphzf+I2SU1A0kTsYPKzGrQr58N+aKYb+pDWWt
         6YRFEu/pyRmLuoN/5Wm/yLUDEHKzUnLZqVMt7cRVm+slEN4D/IO0/PG9PCdq8KWTDh
         uFOhc9Q/GveqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add the watchdog node
Date:   Sun, 14 May 2023 20:32:59 -0700
Message-Id: <168412158455.1260758.10617418534202917524.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427161218.201828-1-brgl@bgdev.pl>
References: <20230427161218.201828-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 18:12:18 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Now that the hypervisor issue is fixed, we can add the watchdog node
> for sa8775p platforms.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p: add the watchdog node
      commit: 09b701b89a761e5e9566d65326d5fe0e94eaa48f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
