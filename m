Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB776A8772
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjCBQ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 11:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCBQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:59:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4B525975;
        Thu,  2 Mar 2023 08:59:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cw28so21073606edb.5;
        Thu, 02 Mar 2023 08:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677776393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBZBNslhtwlIzlUkHWxR7XOVSQ6+M0SjUmCkItVPLxw=;
        b=hIWwZQaphQFIlBeWy/YHad+gu9IXge/z9zUs/TxBp52fxwsQtFKFOl/VBz+dUUrhW6
         Z42IRXSmBdUXecuduyR8BY10OPbASajVmFl364VSd6SGu1r0a1aMkX3EU13vYFmcs42l
         Gmpn+cj+Ya7AdJ6hSVQ6oCoTVwJLzHTKadgekQEBt0zNoznYX1yPIFlinGxU+QYtICw5
         CMdf8XCfC4fCHQmoV8Z/ef6Hpm7AHq0tg/I6Hbdz4/JsB+pmTMJhz0XD5kNdmrDW4F3i
         zvXioByq/UOJkJ6IfYjdYuN7zwQe6liacCg8nREG/DRJB6YLGOr/WGcNkXlxTd5obv2e
         AWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677776393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBZBNslhtwlIzlUkHWxR7XOVSQ6+M0SjUmCkItVPLxw=;
        b=uj0AWPNtbumrwMB/u+hoW6AxKu7eYVBQ4uGlm2zI3PtPJKmQ9QTZ7EcZQ+qCnyjjnT
         dJ4OkutrzCwjLrPuY4qOkQ7CxwPbobdErTAdWMJX6+PF/6WJqZoMfJZspOCp67NzACQp
         SpWSOtaRghbrcdk8cFcJVURyJ1OeWZmsY9odPF1Nhex+VRRuvacvHjN6qdiz+CAlHyyV
         BvYW9+zW5qRR8VKCZ3YX6F4ioPvfaGKot4/pwcPRNEOaYN7ND87toZxV52reZscfA61b
         X7/RmEHLA7z5SE/Qies9FEVVpoARKSIQDp7we22uCsKDvjOjGwwnpzWOotNwfjz75INW
         4jHw==
X-Gm-Message-State: AO0yUKVyyLL3ZQoYKaTvQsRsbFKybEmm2fnc+YBG29vL3OG1Ioyf3ZqO
        a4z9tJW9+fqzh7Qthv5iGjypbE2Bb4I=
X-Google-Smtp-Source: AK7set8k62H0tqVcoPpTkhWBbYRPxLzWoHl+dxM/Usmc5uMh03YrDqSV7J5wtztCGcsWKlaxUQrISQ==
X-Received: by 2002:a05:6402:164a:b0:4ae:e4ec:cf9d with SMTP id s10-20020a056402164a00b004aee4eccf9dmr2933039edx.9.1677776392876;
        Thu, 02 Mar 2023 08:59:52 -0800 (PST)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id up22-20020a170907cc9600b008ee84860964sm7256745ejc.35.2023.03.02.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 08:59:52 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.3-rc1
Date:   Thu,  2 Mar 2023 17:59:43 +0100
Message-Id: <20230302165943.254479-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.39.1
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

Hi Linus,

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.3-rc1

for you to fetch changes up to f7c4d9b133c7a04ca619355574e96b6abf209fba:

  rbd: avoid use-after-free in do_rbd_add() when rbd_dev_create() fails (2023-02-26 20:03:14 +0100)

----------------------------------------------------------------
Two small fixes from Xiubo and myself, marked for stable.

----------------------------------------------------------------
Ilya Dryomov (1):
      rbd: avoid use-after-free in do_rbd_add() when rbd_dev_create() fails

Xiubo Li (1):
      ceph: update the time stamps and try to drop the suid/sgid

 drivers/block/rbd.c | 20 +++++++++-----------
 fs/ceph/file.c      |  8 ++++++++
 2 files changed, 17 insertions(+), 11 deletions(-)
