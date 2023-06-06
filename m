Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107057245AB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237029AbjFFOVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjFFOVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:21:36 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2D4E42;
        Tue,  6 Jun 2023 07:21:34 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-650bacd6250so3446501b3a.2;
        Tue, 06 Jun 2023 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061294; x=1688653294;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3Sf9Lt8+hPPrJoTY+fUete8obKMH8fejefWmlC9/FI=;
        b=UeUAidqFx7rBO2nxxi6L4GJYE7X9615zb4+r6m3hckKh2WOIYsl3N5nNtPp62pBFEx
         Pd+aqX8KxsTdiwmHh68Wmx5JJ2HL6eDGXpNYMUC2uNV5JtZ0AuzD92PKXICRKJnrovlh
         gethZVUjr4D492UTirZc9Rhwcovrp8nTAwIT6xOpH5kAmnNCJhtA0yNl85H8PQEjFL5y
         27AQR6dRFTipnLsyg3axjyF6QzK1wNzzqncQVmcbN+9FYCxJJPhYooe1mLDF1oCsfw6x
         2nANiYI+oY9r+YWc/pbHEQUMFJlDT1mHUyXJPRsfL0otvcbLvtyz+2IE/QmYku8tJciE
         NBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061294; x=1688653294;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3Sf9Lt8+hPPrJoTY+fUete8obKMH8fejefWmlC9/FI=;
        b=WS2EDsl4dqvJUJK7gpHXexY0WuLTYDoaPDKYXk+my0pm74TVok9DqgRXzGs1DX+Fk8
         reWPDVy1sbV4bHk3NIO1/wCRIaKIiZbykTBMle/XrzDWvMchbm5XMVbG7dqEXQ6xJLMm
         QohVLQVB7mhlft+OCsKSVpy5L4XHZaBKvQdAz6TyzZKyKX74vgJ3TXPPirkUuMxz1Bon
         WAByox16bDmBnqlE0bhkINFgpcZqx479np6F2mXX6RoXFLr4T4RUJ1WBtofIqTfx7ay8
         DvBslsCEgo67tVm94u/nOrpD2/rxqxFeYpUJ7Eq0OK0N3PxKcVToe3DYbLYcLXUz4xGm
         7SxQ==
X-Gm-Message-State: AC+VfDwg5GqW7uZZLLGxYAX2nnKl5VQKXSPAAzWYkOHQMuxTQEY25wfa
        Qm6dfj8z3xdiRFvg2YUChaZQs6ey9M4=
X-Google-Smtp-Source: ACHHUZ6mooz2yFQ70Hcr1ZYa+GqnscXOcgPouYNj0XAbEP91ME7qTM0ohd1oUr5OWTLtBVL8dX7c/A==
X-Received: by 2002:a05:6a20:840b:b0:10f:f672:6e88 with SMTP id c11-20020a056a20840b00b0010ff6726e88mr1908527pzd.4.1686061293543;
        Tue, 06 Jun 2023 07:21:33 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id f21-20020aa782d5000000b00640defda6d2sm6899035pfn.207.2023.06.06.07.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:21:33 -0700 (PDT)
Message-ID: <e6047201-7cf1-ecc4-ca68-490142f6f40b@gmail.com>
Date:   Tue, 6 Jun 2023 21:21:23 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Stock image illustration (licensing)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Imagine that there is a new Linux kernel contributor, contributing
documentation patches. As it is the habit from her company, she adds
stock images from various sources (which may or may not be related
to the doc), e.g. freepik or pexels [1], as illustration.

However, on the source file, the image requires attribution. Yet,
the attribution instruction doesn't mention image license (she
attributes as "Illustration of foo by bar on pexels"), hence
all rights reserved. Can that stock image be added to the kernel
docs (which is licensed under GPL)?

PS: none is lawyer here.

Thanks.

[1]: https://www.freepik.com/free-photo/young-man-chatting-via-net-book-during-work-break-coffee-shop-male-sitting-front-open-laptop-computer-with-blank-copy-space-screen-your-text-message-advertising-content_34485193.htm

-- 
An old man doll... just what I always wanted! - Clara
