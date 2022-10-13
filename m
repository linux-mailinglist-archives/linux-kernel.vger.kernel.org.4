Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDAD5FD638
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJMIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJMIa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:30:27 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1929DD83
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:30:26 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so650633ioa.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCfRBkrrNMRK19v311kWSWOmZyezCZ5TsQNU9jK1WPs=;
        b=35MCDm19xVz7OKOPaenUjPJOcZExB1maHgkxPOjbv+EeNu4VspBql/iNV8u8NPKFpw
         XM3o3GNQQpIMlL8kDf1QC1tiq61R+lVl21Y0As5H4bz/ZQYM0f4BIy3j59o8g6ajRgA8
         mA6lBl3OH1cQnkClOIdddPnLms4XKU1JEmhm0ercacO8TJ/ZYMY3D31Hhtr4UF+GAFHA
         ImRFE7B6o2ZmHjK2swD2g4zHONin68qmF8cR0e0jG53rDPGHXD7dQrY5sG/QUdNLJRzN
         13CV/eAm7YGlllX8WnRL7F22XUjgEuWZd/SPX9WSnOuZuGCjtfKF9Xv0nsxh6zFeTmkJ
         NKww==
X-Gm-Message-State: ACrzQf39x+oJ9fVSUuvlenPKYAIghSxBdQXE4uGOdln11tN+7p9Bkchb
        fSg8P6ZT2dWY0Q/coQ2PTbVLWWCfuqqR40YXS+bEgXlpGrCB
X-Google-Smtp-Source: AMsMyM7k6/9AD14vBsPc4TY6v/uhwtYqAUGIdVoyfvsNLy06yTlJWYcH1pPUieL+9pxpX0fJHx+uSu0CbSbNbFFSFePqs/gM9EIW
MIME-Version: 1.0
X-Received: by 2002:a02:a307:0:b0:363:bd76:17fd with SMTP id
 q7-20020a02a307000000b00363bd7617fdmr9775450jai.248.1665649825465; Thu, 13
 Oct 2022 01:30:25 -0700 (PDT)
Date:   Thu, 13 Oct 2022 01:30:25 -0700
In-Reply-To: <CAJfpegtyWgdZDxPoYgwE=LekX1bNi8x0+Odvh-KYthSVxZMx7Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002acbb605eae652b1@google.com>
Subject: Re: [syzbot] memory leak in vfs_tmpfile_open
From:   syzbot <syzbot+fd749a7ea127a84e0ffd@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
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

kernel clean failed: failed to start /usr/bin/make [make -j 64 ARCH=x86_64]: fork/exec /usr/bin/make: no such file or directory


Tested on:

commit:         a185a099 Merge tag 'linux-kselftest-kunit-6.1-rc1-2' o..
git tree:       upstream
dashboard link: https://syzkaller.appspot.com/bug?extid=fd749a7ea127a84e0ffd
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1452718a880000

