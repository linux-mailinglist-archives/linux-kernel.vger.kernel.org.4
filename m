Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6685BCEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiISO1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiISO1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:27:45 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E7326134
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:27:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id q11so17523895qkc.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 07:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=Mt5NqLIpZohSANfmYMh8mk/tMtpJZlQj8cgMWB45y0s=;
        b=I3/GRIf1RcI9/7K0oF1bOlHdLy3zi65j1yqCceu6T0nLRimx3cZkWA3svYL/fIJzIj
         +Sq8Cae1HWIK58EIW0QiKTH2Ca/qwx2qBzM6K2TLl8RgwRmdY5KJfO30B6h5wzeC8uN/
         YSqgOsjHcHjEgmXUotpie7H2n36mkIElmO3iY6G+31n/F34KrpWcs+7yWWDlNsBIFIFE
         YWFF8LhmKT/szqVROaohNoy++kD2OvGZQRzCRdZ5049nSQ6cmDQUjz9vUrCAKQoJnune
         Uo6/RWF9dmI7c1DOORG0UatSYS/7z2pWP+1A72/wTwbgXtCjtuFSj7XpjDqY29iny1d9
         CZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Mt5NqLIpZohSANfmYMh8mk/tMtpJZlQj8cgMWB45y0s=;
        b=lgsXQ6eVB2qqf80uBzzsLQHTKVxkKpFldNT6IcpnPdBy6t5/Q+sAeQK85TI3lvhi1X
         Qb8WPzNoXzKpDArSEC3nRgXWEAAyt0+ntKX262cfaQ2U3aEjrYYhvU5AxEUhpom0+nf1
         OdgKW6EN0St8fCguEeHVPaJRcu4xYlOnpI6BaRSq8pDkDQqvAdsI173byjabMOgCdCZJ
         kmhT5eHVw51pC2T8tovnuw8eZzdts32ZcDAAUhhPF4XsbJwiOEa89boki/lzeIZCEb+y
         PFnc5Xb4rqLOsaQMeRiq1ivPxRFJWOhN7j7bOiwQEcxsj3G7/K+HW/dRtnH9IP3px1W0
         HjIg==
X-Gm-Message-State: ACrzQf1jSQTBmKNWastOs39AVczuxPoHGHnYIL2vCh+6B8ncCRXNh2Vt
        SrDyCHXiC0Wr1RsGMiSH928=
X-Google-Smtp-Source: AMsMyM5l12JtH8fP+nqVzawVrelIn/45yRWJBuLS9inKsM7UKSe9S64nL/kY9frgKCIt+ahI+h1q1A==
X-Received: by 2002:a37:464f:0:b0:6ce:5821:496e with SMTP id t76-20020a37464f000000b006ce5821496emr13073475qka.88.1663597663561;
        Mon, 19 Sep 2022 07:27:43 -0700 (PDT)
Received: from localhost.localdomain ([142.126.147.56])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a424800b006ce5fe31c2dsm13378507qko.65.2022.09.19.07.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:27:43 -0700 (PDT)
From:   Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     f3sch.git@outlook.com, guozihua@huawei.com,
        linux-staging@lists.linux.dev, aruna.hewapathirane@gmail.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: rtl8192e: Removes blank line
Date:   Mon, 19 Sep 2022 10:27:26 -0400
Message-Id: <20220919142726.9101-1-aruna.hewapathirane@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes checkpatch multiple
blank line issue

Signed-off-by: Aruna Hewapathirane <aruna.hewapathirane@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_tx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
index 933f347fc17e..ee7c1a5e93c6 100644
--- a/drivers/staging/rtl8192e/rtllib_tx.c
+++ b/drivers/staging/rtl8192e/rtllib_tx.c
@@ -895,7 +895,6 @@ static int rtllib_xmit_inter(struct sk_buff *skb, struct net_device *dev)
 				tcb_desc->bTxDisableRateFallBack = 1;
 			}
 
-
 			tcb_desc->RATRIndex = 7;
 			tcb_desc->bTxUseDriverAssingedRate = 1;
 		} else {
-- 
2.30.2

