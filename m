Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33D261A548
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiKDXBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiKDXBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:01:07 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985482FC1B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:01:06 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id i8-20020a170902c94800b0018712ccd6bbso4447202pla.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzksqxZzngSMnVq4LNIxjbY1eQuHqjVmZsqNyLkHpLQ=;
        b=BIBsVrxM73h3e1apgZ8GqU8UNyKW2HQO0OE44bbRUUT2OwpePR3ksSeoLDIF2AAppi
         UIvjXfIZw49dRr5/3v10oZ8lc5T4uPjeV/3CGwjrqgx0buubBD8+N4gLUeuJaN0NYmOG
         OecG9IMwFWLDFm0hRdU8UOZmOh0C6d++yXgxgfV3JZmREWL5YSlUHX+ExpsRQ1FG2Hug
         fgm3pE7U7RMfGNdDVyG/8tzKc+SHK18KiVIT6HKOW0XsOvxQa3LGQ9HctRR9Pq3gdd/6
         7M5H5aK29XyvTmiBstvkHci0qjyG4M91NxCGr+1PprGcPrD0XVSzWCnoKLmhACWt/u6y
         zJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vzksqxZzngSMnVq4LNIxjbY1eQuHqjVmZsqNyLkHpLQ=;
        b=Or6dpAX2rrQNBsDSS+xyqMFUQZKH29tjlS+BndrKgdaaG2x5p9U8sPQCSknm2btlrm
         /1YWdpUh2hCzc0H2UM2ZM7J3mZc2RArJo+Npw4NefcHh++P9/0HzD2sVZHa8rPKpi9Vs
         TQ316UkNPkiAQa8o/EK1RRuwdshBG/SF2GTnIbuQkP2lGLlKPvTKcEi11olKT1E5SC1l
         zB9Pdtwg4ad/BMeqAss2530JKLFUbvVOGby40mM9jLSbkZPssqRFoZTK46iCpZ3YzI96
         D1zTSihHBeQF06qSKDKKQjf955JsYHFqIBBEVIHCw1X0XRhs9Ds5k48/Bh43jR6OymqH
         FT6w==
X-Gm-Message-State: ACrzQf2rN7Ci4n3kjNN2pTzS/ReIqEX6F8Hd1sPexfabgVWb6jwwGDfS
        FkPX32Ls85p+tmTHBlB15I5osT0iI3JLip8xmDwr6R4L04JD0j3358EnufvUQBFZ7MYzo6TteTm
        X/FgGgCcHDaOS+0625xlii111eiVlCNGvn7Ah1V6wbw0n2dOwhhsnu26UnAiee7u8KdPg/+WJKO
        RJ+uSm+yo=
X-Google-Smtp-Source: AMsMyM5L8xHYLm1sG59EUjCuXRw1oWIFhxNIDAHjPypLk91uNjp5P86+/ua2VP1fXQH8V+6zXgNf6f1N/JXk62uVhQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:a383:b0:187:34f6:439d with
 SMTP id x3-20020a170902a38300b0018734f6439dmr22005841pla.35.1667602866059;
 Fri, 04 Nov 2022 16:01:06 -0700 (PDT)
Date:   Fri,  4 Nov 2022 23:00:37 +0000
In-Reply-To: <20221104230040.2346862-1-dionnaglaze@google.com>
Mime-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104230040.2346862-2-dionnaglaze@google.com>
Subject: [PATCH v8 1/4] crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirsky <luto@kernel.org>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dionna Glaze <dionnaglaze@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Gonda <pgonda@google.com>

The PSP can return a "firmware error" code of -1 in circumstances where
the PSP is not actually called. To make this protocol unambiguous, we
add a constant naming the return value.

Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Andy Lutomirsky <luto@kernel.org>
Cc: John Allen <john.allen@amd.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>

Signed-off-by: Peter Gonda <pgonda@google.com>
Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 include/uapi/linux/psp-sev.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 06fc7156c04f..97eb3544ab36 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -444,7 +444,7 @@ static int __sev_platform_init_locked(int *error)
 {
 	struct psp_device *psp = psp_master;
 	struct sev_device *sev;
-	int rc = 0, psp_ret = -1;
+	int rc = 0, psp_ret = SEV_RET_NO_FW_CALL;
 	int (*init_function)(int *error);
 
 	if (!psp || !psp->sev_data)
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63d5cbf..1ad7f0a7e328 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,13 @@ enum {
  * SEV Firmware status code
  */
 typedef enum {
+	/*
+	 * This error code is not in the SEV spec but is added to convey that
+	 * there was an error that prevented the SEV Firmware from being called.
+	 * This is (u32)-1 since the firmware error code is represented as a
+	 * 32-bit integer.
+	 */
+	SEV_RET_NO_FW_CALL = 0xffffffff,
 	SEV_RET_SUCCESS = 0,
 	SEV_RET_INVALID_PLATFORM_STATE,
 	SEV_RET_INVALID_GUEST_STATE,
-- 
2.38.1.431.g37b22c650d-goog

