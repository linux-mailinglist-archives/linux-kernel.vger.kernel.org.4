Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE7737750
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjFTWOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjFTWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:14:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04408E7E;
        Tue, 20 Jun 2023 15:14:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93F86612EE;
        Tue, 20 Jun 2023 22:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A221C433C0;
        Tue, 20 Jun 2023 22:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687299244;
        bh=1ToqkfvRn2DXfq6f7kV6fMxA/kE+OyiNHA3FOg6t2y8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOhEnoJ6EmOI7PhQampg4OghoSBrYOxmJfSIfBXGSZ+FzlVktLn7y9BxNUSR2C79d
         QZi1vG2xeMyYTj2TqI0DGTzh1EPc6xWTKn4QbHx02SLMX7+VEwsUohofCITOMVHL+Z
         2jMlUoPdNM4T7zLgVgzmCWirCaLqBoCCo94YC6xdVqI2BSwnBjjUi52NJnrvbhsLD1
         vekc30pzsI4kCBQ+feaigklUIGQ1eLmg4bLrefM44WLaJmai494r2tmc0mfW3GoKyu
         knNvL//kGowcPectsXyQcc4JuGb5DDv47riJnYhXIVABWu00oXetfLqmBN+t7t/ojl
         YopKE84hBLMYA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: defconfig: Enable Qualcomm SC8280XP GPUCC
Date:   Tue, 20 Jun 2023 15:17:17 -0700
Message-ID: <168729943250.722613.8167743554496755216.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230620202114.83797-1-quic_bjorande@quicinc.com>
References: <20230620202114.83797-1-quic_bjorande@quicinc.com>
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


On Tue, 20 Jun 2023 13:21:14 -0700, Bjorn Andersson wrote:
> Enable the Qualcomm SC8280XP GPU clock controller, to allow the GPU
> drivers to probe.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: Enable Qualcomm SC8280XP GPUCC
      commit: f97be4f1b3df7f8a57322dbae4b4fdbf4c6b4253

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
