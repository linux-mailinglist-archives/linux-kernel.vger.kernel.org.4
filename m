Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7726A7A05
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 04:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCBD0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 22:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCBD0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 22:26:48 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985E34E5DF;
        Wed,  1 Mar 2023 19:26:46 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4PRxNN44KNz8RV7L;
        Thu,  2 Mar 2023 11:26:44 +0800 (CST)
Received: from szxlzmapp07.zte.com.cn ([10.5.230.251])
        by mse-fl1.zte.com.cn with SMTP id 3223QYm9099616;
        Thu, 2 Mar 2023 11:26:34 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Thu, 2 Mar 2023 11:26:35 +0800 (CST)
Date:   Thu, 2 Mar 2023 11:26:35 +0800 (CST)
X-Zmail-TransId: 2b036400176b393f8afc
X-Mailer: Zmail v1.0
Message-ID: <202303021126356602083@zte.com.cn>
In-Reply-To: <ZAAOa4nYSYQc48Lr@debian.me>
References: 202302131408087983857@zte.com.cn,ZAAOa4nYSYQc48Lr@debian.me
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <bagasdotme@gmail.com>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <wang.yong12@zte.com.cn>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0XSBkZWxheWFjY3Q6IGltcHJvdmUgdGhlIGF2ZXJhZ2UgZGVsYXkgcHJlY2lzaW9uIG9mIGdldGRlbGF5IHRvb2wgdG8gbWljcm9zZWNvbmQ=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3223QYm9099616
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 64001774.000 by FangMail milter!
X-FangMail-Envelope: 1677727604/4PRxNN44KNz8RV7L/64001774.000/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<yang.yang29@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 64001774.000/4PRxNN44KNz8RV7L
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm kinda confused. 0.000ms is same as 0ms, right?
Not really. The types of these two results are different, so the precision of
representation is different.

> And did you mean accuracy of delay average is to be same as CPU time?
Yes.
