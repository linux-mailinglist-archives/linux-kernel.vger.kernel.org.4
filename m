Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B7701904
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbjEMSKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbjEMSJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:09:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D2E5FF7
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:21 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94ea38c90ccso303364966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684001359; x=1686593359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f90+s7Igr7R0Bh3E9BN/GprSOguGxSIypRawQW0lt1w=;
        b=GBAyjJwgrlQBo4qCirom1I3kazZPGDJHZ8/vLMAev4jETPYQ5ZI8oaf+GfYlRDB+ih
         Hm9HffyZ1EldF6ZrrrnxhFScj9LDNi9JmJEx0wm0zzp5c5HEDHMo8A/cih+DV+sgx2p8
         fK+vQNhNXIEhnYG+ArEnjrk8a6G/RHGPpcJ72HcTPy2fk9RZj8RJdrNB45Leii2kQ9Lt
         kii+y9JQWkh0MSd4iIn0LX+0vJFIRvzNCd/vq3VxroUaOY1sl9pT4mf3dTauY1GLjmxW
         PYC5aFncSAvzVOkT2r5RVj0gdjAAVIiO45Civ66G/Ywno29kQlKqvddTszJi1HOpRkV+
         WFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684001359; x=1686593359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f90+s7Igr7R0Bh3E9BN/GprSOguGxSIypRawQW0lt1w=;
        b=P9rGkJDlpyr0CT18/re1LGO3Iil5PFFkkL+zsQ6m31NlyZiXVtAWj99Z/LMbl0J6vi
         oWlEIdWFXQ21UuawhPbMPi+q7m9rsPKwpY1vuH5OsEljG4lsmykRwbJLkWSYb5enz8wE
         J02O6sWv0i1SZEBfORufZ9AP5O+hU9+volkOvYRPw4/OjJRqnwPRJjzlqUxbwsu/3FBe
         8ieUHCShS8eFBA/E7rhOUEAjMHb1lGQ+sfEIT+IsLDydpG9oxJFpPOEBfaggwC7ZR0cd
         kFBIPlG7hURAYcWgnJkACah6PBCV2fetWpH+5cwwpQTOqlD34/UQIdAk9dZJh//9INWQ
         iiXQ==
X-Gm-Message-State: AC+VfDwhYzT4/A+mHBSvE/djZtawxgnc4kBfCRSTk6WVLJ6HygBBSB2C
        K6D+eEY17uNzCyPO9lk4Y/Y=
X-Google-Smtp-Source: ACHHUZ4HDT3yZlY7XILkad4uBH71A/7AoaB5cNMR6d6DGOHLDzP21vRLhXERUMNrwPu4Il7VkzJqSg==
X-Received: by 2002:a17:906:7a50:b0:94a:5f0d:d9d6 with SMTP id i16-20020a1709067a5000b0094a5f0dd9d6mr23904887ejo.4.1684001359187;
        Sat, 13 May 2023 11:09:19 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57935e01.dip0.t-ipconnect.de. [87.147.94.1])
        by smtp.gmail.com with ESMTPSA id ig25-20020a1709072e1900b0094ee3e4c934sm7039695ejc.221.2023.05.13.11.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 11:09:18 -0700 (PDT)
Date:   Sat, 13 May 2023 20:09:17 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] staging: rtl8192e: Remove undefined function set_security
Message-ID: <bdc9bc3a70ca2b5d86bdd2cb5c815d0b3c67972f.1683960684.git.philipp.g.hortmann@gmail.com>
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

Remove function set_security as it is not defined.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib.h    | 2 --
 drivers/staging/rtl8192e/rtllib_wx.c | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib.h b/drivers/staging/rtl8192e/rtllib.h
index 7be02cfe56fe..cc1ce106678c 100644
--- a/drivers/staging/rtl8192e/rtllib.h
+++ b/drivers/staging/rtl8192e/rtllib.h
@@ -1651,8 +1651,6 @@ struct rtllib_device {
 	};
 
 	/* Callback functions */
-	void (*set_security)(struct net_device *dev,
-			     struct rtllib_security *sec);
 
 	/* Softmac-generated frames (management) are TXed via this
 	 * callback if the flag IEEE_SOFTMAC_SINGLE_QUEUE is
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c b/drivers/staging/rtl8192e/rtllib_wx.c
index 1876ff75c31c..82b537da8b21 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -416,10 +416,6 @@ int rtllib_wx_set_encode(struct rtllib_device *ieee,
 	 */
 	sec.flags |= SEC_LEVEL;
 	sec.level = SEC_LEVEL_1; /* 40 and 104 bit WEP */
-
-	if (ieee->set_security)
-		ieee->set_security(dev, &sec);
-
 	return 0;
 }
 EXPORT_SYMBOL(rtllib_wx_set_encode);
@@ -611,8 +607,6 @@ int rtllib_wx_set_encode_ext(struct rtllib_device *ieee,
 			sec.flags &= ~SEC_LEVEL;
 	}
 done:
-	if (ieee->set_security)
-		ieee->set_security(ieee->dev, &sec);
 	return ret;
 }
 EXPORT_SYMBOL(rtllib_wx_set_encode_ext);
-- 
2.40.1

