Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D67664F9C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjAJXJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjAJXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:09:17 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C06DE4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:09:16 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id be25-20020a056602379900b006f166af94d6so7819498iob.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMq+5YbxbdQtL7sPG63Ybj/quOFBMceHZrsboopnGL8=;
        b=15XkebxPRH8I9A8xsLVD1Eo/QJ6GMHl3gpuiEoHl4sGa3rJGY6s/DCXOSWE0g/6H/y
         FmiBPur6R1+5VVLGJqTY47nL0eAVUbHcXsNrWSVTc4WuW/iICvReLhapyElydjUPma2a
         ++j8RHpAax1F6ui8K3f3JvZoWtT3gAaEJ3IqE5aS7oFK/WHGLmvYC1Um6xP29pvGFWQS
         +WPaOXuwvzl8psn9Nccjnvrwgs5HkX6B7DjrMjEzFmbkSpg6VFClJ8R0yjX0V3nu+2Mn
         S65oEC/G9Azqaz4ZLtp2d2TgaiNK1IHY8Vsv0ys+EY4hbZl3nYppeVgdkW8bVNxXkWLC
         Y6Jg==
X-Gm-Message-State: AFqh2kqZVtpMrrHRWXkxZrGpniNwy6gflwGX5hRBx16bgBaWMOSChx1R
        u0OOniPKHTC2BzhlpZJIapC8V6XWT9sJurPq0ysS9dDxmhY4
X-Google-Smtp-Source: AMrXdXs0QEN0d230UYh4hktMs5Xcoyn7rnFVerfDN4YC+6KAO5M3f2s83bApDd/GfzP06dW/fhqeLPIJrwR9GerxJhw67un8bk15
MIME-Version: 1.0
X-Received: by 2002:a5d:8b8b:0:b0:6e2:deb4:b078 with SMTP id
 p11-20020a5d8b8b000000b006e2deb4b078mr5599832iol.52.1673392155056; Tue, 10
 Jan 2023 15:09:15 -0800 (PST)
Date:   Tue, 10 Jan 2023 15:09:15 -0800
In-Reply-To: <e0d7b1ed-1ffb-c97c-13fa-055db635f404@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8e84405f1f0f804@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_wq_put_and_exit
From:   syzbot <syzbot+0ef474eead6cc5d7f8f9@syzkaller.appspotmail.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
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

> I think we can stop reporting issues on the same buggy patch... But
> in any case:
>
> #syz test: git://git.kernel.dk/linux.git syztest

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Jens Axboe
>
>
