Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FF25FA3E6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbiJJTFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiJJTFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:05:09 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F563ECFF
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:05:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w18so18351665wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 12:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QD8wdvaO6XBs/zfHh26v0oCC9SUgounvKhPdieCAY3o=;
        b=lOfe6l0Q1kuGftEXm9/Yq/X7M4WDGYhWr+oME53Nyu0Qr1cK6ehbciTAZuosWFfLEz
         HinYyEGrtNPn+xMBDV+i5zzmsbVaM970AIugse44Actw41tYxLg68gLuw9DDwQlNiFNd
         817LZfVfRiUiBa0hyitefwmSNTgf+Mm7BPz680HuVqhIDqe/tx4o2y5I0UBb8wBiPwdK
         gLBxv1PsHYLbE8kpgf4yLPLLRlaSvoTQ3gcKRjuZrb22RUZP+hrUFbL44dnzKS3picC5
         0SXoyvLDVw0aTs7DczrQzfChT8H7WfGwTMwq3VqjN+tad9XVks4KU0/36jOzjXG9paUa
         5i5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QD8wdvaO6XBs/zfHh26v0oCC9SUgounvKhPdieCAY3o=;
        b=1kMylyAWzlZgD1U52OXeW/TDCbSt5XC0lWTovMD1ChgWcUt7RwtYLJV4Vcq0ROgMAG
         3vo1tv4abIKeurQR6lX+svDXfOIew+/O3zYmtsjxool8Vv02P6eVp1URCv+7pFlqKxn6
         0I4J7xPyXXwTvSfeqE+488AZJXJFxpfrFZgqv+2igSlTc6TCkJEi6R3LYrt6RMfUnGWn
         zdHw+1e87bWaHD3mzPgHE1nrk+w7mthfSSA6wxp4o6xQCbQHl1wdT+wQP+OMhIDJxVFN
         JGlGADAnL3vAUJJuys3vVnRQxx7EfFFfzMHpj0UtzLH83G6rXiwQgSathY6j4R3O0tZf
         mIfQ==
X-Gm-Message-State: ACrzQf14FO3SAD4vL/pCgJve5KF6A4hTraxsFc6LVJG+IGG9P55kyBj4
        MI4gUooCQx0p4tWFOkv9A0s=
X-Google-Smtp-Source: AMsMyM6HPVmC4Abz5JFMY400zWBGWNlFJ32woPTJV4KfgC3wG/Xfc6cAzCY3z7r7Kc0W9TP74zNPpQ==
X-Received: by 2002:a05:6000:1786:b0:22e:3955:13a1 with SMTP id e6-20020a056000178600b0022e395513a1mr12486277wrg.624.1665428701383;
        Mon, 10 Oct 2022 12:05:01 -0700 (PDT)
Received: from localhost.localdomain ([176.61.123.135])
        by smtp.gmail.com with ESMTPSA id i29-20020a1c541d000000b003c41144b3cfsm8650140wmb.20.2022.10.10.12.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 12:05:00 -0700 (PDT)
From:   Dragan Cvetic <dragan.m.cvetic@gmail.com>
To:     philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.m.cvetic@gmail.com>
Subject: [PATCH 0/3] staging: r8192e: Rename variables in rtl_dm.h
Date:   Mon, 10 Oct 2022 20:04:54 +0100
Message-Id: <20221010190457.13199-1-dragan.m.cvetic@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Rename variables to avoid CamelCase which is not accepted by checkpatch.

No test performed on HW, just build.

Dragan Cvetic (3):
  staging: rtl8192e: Rename CurSTAConnectState and PreSTAConnectState
  staging: rtl8192e: Rename Enable, cck_Rx_path and disabledRF
  staging: rtl8192e: Rename Op, Length and Value

 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 48 +++++++++++-----------
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h | 16 ++++----
 2 files changed, 32 insertions(+), 32 deletions(-)

-- 
2.25.1

