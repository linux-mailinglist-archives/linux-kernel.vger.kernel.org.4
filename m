Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278D86EA227
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 05:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjDUDIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 23:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233006AbjDUDH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 23:07:58 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DB72712
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 20:07:56 -0700 (PDT)
Received: from kwepemm600005.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Q2fWF1JZBz17Th9;
        Fri, 21 Apr 2023 11:04:09 +0800 (CST)
Received: from [10.67.103.158] (10.67.103.158) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 11:07:54 +0800
Subject: Re: [PATCH v10 5/5] vfio: update live migration device status
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <alex.williamson@redhat.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        <jonathan.cameron@huawei.com>, <cohuck@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>
References: <20230408074224.62608-1-liulongfang@huawei.com>
 <20230408074224.62608-6-liulongfang@huawei.com> <ZDlGOlGqo2ZHDFm3@nvidia.com>
From:   liulongfang <liulongfang@huawei.com>
Message-ID: <fe02f34a-c3d9-056a-3081-58605e8e1247@huawei.com>
Date:   Fri, 21 Apr 2023 11:07:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZDlGOlGqo2ZHDFm3@nvidia.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.103.158]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/14 20:25, Jason Gunthorpe write:
> On Sat, Apr 08, 2023 at 03:42:24PM +0800, Longfang Liu wrote:
>> migration debugfs needs to perform debug operations based on the
>> status of the current device. If the device is not loaded or has
>> stopped, debugfs does not allow operations.
>>
>> so, after the live migration function is executed and the device is
>> turned off, the device no longer needs to be accessed. At this time,
>> the status of the device needs to be set to stop.
> 
> STOP means the devices isn't functioning
> > An idle device that has just been reset is RUNNING by definiton.
> 

After the vfio device is opened, it will be set to RUNNING, and after it
is closed, it should be set to STOP according to the function of the device.
Or redefine an IDLE state?

Thanks,
Longfang.
> Jason
> .
> 
