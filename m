Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70BF72DDD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbjFMJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241961AbjFMJfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:35:10 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C713E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:35:09 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f9ca59283cso6506831cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686648909; x=1689240909;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EY6u/szPiEF1tn411xY8QwYqvhq+8SPf19l7c3Cz9V4=;
        b=FkTva839ZNNAC5o2CgHkBtRJGxwlLymEEYYIG/0Q80y9uHbxOPuDXkC3EfqNRSQREF
         cZVV/C8dwV8Q/Z6tQUu3VUFLNxAhHxAmNqI4NxmCxeYH185ts9CGQx6HLZ0VTRbPVSwR
         MXYT9n7L/YdjC9BL5LppO3rWkasujkd+kL30XcSH/j8hMD5nKgReXEL7XcUBXwtgUake
         zTfMzG7feiLRArjck/OIFc81eq8AuPg6XbObi+uJXGxvljgokDXT2gjwA81yi2ygb7Xj
         ll2K+Gne1hh9GUT6CHbBtNeEHztAD25+MlHnhD92+d7M6Q+rvlLRd1L3b/UQYXWIXAUH
         01sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686648909; x=1689240909;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EY6u/szPiEF1tn411xY8QwYqvhq+8SPf19l7c3Cz9V4=;
        b=SYIfyN3Ly/M1zMTcq1cBAdcWVFJi4iV0/CmKvSilE8E1V500LfXOjOoK78Eyu5rQQc
         2IvcZKTBJSqs9e6y6m5CNUQn9cJxfAimasbfzD6YOU9tL6na2A2wEbTDCS/X83ijMg2w
         AvEocgzs3MOrD96xk+jX8/RH29j2ScKoPf4xqgzoshVjHC9+6A9CJJl5MxyP5WXsf1FW
         3vycvNosrwJe4GVJHLT6biIvmBNSsUUSLCjJAIsXL10/EgQwOGADXRiWPXB7O4k2HzgU
         IlfhtIsiOIR7ovfYd4xd+j4cF+d95YkyZJxA37F0nlZV6O9FirMY6EN5mzN5Z56sSdJG
         1ePQ==
X-Gm-Message-State: AC+VfDx8IdPi0ziRf5IwIay7/CIOPQ6XiIklq8CZo7QWxotxeAMPK57V
        4choYCOaBbg1pBsaOB1tqSNS5zvAB7LWOkr7eVldRri+N+k=
X-Google-Smtp-Source: ACHHUZ5ZqSRvWt74nYfqjGBGaXiXqxvT7U9C3DUVkx9MI+mzbBDzBkKMO6kxFtEuIP8wKRQvBCg4kJFb18dR6qhJuJs=
X-Received: by 2002:a6b:7614:0:b0:777:4be:8b4b with SMTP id
 g20-20020a6b7614000000b0077704be8b4bmr10244736iom.13.1686648517890; Tue, 13
 Jun 2023 02:28:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:1486:b0:411:b2a0:c2f5 with HTTP; Tue, 13 Jun 2023
 02:28:37 -0700 (PDT)
Reply-To: jenny@zjwtrading.com
From:   " Z.J.W. TRADING LIMITED." <niyazovsherzod031@gmail.com>
Date:   Tue, 13 Jun 2023 02:28:37 -0700
Message-ID: <CAKxnV4wYd8eOPFtA6y9ni-VOeGEtXjSYO2PeyGh9ZWt49VaL8Q@mail.gmail.com>
Subject: ... COPPER SCRAPS PRODUCTS FORM Z.J.W. TRADING LIMITED
To:     niyazovsherzod031@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROMSPACE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. LLDPE & PVC RESIN,

. Good Morning, (Zhejiang Willing Foreign Trading Co.,Ltd) I am a
Sales Manager and My name is Quinn We specialize in Manufacturing and
supply of the below products-: Industrial Chemicals,

Aluminum scrap and Ingot,
Stainless Steel,
Laboratory Chemicals,
Fasterner & Hardware,
CHEMICALS,
Laboratory chemical etc,

Supplier and the price of our products is very competitive.We have
more than 20 years of export experience and so on. If you need Further
information about goods and services, Please feel free to write one of
our representatives.

Best Regards
Z.J.W. TRADING LIMITED.
=E9=82=AF=E9=83=B8=E5=B8=82=E5=BA=B7=E6=9F=9C=E5=8F=B0=E5=8C=BA=E5=88=9B=E6=
=96=B02-2603=E5=8F=B7
Z =E5=92=8C=E6=B1=9F=EF=BC=8C=E4=B8=AD=E5=9B=BD
Email: - jenny@zjwtrading.com
