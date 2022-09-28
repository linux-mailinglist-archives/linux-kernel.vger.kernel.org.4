Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3081E5EDD34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233771AbiI1Myu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Sep 2022 08:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiI1Myr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:54:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69450DFE1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:54:44 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4McxGq6XJ4z684cK;
        Wed, 28 Sep 2022 20:52:35 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 14:54:42 +0200
Received: from fraeml704-chm.china.huawei.com (10.206.15.53) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 13:54:41 +0100
Received: from fraeml704-chm.china.huawei.com ([10.206.112.182]) by
 fraeml704-chm.china.huawei.com ([10.206.112.182]) with mapi id
 15.01.2375.031; Wed, 28 Sep 2022 14:54:41 +0200
From:   Dmitry Kasatkin <dmitry.kasatkin@huawei.com>
To:     "cl-cheri-discuss@lists.cam.ac.uk" <cl-cheri-discuss@lists.cam.ac.uk>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "cl-cheribsd-discuss@lists.cam.ac.uk" 
        <cl-cheribsd-discuss@lists.cam.ac.uk>
CC:     Wang Kui <wang.kui1@huawei.com>,
        Jan Erik Ekberg <jan.erik.ekberg@huawei.com>,
        "Horsch, Julian" <julian.horsch@aisec.fraunhofer.de>,
        "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>,
        "Ahlrichs, Vincent" <vincent.ahlrichs@aisec.fraunhofer.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RISC-V CHERI port
Thread-Topic: RISC-V CHERI port
Thread-Index: AQHY0xj5issePbSyp0Kh6CV3gQk2ww==
Date:   Wed, 28 Sep 2022 12:54:40 +0000
Message-ID: <1c0ba05578f1487980b071da1377fb3f@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.122.225.45]
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

Hi,

I would like to inform here that our Cheri Linux for RISC-V work has been open sourced.


BR,
Dmitry

