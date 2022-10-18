Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D230B60224E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiJRDM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJRDJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:09:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72EF9AFFA;
        Mon, 17 Oct 2022 20:07:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C49861350;
        Tue, 18 Oct 2022 03:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449F5C4347C;
        Tue, 18 Oct 2022 03:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062444;
        bh=pyNbBNwacrMjD54CLhhyBmq3pnoGcl+3ZsTc9CPSfhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIXUj2ngMJsqfHzprBwY04O1SFGh5IkKUD25J3VWYQECXo1bB/alTY0qLx0hTsJV7
         jRwTOC3a1hU7ic4SoaPimufRm9ZJyGzACD8hmXXJrpl/ilEYDSMidG6gbejQALTL74
         iCbg6MxhSb7WubC/Q5zxX6DMRiQHaxE/Xk96k0tdeCH49tr0pS6Tg9yrjuGJKpWAP0
         zktOSTpDTxqz26mCJ5BUokDM4en8S2qTzc345GO0RHBPmG0gQwF8NZiI2dpXE7THfM
         2ZPjJXYoXOyMWa4B3jgpYXHcgMY4BX4FC8fMHDgu6D3K/BizhS08URJVk/nze0SbjR
         /YEpdV9h2yDWg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] ARM: dts: qcom: pmx65: use node name "gpio" for spmi-gpio
Date:   Mon, 17 Oct 2022 22:05:56 -0500
Message-Id: <166606235858.3553294.11511875140424994610.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220925190622.111505-1-luca@z3ntu.xyz>
References: <20220925190622.111505-1-luca@z3ntu.xyz>
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

On Sun, 25 Sep 2022 21:06:21 +0200, Luca Weiss wrote:
> All other usages of qcom,spmi-gpio use the gpio@ node name, and this is
> also validated by the dt binding check. Fix it.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: pmx65: use node name "gpio" for spmi-gpio
      commit: da76bc88bde1dc3f547078282e30a88c371699ad

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
