Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A912B6CABA5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjC0RN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC0RN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:13:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACA62D7C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:13:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so9614497pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679937236;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTxnICyACcYyrkEecWGvFx2Lv9BMykftFbe2Wex0fDc=;
        b=Txo9gHrovk+y74juJztl+stEEUDPT6H73vBBnA5KKkqubPkDnbJC5+RdXUgw4TbOCa
         R96SK0U5QWM36ih6e3JAu942NvucO0CHILGMNU+QbotMNF6jf/T/0Fa1KaiilS6Oex2O
         CHwncFX4IzgJxfYFqWDdONL9ff/eRaPseFklo8/zjaOidbG6ZiHejBlFrIAUCnl8kz3Z
         RRutBIPsf3U5UtYBGWePJeGzx/pg4h1V/aqyVmklG0TJdOVXALLmQx/OVn4v5W5KR2cN
         EImX+91GLPbaVB8V9HEGCzoIdD0ensVZE6iUOHtzyYAjfjruPbJmqpTA7PQWnWWM7hP6
         Jbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679937236;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTxnICyACcYyrkEecWGvFx2Lv9BMykftFbe2Wex0fDc=;
        b=17fw0p21F+thgmpxhVBeWWhfSzLf5MIRlFzx1Z1HVlQVUj+7hx7WtZfypCSb5XF8nK
         HQvTh8GT4Mxlt+k2Vli8sqOOWDJoCQf2XseeG8DPWM0af5V+m5h/gzEocx1T1HXjI+kq
         LgNFyRcwaIUamoQ/rjly053vrAMTJVbrZOp3+vIH5i6d7qri7HsrnH1ExYJqwEBw55w7
         SOpSJ2ktTIopBkyWtE9L3grxhPaqAAiS0oC8+z723jQuQCYhLtuAinPVPuBImFE3cjNx
         BBfDd+BkhhTxy9zizZjgyhj7SEvS3+qdB4tI/EyzGeC8Gk2CWjhXSLrYppFmKNSrqDCg
         4tvA==
X-Gm-Message-State: AAQBX9e54YGbvGac3kUW4zpt0DpE989jubUGpbFy++UBNsgruF9mzv8w
        DBGJExx0vm78HQP4AAz6SXBkCfYZUCeehQ==
X-Google-Smtp-Source: AKy350aqYyOOidnWDAt1JEPXWZkd7QjsEbExpBR1/9gQIiDyaaqIT7L3LNEi2B5t+vdzHlcXRt9SGQ==
X-Received: by 2002:a17:903:64b:b0:1a1:cc9d:3d55 with SMTP id kh11-20020a170903064b00b001a1cc9d3d55mr10073117plb.20.1679937236123;
        Mon, 27 Mar 2023 10:13:56 -0700 (PDT)
Received: from sumitra.com ([59.89.169.114])
        by smtp.gmail.com with ESMTPSA id d2-20020a639742000000b00502e7115cbdsm15560708pgo.51.2023.03.27.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:13:55 -0700 (PDT)
Date:   Mon, 27 Mar 2023 10:13:51 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     outreachy@lists.linux.dev
Subject: [PATCH] staging: rtl8192e: fix line ending with '('
Message-ID: <20230327171351.GA188288@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the first parameter right after the '(' in the function call line.
Align the rest of the parameters to the opening parenthesis.

Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index c1b4e9e7c091..197c0a44ebd6 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1900,10 +1900,9 @@ struct net_device *alloc_rtllib(int sizeof_priv);
 
 /* rtllib_tx.c */
 
-int rtllib_encrypt_fragment(
-	struct rtllib_device *ieee,
-	struct sk_buff *frag,
-	int hdr_len);
+int rtllib_encrypt_fragment(struct rtllib_device *ieee,
+			    struct sk_buff *frag,
+			    int hdr_len);
 
 netdev_tx_t rtllib_xmit(struct sk_buff *skb,  struct net_device *dev);
 void rtllib_txb_free(struct rtllib_txb *txb);
-- 
2.25.1

