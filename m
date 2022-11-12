Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20096266C8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiKLDwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiKLDvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:51:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A7CE32;
        Fri, 11 Nov 2022 19:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BAC05B828AF;
        Sat, 12 Nov 2022 03:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94852C433C1;
        Sat, 12 Nov 2022 03:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668225112;
        bh=8QpppI1bthbtaOEADOhZ6OKEznG8xBroutVPiv10vko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kg1jFSazqEGiuzl2nA/QdwKzQsCFpFzIDlid7jgdlQLuY0x4+FP/hWldPNwvTzaRq
         64izvRtJv/DjG+Y5LzHvTVpvO0fOEeNVnLAhLyeoF04teg+rMhlcEZhAdJqTP8Y52Z
         r95I0BfrvvFzmACU7+8GjI/CDP6OcQ2sxhBzGHmRmaoCI5LNCakAPTlZ+oaEkpPaa8
         rbWY2t6Q61dLFERuOREXlDZHh3dvoM3teyiqZK3nZ4OoIdg0jyyO1qsevhWkQcryyG
         EOm16QxTnODn6D5Hw/skNpSx6iAZltMAPDt2DUpRxinf2n/aJVTLgoB9NlmfMZPV4a
         3Mo+VU6vjJnWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        konrad.dybcio@somainline.org, agross@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: Add LID switch
Date:   Fri, 11 Nov 2022 21:51:45 -0600
Message-Id: <166822510240.978218.11482432146207540020.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
References: <20220730193617.1688563-1-bjorn.andersson@linaro.org>
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

On Sat, 30 Jul 2022 12:36:17 -0700, Bjorn Andersson wrote:
> Add gpio-keys for exposing the LID switch state.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: Add LID switch
      commit: a607fe5ea21324a91f03301194bfcda1df2108a6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
