Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FBD664DEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 17:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLOQek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 11:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiLOQeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 11:34:37 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95FB879
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:34:36 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i21-20020a056e021d1500b003041b04e3ebso11949279ila.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 08:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKNN3axs1y811QkhsVcYtMf113asLOYvCITq8yCsIOI=;
        b=NMnW7ArpVJwVatykzkZaXdIWS+gXA523zN6o1t+9VrmamiojcU9w5XqhFyz02Uao+0
         TfhCCRSBkSRFZNWJQnkTXli2N9jRx4b/z/XOeDWKcap9pkHvGWtfVf2jY2tI0HNz9IrD
         7zf2TSLoVkti4yvDY+ik42tUGBx6V6M4DczLSrsgzS83JRrnwtSRCNj+89ls5RBadR0S
         UDWDuM3A/BriwGEeBS5yj+tMeMil5Vua0dkzgVamTwiwWHbYLWUXWekGSNciDFFyxS97
         WIIcFYyqSdnv9cSe/Ml2MxHE28ZszIZLxFjIuf/0Oy4IetefvmL9QPE95gT8hQwtsyCa
         Ua0g==
X-Gm-Message-State: ANoB5pkHkSL3gLENhipdK8dm+pIOdAq32N8Nn0SWuzFDVLDvrK7jJR7Y
        CA1G2N672FV3yV/Vp1XUpRCipB1IMlvVvCt8tKcfSCPASJlm
X-Google-Smtp-Source: AA0mqf5FzknCTRgZ5/NnD2luL2tffHnVuVk1MAMWE1nMsEVq82UTqE43Kw9M0nei31X8BWp1l13rVJn/Sof8OhGcbC4QuC/fffzN
MIME-Version: 1.0
X-Received: by 2002:a92:dc04:0:b0:303:1c4d:d32e with SMTP id
 t4-20020a92dc04000000b003031c4dd32emr23700450iln.286.1671122075910; Thu, 15
 Dec 2022 08:34:35 -0800 (PST)
Date:   Thu, 15 Dec 2022 08:34:35 -0800
In-Reply-To: <0000000000006c411605e2f127e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b60c1105efe06dea@google.com>
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
