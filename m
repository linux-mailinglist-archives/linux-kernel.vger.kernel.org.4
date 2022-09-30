Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829BB5F097A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiI3LHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiI3LGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:06:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4279F1B0E0F;
        Fri, 30 Sep 2022 03:43:14 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mf5qq1Mzxz687Z8;
        Fri, 30 Sep 2022 18:21:43 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 30 Sep 2022 12:23:55 +0200
Received: from [10.126.175.8] (10.126.175.8) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 11:23:54 +0100
Message-ID: <5613166f-51f9-18f0-af52-b352aa67326c@huawei.com>
Date:   Fri, 30 Sep 2022 11:23:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] perf tools: Fix empty version number when building
 outside of a git repo
To:     Will Chandler <wfc@wfchandler.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220927195228.47304-1-wfc@wfchandler.org>
 <c5181877-2998-b952-abe6-26d733ae2aeb@huawei.com>
 <87A1F5B6-3F60-4988-8BA6-A993E5789C80@wfchandler.org>
 <2a4a15a4-55cd-f98b-4b14-474f24e2c308@huawei.com>
 <B89DF3DD-B07E-427F-8D4B-1F8251345A4C@wfchandler.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <B89DF3DD-B07E-427F-8D4B-1F8251345A4C@wfchandler.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.175.8]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 20:06, Will Chandler wrote:
> On 29 Sep 2022, at 6:09, John Garry wrote:
> 
>> Hmmm... maybe someone would want to customise PERF-VERSION-FILE for their own distro. Not sure. But then fiddling with PERF-VERSION-FILE might break the parsing so...I guess not.
> Yeah, seems like a bad idea. Doing a quick search, Void Linux does seem to be
> trying to set a custom version string in their build script[0], but I don't
> think passing PERF_VERSION as an argument to make has worked since 2013 with
> 3cecaa200227 ("perf tools: Do not include PERF-VERSION-FILE to Makefile, 2013-01-16").
> 
> [0]https://github.com/void-linux/void-packages/blob/fdb3515c33f2bb997392ea6992e6bbb82c4376c5/srcpkgs/linux-tools/template#L56
> 
>> BTW, is there any other method of building the perf code not considered? So far I know:
>> a. in git tree
>> b. perf-tar-src-pkg
>> c. tarball
> Those are all that come to mind for me as well.
> 
> Let me know if you'd like me to re-roll the patch using the pre-7572733b8499
> approach.
> .

I have a slight preference that you do like pre-7572733b8499 if that is 
ok. The reason is that way was a bit more tried and tested.

Thanks,
John
