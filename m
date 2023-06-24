Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBAB73C708
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjFXGEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbjFXGER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:04:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F92957
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-510f866ce78so307452a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586640; x=1690178640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pA2jkr79HAQgO3Z0go7Vrb5Aqnnlcr4ywSCkzPMV9Eo=;
        b=letFtaa02giljSKBhUJXMSlsE80/XLx8rhYD8T02crEkd3ClKKcgnQ7VTO1H3XV7FI
         vzdkL3uAp79g9np/8906vQSACE8gNhpUc3Vf7doCvP5dTUtxWyJKydQ91H17czf/Qoar
         b7AbzUWWecKwopabvEarp1Ojix80ioau8nPnmqvD9h4viuAYyZvjC6+TGsF4WbiMOkpp
         6n9l954XhpDxt9a24vkWoxH4hVfiIi+a+L968ie3S5L/TZou4jqAabyYLceLa1rpA9AB
         1D3/m9OVbvslFsMH9wNPcPGyHXk90Aj05DucbgM5q12NEvmSNUKXyiGsJ8FzsNNlHTJZ
         M4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586640; x=1690178640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pA2jkr79HAQgO3Z0go7Vrb5Aqnnlcr4ywSCkzPMV9Eo=;
        b=cs3QSzq3RC/YimS1QmUe+AitWvwAX/dNdfbDLUq6yOIuHad72/aWPjGDupiOg74IRU
         lrc0j3tdEBmvGRFB3UlmAs8grSuVKGjy/con3AHCAoD0/nmwqSNXU1FciS1KXx2aerOf
         f8r1t2NFm7nwHrzIJIPKDoGAtIwStSTbki0KEBuSvHjTxUAWOKKL9JGselWEt9BPRRFB
         inMMKi21+r615UcJ7w9CxEDCAFlh20/ndlAIvgSr3U/zxmVFNfXbCLuBlZO3bjF/RAkt
         81QHK8xNaXh3PWH1zbi6a/e4a8PZgA9a3hvJkVLKgRe7gq4y1L85uNCXPzafukn7qmQJ
         CAGA==
X-Gm-Message-State: AC+VfDwVLlRRA5J9yNloSTCYUioOasaIgfzEjB9XW2gUPlEzS9ITN0As
        zftk1mVC22U+RBHbyCqvmbVtUXtXZ9U=
X-Google-Smtp-Source: ACHHUZ4bHhttEzXSc2wdcua+iq74NCIJmLE8qVn9FEHU0Rt6VBg0JjUIL52nTOHw7T9sF84wGOdZLA==
X-Received: by 2002:a05:6402:5112:b0:514:a59d:93c5 with SMTP id m18-20020a056402511200b00514a59d93c5mr17018620edd.2.1687586639895;
        Fri, 23 Jun 2023 23:03:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id u22-20020aa7d996000000b0051a26ce312dsm309144eds.71.2023.06.23.23.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:03:56 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:03:54 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] staging: rtl8192e: Remove empty function AdmitTS
Message-ID: <572feb55932b59c7fc652183877698f8b1123d8d.1687583718.git.philipp.g.hortmann@gmail.com>
References: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove call of function and empty function AdmitTS.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtl819x_TSProc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl819x_TSProc.c b/drivers/staging/rtl8192e/rtl819x_TSProc.c
index 7fff20b185f0..474171edb2f9 100644
--- a/drivers/staging/rtl8192e/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192e/rtl819x_TSProc.c
@@ -173,11 +173,6 @@ void TSInitialize(struct rtllib_device *ieee)
 	}
 }
 
-static void AdmitTS(struct rtllib_device *ieee,
-		    struct ts_common_info *pTsCommonInfo, u32 InactTime)
-{
-}
-
 static struct ts_common_info *SearchAdmitTRStream(struct rtllib_device *ieee,
 						  u8 *Addr, u8 TID,
 						  enum tr_select TxRxSelect)
@@ -352,7 +347,6 @@ bool GetTs(struct rtllib_device *ieee, struct ts_common_info **ppTS,
 		pTSInfo->field.ucSchedule = 0;
 
 		MakeTSEntry(*ppTS, Addr, &TSpec, NULL, 0, 0);
-		AdmitTS(ieee, *ppTS, 0);
 		list_add_tail(&((*ppTS)->List), pAddmitList);
 
 		return true;
-- 
2.41.0

