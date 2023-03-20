Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA6B6C0902
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCTCxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCTCxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:53:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287AB35BD
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 19:53:17 -0700 (PDT)
Received: from dggpemm500014.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pfzn35nf6z9v3S;
        Mon, 20 Mar 2023 10:52:55 +0800 (CST)
Received: from [10.174.178.120] (10.174.178.120) by
 dggpemm500014.china.huawei.com (7.185.36.153) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 10:53:14 +0800
Message-ID: <1db62151-f7b5-a85e-f97d-325058f548e6@huawei.com>
Date:   Mon, 20 Mar 2023 10:53:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
CC:     <mawupeng1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, <bp@suse.de>
Subject: Re: [PATCH v2 -next 0/3] Minor cleanup in PAT
To:     <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>
References: <20230307022606.2367399-1-mawupeng1@huawei.com>
Content-Language: en-US
From:   mawupeng <mawupeng1@huawei.com>
In-Reply-To: <20230307022606.2367399-1-mawupeng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.120]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500014.china.huawei.com (7.185.36.153)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, maintainers, kindly ping...

Thanks.
Ma.
