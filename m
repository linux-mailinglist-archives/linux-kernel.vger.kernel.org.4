Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A8A6FE44D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbjEJS7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 14:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEJS7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 14:59:14 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A692FBE
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:59:13 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33338be98cdso41961845ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 11:59:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683745153; x=1686337153;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PSmlt1pubYFv1U6NX+BxCqpmANLnkI4L70JDSkZJ7ws=;
        b=Bg9RwXBNp4amQQAMOn+79gpk++bcX0v81KsYXgUuz7v3mE0a/FsFPDLkmoiKl4S6rv
         w3VwNB7OUQX4zmS48Ypoq4te/JSdkBN1i3emBZIOZtrl9zh3+aeMTklWYHPC4zJK/Z6l
         iT13IQNUlSwUKfW8DCov3nB029HbX9tyYvZVBuzFpGbAgVgf8rT7mUgcHbtgsqK4sz2Q
         9WsLHGjufA+/JVSmMksWf8Q87BIC6o/pV/xfBXVgV5tcoO6liEIuTx7R/VytgX4Y93mT
         tgmQKiYvDCcCiaRN8LZ+IkssrXhgWxxYP+z7IvczajcJYd1ujMPxGr9+H6jxNlhJRBNP
         JQoQ==
X-Gm-Message-State: AC+VfDyA4syIs6crvXk72hZRSK30VPH/DQ+3nPYZlLLbjtJ8cuMQObaB
        Vp+E/t3DfZqZhSb4iM9V2XvuDKfefKKYQjHhlnDF/bS5sYGi
X-Google-Smtp-Source: ACHHUZ7L0sj91t3luFFP8vY4i8KSPqBQttp+O9MHIEEp89O+Lz1OHryGtpUH9w4xMQMhkvYVP+I4jYAvZhT+WRe1yrcdv+Fw1PQr
MIME-Version: 1.0
X-Received: by 2002:a92:c04e:0:b0:335:908b:8fc with SMTP id
 o14-20020a92c04e000000b00335908b08fcmr3369299ilf.1.1683745153048; Wed, 10 May
 2023 11:59:13 -0700 (PDT)
Date:   Wed, 10 May 2023 11:59:13 -0700
In-Reply-To: <ZFvpefM2MgrdJ7v4@mit.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd687205fb5b7714@google.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid
 context in alloc_buffer_head
From:   syzbot <syzbot+3c6cac1550288f8e7060@syzkaller.appspotmail.com>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz set: subsystems mm

The specified label "mm" is unknown.
Please use one of the supported labels.

The following labels are suported:
missing-backport, no-reminders, prio: {low, normal, high}, subsystems: {.. see below ..}
The list of subsystems: https://syzkaller.appspot.com/upstream/subsystems?all=true

