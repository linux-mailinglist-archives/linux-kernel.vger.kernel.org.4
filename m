Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E5462C7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239218AbiKPSg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239238AbiKPSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:36:25 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9B25CD3C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:36:21 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id be26-20020a056602379a00b006dd80a0ba1cso9162512iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:36:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eOl85M3HBegjjqUqhiGsw5DiNSWU3isKndUjsq6PXmk=;
        b=BlRFen0A4igvXrBwP/UY8cEHn0H/ziQqrZLVDPaKlRNFrDMjCAClVhp9GRp7ik+Guk
         aklruzU5RxZbTxc7CDtfbXNSGMjny/8Ulaw3OC+RE8cBMDfbyT6IFF7z7aPLPFWIFHvx
         GunHdo8H5fAwUr/g++ABDdx/Xv171T4+CM2hV9oj8IT2ac8Z+14LUZbXg8BVtLLH10es
         AJuTtJWFo9mhdtpu9/GXRDtuUZiWIN8LZNtzI451VsCtJMmouLGZ+805NG6h01p47dkT
         qkxWRwRwkmB/2RTflBXd7hEGPEy+VoK56cY+yP7l4v2BjVRaHOcBpI+N4vQv9O71XNFr
         OzbQ==
X-Gm-Message-State: ANoB5pl/MyK7Vd6xTJBdIZvucblWVDqth5wGD8V6u2kA3lcoujLtnmRk
        7J1ax4KJH/VRiwmFwJqr4SozIRMejY6seCBJqr/38zs6EwsV
X-Google-Smtp-Source: AA0mqf5Ikf3dlYKkJbcI3Zp/TcbIu8kt9E04SyzHjYXfDJq0332Kf8Xi+YzJbAK+vVfdjnaGtJ0I8ji+CQR9U/sTqJ0gOEClez6R
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8b:b0:302:504e:e289 with SMTP id
 h11-20020a056e021d8b00b00302504ee289mr9125390ila.129.1668623780514; Wed, 16
 Nov 2022 10:36:20 -0800 (PST)
Date:   Wed, 16 Nov 2022 10:36:20 -0800
In-Reply-To: <20221116085524.3203-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b394cf05ed9abf4d@google.com>
Subject: Re: [syzbot] INFO: task hung in rfkill_global_led_trigger_worker (2)
From:   syzbot <syzbot+2e39bc6569d281acbcfb@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git on commit 9e4ce762f0e7: failed to run ["git" "checkout" "9e4ce762f0e7"]: exit status 1
error: pathspec '9e4ce762f0e7' did not match any file(s) known to git



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git 9e4ce762f0e7
dashboard link: https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141f1031880000

