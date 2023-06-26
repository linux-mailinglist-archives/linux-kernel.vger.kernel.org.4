Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC273D56D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 02:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjFZAxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 20:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFZAxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 20:53:41 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDBF114;
        Sun, 25 Jun 2023 17:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1687740817;
        bh=uHss9sAi+BkodLXCCxVWpP2rO/AqcIvC63aHn5xoSDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fsrBonckOhtrOvxQqgG0G4Ww74ue+qgzTStBvp/4GI3irM+EBTPYGApzTW4bM2YLV
         2fkQbOTZIXGc4JV9qj3H8cLmrcvquaV0/P+RKqq174tPkACG0RnU+jou5GH+Wdr54h
         OVb/4tPJ+2HUc/eEsEs8r41KNbaFCLJhpxv83xUo=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id D620A411; Mon, 26 Jun 2023 08:53:34 +0800
X-QQ-mid: xmsmtpt1687740814t3ck9jg1n
Message-ID: <tencent_2E65037221902CF14B5F95DCD78E514FC407@qq.com>
X-QQ-XMAILINFO: MGSlRwRrdVfIisT3TiXB4uZPk7W6In/1TvGVgklfmnUyf6+68w+k7zjcQTVeQd
         0W4iIR+q1O+eReyH0RzazhC9cQsg0RqCZnQBy5nAfgPGp1gUmP20NwzkUOz3FnWq9SBp0GVIn0Eo
         B4s75AGMo3jb+AwneIHXTNP/48afTscK52RK/SNqAATK7l1s3LdBy3V6pPROdginc6CRarYtKCjj
         QTXnEer4hrxuZsbcQ7tL9qi41xWabzI+InRe+VmeuJsfQ7RMwuMw3jb7ybZC0KYA6avfe0wxY7p1
         Yx+mH8Zt15+1Q7zWx3K39zOvWF0FrNhA16tDW8/vqdZe1rkGin539mBus87IOYQr4mVMSnvcOKkV
         48jk8K2H6Mr2nmaWHKnmZ40O9y4l7wvB7DXzxmR4Vy+4onN/aNp0FHKlumvle/gXA5V5nI9LqsUO
         8766Tc7naKSD4WiUy0byWXP/I0CZgwIiNdxNfELyIXoyfd77RlhP+9hWTvzH3pqkK1QWigvwnxXD
         q/LbM1AU3Gtu+HbZydXp1EpcuZx0kl/yae59jUym6yO4Epq+UTO+1Qd4ZhnxwfBIOhaILiwFXjBV
         V+Iegce9hMf0XUrQUP1vTsQJwWul3TSKg2q2YE3+58NbnL0Iy286EP1K6V1k4S+ndnJXiPKpkvYD
         mcGz80CbSBVYN7lhNobvXDUDv/S2LSDMbuFPmOFBsblLjRd/fYUyg9mBJuzHJvzI6sGsZcK2Nt1m
         dgoe6ElS39GFmuPxr7p4TqCoQieP/6F3H5M1valmKZpWaDUjNB/SA2H1iwviWmcPWElQP7BC0NYp
         Iuhup1a0liAGX4QhvfmxkrQ7YPY4LSs728+SQZS/OQOKQWYAczb4VM1joCEdSZ07QgqWutuVqZma
         t25SDkXnHohkPXnYvwhSUFQqDBwQpdqXWWG84/9pNxI2eZzfRUIFMUY9tmnmjbbb88wjspk/tFt7
         Xy1MjQOA224OvgS0/TXVQA/yXAnrZTrFIgRar3V5okzrX0RrXTGQ==
X-QQ-XMRINFO: NjIWXnpjOUTzjNa+72IgnqZv1lPwKoxBEg==
From:   Rong Tao <rtoax@foxmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        rongtao@cestc.cn, rtoax@foxmail.com, target-devel@vger.kernel.org
Subject: Re: [PATCH v2] docs: target: Remove useless tcm_mod_builder.py
Date:   Mon, 26 Jun 2023 08:53:33 +0800
X-OQ-MSGID: <20230626005333.40560-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <87bkh3l1mr.fsf@meer.lwn.net>
References: <87bkh3l1mr.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, jon. I just submit v3, remove the reference in
Documentation/target/scripts.rst.

Thanks,

Rong Tao

