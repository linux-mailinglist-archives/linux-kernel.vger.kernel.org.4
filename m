Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7805F6038
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiJFEkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJFEkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:40:20 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3580B20194
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 21:40:19 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id g130so780919oia.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 21:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8+QttvtGihQvGWVDrrPa8kESIqJl70gBVM/P5ypKNYg=;
        b=beRofpoX3XlsB548TK3/LzBzadhoAmUJMt58SE6HtXgInNqvNbD+gWPsqDxjpcU8sX
         IdRx3rovpS54+esJho1FqjwcelBoRyjWbZ6FYm3RMENiR4S70xWYMh6u+y9katy4d4hh
         eotQSl9siSMFyQIQDvIE0Qv7y1BulvGLVS3R2q8EKGUnCN4QmG5WxHRkblCjHJBkO+mI
         S9guIxhERwVTmtErZQMhjKHRZKyKACVgS3Cc/XAQ9o3N6WVuJD5mEnaSnh0tQctZ90+0
         d/HiusDgNMhP9+IEAz4huec4k6FbYYQ3XIXxfV8RiWz7fWc6TYVbm34jfuuZ3GUDCZCG
         xYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+QttvtGihQvGWVDrrPa8kESIqJl70gBVM/P5ypKNYg=;
        b=DLcboq4embYvZYDYx1hZUtoKBwQU/mBosqkYQCCibXxR/KbCnBD6YbpHHcEW3u6tsP
         4AZBP89+bT1ddROERuqBbk5q+mwHR8rVKkHOTlLnDQ7Bo+nHpgnaqfUbA7VeghCZXlWX
         LhsnSyHiPkffBbS5bYA5oB3NyhVi/Gn0jPCh96RTkbR/EDv7BQ53HIhzNI8H/0oHMUyU
         vitfdB5/4+FqefHIQT9DJ/KqYwxUDmN1a3okcplEEBX0awEMekn37W7aAUbGzk9XGyWU
         x3XJyb5OJaKZ4HNlOQ4wHjnnzzKMux0B67YtHEiF9G7F9CzN/OLwr3gZ7GCxpOR3h5Zs
         ttjA==
X-Gm-Message-State: ACrzQf0LbVHzT0XdBHeYaVXMchVDNyQU5GjxphvUuYKTywHPbU0nocfG
        VvqsiIwiDKa3VG91lInbnygTYKjCeCt2guy+9cghmDq6dJg=
X-Google-Smtp-Source: AMsMyM6T52z1ktm6hz3cxvmEqYL+6DTn7dg+q022Cey87c/FlT3qx81piw6GVC0GBxIs9ZzPxnQGcVbjydrA2Cl5Byo=
X-Received: by 2002:a54:4805:0:b0:34f:dd96:499f with SMTP id
 j5-20020a544805000000b0034fdd96499fmr4191215oij.276.1665031218401; Wed, 05
 Oct 2022 21:40:18 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Maser <jonmaser8@gmail.com>
Date:   Wed, 5 Oct 2022 21:40:07 -0700
Message-ID: <CAF=mWJMvmrMjFj9f_iPSREG4n9JHu2ZeNM1xJe1V2ePQSDafeA@mail.gmail.com>
Subject: Some ideas
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lkdoc = parses code and dev comments for eMacs
Compiling Linux against g++ may take some coding
And specific eMacs configs for Linux kernel development on the site

Also check out the inline keyword in c, lets you use asm, and I think
asm is like you just feed a register data and it does it's magic

Thanks

Jon maser
