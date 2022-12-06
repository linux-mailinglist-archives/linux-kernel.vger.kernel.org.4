Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322FE644B97
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiLFSWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 13:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiLFSWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 13:22:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C140467;
        Tue,  6 Dec 2022 10:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD94616C6;
        Tue,  6 Dec 2022 18:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC28C43470;
        Tue,  6 Dec 2022 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670350814;
        bh=cRTVyzIiiu31+sVEsTony/frIXrdN1dj9dFGjCS3u58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VlWiDian6OCVR68xvG0D7+ImuuQUyaaXN/IXsXM13OlxPpV87z2kmcxuBnR1ZouN6
         RpUISdhyhRc5ESxrzletAUM9jhg7GBgw40t+IgPUD04Xf1GIUTQlFsOu34SgE/WXq0
         /i5rPzHxt3JIZce/XVrk67Am0FR0tJZHem4ethbsqym+4ghHhNbC2/MAVSdmSenCui
         kAR5AAA450Kpp/r0RBQqJBUntrGzFCSnBs4nomVrJXRxPuK+6ku71a+p8UKqO0OFSl
         kdekfln62QRDNjFaPqteHJ8ub0Z6P2uFNLMriTmRZ6XC3z9755PjhWf8nZ4SDtcXtW
         0MhodaukGzvvQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
Cc:     phone-devel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>, konrad.dybcio@linaro.org
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: clean up USB nodes
Date:   Tue,  6 Dec 2022 12:19:20 -0600
Message-Id: <167035076346.3155086.14113764607698991214.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221128171623.825572-1-luca@z3ntu.xyz>
References: <20221128171623.825572-1-luca@z3ntu.xyz>
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

On Mon, 28 Nov 2022 18:16:23 +0100, Luca Weiss wrote:
> Rename "otg" label to "usb" to group it with other usb nodes and also
> because "usb" makes more sense for a USB controller.
> 
> And now we can also better use the usb_hsX_phy labels instead of having
> the ulpi -> phy@X structure in every dts.
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974: clean up USB nodes
      commit: 08b37b2a9b1a9e4dcdd810e514e3f60f54338fa9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
