Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE58710456
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbjEYEv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238707AbjEYEv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ABB1B6;
        Wed, 24 May 2023 21:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7D563C35;
        Thu, 25 May 2023 04:51:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00F1C4339E;
        Thu, 25 May 2023 04:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990269;
        bh=zwBtwNaLG4wjB1uxQSJySa/R5WuHKxv8Kmi+PCSmTUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GRNiVBvwh7e5RF3ZJbRQvti6VQ40UpV4UNUepaRA+27CF9aMqOGrEHaAnpkR3pK+z
         nx2eiETT7tBBLyCBdjuePeBW4S051q3V2YcOE8ooqJ8R9ScR98ltaX7xG85tZU1ebV
         FeSWjsEpiaS01nriJv+bJo7EylS5q5beD5Q2vZEbu9Yjk3aygw9B9M+JhRSdBUZdXy
         V0VMjeqsb+Ph97KocBtozxcXdFHDK61PPcxKrVkeXQIwPVbhRauFv5NdglqAdY1Vdu
         FDjJb2di7ugucaNxoePGhERugiOqgiK7OfoMh7AH6y+wtpkBKPsccVHVgv5VIup8st
         AZj39eOpoB7tg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yang Xiwen <forbidden405@outlook.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Nikita Travkin <nikita@trvn.ru>, devicetree@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] arm64: dts: qcom: msm8916-ufi: make UDC dual mode
Date:   Wed, 24 May 2023 21:53:49 -0700
Message-Id: <168499048185.3998961.6916864245683829909.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <TYZPR04MB632102315884225B7343533B96729@TYZPR04MB6321.apcprd04.prod.outlook.com>
References: <TYZPR04MB632102315884225B7343533B96729@TYZPR04MB6321.apcprd04.prod.outlook.com>
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

On Sat, 6 May 2023 00:32:51 +0800, Yang Xiwen wrote:
> It's possible to use this device with a (non-standard) hub to get USB
> working in host mode, but dr_mode="peripheral" prevents the UDC to
> do so.
> Remove dr_mode="peripheral" and add usb-role-switch so that it defaults
> to otg mode and can be switched to host mode in userspace.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-ufi: make UDC dual mode
      commit: 06a9f50c20b5d5fcec9cb0d44b759c4183c7bbd5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
