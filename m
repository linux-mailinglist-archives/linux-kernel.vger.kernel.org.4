Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605335F99A6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiJJHOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbiJJHMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:12:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD495EDFE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:08:19 -0700 (PDT)
X-QQ-mid: bizesmtpipv603t1665385643tpeh
Received: from SJRobe ( [255.42.121.1])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 10 Oct 2022 15:07:22 +0800 (CST)
X-QQ-SSF: 01100000000000G0Z000000A0000000
X-QQ-FEAT: 6/K5pWSRdGpokNOwCkluLRXvxc0hWr6lWT3ic6BMt5hbVEKkBvpgf1N8VX9L3
        L3PwtDr5acycQUv8wCfgl4WnT6cfFnPKgnBmFfKHFfZLyObn+65dEmc/iA+oMtkeUHxYlRn
        4IGNvvzdycTocCLu4Sstf+K9PYNn9wCR2dhYpGrKz0bb0BkMNUeJNv2c5wRd1YVIakoldoW
        6p0Y98pPKPejW6fpNI7RvTEtImO3FHsb/VVFkkyIlPcmJ/OJ68DlVOe+CWGO5249GBo5YA7
        jrz05lrah2CYr0NsHCWCOa8428qMbda++1KS6m+xHbXn3IYs78PThgcG8BfzK8CfMAwNC5W
        6dq8WnMcg3id+MgWq/MJuVde55k7jXqOSL9Jn+mkDsTD3fdVV9vflo5f+b4PA==
X-QQ-GoodBg: 0
From:   "Soha Jin" <soha@lohu.info>
To:     "'Greg KH'" <gregkh@linuxfoundation.org>
Cc:     <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Wende Tan'" <twd2.me@gmail.com>
References: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info> <F789F6E98A6F9BF5+1d8501d8dc56$74036f70$5c0a4e50$@lohu.info> <Y0O5//6A3VvT7S5Z@kroah.com>
In-Reply-To: <Y0O5//6A3VvT7S5Z@kroah.com>
Subject: RE: PING: [PATCH] platform: use fwnode_irq_get_byname instead of of_irq_get_byname to get irq
Date:   Mon, 10 Oct 2022 15:07:19 +0800
Message-ID: <07EF40D2C259BC45+249601d8dc76$f05f03c0$d11d0b40$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGbqugtR3NtpzGFsVDN54JrNGFkNwLyBvmkAZL2edWuXW6CIA==
Content-Language: fr
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:lohu.info:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Monday, October 10, 2022 2:22 PM
> 
> It's the middle of the merge window, we can't do anything until after
> 6.1-rc1 is out, please relax and wait for that.
> 
> And what is the rush here, what is broken without this change?
> 

Got it, just wondering if there anything I could improve in this patch,
since I have not got any feedback. The bug just affect named interrupts in
ACPI, which seems not used widely and not in a hurry.

Regards,
Soha

