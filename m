Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3162E20F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbiKQQft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiKQQfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:35:11 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D733922290
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:34:26 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id g13-20020a056602072d00b006c60d59110fso1148638iox.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=bZJ2Jm/9FQu016gUly93xv9PfdHbBJp28SlVdxhpx5g49hSXiQxhLyoj2R/w6Tv4fJ
         wpCjH7cCrj0BNma130zbiUdZTwKKZ6Ah0bslLpWwMjsqgov1pMkNwd9rFhzTZepnVdDy
         c58Wc0+ljqaGZl6c2kYRyq1dl4/XLVTRrDkJto5U2VFd/qzMA62Hy6wMKyJ6s8Qac0fh
         5cc59CoVnXLOQszEM+bb4oPJFEHYZiYF6Ni/PNy9stMzYpUPx7KnKSW5IB5VS7vBtIzB
         eVRJyxe1ZSWIdPdYMQIyWw5P2jemRg3MNk+kLz+b+dy1ZYqG+duMEMI3XdqUDEiRXh/k
         yBIA==
X-Gm-Message-State: ANoB5pnJYFDKlmfpSG8+/WqTsFhwXlslZbL4znTEag/t5e4u/x9BPG3q
        0qirEmQDHNJyzDcOUBoY6AwFj6gbxDgk+Dns4MKKdS1RxfEo
X-Google-Smtp-Source: AA0mqf5cB8zjsOSC8LHfvAYaU0F7H15UOWRCuC2r5ny9Tj6mj8hA5jpRHTg/4LdRqCujB/GD3+SOVZwgGwscKi4bxIBPLJ2kZP0a
MIME-Version: 1.0
X-Received: by 2002:a6b:c990:0:b0:6dd:807d:89a3 with SMTP id
 z138-20020a6bc990000000b006dd807d89a3mr1779863iof.33.1668702866278; Thu, 17
 Nov 2022 08:34:26 -0800 (PST)
Date:   Thu, 17 Nov 2022 08:34:26 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000949d0805edad29fc@google.com>
Subject: Re: kernel BUG in ext4_free_blocks (2)
From:   syzbot <syzbot+15cd994e273307bf5cfa@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, gregkh@linuxfoundation.org,
        lczerner@redhat.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org,
        stable@vger.kernel.org, syzkaller-android-bugs@googlegroups.com,
        tadeusz.struk@linaro.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
ext4: block range must be validated before use in ext4_mb_clear_bb()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
