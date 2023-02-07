Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D0368DF21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbjBGRjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjBGRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:39:42 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF5772B9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:39:42 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so11174075ilj.14
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:39:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=0XC+EpZnf2FMrSEHGRL7Wn91OpfhCv+XqPiLjiUDSI4DuPn5meKITbvtgbPNuktHv3
         Cfh0JDAFWDxWaNCs3CU1YLqr5vGMjlt8Ub/92jUezQeZnOW3KjRKU3e3iZzEGtcXPh52
         so7k0SY1FkDax4332fXJWkLYBMQ01YtnMNl+kkUtmLLNmcvCRZxpYlEdJCuzvH3vzZ0J
         j2q+RCuAyLmFGxicVuwsJIHToVpiyvoD1inR58hdBEANl4Fs2elRoNJpWfEQ0rz1sH+D
         sd+PAJPWViErCUX5PRq1R6I22QqYo+VZHVsuDdvnxA0KTQD7WAR+QdgIfIK2qObjmaMj
         xXWQ==
X-Gm-Message-State: AO0yUKU8bRiVygaXtFLZwNNW0jNo95NM/jDGvFkC6sG3VGclsMYmozcY
        mXP8Ij5WeQmxlBF52xmqbqFOt4k89XNSlMBEXlDlvZg9v071
X-Google-Smtp-Source: AK7set8DpSLTHSkVrMAI4vYEpsDIPcDpfMXGtW+AIlCqVy8dbfQoTimphS21NAMD5sKRpxgfvbiTwSRVh3cU6cqaHZZioevPvoXK
MIME-Version: 1.0
X-Received: by 2002:a02:8795:0:b0:3b2:7985:6624 with SMTP id
 t21-20020a028795000000b003b279856624mr2877497jai.32.1675791581416; Tue, 07
 Feb 2023 09:39:41 -0800 (PST)
Date:   Tue, 07 Feb 2023 09:39:41 -0800
In-Reply-To: <0000000000004d659e05ecf7e1b1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ed940b05f41fa1f7@google.com>
Subject: Re: BUG: unable to handle kernel paging request in call_usermodehelper_exec_async
From:   syzbot <syzbot+10d19d528d9755d9af22@syzkaller.appspotmail.com>
To:     bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, mgorman@suse.de, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org, schspa@gmail.com,
        syzkaller-upstream-moderation@googlegroups.com,
        vincent.guittot@linaro.org, vschneid@redhat.com
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

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
