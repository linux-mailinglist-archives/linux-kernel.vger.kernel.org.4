Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C77F73480D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjFRTpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 15:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRTpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 15:45:02 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DEB128
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 12:44:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51669dd574aso648265a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687117498; x=1689709498;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=idXdS9jRPviKMoRt0bBHppB9dZDM/k9Odq0fiPi3ljQ=;
        b=IlKWWrskmi0qXvsLQAGP2OJCKq8McIK77wKkLTL8KfeFi6SZrWrLJc/Dop3G+CLBIK
         NoHhIWrxBNwviCbn4CAnmikM0G7jeHV/dLI1iViUICWf+Whw12ybhF4bv4LP0y/+Y4t8
         ToQfN/uV/vjcMv7InR+DFZmEcyaV1eJQ5hAUgefr6tS/im+wMHvjs2Wbu/eVw/t3LcuM
         z8J6qv1mjtqbWdBMhsMg2EmRDj4mOOu64UPscpCt/korxciCNKUt2bqLJEN/qK5Nugeb
         PoixWLviM8UspOF8OxFAPfQr5FCYpNIBngAK3+QO5/aR589BgRls9NYZe7rbtCKnrTCR
         TvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687117498; x=1689709498;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=idXdS9jRPviKMoRt0bBHppB9dZDM/k9Odq0fiPi3ljQ=;
        b=JkV4ODgw8diu56qVrLue+GWvEmw8r+Alc+jL+HZP5W0pSYqdEmaldIkWDagDy60LJe
         Hg4eFjIitxJTqwBsEJFwBzJ7dkTnQZ10cok+AlGWsdAjiBVJ3suvWUka4Cd5w6r5FIb4
         19N3fMdRAiLg69OUjIOmnTkmb2+4XAq7qmAWfLihEGf3x6vtrdqxClbhnBB/tXqGUt1N
         2Hl9BBDUV6eNFlp7c5LTDADThFCBtS1bnExJlnVs2D6MP9ecWglwUDHMgZZEXT+9Pydg
         r5ZnhR/NTio6Ve+Ng97P2jDuXB11t1XFK1gAOLf37QAPVcmQoOPNmiK7Pc+gVk+OTlzz
         vx9A==
X-Gm-Message-State: AC+VfDxBkOx8VIaDlbZPB+Ed9r8BMCxXLiHrubdW0LZBCciwP2A/yfgx
        ISJTA0CfEw5uG23oZtBdSa8=
X-Google-Smtp-Source: ACHHUZ6C9zgdZYCqZ85VizVH6aieT5dj7JUJQJdATrVopZdXeyGOlAOhfCEuzDniurqxZDjJabTyNQ==
X-Received: by 2002:a05:6402:42c9:b0:51a:4dd9:4308 with SMTP id i9-20020a05640242c900b0051a4dd94308mr2100323edc.2.1687117497730;
        Sun, 18 Jun 2023 12:44:57 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id i17-20020a05640200d100b005183673f2fcsm9014806edu.69.2023.06.18.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 12:44:56 -0700 (PDT)
Date:   Sun, 18 Jun 2023 21:44:54 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Add missing entry CFG80211 in Kconfig
Message-ID: <20230618194454.GA10653@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing entry CFG80211 in Kconfig to ensure that CFG80211 is
available when selecting hardware rtl8192e.

Fixes: d88b46ce5ab8 ("staging: rtl8192e: Add cfg80211.h and remove defined variables")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202306180620.Ew55XtKJ-lkp@intel.com/
Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
Tested with rtl8192e (WLL6130-D99)
Transferred this patch over wlan connection of rtl8192e
---
 drivers/staging/rtl8192e/rtl8192e/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192e/rtl8192e/Kconfig b/drivers/staging/rtl8192e/rtl8192e/Kconfig
index eae8167f79dd..f8f774a16295 100644
--- a/drivers/staging/rtl8192e/rtl8192e/Kconfig
+++ b/drivers/staging/rtl8192e/rtl8192e/Kconfig
@@ -3,6 +3,7 @@ config RTL8192E
 	tristate "RealTek RTL8192E Wireless LAN NIC driver"
 	depends on PCI && WLAN && RTLLIB
 	depends on m
+	select CFG80211
 	select WIRELESS_EXT
 	select WEXT_PRIV
 	select CRYPTO
-- 
2.40.1

