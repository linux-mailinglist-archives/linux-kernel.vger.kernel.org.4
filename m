Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5FA620601
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiKHB3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbiKHB2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754492CCA6;
        Mon,  7 Nov 2022 17:28:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3417BB816DD;
        Tue,  8 Nov 2022 01:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AE3C43144;
        Tue,  8 Nov 2022 01:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870884;
        bh=FP97IcSbPmd3bIEDid95eErj3OOgawoY96h2JYd3HQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tRAk2FlzuFq/bwO39xdFtTzTJbwi8IlfUGbRjZY/h6/wfDfk3hoKzr03U/RI60Ol4
         kRXkgjQ9nDdfXwzLNe63gzfwpklwy4PP3awzPyeVkkULxTI65eF4VGUNbKDf+Fsghu
         ialD2FKf/zs/qs4pW8lE3BMg/ljG/hJ8dCJguGNg31VK6uftdp/rIw1ivBE921uJX/
         /M0lhT58jLhRvsYoa+pQUKdHxdoMZXsi8mlFUac0Ggqp77sMn4BemLEa+BwxWaQQU5
         Op9aMjPm+Ju3dUWPaY8iINN7iczkZT79UMDPNZGeL//BUGTqu3nX20wyZCgDeTd9yb
         KYYz8mtuldBqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, matti.lehtimaki@gmail.com
Cc:     devicetree@vger.kernel.org, rayyan@ansari.sh, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v1 1/6] ARM: dts: qcom: msm8226: Add MMCC node
Date:   Mon,  7 Nov 2022 19:27:34 -0600
Message-Id: <166787084687.599230.11115238688435014299.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221002122859.75525-2-matti.lehtimaki@gmail.com>
References: <20221002122859.75525-1-matti.lehtimaki@gmail.com> <20221002122859.75525-2-matti.lehtimaki@gmail.com>
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

On Sun, 2 Oct 2022 15:28:53 +0300, Matti Lehtimäki wrote:
> From: Rayyan Ansari <rayyan@ansari.sh>
> 
> Add a node for the Multimedia Clock Controller found on MSM8226.
> 
> 

Applied, thanks!

[1/6] ARM: dts: qcom: msm8226: Add MMCC node
      commit: ad789f571d93419882aad66515640f649e63bf95

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
