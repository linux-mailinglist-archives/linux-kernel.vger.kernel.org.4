Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0040A6ED415
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjDXSFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjDXSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:05:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6FE7D8C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:05:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso4108825b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682359530; x=1684951530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tfmGIk+2aJtglmQ4U+xotZJmfTGbg/l0yn8LVq2SGfo=;
        b=OarNsWC+fF4u+9Ooj0JuFEUiySfJdyWWMfDsKABx+8IhNqooMu67lLrn21b907pxSV
         HF75Bf7Sn4C9W9C1k3x7TXDy2bi9I8G7irqy81QbvEE4g3+COSbEZ9B1sWDFcgyY4/i7
         dfwu2ZtKN/9iv63Q8MJJlyXURJ9BWZQQac4AhCBtyCOBH2msn1kgPqtMjASeQVMHZmqd
         24yBO0+fzkcmstrvItioH7HPnbkajWjknDCCL/X/M188exE7W4VkOXotr9XqVPTJVq2y
         zvyRr3ag+sSVP9CrnTck5sWVuon1wX0N94pP9YEuPkk38AbfJEdqBjhcF/0bxcLaAFWJ
         wLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682359530; x=1684951530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfmGIk+2aJtglmQ4U+xotZJmfTGbg/l0yn8LVq2SGfo=;
        b=RSYpXYbK/4gN6XAWgt/x43RAW9XtjP4XG6yS/rlVXkT399cACpUu3exZoMASOMPADt
         FplQiHrjJqxx+Pbl4rqWYcRMNrO16lzCsTtSZB3a7MrBn0B4XDEWY+GHseKA6X5t6XtA
         Lt8E72ypl0FX2M98ufBd+n3C0FkFnJb2J4Ye6F3NarzoLyNq2REAnVbifRmsMMllCaWm
         K8mcRLX4FkhIMNmj7Np+l9jh16TA+Mx2AiIxA9tsdOMeEdFrQ/IyBHBzI5Sz1H0LuF+2
         2jj0RhHdUmmeU5RJvDKIwutS0+16h+RhYT3Xqw+vWXIK0FBrE+1Xa8z5NUkUwV1Gb5Zc
         s8Xg==
X-Gm-Message-State: AAQBX9ejuxMMlTKtaWIjR2eHVZfJeNeZStogJNoT9OUiHZ9g3S37OWSf
        V7NrEqmVnCyHYkyhiBRbwRUE97Vta+E=
X-Google-Smtp-Source: AKy350b16pqAJrWOT+Sm5OQWm92N7XgAfn7JZrPjyvJrRp8bFYWR1qAMfjPUGAnZ3NPHUNtGl4kMog==
X-Received: by 2002:a05:6a00:a93:b0:63f:1717:b7fa with SMTP id b19-20020a056a000a9300b0063f1717b7famr17891664pfl.24.1682359529639;
        Mon, 24 Apr 2023 11:05:29 -0700 (PDT)
Received: from pop-os.localdomain ([103.251.210.208])
        by smtp.gmail.com with ESMTPSA id h69-20020a628348000000b0063db25e140bsm7666697pfe.32.2023.04.24.11.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 11:05:29 -0700 (PDT)
Date:   Mon, 24 Apr 2023 23:35:25 +0530
From:   Yogesh Hegde <yogi.kernel@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] staging: rtl8192e: Remove unused sens and max_sens
 from r8192_priv struct
Message-ID: <e117e958ada5695975deecfcd442703fd11bba3f.1682358035.git.yogi.kernel@gmail.com>
References: <cover.1682358035.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1682358035.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'sens' and 'max_sens' fields in the 'r8192_priv' structure are no
longer used by the driver. This commit removes these fields.

Suggested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
---

Changes in v5:
    1. Rebased onto latest staging-testing branch

Changes in v4:
    1. Split changes into patch series per feedback from
       gregkh@linuxfoundation.org

Changes in v3:
    -- None

Changes in v2:
    -- None

Changes in v1:
    -- None
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
index 08145e1f814c..ec9e454299a8 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.h
@@ -270,8 +270,6 @@ struct r8192_priv {
 	short	promisc;
 
 	short	chan;
-	short	sens;
-	short	max_sens;
 	bool ps_force;
 
 	u32 irq_mask[2];
-- 
2.34.1

