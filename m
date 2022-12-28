Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64998657195
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 02:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiL1BZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 20:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1BZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 20:25:52 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77519DF14;
        Tue, 27 Dec 2022 17:25:50 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NhYkN0xZSz8R039;
        Wed, 28 Dec 2022 09:25:48 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
        by mse-fl1.zte.com.cn with SMTP id 2BS1PiuS035967;
        Wed, 28 Dec 2022 09:25:44 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Wed, 28 Dec 2022 09:25:45 +0800 (CST)
Date:   Wed, 28 Dec 2022 09:25:45 +0800 (CST)
X-Zmail-TransId: 2b0363ab9b194061ad10
X-Mailer: Zmail v1.0
Message-ID: <202212280925459299284@zte.com.cn>
In-Reply-To: <ca6e40fff619aa16cb178382f5404d047ed08f3c.camel@HansenPartnership.com>
References: 202212231040562072342@zte.com.cn,0fb8a86a-ca92-8d5f-99da-6815b2d5ec3e@gmx.de,eaad272203baa65ad65ac2206e5197595c88508e.camel@HansenPartnership.com,279ea596-6a20-0bb8-39c3-67b45d7425a6@gmx.de,ca6e40fff619aa16cb178382f5404d047ed08f3c.camel@HansenPartnership.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <James.Bottomley@HansenPartnership.com>
Cc:     <deller@gmx.de>, <linux-parisc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xu.panda@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBwYXJpc2M6IHVzZSBzdHJzY3B5KCkgdG8gaW5zdGVhZCBvZiBzdHJuY3B5KCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2BS1PiuS035967
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 63AB9B1C.000 by FangMail milter!
X-FangMail-Envelope: 1672190748/4NhYkN0xZSz8R039/63AB9B1C.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 63AB9B1C.000/4NhYkN0xZSz8R039
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> the array buf[] is actually buf[count], so if count < 64 then
> sizeof(buf) < sizeof(in) and you're copying whatever is after buf on
> the stack or wherever it comes from. The amount you copy into in[]
> truly has to be the smaller of count and sizeof(in).  These are file
> operations, so you shouldn't rely on buf[] being null terminated
> (kernfs ensures it is, but it's a dangerous thing to rely on in the
> face of someone trying to exploit a stack smashing attack).

Should we send patchv3 which is back to v1, or we directly use
patchv1 to continue the reviewing?

Thanks!
