Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32627633D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbiKVNOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbiKVNOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:14:20 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8D2AC4C;
        Tue, 22 Nov 2022 05:14:20 -0800 (PST)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NGl7w6pRDzRpBP;
        Tue, 22 Nov 2022 21:13:48 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:14:17 +0800
Received: from [10.174.178.174] (10.174.178.174) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 21:14:16 +0800
Subject: Re: [PATCH v2] device property: fix of node refcount leak in
 fwnode_graph_get_next_endpoint()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <djrscally@gmail.com>, <heikki.krogerus@linux.intel.com>,
        <sakari.ailus@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <rafael@kernel.org>
References: <20221122120039.760773-1-yangyingliang@huawei.com>
 <Y3zGjLsDmVv0ErVR@smile.fi.intel.com> <Y3zHF8rdguSaavo1@smile.fi.intel.com>
 <Y3zHX9FQm8rhLRpt@smile.fi.intel.com>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <6d811ee6-b142-de9d-8ec0-8e78e5f34952@huawei.com>
Date:   Tue, 22 Nov 2022 21:14:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <Y3zHX9FQm8rhLRpt@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.178.174]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/22 20:58, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 02:56:55PM +0200, Andy Shevchenko wrote:
>> On Tue, Nov 22, 2022 at 02:54:36PM +0200, Andy Shevchenko wrote:
> ...
>
>> out:
> Actually better name is
>
> out_put_parent:
OK, change it in next version.

Thanks,
Yang
>>>> +	fwnode_handle_put(port_parent);
>>>> +	return ep;
