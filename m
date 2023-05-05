Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49E66F7F13
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjEEI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbjEEI2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 04:28:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA51A11E;
        Fri,  5 May 2023 01:27:18 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaea43def7so9908115ad.2;
        Fri, 05 May 2023 01:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=daqFidHLvKa/EcNnn6OBcwR+180fuSXQS9LXhy9xsZE=;
        b=WR/RC8IpDtjd/NQVXhatZTxqlcONLslMPx2A33Snt09Dg+S8/l/k2aKnhl/9LcdOJG
         luh0303zIr9AsikC6RqyuYlhZmqgq7eyWIe4OK8QmBR4iNsIk43tOj8HwGnIcGca7fSK
         oT4kO+xvYp88oWVlXlantYPLFLYVCCz63Ej2oGBMMzSSb35tGf1NfhCyLtdFlYBeBwwy
         dsg1D8Nn/s9oJy/BH03tmyDYdUJnQkldtUPQHCIDCX2e3uoj/2oN0V81DG+JLCo7aYKF
         aOGZT/3PwyJpvnpUSsPMn3akaiDTUbo1Wel530/4vGh+9HkfHSz+rKJpPnAg1yjSO5Md
         Vk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275237; x=1685867237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=daqFidHLvKa/EcNnn6OBcwR+180fuSXQS9LXhy9xsZE=;
        b=ECw2DcrDjYhYk2vGujI2dK1zI+f/ROmag+Y5dVy6+HkBc184vYizj698cuT3Q5jhP9
         YJ80DbkuGXvhrEInrcQbMVX1G8q4ha1D1t20/0OU6UcNfTVAC8AxueKsxsmsbDB2YlxS
         1//FOcW8dNEyrPbuJTMmjEFQ2ksw68mNRs0Dor1/VdMs8hTNa0iEJyxeA/HErLMRXY78
         gC/BzLk/4oTM38xjCmsbUEkwyDTnzyuXFczuvMIaU8dPQw1zbHQgNe/WKZYSg8OSJ4z8
         juT1efRJE2a2ZkBuv5mFw0YzSzLyq2rL48uSfKsQgjYkHSOUJgIm80aDpvr4IAtJKwLB
         GWTg==
X-Gm-Message-State: AC+VfDxvvHwgh0PVAcjnkG4ifoiu81mpbrteuweIZG3gA4R9GAeBaCjr
        EeILYpk5cdJKAI6/UDM77fE=
X-Google-Smtp-Source: ACHHUZ4xlU+dfD28ynCDzQnJY3sURDPnzL2Yqfn+zjuCWf/WVV9XAqCe9SbKgNUxiGl5W7eTFmogJg==
X-Received: by 2002:a17:902:ba82:b0:1a6:46f2:4365 with SMTP id k2-20020a170902ba8200b001a646f24365mr637903pls.30.1683275237292;
        Fri, 05 May 2023 01:27:17 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id g24-20020a17090a579800b0024dee5cbe29sm9230054pji.27.2023.05.05.01.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:27:16 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CB925106282; Fri,  5 May 2023 15:27:12 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>
Cc:     Oliver Neukum <oliver@neukum.org>, Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 0/3] dc395x stale reference cleanup
Date:   Fri,  5 May 2023 15:27:01 +0700
Message-Id: <20230505082704.16228-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=663; i=bagasdotme@gmail.com; h=from:subject; bh=kwka9U8hThh6aSXKOLT8PUVaTWTF4XwLc0xe/vryNDs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDCkhey9LrL119GZFQ4bFLfaF5xe8vHepoO7Si/nOMS0Sn +wYRL0TOkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRdQ6MDBfX5ZcuOnTdUPXs 2n/i5txHoyZlHzrmGu11U21dnOSFzL+MDDuWX9q/h7+okGn7xJn9cZ/WzPE63PD2uL6ik1D4O/3 94iwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A small stale reference cleanup series for DC395x driver. The shortlog
below should be self-explanatory.

This series is based on for-next branch of scsi tree, but can be applied
to fixes if needed.

Bagas Sanjaya (3):
  MAINTAINERS: Drop DC395x list and site
  Documentation: scsi: dc395x: Replace non-functional twibble.org list
  Documentation: scsi: dc395x: Remove reference to 2.4 driver

 Documentation/scsi/dc395x.rst | 9 ++-------
 MAINTAINERS                   | 4 +---
 2 files changed, 3 insertions(+), 10 deletions(-)


base-commit: d1316c7b9ec3683c4ca531234998c0e5b9e9447c
-- 
An old man doll... just what I always wanted! - Clara

