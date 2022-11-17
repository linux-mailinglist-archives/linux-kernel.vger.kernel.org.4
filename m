Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06DB162E2B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbiKQRQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240456AbiKQRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:16:43 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9304786C2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:16:41 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p184so1844006iof.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1UJKJ8pf9GmMlqeeqLnhs3XLZuu8QowOC2Mwmm6iCM=;
        b=AbW02JDqXdxzis0e8SgkZPMYhgdQSNeT703u1t8J9BUXwlo1wMsDiw6S2Fxa4HlARU
         q3eKDD5fEoDdlBHvHh3r/HgB9zNSwrTQCfw7IjG9fAQglzaso5izJN5P+PQE4EKNwliD
         Znvm27awYZxRDSeHnm2q7/PX4Sx5NsIovw7f1vuvTetbByQoCSxf51iMtfMNmLcWwpvy
         gnbmZbZSwcFMtyOZvvAhxiy62Q1Xb2v+y1f6Aq/qZlg7wpcq21yZWZ58dxW6tNGsaBnj
         8wXCwJCfo+72N8iKT7DV9Nr+HaERlwQWpTalRkFCYI/zeSgNWjLC0ERuSsxL6sr66D7p
         Zjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1UJKJ8pf9GmMlqeeqLnhs3XLZuu8QowOC2Mwmm6iCM=;
        b=KrwpGZlVMWHXNmbUOAI1Tl8wM4juncQfzOe4ZJzn7Tpem7rdRABtAnbvgFUktLkXKd
         w+uWOio/AYeEZ0Tx24ut3t+udL8W+8EKliVkNfLtQGafnSrrBUQugVlIElWhKi0SiOLy
         BKbbc5GeDMh2c5IMCsiAecB4TeSr2rRCgGPomq2MNOOiv0vu7j5NtPXbitTeyxRtev42
         GCH03lfm6Dhvs3Im6XNUQv/P+BUBkHEtvX0qySAQLtiVrkAg8HMvg9DD7oK+nQNE0tAs
         r6MIm5ASqBukivXEIduWxYdvsidj/PuzHVMvfF7LxKB50FnOIxzAY/74s2gks8r4ojly
         CMZw==
X-Gm-Message-State: ANoB5pk3kJxtLC8BgBw6ax9xHGBy3bRXG27+Wbb6J1MDVGUwNZcFoLi7
        tQ7yX27BJOfom8Fyzq91EXQ=
X-Google-Smtp-Source: AA0mqf4u+wA6j4pWPEedp229tT5U2kku4imBuIAnXuP1oMO/Ti/ejpKFaF3oe8wkPlokbMlJc4QZjw==
X-Received: by 2002:a02:6a1d:0:b0:363:c65d:dd06 with SMTP id l29-20020a026a1d000000b00363c65ddd06mr1542046jac.22.1668705401246;
        Thu, 17 Nov 2022 09:16:41 -0800 (PST)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id o1-20020a92d381000000b002faf6559e90sm495322ilo.51.2022.11.17.09.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:16:40 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [driver-core-next] vmlinux.lds.h fix (corrected)
Date:   Thu, 17 Nov 2022 10:16:31 -0700
Message-Id: <20221117171633.923628-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <Y3XU59mj80wvTD6Y@kroah.com>
References: <Y3XU59mj80wvTD6Y@kroah.com>
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

Im not quite sure what went wrong with last rev.
Im intrinsically noisy.  Its hard to fix permamently.

1st patch restores basic BOUNDED_SECTION wo header reservation.

2nd redoes the HEADERED_SECTION idea with separate macros, so it cant
affect the basic case.  I havent actually used this yet.

I should have stared at this patchset longer before sending.
sorry about that.

Jim Cromie (2):
  vmlinux.lds.h: fix BOUNDED_SECTION_(PRE|POST)_LABEL macros
  vmlinux.lds.h: add HEADERED_SECTION_* macros

 include/asm-generic/vmlinux.lds.h | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

-- 
2.38.1

