Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194516637CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjAJDR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjAJDRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:17:05 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FF939F9B;
        Mon,  9 Jan 2023 19:17:02 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4NrbZg5W8lz501SX;
        Tue, 10 Jan 2023 11:16:59 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 30A3GnXf060740;
        Tue, 10 Jan 2023 11:16:49 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Jan 2023 11:16:51 +0800 (CST)
Date:   Tue, 10 Jan 2023 11:16:51 +0800 (CST)
X-Zmail-TransId: 2b0363bcd8a3594a2d8f
X-Mailer: Zmail v1.0
Message-ID: <202301101116512112512@zte.com.cn>
In-Reply-To: <Y7bYKgjYSG09OD0f@debian.me>
References: 202301031002076571212@zte.com.cn,Y7P6mSuYkmP8g8Ot@osiris,Y7bYKgjYSG09OD0f@debian.me
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <bagasdotme@gmail.com>
Cc:     <hca@linux.ibm.com>, <freude@linux.ibm.com>, <gor@linux.ibm.com>,
        <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
        <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IHYyXSBzMzkwL3pjcnlwdDogdXNlIHN0cnNjcHkoKSB0byBpbnN0ZWFkIG9mIHN0cm5jcHkoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 30A3GnXf060740
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.251.13.novalocal with ID 63BCD8AB.000 by FangMail milter!
X-FangMail-Envelope: 1673320619/4NrbZg5W8lz501SX/63BCD8AB.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63BCD8AB.000/4NrbZg5W8lz501SX
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Specifically, the second SoB from Xu should only be included if he was> 
> in From: mail header (that is, he should have sent the patch instead of> 
> Yang).

Thanks to your carefully reviewing! Actually this patch is made by Xu,
and Yang help to send it. I remember this is OK by patch rules. If I am
wrong, I will try to correct it.

Thanks.
