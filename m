Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72D26FC360
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 12:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234872AbjEIKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbjEIKDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 06:03:21 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49A2126
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 03:03:19 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-76c5404464fso83177439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 03:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683626599; x=1686218599;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr5A9BHkH8TAVf1Gi5cMOBc0otnHnrtQAO/VtMxvYuU=;
        b=eS9Jvmz598mIZ48UqAJ+vSVt20rynoYuamKWZREUD9QeY91vuEWZcicK/D7GsIazT8
         idQg+2UclxKOwnra/CeKcN9pyus8zfPsd81K//dIYXpPxFlmRLWJnNCkSv9EqGNpH37l
         /Y8rfXJuT8I/Nf4ExhrcwujImieDmogRq/es8KIvaGqexsNi+0ckaeTAzlFxFIQBCKb8
         hMQArQGJ0N4jEGG77MUwCyc4JJLVsgIfm5bo7eC/KrNurVvMlLJIKIUfuzamE/DylLU6
         AihYQAqJeI1hdI3CXoPLm7jziibA/aXcYuLmRQ7p1wGJ/CACZxb89XLCP/zvFzZ/63kN
         Jx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683626599; x=1686218599;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gr5A9BHkH8TAVf1Gi5cMOBc0otnHnrtQAO/VtMxvYuU=;
        b=dxqbLtbTorM+jc0VgsgPayxvK29Tljm3RL9YbhInVOzrabOFVWGVy8GsGfwwghdqPT
         B0VYlZMxRSc0OB226f/+GddyAYo0PVwvBncG6UvPNETYzZhXorgiZa+V36tzZwNN9FHD
         Oq001i8wL3iPQnvPbrzsMq77lsXmSLXrJ95cbQtuigUH+SmjA1bOgOnubSI5XaOx1d0C
         QtfIXBguID/1ra0U3mgK33CEfmAQ24ln0bBVfNb3bOvYdbxxKWHNOYEOmnY3i1MmNiVH
         TUWR7BiKNJiV/mRZWcZDQFFbA+RXL/79hKpBqPrlnbT7nUWSQYu10J56r4tuSQlYiTOW
         xD1Q==
X-Gm-Message-State: AC+VfDwuoB5oqifrQqF4izMYa6tTMFIvzEiKbI/w7GCBmBrofngiverX
        muJOSIFbsGhhi5B1MXmM+uI/gTRMVEgmhywa88U=
X-Google-Smtp-Source: ACHHUZ5O/+H/arWDcBRmVGH1haLasZo31LvB64oNKSSZMfI2pXckgRTxE6TKRi3z/S2Y5YSnPPmH/hor/2YFqJOusk0=
X-Received: by 2002:a25:54b:0:b0:b9d:dcf0:af4e with SMTP id
 72-20020a25054b000000b00b9ddcf0af4emr15866705ybf.37.1683626141085; Tue, 09
 May 2023 02:55:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:68a4:b0:2ec:361:2120 with HTTP; Tue, 9 May 2023
 02:55:40 -0700 (PDT)
Reply-To: jenny@zjwtrading.com
From:   " Z.J.W. TRADING LIMITED." <henryjon2000@gmail.com>
Date:   Tue, 9 May 2023 02:55:40 -0700
Message-ID: <CADmf-eUMcMPfO5zMvwX8en4KzLXg_LpP5x-KHw9-2R-LO7AOgg@mail.gmail.com>
Subject: ... Z.J.W. TRADING LIMITED (GOOD QUANTITY 99% )
To:     henryjon2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.. Hi ,

. CONSTRUCTION MATERIALS High Quality (Zhejiang Willing Foreign
Trading Co.,Ltd) I am a Sales Manager and My name is Quinn We
specialize in Manufacturing and supply of the below products-:
Industrial Chemicals,

Stainless Steel,
Laboratory Chemicals,
Fasterner & Hardware,
CHEMICALS,
Aluminum scrap and Ingot,
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
Email:-jenny@zjwtrading.com
