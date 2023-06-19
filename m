Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D39735AD7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjFSPKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjFSPKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:10:06 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A663DE68
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51a324beca6so4957038a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687187403; x=1689779403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TD4KyJwmLcyQbc53eDQ3FoSu3CT+Si3hOoe+8Vx8cGw=;
        b=E2uiSvQQAPNHpBZb32RR72MmOJ6cKYumOcMuiSSVUg0phsA8mhm1pa9jSx9Hym4aqc
         dYzd61eMBJQA14d9tlDoucGBDk8f5JwGn7ZskCn1AY+nb3hqjXYfZJsXLpA3ma4eALcP
         zD0lPTGeG1jvkMjNMeZUhcKupkB/HcEvIuYQtas3WzWqjbJjE+Hx61XlalfQmc94ADnv
         1fobQVhO4TqzYCffSHQepxZGsOhCqqnAGYWcHv+UvaGIVh7cfNLduTLysoqLDecCtXvS
         hbe+Jbc3XsqZAIm/xhxmnQAkFU7KFxpm0iMktt20glCsN7BbGKwApP7mlH2DJ/zQcl4S
         JbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187403; x=1689779403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD4KyJwmLcyQbc53eDQ3FoSu3CT+Si3hOoe+8Vx8cGw=;
        b=KPKEZWdNDzRR/0sDICoBKIjGLo0f4Ihbmn/s6izVfZXiVw92zh6ipfEsrkRX2GOGuM
         MyDQ0yBsj2sktbSmXURbok/0i99gu6Jm25aGrz6Qq1DDK33SMHswvY0jsDxn703bOyqv
         vCzG7/FPchJ9+HQTyyszx5OsR0aZzMG89S4hK8oHHxq9/VJf9bjfXYN/DS7kevrjMpOs
         PGqWRj7wAzRkFbmm9fu2OiosgoKJXgMenXpBna5ZaJSUSywxNgAKXh5GB/MoIl+E3NMk
         7k3Sl5hkz35JH8Haq+nYmIP3H8HU5/4y9NP1Ym1+Olwv3RjvpBxP+t7r6q0kAUpv1Uz7
         0I4Q==
X-Gm-Message-State: AC+VfDz7T06222D+z4q9Npbi0qfsFI50W/prV4mIfLx635S1QdCjmgPh
        N5+y2ThvxOeJq8oYcUbrCuT9joHFpmo=
X-Google-Smtp-Source: ACHHUZ4lv1LI1EaN8I+nHnwhvD+Z4VbBsYtpegX2mQ62GMDa0k2hbDRPqmcdVIfQdtS802sW8rXNkA==
X-Received: by 2002:a50:ed83:0:b0:51a:2c69:5c74 with SMTP id h3-20020a50ed83000000b0051a2c695c74mr7097975edr.37.1687187402901;
        Mon, 19 Jun 2023 08:10:02 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abbd5.dynamic.kabel-deutschland.de. [95.90.187.213])
        by smtp.gmail.com with ESMTPSA id p6-20020a056402044600b0050488d1d376sm13297186edw.0.2023.06.19.08.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 08:10:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: rtl8192e: some simple cleanups
Date:   Mon, 19 Jun 2023 17:09:49 +0200
Message-ID: <20230619150953.22484-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Four patches with simple coding style cleanups.

Michael Straube (4):
  staging: rtl8192e: clean up brace coding style issues
  staging: rtl8192e: convert else if sequence to switch
  staging: rtl8192e: remove return statement from void function
  staging: rtl8192e: remove comparison to true

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  3 +-
 .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 11 +++---
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  3 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  6 +--
 drivers/staging/rtl8192e/rtllib_softmac.c     | 39 +++++++++++--------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 +-
 7 files changed, 40 insertions(+), 29 deletions(-)

-- 
2.41.0

