Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7A713139
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243360AbjE0BEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbjE0BDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A9B19A;
        Fri, 26 May 2023 18:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F20A1654C9;
        Sat, 27 May 2023 01:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C1FC4339B;
        Sat, 27 May 2023 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149433;
        bh=fxYWXexHjqMsOELaFczQ5u72qTfpRnCt7eHfSifnC2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yuykaj5RKxbCSk+uxlKl2m0aQPZGNjZDtnLBMcy4KjHfVAqu0H7uYggJT5era2Cpo
         u8lGXsajJdyjLbM9EIe79pWN3GhgB3jCyet4S6/rpRe0ZUcgdFEKl325VfpxqDncBh
         VfYe64xLlAoQQyl3hhaO99ys4mg1l1d9VGsWLolsMwgFVz+1ZkMwFP91dOaRMmgYiF
         yHLp9prljwstX/eaDUccOj3hKZ+uk0qFsE86Dho4buEJ7SnigRJjt3iRjCeHRxls51
         pUMH3l5jYhQDxA2efs69Li/jEZT+0YK1xfpTkbl9mn+IRqJZJwqcqms5VBs+WmRs6F
         0DgVp9tjMaiBw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Dan Murphy <dmurphy@ti.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Luca Weiss <luca@z3ntu.xyz>, phone-devel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Raffaele Tranquillini <raffaele.tranquillini@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: (subset) [PATCH 0/5] Improvements for drv260x driver and add to Huawei Watch
Date:   Fri, 26 May 2023 18:07:28 -0700
Message-Id: <168514964951.348612.17473479796367169535.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
References: <20230430-drv260x-improvements-v1-0-1fb28b4cc698@z3ntu.xyz>
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

On Sun, 30 Apr 2023 20:20:52 +0200, Luca Weiss wrote:
> Clean up some issues with the driver I've noticed while working on it,
> then fix the magnitude handling which previously resulted the driver
> discarding the upper 8 bits of the magnitude value, and finally we can
> add the drv260x to the APQ8026 Huawei Watch.
> 
> While the "fix magnitude handling" commit technically changes behavior
> and could change behavior of existing user space applications that deal
> with this quirky behavior, it's definitely not correct and results in
> very unexpected behavior if the user space doesn't look out for it
> (meaning only use 0x00-0xFF magnitude, and also know that the magnitude
> was interpreted as signed value, see more details in the commit message
> there).
> 
> [...]

Applied, thanks!

[5/5] ARM: dts: qcom: apq8026-huawei-sturgeon: Add vibrator
      commit: ad318f9ce5a2e815816bfcf7f187a3ac32905523

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
