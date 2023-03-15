Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBFB6BC187
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjCOXgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjCOXf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:35:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234E42E0F9;
        Wed, 15 Mar 2023 16:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59354B81FA4;
        Wed, 15 Mar 2023 23:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54DFDC433A0;
        Wed, 15 Mar 2023 23:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923175;
        bh=BPOCHHteXLKnZC3y+JEMP4ElqNTGojXEqse61Z/dRZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUTiATHluVjrTjplcT0rOePEivnoTrCL/+yS4GrqQuAZjwHhTXVov6FWWZQEUq+6k
         1JDYFXS8oMbcI9MB0aiqBPCojcdNoldsRU4eTJD77ZssFIOt4u9Yy//5ZlbvofKIvD
         bJZh4KskVGzG8hE5+zEIHvaxIFh/oeT8/dUTCgLow7OvA1ISVSDlLE2ruclB31MGuz
         G3uYQnjUKiu13e2TObshH+NqY+C37vGmWXIqp/a2ggvkF5HMxXbMBG0hBkZo6rofNX
         68rX+c0grC1PRRoMoaSwzeVeBO+XH4GDbt9U+t5lip5TzjHGDbupBLBL+KT5XWhDk1
         uzAkgEIG98LkQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org,
        Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        agross@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr
Subject: Re: (subset) [PATCH 1/4] ARM: dts: qcom: ipq4018-ap120c-ac: setup serial console
Date:   Wed, 15 Mar 2023 16:35:25 -0700
Message-Id: <167892332566.4030021.2253910306567333644.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230214161211.306462-1-robert.marko@sartura.hr>
References: <20230214161211.306462-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 17:12:08 +0100, Robert Marko wrote:
> Add the required alias and stdout property so that kernel can setup
> the console based off DTS and not have to set it in the cmdline.
> 
> 

Applied, thanks!

[1/4] ARM: dts: qcom: ipq4018-ap120c-ac: setup serial console
      commit: 131731c44f2cea44135e93bfb0a2920829910625
[2/4] ARM: dts: qcom: ipq4018-ap120c-ac: align GPIO hog with DT schema
      commit: a7d2715df2845560302aea9d9922b4bfdf4fe09a
[3/4] ARM: dts: qcom: ipq4018-ap120c-ac: align SPI-NAND with DT schema
      commit: fabc476a6cff40119365014e84aa2d2bbdf7756a
[4/4] ARM: dts: qcom: ipq4018-ap120c-ac: use NVMEM for ath10k caldata
      commit: d64f94249c689962b895aa650a30c29ac3b41cd3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
