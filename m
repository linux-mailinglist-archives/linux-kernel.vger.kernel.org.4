Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF0260223F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiJRDLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiJRDJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5665D91848;
        Mon, 17 Oct 2022 20:07:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5850BB81C66;
        Tue, 18 Oct 2022 03:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C88C4347C;
        Tue, 18 Oct 2022 03:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062440;
        bh=RZWow1wi+a3wecuQXBRpI+f5+hUJVRWCbd2dTedzE6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ml5DN9+17E2J47ZS7m83rsLOPOL9XuWvqxQeTPZwQln95Ka1ONmnKx1+b07llnkrx
         BgSFufeHDya4EsFoIml8BIt2s6G7CbK9q0eNdmjlfExGFJJz/fUtH+9VJlcKYhF4y7
         Eaezcbnl8vQMx3JX6vz4vTc7bTpEmY/HtQaIN53IbUtCwh/zf419qu72FU0Sm5w67C
         jKjCxaQf4fzn+ehSxg7V3/XySZ+vOwoXpiTp4o22oFBSD8DLVnK+RfP40Y0JQr7Kgs
         qt9IfAOCzBcPivqN54l9LfHWDzyYw4AyO0v4VLaTKQLECQvb1nxl6eJ0RDzmr88XzY
         AKeeqY3qsa+3w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] ARM: dts: qcom: add 'chassis-type' property
Date:   Mon, 17 Oct 2022 22:05:52 -0500
Message-Id: <166606235857.3553294.18139964100226295775.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924154422.9896-1-luca@z3ntu.xyz>
References: <20220924154422.9896-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 17:44:22 +0200, Luca Weiss wrote:
> Add the chassis-type property to arm32 Qualcomm watches, phones and
> tablets.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: add 'chassis-type' property
      commit: 6d28bc945dea4628516b207e0f68199bbc063848

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
