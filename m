Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E3F710E77
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241215AbjEYOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjEYOij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:38:39 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F4101;
        Thu, 25 May 2023 07:38:37 -0700 (PDT)
Received: from dggpeml500001.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QRrCY2B65z18Lj2;
        Thu, 25 May 2023 22:34:01 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 22:38:31 +0800
From:   kongweibin <kongweibin2@huawei.com>
To:     <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <hsinweih@uci.edu>,
        <jakub@cloudflare.com>, <john.fastabend@gmail.com>,
        <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuxin350@huawei.com>, <yanan@huawei.com>, <wuchangye@huawei.com>,
        <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
        <zhangmingyi5@huawei.com>
Subject: [bpf?] [net?] Questions about the impact of ebpf sockmap/redirection on socket performance improvement
Date:   Thu, 25 May 2023 22:38:14 +0800
Message-ID: <20230525143814.361127-1-kongweibin2@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500001.china.huawei.com (7.185.36.227)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using ebpf sockmap/redirection to bypass the TCP/IP stack to improve
socket communication performance (throughput, latency) between different
PODs on the same machine. As concurrent connections or payloads increase,
there may be unconspicuous performance improvement or even performance
degradation compared to the TCP/IP stack. I have retrieved some performance
data, but it does not seem to involve high concurrency and high payloads,
I would like to know if community have conducted relevant tests on these
scenarios and have any opinions on the poor performance improvement in these
scenarios.
