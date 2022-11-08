Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8226B6205EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiKHB22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232815AbiKHB14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEC52AE19;
        Mon,  7 Nov 2022 17:27:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECDE161373;
        Tue,  8 Nov 2022 01:27:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE3AC433D6;
        Tue,  8 Nov 2022 01:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870875;
        bh=GFsF+Y5GqYcWdLjkcGOB9BRTtB8F4Uoi7P3A7bNIvyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=umx9MldoW5952lcOA4FfDVE4AtOaBbofar89tFc7Vb5AV6p5PnFXvnHTTEeVCDoO8
         V9b5O70DDIdmoWQkYzInqhD281/ezLJ6z4/fbjtDjnyCJNBWY/D6dyO+6w+5ItSyyt
         ZvXqvQ3RFjzqwXjBGUP1WOkltyz1JQHsKetl5nFiFXNb00+2F0qMliCllyMwjIQ/Uo
         GI68GxFXyDMyW3O3qItRp8ndTs3PlCpF9xZZ7QIWbRIAMuzTdlkkiPq6zytWSPmMkH
         BySFlT7gTo3UyZEGH2bU8CluhDolVw0ntQjfVVXaxMd5cooY04ROq8qwQfijV/SSzo
         K0T6I5GTPEu5Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, afd@ti.com, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, lee@kernel.org
Subject: Re: (subset) [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: rename extcon node name
Date:   Mon,  7 Nov 2022 19:27:27 -0600
Message-Id: <166787084684.599230.17834459930926701866.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221031175717.942237-1-luca@z3ntu.xyz>
References: <20221031175717.942237-1-luca@z3ntu.xyz>
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

On Mon, 31 Oct 2022 18:57:14 +0100, Luca Weiss wrote:
> extcon is a Linux-specific name and shouldn't be a part of the dts. Make
> it be called usb-detect@ instead.
> 
> 

Applied, thanks!

[3/3] ARM: dts: qcom: pm8941: rename misc node name
      commit: 52c47b894b260c3e5102bb4b3e77772734508bcf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
