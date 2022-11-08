Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0950A6205EE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbiKHB2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiKHB2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFB2BB0C;
        Mon,  7 Nov 2022 17:28:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D784B81716;
        Tue,  8 Nov 2022 01:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FFEC433D7;
        Tue,  8 Nov 2022 01:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870879;
        bh=CyPe73X4PtqtTVQNWPinY4BSaQEzpE+Y7mqrS29tYI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNN3D308YEkYXfDMvLI4UJPr3BIewn7ZAYBSjxo1gjO56OreYjuLnh0t1tlOlRcA9
         qo398aymXing5YTpHC12fwJ3FyxtXbUrAd8GjpGQLlJDUVfJvxhqY5tN1jMswXp5DP
         joFcuNB4n8kJ/TqnUvnPpo5vMzxpjpoCwGhNL/t08W/AGgpxugnd6AcekvLvw5mTjT
         PZ34G5iM94/0l0MFjrQvRAAcvfA5KSKp0/nMLwL50vQqBXZolMva0DMsA65pSvMFju
         nMqNJsjUoWCGuTcuLqQSLsDAsxnsQ/FlJ/D+0WCoXJU5HnlQCNYVfMQejUkYInJWKu
         5pux9YjDO0K1w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, afd@ti.com, neil.armstrong@linaro.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH v2 1/3] ARM: dts: qcom: pm8226: fix regulators node name
Date:   Mon,  7 Nov 2022 19:27:30 -0600
Message-Id: <166787084683.599230.13919617003669868505.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221031175119.939860-1-luca@z3ntu.xyz>
References: <20221031175119.939860-1-luca@z3ntu.xyz>
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

On Mon, 31 Oct 2022 18:51:16 +0100, Luca Weiss wrote:
> Adjust the node name to match bindings and fix the validation warning.
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: pm8226: fix regulators node name
      commit: f206bbb6e1d0ec59d8662222637bca9c0216464a
[2/3] ARM: dts: qcom: pm8941: adjust coincell node name to bindings
      commit: 7c0682e7a46d1190ecf43a8e92214f237cc978a9
[3/3] arm64: dts: qcom: pm8998: adjust coincell node name to bindings
      commit: 4ab3acd6379242281d4a55acfd6441830f1984a0

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
