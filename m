Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367E72D8AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbjFMEf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbjFMEe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:34:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61791DB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:34:34 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b3be39e666so15855955ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686630874; x=1689222874;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qvka6//2uWaQtF0BTHBk1dA62rA7SJ2p/E0dmEtui4=;
        b=CuWsTUsbABTc5hOd8bT0WOWUbcCum4neovT/JXQjY4izeTMp1mmGNN578JJAJuThqr
         gRvb2OM+SGewUPIsHcvcHyOHCNektrCLkRET3vWkpg0bd8NXtKh13w4BxLSmgfgUs9m1
         7G9mGWlRYhtjsDtUtlfj0UZ2lG5wjP93KbkjAw7lYrVpWBrOavnEyga+Lgq0EENLYnSw
         fEs/WdQrKMjwFIbjfH+b/kEMABI9kn2nbB8FbktVszcOfXGUpu2dnKKvj/2jIxLHXt0v
         4/vJPJuIn7BymrDeXyvHEhd1sms3E+hwlWxYt1M86zT6LocMVPvnMgHlhCLv2dW8DDP4
         jQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686630874; x=1689222874;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6qvka6//2uWaQtF0BTHBk1dA62rA7SJ2p/E0dmEtui4=;
        b=OJS9rPUwTR1qmujfzedMpI93rYoA7oNEtuC6KYpinQFDIXh5bQrirbqmiYWDCd3vjn
         dBf+Zl456+7t+4j1Mu4oNhwMrJwTGyhSLKwxhJ8Uktqf8+6TQJWt2041rN3Dfk71wYJC
         6n/IYQ4c4Vxv++ocXFPeCbItlgA9dNgznKEV/wFI7orRu/ts6gjEXzIultwrTgQYV/hN
         hb48cuwnr/xKoL/EYw96CWJWpc0LbUgBPqg2eMPqcf3YOCDnqFSHcPTUhzIw0xEyxLqg
         hd6L54oc1m5ke5QaKH6WLMnlHyKzVr+AytPGRQVqRtY/1aQg2hHZjZCZfWzT8G/K7N/e
         Cc2w==
X-Gm-Message-State: AC+VfDw/+yTX6O467ZxqrfTtEsRQ4DBS36uwlkjBkKbbWyK6X+BUQtFZ
        fTkXUd/wvd1eVseZfvwXzyk=
X-Google-Smtp-Source: ACHHUZ6gZXx27tAfV3kMBiWPTFGugi2tredtGzduwgwFQ9144wq53mfjE7EBrnmgzWsxUghyAumcrA==
X-Received: by 2002:a17:903:54:b0:1b2:421b:6f21 with SMTP id l20-20020a170903005400b001b2421b6f21mr7437782pla.9.1686630873753;
        Mon, 12 Jun 2023 21:34:33 -0700 (PDT)
Received: from [183.173.18.203] ([183.173.18.203])
        by smtp.gmail.com with ESMTPSA id jf6-20020a170903268600b001b3d8ac1b5csm2205865plb.219.2023.06.12.21.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 21:34:32 -0700 (PDT)
Message-ID: <0c336a41-54fb-2904-42e2-1d9ee3950b21@gmail.com>
Date:   Tue, 13 Jun 2023 12:34:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
From:   Tuo Li <islituo@gmail.com>
Subject: [BUG] ntfs: possible data races in ntfs_clear_extent_inode()
To:     anton@tuxera.com, linkinjeon@kernel.org
Cc:     linux-ntfs-dev@lists.sourceforge.net,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        baijiaju1990@outlook.com
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello,

Our static analysis tool finds some possible data races in the NTFS file
system in Linux 6.4.0-rc6.

In most calling contexts, the variable ni->ext.base_ntfs_ino is accessed
with holding the lock ni->extent_lock. Here is an example:

   ntfs_extent_mft_record_free() --> Line 2773 in fs/ntfs/mtf.c
     mutex_lock(&ni->extent_lock); --> Line 2786 in fs/ntfs/mtf.c (Lock 
ni->extent_lock)
     base_ni = ni->ext.base_ntfs_ino; --> Line 2787 in fs/ntfs/mft.c 
(Access ni->ext.base_ntfs_ino)

However, in the following calling contexts:

   ntfs_evict_big_inode() --> Line 2247 in fs/ntfs/inode.c
      ntfs_clear_extent_inode() --> Line 2274 in fs/ntfs/inode.c
         if (!is_bad_inode(VFS_I(ni->ext.base_ntfs_ino))) --> Line 2224 
in fs/ntfs/inode.c (Access ni->ext.base_ntfs_ino)

   ntfs_evict_big_inode() --> Line 2247 in fs/ntfs/inode.c
     ni->ext.base_ntfs_ino = NULL; --> Line 2285 in fs/ntfs/inode.c 
(Access ni->ext.base_ntfs_ino)

the variable ni->ext.base_ntfs_ino is accessed without holding the lock
ni->extent_lock, and thus data races can occur.

I am not quite sure whether these possible data races are real and how 
to fix them if they are real.
Any feedback would be appreciated, thanks!

Reported-by: BassCheck <bass@buaa.edu.cn>

Best wishes,
Tuo Li
