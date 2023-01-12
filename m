Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268AE668508
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239706AbjALVHN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Jan 2023 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbjALVGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:06:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F6F59F95
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 12:51:07 -0800 (PST)
Received: from lhrpeml100001.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtGss5dG9z67HtH;
        Fri, 13 Jan 2023 04:50:57 +0800 (CST)
Received: from lhrpeml500002.china.huawei.com (7.191.160.78) by
 lhrpeml100001.china.huawei.com (7.191.160.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 12 Jan 2023 20:51:05 +0000
Received: from lhrpeml500002.china.huawei.com ([7.191.160.78]) by
 lhrpeml500002.china.huawei.com ([7.191.160.78]) with mapi id 15.01.2375.034;
 Thu, 12 Jan 2023 20:51:05 +0000
From:   Jonas Oberhauser <jonas.oberhauser@huawei.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "riel@surriel.com" <riel@surriel.com>,
        "davej@codemonkey.org.uk" <davej@codemonkey.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@meta.com" <kernel-team@meta.com>
Subject: RE: [PATCH diagnostic qspinlock] Diagnostics for excessive lock-drop
 wait loop time
Thread-Topic: [PATCH diagnostic qspinlock] Diagnostics for excessive lock-drop
 wait loop time
Thread-Index: AQHZJh4apQ0ukQ/LOEaXjXF7PGrkyq6a/rvg
Date:   Thu, 12 Jan 2023 20:51:04 +0000
Message-ID: <896a2d84918e4adc8a4d00d72510eb3d@huawei.com>
References: <20230112003627.GA3133092@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20230112003627.GA3133092@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.81.220.202]
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

Hi Paul,

-----Original Message-----
From: Paul E. McKenney [mailto:paulmck@kernel.org] 
> We see systems stuck in the queued_spin_lock_slowpath() loop that waits for the lock to become unlocked in the case where the current CPU has set pending state.

Interesting!
Do you know if the hangs started with a recent patch? What codepaths are active (virtualization/arch/...)? Does it happen extremely rarely? Do you have any additional information?

I saw a similar situation a few years ago in a proprietary kernel, but it only happened once ever and I gave up on looking for the reason after a few days (including some time combing through the compiler generated assembler).

Have fun,
jonas
