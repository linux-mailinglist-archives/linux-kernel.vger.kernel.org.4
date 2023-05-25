Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF9A71107A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjEYQIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjEYQIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:08:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2F610F5
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:18 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-52c30fa5271so1051270a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685030898; x=1687622898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEv45uJta0uzHG0bC+JhZzCb4VSE8MHC7EtFPn9iTPw=;
        b=JDnDL2rZqzVJE3Vwd5HUCn5bmJ8Z24AepAKBASGbdeEPmPgG6N6Z4GbpoGieWvAFEx
         Ldv/jYPJlzSBM4Q5ep/PAu3+ecTcs2puJhTAf8y8Fkr+RmZ5WSEoeYIr+EbSmnvT7q93
         BGP/4kh1w5C0E/03ferCO1lZ7s4n3/bWcauRbtEeQJZbwl9NZcjQDckDPx1YYSOfXxNl
         rQhHjFOzRVs1TdMPK1Wnl5ZQyM870UbePXlRMOpPJOTos6huq/DEdfvYv8uB9qgZWnwi
         OUTLMindhK60AXQfc6uFTKYx0UPn9mEBAaLEFNjQvR1FNPJ2dO+GM8Xhfs4aQED492/k
         XydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685030898; x=1687622898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEv45uJta0uzHG0bC+JhZzCb4VSE8MHC7EtFPn9iTPw=;
        b=ZZhdWGLeGVQz8uCV2rcMokDT9VFmLh8TDOccPoh0ZSeFAdCbkBeQ4nHXJWR2LTyrks
         ZKiSBf/7Sc4OxKSOa1xIPX0COwHBpFAzAdklvTPYPxawl7Vmdfw/Dl4xnsL8XodPWSib
         LwutnpwWjaSKZNRBE+UIfCiMRMQdOPVdW37rApg/28jBN/DHfa0xsEAtSvcOtqnN3WYY
         jRNvCmcF5dCNd2hM/O7ca16gpQgaQ3N8LFnJO3qwf7xGvRlOIbLSKFDquuu+4x7ModQG
         pb/CyPL3DPtx0lFmdJHVgDwlnB1rvkSvugfmjH6dTjkhDG+LWOcCniOs7cRfWBbv8p7r
         wdyw==
X-Gm-Message-State: AC+VfDzV/IqQxLqM8kJPSgkdN7AvP1ehZQ18hVDuQORVvB/cnZeKvwrG
        5mvyL80tn+J6NXU7VO+B6Iw=
X-Google-Smtp-Source: ACHHUZ6uW6fsUfZe/Jt0KEvH/QJobmdMYQHctdVJvfxIo/e7nZPdKSFfHXUir4tn20X6SvBwZ36eBQ==
X-Received: by 2002:a17:902:b10d:b0:1ac:a28e:4b1d with SMTP id q13-20020a170902b10d00b001aca28e4b1dmr2237384plr.34.1685030897726;
        Thu, 25 May 2023 09:08:17 -0700 (PDT)
Received: from ubuntu777.domain.name (36-228-81-153.dynamic-ip.hinet.net. [36.228.81.153])
        by smtp.gmail.com with ESMTPSA id s3-20020a170902a50300b001ab12ccc2a7sm1611450plq.98.2023.05.25.09.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 09:08:17 -0700 (PDT)
From:   Min-Hua Chen <minhuadotchen@gmail.com>
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Min-Hua Chen <minhuadotchen@gmail.com>
Subject: [RESEND PATCH 0/2] ARC: fix THREAD_SHIFT and rename 16KSTACKS
Date:   Fri, 26 May 2023 00:08:10 +0800
Message-Id: <20230525160813.39408-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When I read the arch/arc code, I first noticed that the
definition of THREAD_SHIFT looks incorrect and the
description of 16KSTACKS looks confusing because there are
multiple definitions of PAGE_SHIFT. So I submit
these patches to address the issues I found.


Min-Hua Chen (2):
  ARC: fix incorrect THREAD_SHIFT definition
  ARC: rename 16KSTACKS to DEBUG_STACKS

 arch/arc/Kconfig.debug             | 7 ++++---
 arch/arc/include/asm/thread_info.h | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1

