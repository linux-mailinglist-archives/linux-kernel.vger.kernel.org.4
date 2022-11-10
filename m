Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BDE62482D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiKJRUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiKJRU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:20:26 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15B21E1;
        Thu, 10 Nov 2022 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1668100805; bh=+T5Oar/BbpgMPrOdAhsBtmkmjp5KzTsLrhLyKGfz9YM=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=W10MYXnUcjBvhPW8wikmbCFnsB1u4LjQnoNHVQJn0Z7vwrSCMSMFwxtA2EXQm01Ps
         ZuEtLaSR8zPBSqmOPbo6dUaUINHOHp/1rYkPwxRmF5J2lbJc8SuZzox1/eo4IRFWCh
         GENZOb3gS93xsvCfDXqsNI3cKR4Q5sMFJ6oybEAU=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Thu, 10 Nov 2022 18:20:05 +0100 (CET)
X-EA-Auth: 79NPVASxzui63w1gVP//v3siC7pPGN3FPMDMOM9zstfdA7p6ZJjTxRNS6NZ/CTYl0g26Ot4hzaLinc4vOR3R8IHvHbjSV9JtmNVefMBFAlw=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     w.david0@protonmail.com, stephan@gerhold.net,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 0/5] Input: msg2638: Add support for msg2138 and key
Date:   Thu, 10 Nov 2022 18:19:43 +0100
Message-Id: <20221110171952.34207-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of [1] with no changes, like v3 which didn't mae it to
mailing lists for some reason.

This series:
- moves max fingers number and irqhandler settings in a struct
- adds support for msg2138 touchscreen
- adds support for buttons, which were only seen with msg2138 as of yet

Big thanks to Stephan Gerhold <stephan@gerhold.net> for the help with
deciphering the downstream driver [2] and writing clean and working code.

[1] https://lore.kernel.org/linux-input/20220124212611.752603-1-vincent.knecht@mailoo.org/
[2] https://github.com/LineageOS/android_kernel_huawei_msm8916/blob/2f24fa58086a969687434b40f237cb589a1f324f/drivers/input/touchscreen/mstar/msg2138_qc.c

Vincent Knecht (5):
  Input: msg2638 - Set max finger number and irqhandler from driver data
  dt-bindings: input: touchscreen: msg2638: Document msg2138 support
  Input: msg2638 - Add support for msg2138
  dt-bindings: input: touchscreen: msg2638: Document keys support
  Input: msg2638 - Add support for msg2138 key events

 .../input/touchscreen/mstar,msg2638.yaml      |   8 +-
 drivers/input/touchscreen/msg2638.c           | 182 ++++++++++++++++--
 2 files changed, 175 insertions(+), 15 deletions(-)

-- 
2.38.1



