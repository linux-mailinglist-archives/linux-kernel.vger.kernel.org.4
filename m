Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE08961F376
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiKGMhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiKGMha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:37:30 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B40183AC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 04:37:29 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a14-20020a921a0e000000b003016bfa7e50so5121852ila.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 04:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G4j4i1D9g/K0Cayton2okA3A9p6eYtwnuNOgUF/2ByQ=;
        b=hN36ePi9jRZjZaiN58DftOL7svz5znagILa6KcXE6R0RpihzVLXfM4tzDOdZD969kn
         yCW4fkR2aMDt0tgjYPZ1GubKBVE4myZaSHjqVlmlbsdgZ6MPfNwJ5CRf7vspUt4RzW2D
         0F0/ZKH5JB0bPWco16TtF/TLav/e5tqk/TELIlUBj76BUFYY8ApMd8skJhhMxlWV6+3b
         JV8KfVmiXc2GgJa8M0cxm1MZ/JqRB3U/EfbGezgco2/nSqHuiYpgam2T50ckaVNB2FPy
         BpHkUVTLlUOqdKX/nClL29IW6gx20lK6dO9f2H7XYznKmj6NRWhrwShx5zkrL/srPlxy
         EP6A==
X-Gm-Message-State: ACrzQf0OF/76qPl0L8uji/B3L1EGw46vqUsbSGMD1v6/7ZRYn8hIS+yO
        nfBO6/Ve5MTkZD22ULkdkZ6jItH2k/ercfEuRW/Xd5ocTXQ5
X-Google-Smtp-Source: AMsMyM7hL2RBAgD8t+s2gyQ+GiR0UO0q3NHbLXrJlSmqrZh6R4WmKFa8dNIEZN8EXbW1Ib8B16CXhBZMKKoRRN9U5sAUb6W/TsYn
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1586:b0:6d8:22c5:102a with SMTP id
 e6-20020a056602158600b006d822c5102amr9042086iow.156.1667824648749; Mon, 07
 Nov 2022 04:37:28 -0800 (PST)
Date:   Mon, 07 Nov 2022 04:37:28 -0800
In-Reply-To: <000000000000c3a53d05de992007@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc92bf05ece0af6f@google.com>
Subject: Re: kernel BUG in ext4_writepages
From:   syzbot <syzbot+bd13648a53ed6933ca49@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jack@suse.cz, lczerner@redhat.com,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        stable@kernel.org, stable@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tytso@mit.edu
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
ext4: Avoid crash when inline data creation follows DIO write
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
