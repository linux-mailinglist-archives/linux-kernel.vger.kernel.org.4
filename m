Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48776641682
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 12:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiLCL6l convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 3 Dec 2022 06:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLCL6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 06:58:40 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085ED2F007
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 03:58:39 -0800 (PST)
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NPSxR1NN7z67LTs;
        Sat,  3 Dec 2022 19:58:03 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 3 Dec 2022 11:58:36 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.034;
 Sat, 3 Dec 2022 11:58:36 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     Boqun Feng <boqun.feng@gmail.com>,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "dlustig@nvidia.com" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Thread-Topic: [PATCH v2] tools: memory-model: Make plain accesses carry
 dependencies
Thread-Index: AQHZBkwkjuVXrORfWke+OSARjbJ/o65a8RAAgAEcUfA=
Date:   Sat, 3 Dec 2022 11:58:36 +0000
Message-ID: <4262e55407294a5989e766bc4dc48293@huawei.com>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
In-Reply-To: <Y4pIwqK7SWft1xCl@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.214.59]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Boqun Feng [mailto:boqun.feng@gmail.com] 
Sent: Friday, December 2, 2022 7:50 PM

> > Reviewed-by: Reviewed-by: Alan Stern <stern@rowland.harvard.edu>

> s/Reviewed-by: Reviewed-by:/Reviewed-by:^2 to save some space ? ;-)


Oh, I didn't know I'm allowed to compress things like that! Can I use ² as well to save another character?

> I wonder is this patch a first step to solve the OOTA problem you reported in OSS:
>	https://static.sched.com/hosted_files/osseu2022/e1/oss-eu22-jonas.pdf
> If so maybe it's better to put the link in the commit log I think.

It's not directly related to that specific problem, it does solve some other OOTA issues though.
If you think we should link to the talk, there's also a video with slightly more updated slides from the actual talk: https://www.youtube.com/watch?v=iFDKhIxKhoQ
do you think I should link to both then?

Best wishes,
jonas
