Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C4C6D9704
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbjDFM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbjDFM3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:29:22 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81606EB7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:29:17 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Psggp6NZBzSkrd;
        Thu,  6 Apr 2023 20:25:26 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Apr 2023 20:29:13 +0800
Subject: Re: [PATCH] ubifs: remove unnecessary kobject_del()
To:     Yangtao Li <frank.li@vivo.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <richard@nod.at>
References: <20230405130747.66006-1-frank.li@vivo.com>
 <20230406090813.24111-1-frank.li@vivo.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ce162145-e88f-9c5f-6182-4a57e8efd586@huawei.com>
Date:   Thu, 6 Apr 2023 20:29:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230406090813.24111-1-frank.li@vivo.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>> I think we should still reserve the 'redundant' kobject_del(),
>> removing it won't bring any performance improvement.
> 
> Since it's redundant, why not to remove it.
> 

In my personal view, 'redundant' means removing kobject_del() is okay, 
it won't bring any bugs. But removing it won't make code more 
readability or gain any performance improvement, so it could be 
reserved. Whether to remove kobject_del() depends on UBIFS maintainer, I 
just help to check if the modification could affect the normal logic.

