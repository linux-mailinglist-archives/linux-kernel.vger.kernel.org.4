Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BB763E0B6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 20:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiK3T0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 14:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiK3T0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 14:26:18 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A355A8C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:26:17 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id f2-20020a5ec602000000b006dc67829888so11986160iok.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 11:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHDlPEbyxcL50hjC4RDuSLTtc0u9OjOuwet1Hn6ykis=;
        b=MJP9WYSl2XOTRqM2iV6FduxyOIKT/XDNRWt1mr3HSj2nMFkm710JbEWgjMYRWHz8rM
         YtSI0X5RLmPQQb9rdlXIR41aPFjSzc21ScXyi1rhF7BZ0rwpehjcwHggr+k56fOIaEE6
         HRuUYDQFP/GB4g1eLfLzBTS9HpPSoCYEn93hvmXyMtOsAQTmvbEf/j2QSrpIQY/hyOiG
         Z7XXZly8616Uo6TbR+6PnN1gFhVUOZKY8a0qGU5HRy96+CG54cYEPctyTGc5CD/f3i0K
         HzNtVxHWahr5hLJHhDmI6ui01Roy7D5hetyw15aj0RIfnjFhZn5e9sccH+9wtvpWr3lA
         QWHg==
X-Gm-Message-State: ANoB5pmcRZ8LxQNB3BtJuM/wmELGVd404d3yUFA0WB3NgPWkOfdGXu3J
        Q7NMf0sLmNMaoEL/c/IDqnckN5x+DX9/OLduQUeEBSKnGxgX
X-Google-Smtp-Source: AA0mqf7soXd7jOnwY0B+aHPhvjOt3jilZIWveY+Dx3xEUYDRtEHyu3QDruNVzFgMvkQPltsZUlQsrtx/mYbGE4/QlCnQfhm945Lz
MIME-Version: 1.0
X-Received: by 2002:a92:db4b:0:b0:302:5575:9e46 with SMTP id
 w11-20020a92db4b000000b0030255759e46mr28390061ilq.41.1669836377119; Wed, 30
 Nov 2022 11:26:17 -0800 (PST)
Date:   Wed, 30 Nov 2022 11:26:17 -0800
In-Reply-To: <cd4158d0-bfc0-099c-c914-4889eaf95036@huawei.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001767a405eeb514eb@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1751c2bd880000

