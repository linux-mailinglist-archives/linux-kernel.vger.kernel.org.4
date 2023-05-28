Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250F071397D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjE1Mx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1Mxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 08:53:54 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431CEB9;
        Sun, 28 May 2023 05:53:52 -0700 (PDT)
Received: from dggpemm500012.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QTdlF2Dngz18LS2;
        Sun, 28 May 2023 20:49:13 +0800 (CST)
Received: from localhost.localdomain (10.175.124.27) by
 dggpemm500012.china.huawei.com (7.185.36.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 28 May 2023 20:53:47 +0800
From:   gaoxingwang <gaoxingwang1@huawei.com>
To:     <edumazet@google.com>
CC:     <davem@davemloft.net>, <dsahern@kernel.org>,
        <gaoxingwang1@huawei.com>, <liaichun@huawei.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <yanan@huawei.com>, <yoshfuji@linux-ipv6.org>
Subject: Re: ip6_gre: paninc in ip6gre_header
Date:   Sun, 28 May 2023 20:53:25 +0800
Message-ID: <20230528125325.913443-1-gaoxingwang1@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <CANn89iLzMBJE31VBL3jtu-ojdoAYwV_KLo1Qo+L6LWZ+5UKMtg@mail.gmail.com>
References: <CANn89iLzMBJE31VBL3jtu-ojdoAYwV_KLo1Qo+L6LWZ+5UKMtg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500012.china.huawei.com (7.185.36.89)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply. As a newbie,I'm sorry to bother you with this problem. 

>Yes, there is a fix already.
I'm not sure which patch fixes this problem, would you mind to provide a commit id?
So that I can fix my kernel by patching it.
