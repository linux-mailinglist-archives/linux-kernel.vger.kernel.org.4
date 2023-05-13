Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9ABC701903
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbjEMSJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237293AbjEMSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:09:14 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9CB4696
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-965aa9d1d19so307551966b.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684001346; x=1686593346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Y1rZV1MmREzrVxUKPP6KLxWKeW+vjNzBkwfZoTYQPs=;
        b=oW2BTlZv06GJHQgOMs+JHJERgBNw3DCYSrqWmlpjcRvpjzifJMBlQk+N1u8o1iDZS1
         /y6ybJ1ADRb7POgVRx1BnBgla5ndAY9ItiBT0kVY3KowMHoZKBDvcfngAY0qAKH42oXy
         Q3BkaKo8uyMak0jGHeEIMcQP184ll3UtjpWwphGVfkiNlrr/r3Afuq9H/iY1aey7rSoF
         WwBHmYTnp8lPs8u+LghU+hRVoVg76ATY1zUJXXcn8XJa7o1S+k8d5IVfD7045Udt3tMI
         ExZkBVTnC2th0YwgR6PBPyq+RWboqCA3wJer0/GTedRf644VYrAchqPvCZFSJkvcYX2/
         Xjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001346; x=1686593346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Y1rZV1MmREzrVxUKPP6KLxWKeW+vjNzBkwfZoTYQPs=;
        b=hgWIc2CfARx/rjOBEvReVBcfc/HCd/PhpgHh/jRkOp+rZaVp2mqXF/YlgL3xcPCK68
         3/QGaFpme1PDB5h46b9DXOhxaPmQ0dwf0Q36Kby4gbsHPOqpgfdhXisS5BimSRwTqXsG
         prVBXpCalqqdiXYxLJRU75Llrahz5zPYBXmPDktN8eVtgfT1e4HUMwc8wUVIoC88jc5s
         kO8oiPWPyGph3VJQciu46dQGDvUYfqwXyWEq98MIfJei9XxZipo5TBMXkg2rdmiC8buG
         WGCglBbGSyVmq4teN1wM1MGvbr/qeuRZXiEgKdyxKvVwC/DijnA4LOmENsHeAjjzu6gs
         8lrw==
X-Gm-Message-State: AC+VfDyyxwpO5hSRT2QlTQ8m2ZFhCTIviOxYn2N4zQ7EmnIpwUOGyBOA
        ZUmxuKrwQBUIUMevaEkZVGg=
X-Google-Smtp-Source: ACHHUZ50OzxFPaGRr070VMQlCM0/PqcDsup8HIQ/SBm4Mr7SnRdU9WAgTZyuBOqxrMvKZj/0BGPwQg==
X-Received: by 2002:a17:906:217:b0:94f:66af:b1f7 with SMTP id 23-20020a170906021700b0094f66afb1f7mr22946006ejd.1.1684001345848;
        Sat, 13 May 2023 11:09:05 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935e01.dip0.t-ipconnect.de. [87.147.94.1])
        by smtp.gmail.com with ESMTPSA id p15-20020a17090653cf00b0094ebc041e20sm6952776ejo.46.2023.05.13.11.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 11:09:05 -0700 (PDT)
Date:   Sat, 13 May 2023 20:09:03 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] staging: rtl8192e: Remove undefined function reset_port
Message-ID: <faa1fa979b214f709012a8bd65debbcc2bb59049.1683960684.git.philipp.g.hortmann@gmail.com>
References: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function reset_port as it is not defined.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    |  2 --
 drivers/staging/rtl8192e/rtllib_wx.c | 19 -------------------
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index aac71fda4541..cc4247ebea6b 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1661,8 +1661,6 @@ struct rtllib_device {
 	int (*hard_start_xmit)(struct rtllib_txb *txb,
 			       struct net_device *dev);
 
-	int (*reset_port)(struct net_device *dev);
-
 	/* Softmac-generated frames (management) are TXed via this
 	 * callback if the flag IEEE_SOFTMAC_SINGLE_QUEUE is
 	 * not set. As some cards may have different HW queues that
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index d6691f3c7c70..1876ff75c31c 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -420,18 +420,6 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 	if (ieee->set_security)
 		ieee->set_security(dev, &sec);
 
-	/* Do not reset port if card is in Managed mode since resetting will
-	 * generate new IEEE 802.11 authentication which may end up in looping
-	 * with IEEE 802.1X.  If your hardware requires a reset after WEP
-	 * configuration (for example... Prism2), implement the reset_port in
-	 * the callbacks structures used to initialize the 802.11 stack.
-	 */
-	if (ieee->reset_on_keychange &&
-	    ieee->iw_mode != IW_MODE_INFRA &&
-	    ieee->reset_port && ieee->reset_port(dev)) {
-		netdev_dbg(dev, "%s: reset_port failed\n", dev->name);
-		return -EINVAL;
-	}
 	return 0;
 }
 EXPORT_SYMBOL(rtllib_wx_set_encode);
@@ -625,13 +613,6 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 done:
 	if (ieee->set_security)
 		ieee->set_security(ieee->dev, &sec);
-
-	if (ieee->reset_on_keychange &&
-	    ieee->iw_mode != IW_MODE_INFRA &&
-	    ieee->reset_port && ieee->reset_port(dev)) {
-		netdev_dbg(ieee->dev, "Port reset failed\n");
-		return -EINVAL;
-	}
 	return ret;
 }
 EXPORT_SYMBOL(rtllib_wx_set_encode_ext);
-- 
2.40.1

