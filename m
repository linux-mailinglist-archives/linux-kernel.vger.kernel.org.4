Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90F5EE208
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbiI1Qkf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Sep 2022 12:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiI1QkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:40:23 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41E66A7F;
        Wed, 28 Sep 2022 09:40:16 -0700 (PDT)
Received: from smtpclient.apple ([109.40.240.166]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MiaHf-1p8EQS412t-00flX6; Wed, 28 Sep 2022 18:40:08 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] usb: xhci: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96 controller
Date:   Wed, 28 Sep 2022 18:39:55 +0200
Message-Id: <69D84895-3353-46F6-A21B-3A448003DCB8@oldschoolsolutions.biz>
References: <c1d537ad-5a2d-24b1-bfc3-165deebbbfa7@linux.intel.com>
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu
In-Reply-To: <c1d537ad-5a2d-24b1-bfc3-165deebbbfa7@linux.intel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: iPhone Mail (20A362)
X-Provags-ID: V03:K1:wExZY3q2lutRVqbdwcEZYRhiGk+LpmQOKcootgLCqhQALqyb0Ea
 NmZsidz0wIU6G9NxQTcI5jdcbmr7kmfsHt1+CkbEEdcOIycXdqXkwHeXWI9zc9yaXgd7HCz
 2Z1Hz0oSfrfZYYepl+sP8oWA+gEP4k28AKNfwfQ9w+Fgokm1uHUbp/6Umwv5WGx8P+uHGW4
 5Zg0uygO48yrC1uSrnkUQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KHAVkK0XIi0=:Ip6Vle55wNrPO8Rbbn3MFS
 fLeKUhyz7EJ8SIBFBZ1XD70zaur5as1W1izWiRUX64ckJ5fMX7jueqIp6sxh6mpf+TVnQBsUi
 MZi9Pq1GeO+RWUJhhGmGeukWwNyrl7HN441ovMtXgQJEuI7qI+/FHHEAwsJSydn9pyq8Et9jD
 ho7XVcdICZmnq3s3vnZ/CzCFPjLgBSpQQp61Jk3kjUy7m18KXDhBI+VW+qix6YQwYLoeKPe5a
 GakboXO7kpszQn370HmLvl2IrNJQ0SmJ5EjnCmAxzQQEn4y1P9pObx1rDG4do2mdEFxvMlcTX
 L2AIXrKEm+FDL4N9frcGwOd4OHmDI0nbd5hVciEghea6ZRZHQBlqonThavDun4/25z/IeOfvR
 vaNYKnvH6OME4m5qIdcbBYC2eLmdQ/bz4Wz01bQ1XhOyd2wvn4osw5x3+zHqPIADsUeG8QtDq
 0hj9131f8EhUhK36ZQx5b/HpLM+VkGy8nXX2RGIOyc5GEpdMs9ENxLMjyp+2Xkx0IpnzQK93f
 P6/DH5aBvqSUmr0RH3G65E//+/0blfSooqTnT/XNVBK7+hPK7qaZ4+9iBtxdcQYmY8XAqRTfB
 +pVJYupCV6UMBboEa4kl+FTdK4ldYVM/+BlPse2y4x0pBW4lwp8Xe9+4Mdgnzgsm+Lb5p9dhg
 l8eIjpP165N7S4oiy5huf/nco7J7YostFO73l4Ooc27ru4NuIeJlFG132Wq5A8qEz6ipIWayZ
 XKfz7gpWxlbbxHy60ATAVv1ZyfTMQoByCf5ZTo5+Ryvb8pJGbCyV+RcoaW7uClo8lTpv9ohoL
 akuecYqzUcayWQZC9EkvkHAaegm6g==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, will do. This us part of the mail, not the patch, right?

Von meinem iPhone gesendet

> Am 28.09.2022 um 17:23 schrieb Mathias Nyman <mathias.nyman@linux.intel.com>:
> 
> ﻿On 26.9.2022 22.31, Jens Glathe wrote:
>> This appears to fix the error:
>> "xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
>> current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
>> often) when using a r8152 USB3 ethernet adapter with integrated hub.
>> ASM1042 reports as a 0.96 controller, but appears to behave more like 1.0
>> Inspred by this email thread: https://markmail.org/thread/7vzqbe7t6du6qsw3
>> Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
> 
> Adding this to queue
> 
>> ---
> 
> In the future, As Alan also pointed out, please list the changes since last version here.
> 
> Something like:
> 
> changes since v2
> - add subsystem to subject line
> - removed host 0.96 version check
> 
> Thanks
> -Mathias

