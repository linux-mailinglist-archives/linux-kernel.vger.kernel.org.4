Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A4D63A954
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiK1NUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiK1NTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:19:51 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B91F9DD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:18:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vp12so24413973ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CzsKmQ/JNcqP1IAM5kkjrzrabag01L0YrvSh7VIxqOg=;
        b=GvpNIdrtSxAMpdYe4bLJQOWncgZFUNJlbduQFYQ1WkSkKbMURP2Ga/73TuaojMWaQq
         zrbO05nHC7kVlCnsh+o+3G4+nhSEEpJsestHCQgtJrJXllOyX3ieU6HZHxONrSW1Sdll
         Oh/XXDOJ9wv8ZZEjRNbExmcd1Hsy73/o50aq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzsKmQ/JNcqP1IAM5kkjrzrabag01L0YrvSh7VIxqOg=;
        b=72p5S1PeS42A+MS5plstRi7uJ7WVzwMGNEGiMsEpQA/6rdXvWkiVFhAUjbQP2BUCKx
         ZvRSbjfwCScXn4Z6zxZ+niyd5EnGf+75ymENjj2TVmd801kasRoVpO2tnSMbmyhOoGZD
         urh956Z+uXSdY28LyWxHvXdlMt25piksFvhP6KU+QM3IAMPtOwYfdm6PadrgBnpR+BK/
         brMKnp/j8yILQ4hsDahMxRyeCXyjjGjPgb5zhRbnTJ98ZOZIHSxJOAEajrQFjh6bu7xv
         vOKFx//i15p1osukYNwrEeAuICIBp3ulUsyXr3vAq0PIOnF6HTAMBFGSIrWtOCLvfGcr
         BxRg==
X-Gm-Message-State: ANoB5pnJ+ZXmlZLl3HSPXK6skadxJRAeOWROShiNU9/5ixqendvhdSge
        CSVLapgcMwnnV/7ydzVXR9uMHQ==
X-Google-Smtp-Source: AA0mqf4ZMthsJUb+2jIiRdscWm5XMBnxT9GhgyF+d8Q1b4p6XDKsRp5D3c3DqVPKFIPsXdL2P35QuQ==
X-Received: by 2002:a17:907:76b7:b0:7bc:aea6:e89a with SMTP id jw23-20020a17090776b700b007bcaea6e89amr13615806ejc.671.1669641483214;
        Mon, 28 Nov 2022 05:18:03 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (91-82-180-126.pool.digikabel.hu. [91.82.180.126])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b007b2b98e1f2dsm4903072ejc.122.2022.11.28.05.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:18:02 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:18:00 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse fixes for 6.1-rc8
Message-ID: <Y4S1CNZ6Zk6k1SVn@miu.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-fixes-6.1-rc8

Fix a regression introduced in -rc4.

Thanks,
Miklos

----------------------------------------------------------------
Miklos Szeredi (1):
      fuse: lock inode unconditionally in fuse_fallocate()

---
 fs/fuse/file.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)
