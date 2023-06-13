Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FC672F08D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjFMXrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjFMXrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB42B2D43;
        Tue, 13 Jun 2023 16:46:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35C7063C78;
        Tue, 13 Jun 2023 23:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED664C433C9;
        Tue, 13 Jun 2023 23:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699937;
        bh=80n6STQGwe3VacUdMoV3b3A1GNugjIvglGHInKBpxhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jW2clGq38o4mjZgLZ0FHqVa+ssWNdLj5WdenRdw9K6ZzqUYQfaSeO41WsWpjggPzc
         v0tNxekD9wbpGg9z95fdIZYy3vk/0VZbqH3kheEH0tM/h3D9J/ai+gheC2WFTgLVrv
         XacJ2QorhlDB48aTWyUVZkh6+a8d5A5B4f9knHdYZpXKPITrrH3JO96OuuA7qf29ru
         ihFTJHMWavLLNmCgLqs/bf2Bn22IXvAaxGUzTkcVZ+tTedjDk2mAUxhEf9u7j7aaYT
         krDLpVAxPh7LX4Zy72a4kD8PDfJLF5orxauFxSlkZYnvZ2/rMefzsHUoomR7rPBlxk
         oJtdNnEX6CG7w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH v2 1/6] arm64: dts: qcom: sm8150: Use 2 interconnect cells
Date:   Tue, 13 Jun 2023 16:48:41 -0700
Message-Id: <168670013501.1400697.8845873820910388817.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230602062016.1883171-1-abel.vesa@linaro.org>
References: <20230602062016.1883171-1-abel.vesa@linaro.org>
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

On Fri, 2 Jun 2023 09:20:11 +0300, Abel Vesa wrote:
> Use two interconnect cells in order to optionally support a path tag.
> 
> 

Applied, thanks!

[1/6] arm64: dts: qcom: sm8150: Use 2 interconnect cells
      commit: 97c289026c62f80933b44353904b919572175f61
[2/6] arm64: dts: qcom: sm8150: Add missing interconnect paths to USB HCs
      commit: c2998e9a42637cdab699a21aa75a8cb5a7cbce72
[3/6] arm64: dts: qcom: sm8250: Use 2 interconnect cells
      commit: b5a12438325b9c0207ae4374a797368070cfb945
[4/6] arm64: dts: qcom: sm8250: Add missing interconnect paths to USB HCs
      commit: fd62fd1cf9e7fb7ef761e411d37cb5d06769954b
[5/6] arm64: dts: qcom: sm8350: Add missing interconnect paths to USB HCs
      commit: 8b51dc863baf1447e9ab52411c5bed7ef9a56d80
[6/6] arm64: dts: qcom: sm8450: Add missing interconnect paths to USB HC
      commit: b5b0649d5be4c82d09489492c121a7823323fc4a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
