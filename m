Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370126C2809
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCUCVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUCVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:21:45 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DF649C7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:21:43 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PgZyz61WXznYyl;
        Tue, 21 Mar 2023 10:18:35 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Mar 2023 10:21:40 +0800
Subject: Re: [PATCH v9 1/5] vfio/migration: Add debugfs to live migration
 driver
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>
CC:     <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230320092338.2889-1-liulongfang@huawei.com>
 <20230320092338.2889-2-liulongfang@huawei.com>
 <20230320153336.74b853c7.alex.williamson@redhat.com>
 <ZBjTXwZQs603zHy3@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <41e59e5d-9bf7-2834-4fd1-09ec4c48fa24@huawei.com>
Date:   Tue, 21 Mar 2023 10:21:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZBjTXwZQs603zHy3@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/21 5:42, Jason Gunthorpe wrote:
> On Mon, Mar 20, 2023 at 03:33:36PM -0600, Alex Williamson wrote:
> 
>> This would allow that mlx5 and future drivers automatically get this
>> with no driver code, and in fact all devices would get debugfs dev_name
>> directories for better test coverage.  hisi_acc would only need to add
>> driver specific entries after registering the device and free any
>> related data after unregistering the device.  In this way, none of the
>> entry points here would need to be exported for drivers, which is
>> perhaps the direction Jason was thinking with his prior comments.
> 
> Yes, my point was more not to add more ops specifically to wrapper
> debugfs stuff. If drivers want a special debugfs file then there is
> lots of infrastructure to just create that off a common point
> 

OK! I understand what you and Alex are asking for.
I will re-debug a version based on your request.

Thanks.
Longfang.
> Jason
> .
> 
