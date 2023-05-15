Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F020970413B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244922AbjEOXAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEOXAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:00:11 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69266D851
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:00:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-307c040797bso4240807f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684191609; x=1686783609;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXdxvlOyQEhsDcWWTIqkz6jHiRdvyr0e8CxqsxNeDis=;
        b=e1/V1uScmFhPeLI9lxpFSJxYkIVJ8dxgysUO6CuFtmmtoDKC07RrrPEp0Y3xOUCmWp
         Z8OwbKBQtHXs8yNSnffPaN4WknHkX7VUN1BDwHmS27QIaNsEncmALLWiUftCs1QGO3kj
         WLVrcPyPENXy+vRQSDASkn3CwVXL4qiD2/ostCIhD+wtGp34OQbp53vMXHzG48JYSbYZ
         v40ColNZV9XWlgf3kcrmHoQujBsBTKCS9/93xp3MaTDl9QghaNpuq/KznVZHHtCI6VuJ
         Uo2Tfi808cm4mqjDz80GxWg2l1vuGTeVmpNiMBg9tt24LhtKBrfVa5uj/ZdwjQ+jJijg
         IkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684191609; x=1686783609;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXdxvlOyQEhsDcWWTIqkz6jHiRdvyr0e8CxqsxNeDis=;
        b=hFErdeOFURQNHS0YolWxqOLilRNAXxPk5o1E51gdc66i5KRC4BpRSwK+36bTkzYXhM
         WgegSF9vviX/PbMXGoPyV4R6tJo/N2CDBewA3XAePWtK/nghLzzNWRUfqRVJ3xamSlxH
         myb851N62HSOw2dzDsYX79Wysgkk4IanI1MGK7RVgDJJ7yafz25NsqE4vWNtvxojjvmt
         LtWJFnrDy28GrnadknlYvDYPg2DerU2G44TZq4oMRAw8DXijxvParIe22EZweRYaiSK9
         mysx1l0UmOzQ8yc8YPpU/W6yUuzC66zh6CbODiDiYXred5MFx74eOC+BcgMmIEGeEFk+
         czbw==
X-Gm-Message-State: AC+VfDzhQ+tcxjUi5wNrL9Ewnnd05AZFdAVc0rpzljtmlngKsDLXyikI
        0WJTjIxUGms42UVvDkz727jbIFWpBP6P0B/2cG0=
X-Google-Smtp-Source: ACHHUZ7XgoIp7c0813Vb8ovh/YT2hv+dVIqkH/ky5jXZW1Iiw5YvTIpmJjaVFokkF0XwKT9H2vPAuD1GAgUK/eKyjDc=
X-Received: by 2002:a5d:55c2:0:b0:306:5149:3aa8 with SMTP id
 i2-20020a5d55c2000000b0030651493aa8mr24578555wrw.24.1684191608477; Mon, 15
 May 2023 16:00:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:f6ca:0:b0:306:2a1a:7c72 with HTTP; Mon, 15 May 2023
 16:00:07 -0700 (PDT)
Reply-To: wijh555@gmail.com
From:   "Dr. Emma Tony" <emmatony797@gmail.com>
Date:   Mon, 15 May 2023 16:00:07 -0700
Message-ID: <CAPTs_W87EdOwejDoG+a_zb2UqvEJMTHxixfSAqhC7TgpxruSNw@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hi,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Best regards
Dr. Emma Tony
