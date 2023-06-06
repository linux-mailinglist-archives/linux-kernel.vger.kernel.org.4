Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902E272442E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbjFFNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235590AbjFFNS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:18:57 -0400
Received: from mta21.hihonor.com (mta21.hihonor.com [81.70.160.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A869F3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 06:18:56 -0700 (PDT)
Received: from w002.hihonor.com (unknown [10.68.28.120])
        by mta21.hihonor.com (SkyGuard) with ESMTPS id 4Qb9XB5v1fzZFR2B;
        Tue,  6 Jun 2023 20:58:50 +0800 (CST)
Received: from a007.hihonor.com (10.68.22.31) by w002.hihonor.com
 (10.68.28.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 20:58:53 +0800
Received: from a007.hihonor.com (10.68.22.31) by a007.hihonor.com
 (10.68.22.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Tue, 6 Jun
 2023 20:58:52 +0800
Received: from a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7]) by
 a007.hihonor.com ([fe80::fc39:c25:3c0f:a4e7%10]) with mapi id 15.02.1118.021;
 Tue, 6 Jun 2023 20:58:52 +0800
From:   gaoxu <gaoxu2@hihonor.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>,
        "wangbintian(BintianWang)" <bintian.wang@hihonor.com>
Subject: =?gb2312?B?s7e72DogW1JFU0VORCAgUEFUQ0hdIGRtYS1yZW1hcDogVXNlIGt2bWFsbG9j?=
 =?gb2312?Q?=5Farray/kvfree_for_larger_dma_memory_remap?=
Thread-Topic: [RESEND  PATCH] dma-remap: Use kvmalloc_array/kvfree for larger
 dma memory remap
Thread-Index: AQHZmHakTjKG3Wk/TNCzbQyr42cDew==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date:   Tue, 6 Jun 2023 12:58:52 +0000
Message-ID: <8503f60f264342018384b5427ac361e4@hihonor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Z2FveHUgvauzt7vY08q8/qGwW1JFU0VORCAgUEFUQ0hdIGRtYS1yZW1hcDogVXNlIGt2bWFsbG9j
X2FycmF5L2t2ZnJlZSBmb3IgbGFyZ2VyIGRtYSBtZW1vcnkgcmVtYXChsaGj
