Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02954723EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbjFFKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237629AbjFFKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 06:05:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79780121
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 03:05:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-777399706ceso379428239f.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 03:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686045910; x=1688637910;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UkhkPWN4vtdwEgDSbXtWkYaQGXdhTwsGfVwAerMvqU=;
        b=JxYtRj4yVTIUluFDZE6PW2dEEyAROfvCO0Odyg6E7pLN/9fkhNwazx0kgJCjNK4sbe
         sEeGvtm+9ZtqcmnDzZuAH6nSP644dDT6UpGr0xBJI2CdUgqtWBeTiluJ/0WpuOA9WSR2
         yDRTvUgRvFS4pVOokxu4kE7RzjCsZfSZLZ3flidDvyujx0O/lq/O8pOUQBsAgENb+oeI
         PD9yWUjtktAhXL5ECRzKQGyT7fqNiDLKI4SB3U+/fwsDDBPyw3r5jyIs67WVWO7efejH
         i76lb/GNhb1pn4XJzvBNI9FB0liTDTnVzm710ZLTbRdb5GipBkQzAnGVfhX/R5wAD+Vu
         qZCQ==
X-Gm-Message-State: AC+VfDyc+3wbvxLnIU2dY5BYS7H6Y9GKFXd2yqLvhk/b5jRUNdGKWWIi
        IP1KiLmJe4HkQ+w7NmYkLPoGLMhlC+s2XqbPGC50iGsRsBQ8
X-Google-Smtp-Source: ACHHUZ5XcFcHS+R2q5jms9GgOuXY8+wwBs8QTwllngSwldtC94cHSzKdy7YXUkvMkpkBQucIYvtsXVx1MFlI7PrN2OQqOo1LizqN
MIME-Version: 1.0
X-Received: by 2002:a02:9663:0:b0:40f:9ab9:c438 with SMTP id
 c90-20020a029663000000b0040f9ab9c438mr651395jai.3.1686045909882; Tue, 06 Jun
 2023 03:05:09 -0700 (PDT)
Date:   Tue, 06 Jun 2023 03:05:09 -0700
In-Reply-To: <CAJfpegtY5gpWnT9LqUeaL=QWWDtp9n=YCi9dBWu9cHxZ=7C9Og@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088a1c505fd732771@google.com>
Subject: Re: [syzbot] WARNING: locking bug in take_dentry_name_snapshot
From:   syzbot <syzbot+5a195884ee3ad761db4e@syzkaller.appspotmail.com>
To:     miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz dup: BUG: unable to handle kernel paging request in

can't find the dup bug

> take_dentry_name_snapshot
