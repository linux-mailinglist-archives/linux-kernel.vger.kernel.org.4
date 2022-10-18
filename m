Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3736021E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiJRDJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiJRDHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F5C9A9FC;
        Mon, 17 Oct 2022 20:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51227B81C65;
        Tue, 18 Oct 2022 03:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3488DC43146;
        Tue, 18 Oct 2022 03:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062413;
        bh=bAklUEm2LDbK4ww1YXElkRPQpJROuQklbbeUNnAQl5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fUcwv7Npgu0774wH/jEpxHqWOC/MJWm6EWKEhERFAkUF0Grx3zafIPUoFAluKJcyM
         g3PhOnJzgx8tfGfNTVZxXHkIWSXeu53V8uNXLmlHKPobZfuWoX27/Q2sN4IWsOB/3N
         ery+lJwO6Ocow7gEviS8yV9ats4KkkKwLX9bjMCu2Nl0cemEIQhW6H9y5qfWH7aWcl
         Hq8sQqKw4wqZE/ZSXg/EVEorEhazHBMEDTdtndoazDemxAk0WZ1ysT5WJDVY41mLBC
         tXO0O8/1ZhOdddwraQ01DTLq8xrtDb9KkVebVy3tMMsxqidSqp+zzWpUo0YYpn4iFQ
         tpJB34CYgGwng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.botka@somainline.org, agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8250-edo: Add NXP PN553 NFC
Date:   Mon, 17 Oct 2022 22:05:27 -0500
Message-Id: <166606235846.3553294.15628210439892778538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221008181714.253634-1-konrad.dybcio@somainline.org>
References: <20221008181714.253634-1-konrad.dybcio@somainline.org>
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

On Sat, 8 Oct 2022 20:17:13 +0200, Konrad Dybcio wrote:
> Add a node for NXP PN553 NFC, using the nxp-nci driver.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8250-edo: Add NXP PN553 NFC
      commit: 37eac5a5fe27b1ab189d12064ffdd7db42f26900

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
