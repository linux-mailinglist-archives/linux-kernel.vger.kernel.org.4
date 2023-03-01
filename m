Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECF6A6B88
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCALOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjCALO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:14:29 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493152DE55
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:14:04 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PRWky0Ptgz16P7F;
        Wed,  1 Mar 2023 19:11:22 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 19:14:00 +0800
Subject: Re: [PATCH v2] ubifs: dirty_cow_znode: Fix memleak in error handling
 path
To:     Richard Weinberger <richard@nod.at>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20230215022507.2363193-1-chengzhihao1@huawei.com>
 <9121ae91-5b4f-4b10-46fc-6cc0683c949d@huawei.com>
 <34189394.187159.1677657964794.JavaMail.zimbra@nod.at>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <299a85b4-aea5-b8b8-394f-4b7093b6a754@huawei.com>
Date:   Wed, 1 Mar 2023 19:13:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <34189394.187159.1677657964794.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2023/3/1 16:06, Richard Weinberger 写道:
> We cannot replace the patch in linux-next, the merge window is already open.
> A follow up fix is possible after 6.3-rc1 is done. So, next week.

It's okay, thanks. I will send fix patch again after 6.3-rc1.
