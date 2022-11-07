Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED4C61E94E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiKGDOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiKGDNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A2511C0A;
        Sun,  6 Nov 2022 19:13:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7FB960EA2;
        Mon,  7 Nov 2022 03:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C856C43144;
        Mon,  7 Nov 2022 03:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790786;
        bh=qQ2gGz+etukYdxWDGdJ4c/tlmPK4Bf5ST3iIjtsUHms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XwC96ur4kj4AHIbWly+cu0G5e7+aHme9n5hU5XPTtehBbX4Ux4frGIMf7jl/CXFEH
         Y5yMUJJuqZUO0HACtSlTL0mSLFpUOjrr9PMNtVyNSnoW5ipg6+mzVyiCMAfkCQyHvF
         2ys9PRqkz8vngcBJw6IcKdOTSolFiW8hGpVGVzPsl0jihA0c0xfDv74ZxUOlozWvd1
         GgB/YjNFG5FxE+Y+UUEVCDbzb6w4KHY5NZAGVEHaWesGEIlrOPNtb02lKCa1Whdlf0
         TYf7bPA6c3Yt8I12gDtqmDj9OEHa00AnMhZFiiM2teMjvBDNHGj4UNuYWZLSZLThX+
         VHTeidigKLlrw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: arm: qcom: Document huawei,sturgeon device
Date:   Sun,  6 Nov 2022 21:12:24 -0600
Message-Id: <166779074252.500303.16646489409571758224.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924152937.4076-1-luca@z3ntu.xyz>
References: <20220924152937.4076-1-luca@z3ntu.xyz>
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

On Sat, 24 Sep 2022 17:29:36 +0200, Luca Weiss wrote:
> Document the Huawei Watch ("sturgeon") which is a smartwatch based on
> Snapdragon 400 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Document huawei,sturgeon device
      commit: 773c7700a71bb3f7f4fa4f689ffd4d063ddd66a7
[2/2] ARM: dts: qcom: Add support for Huawei Watch
      commit: 65e0d1c4668506d511af9ab0ff0a1f4c940ef8e7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
