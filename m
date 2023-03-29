Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C9B6CD0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjC2DbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjC2Dak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:30:40 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA640FC;
        Tue, 28 Mar 2023 20:30:20 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a16so12811068pjs.4;
        Tue, 28 Mar 2023 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680060619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtcGDVjaqeuPL/8W91XNPY+pMHVz0BQOB0Aiv4wpJnA=;
        b=qmpshAbCBfuJyN0nxoS0rwN7HMmcs2sIkK+0M41zIOvabJzUxUNgoXdDRpUhtoQPsY
         mlp1UhjMk+5sN4t3PsJjmXw8Mb9r/+mCLfdHWU8lfQA874uRhKis1ZmOWyPJizJJQ/V8
         lHrOaNkRzdQtXMwYzeUhd7lJkL2jbphwXJCp8+G0ZjgWpl+dVts31p5xH9Vu54rPgkGx
         oYFamu0EjSeoxTzEg3MlHAeDZwSU8kcsrVj1PVbsgwMTEVftnG+C56Cm8Uo1BRBUUCjy
         AEYx972gwWKdvr7yLiv/2JLzaSVZnFKRw057/fyfYHV454xC6D7WfaL4LxbCuYBM9Gdq
         1ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680060619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtcGDVjaqeuPL/8W91XNPY+pMHVz0BQOB0Aiv4wpJnA=;
        b=bxXEHxIEDsJWZfTTiv4UjjGjWHka3qne+MIz3lSbhbOidopdrWMFXsoUH9RiXkDV3H
         TPUIBG0mz27ocOr/9Nk+vEHlmTUSg5c1Ox5qRxp2jn21MImtm0FuXFIhbehaUgA/ICBO
         HoDRJCmADmkGlVFyKbbG6kRXD3gpvohHxeLfUkDtx7n8XEk3tLF7hbpSY0ZPRWSFHqjk
         mJIJjcsxVLb1uH1VSy9/FcvnywzGnLHDYes4HHRLKYhsl+MwBKcxZOE9HUISfyg9TEiK
         HHqN1DfWMcVQFA0G7LncrqSeiRGkCrbG4L/9FHwgQGZw3Z53gD02oZXS2yuFuNB+Kjj0
         7CQw==
X-Gm-Message-State: AO0yUKXDRFM5l9Q4+AwH95CGRAGktCXdCaFu7lhwYrY7F2HbbJM9F6Mx
        wCQtn+mq639Jg+c0m9hV7Xw=
X-Google-Smtp-Source: AK7set+CTVBUTdTSSPwN58myXR04b8IPcF1+KE3BwukRJc4IVqatk69et9J/h/7SjjKJY6HQXGTiRw==
X-Received: by 2002:a05:6a20:c41f:b0:db:6237:e76 with SMTP id en31-20020a056a20c41f00b000db62370e76mr13881116pzb.15.1680060619295;
        Tue, 28 Mar 2023 20:30:19 -0700 (PDT)
Received: from mac.. ([2401:4900:1cb9:b52a:d09c:44e6:8975:d681])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7800e000000b0062d8e79ea22sm4100116pfi.40.2023.03.28.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 20:30:18 -0700 (PDT)
From:   Piyush Thange <pthange19@gmail.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org,
        Piyush Thange <pthange19@gmail.com>
Subject: [PATCH] usb:dwc:core.h Fixed warning of documentation
Date:   Wed, 29 Mar 2023 08:59:38 +0530
Message-Id: <20230329032938.225211-1-pthange19@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While compiling documentation a following warning is generated.
Function parameter or member 'resume_hs_terminations' not described 
in 'dwc3'

One more warning arises in the same file as follows
Function parameter or member 'gfladj_refclk_lpm_sel' not described 
in 'dwc3'

I need some insights on this.

Signed-off-by: Piyush Thange <pthange19@gmail.com>
---
 drivers/usb/dwc3/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 582ebd9cf9c2..4743e918dcaf 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1098,7 +1098,7 @@ struct dwc3_scratchpad_array {
  *			change quirk.
  * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
  *			check during HS transmit.
- * @resume-hs-terminations: Set if we enable quirk for fixing improper crc
+ * @resume_hs_terminations: Set if we enable quirk for fixing improper crc
  *			generation after resume from suspend.
  * @parkmode_disable_ss_quirk: set if we need to disable all SuperSpeed
  *			instances in park mode.
-- 
2.40.0

