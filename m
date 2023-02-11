Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E6869322B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 16:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjBKPyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 10:54:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjBKPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 10:54:50 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDC3189
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:54:49 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id nn4-20020a17090b38c400b00233a6f118d0so6074385pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 07:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=nfc3HfUA4skbr8W+wJiJbUTw5+Wtd8fPHDaYrM0kckNUkcd1FvBCq+GhLItytXfBsC
         ymUsXa7wh0EQ0QLnOK5wi7tacIKYSpMDBKF8GsgRNPQHk9o+qsjkgHNjyrRAa7BvkjEy
         HeoPVmYQSCa51o6Fehp3zpH+E5htqHR/uw6P6i7S1rgDTs7E+1ndnbjCqul48Fk2M9Sp
         PLLrxWTFaL6rKvrLg0jW4w3dxiLmuEK8dr8HIxOlQk/DZgsFNyuuIcPB7+m0agHxrfe2
         yG+PAU3NQOp9YMkuU7HHfAwyPCfGzVvG8qC7BV+WNBa7jNnRc3b6cPH8ZU3uqrRpq8sP
         kjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=gd5Ukjj6m3ssuXhAitnCmynvuGXFoK9qKOEBm1NOLYBW0LyaRzcJgTbP4CKSHW0Obo
         ZLCWdDJZasHVn9Irl6nyuEj74ha3gV34/Pl1QCzSAW48mp8FJFNlyXn8mDroQrAP71CV
         gP5rRoQUrEcJhyl36q0hO07zEMTPOeAsK0v9r+o2uJmAPneIUfK8Lgoocg7f1psGwHpl
         VhlgCeRpf7jGAVtGAO3XbsJJXq1O7li1NVT6zyqMP/2Ugde6EVHBp/YI7QmiUmt6KcLl
         UDAq9G3nrohnnq6a7o6bTkhHJ9pzlJVzSdBLaL+pb6tKvJ1NGQFXD1qkQ/hzeWjXEMkw
         pq3Q==
X-Gm-Message-State: AO0yUKUpZDUP5xJFCHZIwjniqi2e/BiqMaQot6DLFujmY1cqP42ccWRh
        ccK0CxFvu/mrIrdXNnDn8xIlXQJaVzej85M8L6s=
X-Google-Smtp-Source: AK7set8jVH6zRiYxD6bEDqsTgmhXFbqG/HhukPKpvIC/8bwXG0L2TzZosv+4k3js9sDKt/QUWgRRPjulWjMdmmi0VYQ=
X-Received: by 2002:a17:90a:9293:b0:231:2812:e916 with SMTP id
 n19-20020a17090a929300b002312812e916mr2529215pjo.47.1676130888944; Sat, 11
 Feb 2023 07:54:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:3dd4:b0:3aa:540c:3dfb with HTTP; Sat, 11 Feb 2023
 07:54:48 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <ava152687@gmail.com>
Date:   Sat, 11 Feb 2023 07:54:48 -0800
Message-ID: <CAMPb6BOC5hkP3MEDJh-RdAXdVNU0K3McUnyx-cGvhcBNVnWP7Q@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1043 listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ava152687[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ava152687[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
