Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E51672F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 03:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjASCnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 21:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjASCm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 21:42:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AECA3C2E;
        Wed, 18 Jan 2023 18:42:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A0826192E;
        Thu, 19 Jan 2023 02:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC871C433F1;
        Thu, 19 Jan 2023 02:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674096177;
        bh=qY7w+eV2lvDRxscyIliGQJP5KskMsmhdNvw5zPCvDr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1yGn45B+1nVwaa8MLHWMnvRy92vR6HE9V+F3w9sfdSJBLXFlJIpa01MLcrJlh+d7
         cssRTVuj3nJrhXB1TD/rAtsDS1j7JP7sYQ9pKoFrGQJwP8vQLJr1LgBWTD+OGJKK19
         psGRnFiO8iXrpUeopfUYQ9GlS3BGaLnxkOqaSuqOc6fCv/vW9AN4S0PH78+oTWE2Dj
         lJkjNDoVLp3WrZopWOX9XAa/BPliaMqkdWNIU5q+2pSzaQTqt2e29WuCtmVBqgL1yl
         U8mJ0yv9iHLuWE1xgH3KrmcBzlsBbdVlMmcA/rz13EminwBJ2GP9p8oOUq6p5fhOJ8
         +Cj1dZJpSacqw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, rayyan@ansari.sh
Cc:     robh+dt@kernel.org, agross@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8226: add RPMCC node
Date:   Wed, 18 Jan 2023 20:42:52 -0600
Message-Id: <167409616953.3024582.7885726296537846951.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230118181343.438373-1-rayyan@ansari.sh>
References: <20230118181343.438373-1-rayyan@ansari.sh>
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

On Wed, 18 Jan 2023 18:13:43 +0000, Rayyan Ansari wrote:
> Add a node for the RPM Clock Controller on MSM8226.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8226: add RPMCC node
      commit: 34d50b12d67795454139a1cfc7ca3add8efa3612

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
