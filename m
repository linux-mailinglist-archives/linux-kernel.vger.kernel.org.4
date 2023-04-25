Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDB96EDEBD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjDYJH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjDYJHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:07:54 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE57AC3;
        Tue, 25 Apr 2023 02:07:51 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:b4e1:4fd9:48ca:cb80] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33P95P0Z009185-33P95P0a009185
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 25 Apr 2023 17:05:26 +0800
Message-ID: <b9f1a8d5-49c1-3a81-0895-91f733df28a1@hust.edu.cn>
Date:   Tue, 25 Apr 2023 17:05:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: qedi: qedi_main.c: modify the code flow in
 'qedi_alloc_global_queues'
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        "ktestrobot@126.com" <ktestrobot@126.com>
Cc:     "meetlpz@hust.edu.cn" <meetlpz@hust.edu.cn>,
        "hust-os-kernel-patches@googlegroups.com" 
        <hust-os-kernel-patches@googlegroups.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "njavali@marvell.com" <njavali@marvell.com>,
        "mrangankar@marvell.com" <mrangankar@marvell.com>,
        "GR-QLogic-Storage-Upstream@marvell.com" 
        <GR-QLogic-Storage-Upstream@marvell.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <64474340.013BDF.00009@m126.mail.126.com>
 <CADzAj=CYeXvFkhe+6NSObjAcUH4mq+2qXf=kSFd6FGqCAD4_eA@mail.gmail.com>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <CADzAj=CYeXvFkhe+6NSObjAcUH4mq+2qXf=kSFd6FGqCAD4_eA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/25 16:51, Dan Carpenter wrote:
> Heh.  Let's not send these robot emails to the dev lists.

Dan,

Really sorry about this embarrassing situation. We don't intend to flood 
any emails to LKML.

Our robot development introduced a logic error in checking if patches 
are sent out to LKML.This robot should only check the patches sent to 
this internal review mailing list, instead of patches sent to LKML.

I spent hours today to write say-sorry emails about our mistake. :(

Dongliang Mu

>
> Regards,
> Dan Carpenter
>
