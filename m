Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C023060223D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJRDLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiJRDJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA689AF81;
        Mon, 17 Oct 2022 20:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D3A361374;
        Tue, 18 Oct 2022 03:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2543DC43141;
        Tue, 18 Oct 2022 03:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062436;
        bh=3F5goSiRgENkevMYhY5s37LRCe6CC7oI5F2FCG5Us9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QUxQz32e3pANDdCQBadRR66fEfSSLIRXM1h2SfEbKsdY/5Za7f8vhpp6HtcHXc/Wm
         2j16kkHp+zWnwtxWojJoRnIufERDUiMyZjZF0r+JPsoNn0aJZra53A9JXaC1Yg5z5J
         jk73Gxa0WstBkVyt5ACSzZ/yCFaWcrrnnPUWgm/aaKqRkF8iZ+KYNEr0SVK2WmAeOT
         K789H+RYwIq+xKFLmV0uHofrPpqK/ReFNNc8Rxow3+WJcngTJlfNpOzV4lIbfS426Y
         MBCb7YjC85VlyPHsTlEWnceN0LSDjUAkDlHmpZrECrvpjZjqVgaAypCB8Spun1KlFV
         CP23Dv+zCMNoQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH 1/3] ARM: dts: qcom: ipq8064-rb3011: fix nand node validation
Date:   Mon, 17 Oct 2022 22:05:49 -0500
Message-Id: <166606235861.3553294.8715702430694617342.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221013190657.48499-1-luca@z3ntu.xyz>
References: <20221013190657.48499-1-luca@z3ntu.xyz>
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

On Thu, 13 Oct 2022 21:06:55 +0200, Luca Weiss wrote:
> The devicetree documentation for the nand node requires the subnode be
> called nand@ and no compatible is needed.
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: ipq8064-rb3011: fix nand node validation
      commit: 6f917ec31d3eb0f2c657f36d299d39bd8d051e03
[2/3] ARM: dts: qcom: apq8084: fix compatible for l2-cache
      commit: 891bcfe02470c79489987d643ba0010c0b16f896
[3/3] ARM: dts: qcom: apq8064: fix coresight compatible
      commit: a42b1ee868361f1cb0492f1bdaefb43e0751e468

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
