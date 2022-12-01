Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D560A63E8D7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 05:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLAESU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 23:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLAESR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 23:18:17 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CD2E6BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:18:16 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id l21-20020a5d9315000000b006df7697880aso524999ion.23
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 20:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W055SxKKW3Lj64tBCE0lgo7kNPF3QF/1jTn7eSw/lrw=;
        b=X1mRnhqjHRfJ7XtMNW4VMweWrHG9BXb4DLkOwV5iJ7Rn27zqwHy5ir0hav3/1YCyZP
         XT/K2b1ibkHKVoDfdpW47c+EhSZBr+RpnbQ43qXZ2VNHTJIujhLpQP6lVdah5x//iWUv
         AO9qf/PHclL5moc+tyv+vmpfoxvDSxIasVG5s4KWybt91wR/b4nFYVO1kugfH+qSGacL
         1SkAAMKJu87BydJso4WNhKnSmRvpST28LPAZNLaa42tMqodzgUdzVvqhGpwZ4m92QNYc
         fXWYFwMukklrpgT3YyZj7ismc/unMKiWfXPSp9If6s/u6Az33hIOzKA/17kzSJN3LWIA
         6rjA==
X-Gm-Message-State: ANoB5plD1dxvaaiW0qbfmLzkrlBAk/lgJ8TdH5zvhPF1n7/qlLjUxvOc
        oHqZ4vVuLCFS3CtFdk3pCZjA1mraXXJA3HtLGlcY225/jPKb
X-Google-Smtp-Source: AA0mqf4bQGlniZqxE5ritC2Kgy7J6RILNUsm0gcAsKhcbvyCwsnZTnFzVK2eXcrJ2gprjXPBOOxTpigMa7R/bHEcUM0x2JEgXbii
MIME-Version: 1.0
X-Received: by 2002:a6b:cd89:0:b0:6d6:d016:b607 with SMTP id
 d131-20020a6bcd89000000b006d6d016b607mr21724488iog.70.1669868295807; Wed, 30
 Nov 2022 20:18:15 -0800 (PST)
Date:   Wed, 30 Nov 2022 20:18:15 -0800
In-Reply-To: <b18c6ce6-0862-2717-1407-343424e92e96@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097eb0a05eebc8290@google.com>
Subject: Re: [syzbot] INFO: task hung in gfs2_gl_hash_clear (3)
From:   syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>
To:     bobo.shaobowang@huawei.com, brauner@kernel.org, broonie@kernel.org,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, liwei391@huawei.com,
        madvenka@linux.microsoft.com, scott@os.amperecomputing.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/gfs2/super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         b7b275e6 Linux 6.1-rc7
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179c1703880000

