Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504BE7104D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239653AbjEYE43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbjEYEys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2AF1981;
        Wed, 24 May 2023 21:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C76DB63BA0;
        Thu, 25 May 2023 04:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13057C4339B;
        Thu, 25 May 2023 04:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990311;
        bh=V0AR9VB0Abuf/boWapRE1QYU924C/0nH8pQepDItrIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UWJDMpUtGLAut5O1NSPjjzVnhfXNvVBBZn0Hqk45UMwXA92bUeJ+HVoLQPwfyHZ1g
         c5cQc7yr4nzef+VkRNhEOB+MwOPYe+Aemntjl9BzaKqH/aNxSItH1+2IIrVmg7ZfyO
         GQBr8EPVdkfXVL533eK++sugk7iNZWP1a2znkZedJoWTLGHQaxylNWq92jn4dLax8D
         oaRJEBNN131HhrQK8wN1/zr5T7nP523j8dWam+m1Qjd4sSxNxHIfp5DIx8lDqEPFwF
         zMLBjZyQi4dy309rbY1DUZ8Ew2fvmkzRaWZL7xsZs0/CLrwH3wJhsqwq/Rb2JMWso2
         svRAmSE3nUuVA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, quic_fenglinw@quicinc.com,
        konrad.dybcio@linaro.org, Dylan Van Assche <me@dylanvanassche.be>,
        conor+dt@kernel.org, robh+dt@kernel.org, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        amartinz@shiftphones.com, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] arm64: dts: qcom: pmi8998: add and enable flash LED controller
Date:   Wed, 24 May 2023 21:54:29 -0700
Message-Id: <168499048186.3998961.14574911875082597467.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518133113.273880-1-me@dylanvanassche.be>
References: <20230518133113.273880-1-me@dylanvanassche.be>
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

On Thu, 18 May 2023 15:31:10 +0200, Dylan Van Assche wrote:
> Qualcomm PMI8998 has support for 3 flash LEDs which got support in [1].
> Add this driver to the PMI8998 DTS and enable 2 flash LEDs in the SHIFTPHONES SHIFT6mq
> smartphone. This smartphone has a white and yellow flash LED.
> 
> * Changelog *
> 
> Changes in v2:
> - Document compatible for PMI8998 to fix missing compatible in DTS.
> - Improved commit messages, following [2]
> 
> [...]

Applied, thanks!

[2/3] arm64: dts: qcom: pmi8998: add flash LED controller
      commit: 9139bb56734a14c156d3ef736c22a06bd1a9d22c
[3/3] arm64: dts: qcom: sdm845-shift-axolotl: enable flash LEDs
      commit: 8587d217ec3c09268d2023758e5fd6dbc3529c2b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
