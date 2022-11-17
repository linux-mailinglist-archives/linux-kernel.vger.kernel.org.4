Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DBA62CF69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 01:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbiKQAU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 19:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKQAU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 19:20:27 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B423445EF1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:20:26 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e189so261010iof.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 16:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPc35w4bL3evLvE6sSs2HbHKwboyoUxdBz09nDskuGU=;
        b=XUW785RYZqcfrRBAl8eP2sSP9ytvjquWdcjBP3fpRgqLQoSIJHB9jJ3Psz2fUzQCWI
         AIeQ1O8fSfm8nDc3OznNIgQ0eMzylxAllMZknOfbjTxvzjfigpbAMIDta4XXhIosMlBo
         QHzIU7qwmhFpE2qoWuigdSgZCw1E1ZaBOSEn0xnD01yrwDzdiByjd+TfB8R0TKVkm3Ge
         RdA7Q+pYFEuw6Mse1JYlIZkQyyhNvo5cgC50InCx/UWw+7Ec4Ih+hnVDPJlvP5+qWZ2q
         DEuOJQ3z6iNoME1vqaSgYiQ6N5jmUTQ6ezt3gHfDcD1HEekL2+krxGG3EjFpiU0Quzy4
         f3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPc35w4bL3evLvE6sSs2HbHKwboyoUxdBz09nDskuGU=;
        b=eYxZYbZOpxNe38HMdmvyEVNzmzXBu7KraEshHr3AJxzpn5oq0pknuIgq0TQSSu8V0a
         R5a+5IjP1pSP4gP/QMwcgIjiuDIMTU4JliOEBbn+ct8hOCr4xwhcMcLznD4Dj8TyfIO1
         24jrN6SQntufqd1WpX8newhml3go8uG1reY21W5sEHSqILT/0uMSfuTVHEOV1GSd97gT
         CO4MvQ9np6/VuMQXuh+FQUDmH5sEAXyzeTY18Y9r9vPLqUl+GHlvSgE+QWxPqwNbbRof
         +qHjjUZfcxYqL3WOfX29rvp07WznJnEIkna65A3NABKUDHkZbrA7M79Qxlxwo70QOaJa
         am1Q==
X-Gm-Message-State: ANoB5pk9DfeNL9smNMrCU95RyWou0MMyfcLeYVkcaldwQGI0/Vw1OfGn
        9rx0jEnr7KERAUsGJ9mxGE4=
X-Google-Smtp-Source: AA0mqf4IqRnoeUvs13DesaVL24P9l0VZfLBCeHLSo3fD/aCEH5Gbn65O4X2xgapqn43rF4k4epZsJA==
X-Received: by 2002:a05:6638:54:b0:363:95e3:c813 with SMTP id a20-20020a056638005400b0036395e3c813mr11701281jap.263.1668644426047;
        Wed, 16 Nov 2022 16:20:26 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o194-20020a0222cb000000b0037556012c63sm6119777jao.132.2022.11.16.16.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 16:20:25 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [driver-core-next] vmlinux.lds.h fix
Date:   Wed, 16 Nov 2022 17:20:20 -0700
Message-Id: <20221117002022.860237-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y20+PqtF+dFAe7hX@kroah.com>
References: <Y20+PqtF+dFAe7hX@kroah.com>
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

hi Greg,

You recently applied to driver-core-next: 2 vmlinux.lds.h patches from
me.  The 2nd has a subtle error, placing the optional header KEEP in
with the data.

1st patch fixes it by dropping the extra KEEP, restoring basic behavior.

2nd redoes the HEADERD_SECTION idea with separate macros, so it cant
affect the basic case.  HEADERD_SECTION is not the name in code, maybe
it should be ?

Also, 2nd is NOT in real/purposeful use yet.

I should have stared at this patchset longer before sending.
sorry about that.

Jim Cromie (2):
  vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL macros
  vmlinux.lds.h: add BOUNDED_SECTION_(PRE|POST)_LABEL_HDR macros

 include/asm-generic/vmlinux.lds.h | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.38.1

