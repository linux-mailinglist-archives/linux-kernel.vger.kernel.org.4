Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4113B698DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjBPHoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPHoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:44:19 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00A03A084
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:44:18 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id r8-20020a92cd88000000b00313f4759a73so830597ilb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:44:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcvFc+W0uSULQLuVloDLR2nfD6ofXaM8O2gBExayvaE=;
        b=NfEoQL/ZNvklEhQQD6V+zzSLTLiIyt3NR5Tt3U6liWPaSuFQu1DIptm0NBEGUf0DZw
         JMHog5wSe4I8+7sIU/iRxtMnIuESPLaWnK8OWK7mRdX0JV3woPesjbQLc3WuYRFlLgv5
         5wU4VAC4jFGqhfYWOcxyOZruCwI+AkqAoYH33pk/+6OpcVrsQrWYrQEaoG6tJx0lab/X
         Cv7r8CXwXskcB0q3g1EKNLgYtpCPRbInzZY2xebxD9m4XzHei9SlkuAUTgO65JqCuGY3
         Le2GTXnSdPvWxAW9IwBDybb3CeXuWC8gMagcl6XCRsvrwPdoFC71/wNU6zc31kKTbivK
         4XgQ==
X-Gm-Message-State: AO0yUKVGH9pYXCdfOPrlnSHGqKWKx7lD+9yYWZ0KzkZ3VopDF49WNHuW
        z+WNrIatZPlVj8RcDrp7YMYvxJT0AQdA7lMfeKnUTARlP/qa
X-Google-Smtp-Source: AK7set/5dsD6k138yBAhvshUd8mxKdmSGY+rwHrUWwY3QWv9BalE1TClNfUsQOFcEGGKmliYhJWGNnk7r/hCvJXq+jv5xQ+jVxdN
MIME-Version: 1.0
X-Received: by 2002:a5e:a811:0:b0:73d:7478:5c00 with SMTP id
 c17-20020a5ea811000000b0073d74785c00mr1529701ioa.20.1676533458099; Wed, 15
 Feb 2023 23:44:18 -0800 (PST)
Date:   Wed, 15 Feb 2023 23:44:18 -0800
In-Reply-To: <2136128.irdbgypaU6@suse>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000039636e05f4cc5da3@google.com>
Subject: Re: [syzbot] WARNING in usb_tx_block/usb_submit_urb
From:   syzbot <syzbot+355c68b459d1d96c4d06@syzkaller.appspotmail.com>
To:     fmdefrancesco@gmail.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

drivers/net/wireless/marvell/libertas/if_usb.c:865:43: error: expected ';' before ':' token


Tested on:

commit:         f87b5646 dt-bindings: usb: amlogic,meson-g12a-usb-ctrl..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git
dashboard link: https://syzkaller.appspot.com/bug?extid=355c68b459d1d96c4d06
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1414acf0c80000

