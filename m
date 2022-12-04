Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E52641A14
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 01:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbiLDAPe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 3 Dec 2022 19:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiLDAPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 19:15:32 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800A19035
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 16:15:31 -0800 (PST)
Received: from lhrpeml100005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NPnDZ6ys6z67PMg;
        Sun,  4 Dec 2022 08:12:14 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml100005.china.huawei.com (7.191.160.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 4 Dec 2022 00:15:28 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.034;
 Sun, 4 Dec 2022 00:15:28 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
CC:     Boqun Feng <boqun.feng@gmail.com>,
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
Thread-Index: AQHZBkwkjuVXrORfWke+OSARjbJ/o65a8RAAgAEcUfCAAHmXAIAAGa0AgAACuoCAAA15gIAAG60AgAAPKuA=
Date:   Sun, 4 Dec 2022 00:15:27 +0000
Message-ID: <43c7ea9ebdd14497b85633950b014240@huawei.com>
References: <20221202125100.30146-1-jonas.oberhauser@huaweicloud.com>
 <Y4pIwqK7SWft1xCl@boqun-archlinux>
 <4262e55407294a5989e766bc4dc48293@huawei.com>
 <20221203190226.GR4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4uyzDl49Zm3TSLh@rowland.harvard.edu>
 <20221203204405.GW4001@paulmck-ThinkPad-P17-Gen-1>
 <Y4vAYzJTTQtNkXFh@rowland.harvard.edu>
 <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221203231122.GZ4001@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.48.135.133]
Content-Type: text/plain; charset="us-ascii"
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
From: Paul E. McKenney [mailto:paulmck@kernel.org] 
Sent: Sunday, December 4, 2022 12:11 AM
To: stern@rowland.harvard.edu
> On Sat, Dec 03, 2022 at 04:32:19PM -0500, stern@rowland.harvard.edu wrote:
> > My advice: Omit them both.
> It would be good to reference something or another.  ;-)

I also prefer to not refer to that presentation. 
If there is a feeling that more context is needed, I would first prefer to enhance the commit message itself in some way. (Personally I don't feel that this is needed, and the imho the issue stands by itself even without reference to OOTA, which could be resolved fully independently e.g. by Viktor's suggestion to just axiomatically forbid OOTA --- the issue addressed by this patch would still exist).
If that's not satisfactory, I would also consent to publishing the e-mails from the thread starting where I relayed Viktor's observation of the relaxed accesses, but I don't recall it saying anything substantially beyond the current commit log + the documentation included in the patch.

best wishes, jonas
