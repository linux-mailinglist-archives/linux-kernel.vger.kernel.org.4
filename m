Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B09F68D1BD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBGIu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBGIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:50:24 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B731617176
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:50:17 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id s12-20020a92cb0c000000b00313ceced13aso3009245ilo.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 00:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZudusWGG5cp60tJ2sRNhtj/VAm33RPMEtWAQ7vrCuvk=;
        b=nHuLZ6r0iyXY8Ui8rxdihraSr8h7L3fDqSS/sxoMeIw2MhhI+eTFtWcohsEZ6L3lzg
         QpjM6FqO+OEFJf6pHeLZZmgo2qVqF4uV4G+KsM/OFGAWQz+NzSAAo80LriKuDUfdgFI5
         ySbXHxQPcJbr4xfmxUaTkBcqYq5Bg+jZn9/ehxjf1KgR6lI24RfauHUrxlHw7HAa8vyC
         S/BxjRvRy44LSGWzUch+LKY83rhJ/xR+pru6MJBYYJMv/RMLn/j9ItgxzeqZ9/Ps76j7
         2TCBjJcH2GZZFUMVGRG0vlUCQVmnQ0YrXoivKYIoe+M0agrnPWNxHdPZwb2OMlQk2Wi+
         d+QQ==
X-Gm-Message-State: AO0yUKXXehNVq6m9ovowh7H03NkkRYgQnow9ZIFWaSOOV1ks2BwZyF+w
        P4tReG6+0V7bK1M6bKB5CaWK5LAVdWTJSxiwc1iV+wS29CQy
X-Google-Smtp-Source: AK7set/5TsfYP6+cu0BxJcHxeiNU70jMTJq5ZHHtWKrXVticb9kDA7l3ipuTSPpxgLzkLp/VnBN4nAnmjlmGhs5Wr1L6LXmhVSR0
MIME-Version: 1.0
X-Received: by 2002:a92:2e04:0:b0:30e:d994:199b with SMTP id
 v4-20020a922e04000000b0030ed994199bmr1845598ile.41.1675759817069; Tue, 07 Feb
 2023 00:50:17 -0800 (PST)
Date:   Tue, 07 Feb 2023 00:50:17 -0800
In-Reply-To: <20230207082506.1322-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a01e8305f4183c3b@google.com>
Subject: Re: [syzbot] kernel BUG in process_one_work
From:   syzbot <syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c0998868487c1f7e05e5@syzkaller.appspotmail.com

Tested on:

commit:         4fafd969 Add linux-next specific files for 20230203
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1753218d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0998868487c1f7e05e5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15a33033480000

Note: testing is done by a robot and is best-effort only.
