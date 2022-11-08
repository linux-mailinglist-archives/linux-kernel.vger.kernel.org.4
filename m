Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C01BB6205EC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiKHB2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233279AbiKHB17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:27:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E372AE06;
        Mon,  7 Nov 2022 17:27:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E92E3B816DD;
        Tue,  8 Nov 2022 01:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99782C433C1;
        Tue,  8 Nov 2022 01:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870876;
        bh=Cnbws5G7KGmfRLaIrW95vot+pUVUXpve3ZRx28df1JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=slbkL+TBZKDaHXEJUy8GkTxbUOSAQwEAM4xSqVMZt7q/yDJNssJRummIK1z4fR2xo
         /f6w9b6tEPoKAA9KhYkgByIqE9iUzGLuDN6S9fG1CP08pC/7a8jqIEAWz3KhrreloY
         UO97Z+HpxuPzrZ41vpsCjNfVfWr+d9xtZOGMTPtrgh0rYANysXJ3rVbHRsdAUXCMA5
         BTR+/bdqL1GnfIMPRTrwG2EJ4K+lmAoWSHQrSlEfekhdTL+JPCyJi71UcYiYCZOY3R
         GeSLRP7O72pD1HihuOm7eL1aF4Al6Aa0zJKyu6KFN82yvLPRejyC7NZUMX8VeXNNrM
         FOvb7RLTicBaA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, afd@ti.com, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/2] ARM: dts: qcom-pma8084: fix vadc channel node names
Date:   Mon,  7 Nov 2022 19:27:28 -0600
Message-Id: <166787084684.599230.9451669404904525907.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221031181022.947412-1-luca@z3ntu.xyz>
References: <20221031181022.947412-1-luca@z3ntu.xyz>
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

On Mon, 31 Oct 2022 19:10:21 +0100, Luca Weiss wrote:
> The spmi-vadc bindings require the '@' in the node.
> 
> Additionally change the node name to adc-chan which both makes it a
> generic node name and also removes the underscore from it.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom-pma8084: fix vadc channel node names
      commit: 31eab2bb9c1ddf8a9ab5a1e4dc59446eeed2ea9e
[2/2] ARM: dts: qcom: pm8941: fix vadc channel node names
      commit: c5ef315a38fb36779adadbafbcce2274a3dec0d2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
