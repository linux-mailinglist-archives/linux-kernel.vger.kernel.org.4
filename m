Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476387104AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbjEYEza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjEYEx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A641AC;
        Wed, 24 May 2023 21:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D551B641E8;
        Thu, 25 May 2023 04:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6D2C4339E;
        Thu, 25 May 2023 04:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990303;
        bh=pWp2Tmn3uVyeS0VVLg1WiQhnxzMv6D5reWPQ0q4J3R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=COGmehcBvCs4HpSQHyk4ZuS2tftP27WAvTaSPo81WJDURdQpqb0W7Su4Z/Ky5xWeG
         j2d/os36iDE6nx+uu25Q3dC6CyEJp1nLhbJyuPppGQzVJiQhKOZi+SPJlneyyeO3zM
         4FBlwAqrjbuzc+npW7/EYHsoQtN4lmNFfSHpR9NjZvPELehwcnN/NWMDt2aRGte3ro
         B4voyi8EwYvm2LXStRT/BEFL2lV0tezilUARyvytts/+W68vW2W8796gVHeh2cYzfy
         kpPMkzcO88yxfMRNBSaPCaq2T/yRYW8a459bwIErrUtCuz1DD6VttIxavVWm9Yr7b0
         ItC2pSZqBrPFQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Masney <masneyb@onstation.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Sebastian Reichel <sre@kernel.org>, phone-devel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 0/4] Add haptics support to Nexus 5 using pwm-vibra driver
Date:   Wed, 24 May 2023 21:54:22 -0700
Message-Id: <168499048179.3998961.9210291872434936016.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
References: <20230427-hammerhead-vibra-v1-0-e87eeb94da51@z3ntu.xyz>
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

On Thu, 27 Apr 2023 22:34:25 +0200, Luca Weiss wrote:
> A while ago Brian Masney sent some patches for a clk-vibrator which was
> then succeeded by the idea of a clk-pwm driver that "converts" a clock
> into a PWM and to use the existing pwm-vibra driver.
> 
> Since clk-pwm has landed last year we can finally add haptics support
> upstream.
> 
> [...]

Applied, thanks!

[4/4] ARM: dts: qcom: msm8974-hammerhead: Add vibrator
      commit: e0a6590d8ceb7d6c4e35b5b5eb368d9fb800487f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
