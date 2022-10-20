Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9071A6065DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJTQck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiJTQcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:32:33 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACD31BE411
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:32:32 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h10-20020a056e021d8a00b002f99580de6cso314125ila.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=NBDZnktAZTjRhCsNFoUKwNQ+J799se6RCGwXjEJC1KUfZpUyAgOZZlmrWpdbYnTGDp
         6TB1sZU8CybMAhEeVz3JS7BSfEDnJbnvtOuQA6lfr1Ylut7Lj3qVK+OzPU2H2P0VtCmR
         /g7mrdlo45BFiwXRGmJUdkjEoXnAhOZ7fLEEl5xiec5uM2km0F3y8kARiOxi1Al7iIls
         I2DYS/YF5EM9ugkS6sn+5RjuS+p3wFn2Y0NNTWmhyEIqjhZSS3nibo26GDvFf7mD2r6w
         mYpd7RxZVW96xOCRNHzhEa3fjS6LV8a2FrV2XRHhZ9LNTNia+ppn9IS6kGmbkeOza0q+
         ODGA==
X-Gm-Message-State: ACrzQf0/bKyqOTXcYHNfChN7tDpY+F7d5zXlJM1ZsvqSGRl4WwjVlfo4
        lqQ19S+9S+P2i4yJoLzbjaCuP20OT0seHtb/GMb6KMMtRmJ5
X-Google-Smtp-Source: AMsMyM4FPk0iRiokf85qWc1ZXECTEgMCQq+Q8VRal+EfXVpDu+LSoILYcUwg/tzPl125RD3+HZ/hveGyU+kyJ/AQ4rT8VBRuhcH/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2164:b0:2fa:e426:dc5e with SMTP id
 s4-20020a056e02216400b002fae426dc5emr10321935ilv.213.1666283551925; Thu, 20
 Oct 2022 09:32:31 -0700 (PDT)
Date:   Thu, 20 Oct 2022 09:32:31 -0700
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000352cf605eb79dfde@google.com>
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
