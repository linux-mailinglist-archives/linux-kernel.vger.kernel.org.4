Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B1E665010
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjAJXww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:52:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbjAJXws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:52:48 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FB5551E9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:52:46 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id i127so11488073oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=djmzJMwivyyLiUPOZqyA+F0qeEslqUQz3Lv5wy+yIFo=;
        b=ZNyQw7zYQeYS3aqI9EhBAcrX37oZOd7ZqYFCa8Pg97tIY/LRV69Wq6Aw8hh0xChI8l
         dSeb/ujVcwcuCBEwH9eJh2XUm2JffyImeionbTEjCrzrmEcSgyRkG57Ox5DKiB3SwzUk
         gb5BQgZrFcoK61671tUfPrri/Tk7ztrIVKssxq5ocbRaV1YC+4TDSr+5t9kV7Yp29pSB
         yd6xsNIIToXUypSZ3WMb6FkPDDCtgffNzPUv3jDzdhYsHghPelyvvotKi5BzMSHoQ/Jl
         8s9Jz3ZqcmxjbdIQ1O5kq2sYJ42Rw7LS53vUDV2NG6QO2hjRAZ4VunUPxjeIm/hOR8Z5
         PvDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djmzJMwivyyLiUPOZqyA+F0qeEslqUQz3Lv5wy+yIFo=;
        b=mbrl5zC+Bvg+BINbDApTXenes+s+9NDL4w3Lpcb9VkHRywGTnJxU0bVxvqQGHgqpP2
         pkb54sL4KpW6kDgr3jK32k0LrQ0qG+mLyTMG4xSQ7lWNRxJ6NbloWBeeOzHPPqQodNea
         UC1xgxdcem9VInhmL+QIq/TwW1IcvZGryh9BFlv54SlVQ+gJ5PBHbGwolKk0ClQHXgS3
         pfMkpOh7yh2qLXjd1oPpqyH27Eni1pEfQGBQXZiej5H//HOdD88tKPGLQswvYYxvDQ4F
         51Soxj450AxErwXtFr4kj1rfg1mliKSRbA0MNch8p9nidYc5v2peA7mpfqSgFhH351rt
         JqgQ==
X-Gm-Message-State: AFqh2kr8Lms/U+ad1V7F2u0CvMvp2WGTcAsvxRewbh2UzIk2FEaQsQd9
        AxnY578ZdjWiYoHMi2lLnqwniwMmqVXU6pusK0M=
X-Google-Smtp-Source: AMrXdXsrq8AXTzMY7ALpSeyKvRXQ3IjIBqkuG+5c6TbgW2sgSaIqy6yNKmsn18Z/5/cwekzjTAPWvgZArsRStR67M4c=
X-Received: by 2002:a05:6808:495:b0:35a:6774:8ec0 with SMTP id
 z21-20020a056808049500b0035a67748ec0mr4108989oid.177.1673394766112; Tue, 10
 Jan 2023 15:52:46 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:44cc:b0:dc:e6c4:1349 with HTTP; Tue, 10 Jan 2023
 15:52:45 -0800 (PST)
Reply-To: te463602@gmail.com
From:   "Dr. Woo Nam" <namwoo633@gmail.com>
Date:   Tue, 10 Jan 2023 15:52:45 -0800
Message-ID: <CADGCwd5_WZX-a+BE9w_CGFLxxGZwEebq2jgzFf2ub8euHoxg=g@mail.gmail.com>
Subject: Very Urgent,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
I tried e-mailing you more than twice but my email bounced back
failure, Note this, soonest you receive this email revert to me before
I deliver the message it's importunate, pressing, crucial. Await your
response.

Thanks,
Dr. Woo Nam
