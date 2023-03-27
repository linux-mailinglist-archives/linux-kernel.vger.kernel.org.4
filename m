Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4ED6CA55D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjC0NQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0NQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:16:22 -0400
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1909C1985
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:16:20 -0700 (PDT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id gTB2pdOA5uZMSgmhvpWkgb; Mon, 27 Mar 2023 13:16:19 +0000
Received: from fanir.tuyoix.net ([68.150.218.192])
        by cmsmtp with ESMTP
        id gmhvpXMbRHFsOgmhvps1k1; Mon, 27 Mar 2023 13:16:19 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=64219723
 a=LfNn7serMq+1bQZBlMsSfQ==:117 a=LfNn7serMq+1bQZBlMsSfQ==:17
 a=k__wU0fu6RkA:10 a=M51BFTxLslgA:10 a=nlC_4_pT8q9DhB4Ho9EA:9 a=iox4zFpeAAAA:8
 a=RJS_abe42CKYiTlhkZkA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
Received: from CLUIJ (cluij.tuyoix.net [192.168.144.15])
        (authenticated bits=0)
        by fanir.tuyoix.net (8.17.1/8.17.1) with ESMTPSA id 32RDGIiH011254
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 27 Mar 2023 07:16:18 -0600
Date:   Mon, 27 Mar 2023 07:16:11 -0600 (Mountain Daylight Time)
From:   =?UTF-8?Q?Marc_Aur=C3=A8le_La_France?= <tsi@tuyoix.net>
To:     Petr Mladek <pmladek@suse.com>
cc:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove orphaned CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT
In-Reply-To: <ZCF72chpZx77+lEM@alley>
Message-ID: <alpine.WNT.2.20.2303270710530.3348@CLUIJ>
References: <5c19e248-1b6b-330c-7c4c-a824688daefe@tuyoix.net> <Y/Teb9QnY8DOihZ1@alley> <ZCF72chpZx77+lEM@alley>
User-Agent: Alpine 2.20 (WNT 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="372313-13982-1679922971=:3348"
X-CMAE-Envelope: MS4xfB/+HjES4Zcdh8MPyQIzFJq9kn/nUULn1SQaxFuHz5Zp1GUd9VawR08dXE+ZuPwCa1gzVvVyiqReprJpubsVVBxNyYAuiVNR45UiuK78y32Nm8ZOwrwK
 ltB2kObEoR/p5DU+iJur89f2hIveLH5xE8cD81N+6J7edIalBCQ6j31tPC68DUEkGOPg32uDjMtf1aXaTfL8KfkBFCekIyQaHIxTjtScL6t1ITI5I1Kl64gi
 QxZazf7NZazJOBQr5mOLhGDDkeqxoWMNURCwch+QW9k=
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--372313-13982-1679922971=:3348
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 27 Mar 2023, Petr Mladek wrote:
> On Tue 2023-02-21 16:08:37, Petr Mladek wrote:
>> On Mon 2023-02-20 22:10:32, Marc Aurèle La France wrote:
>>> After 93d102f094be9beab28e5afb656c188b16a3793b "printk: remove safe buffers",
>>> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT is no longer useful.  Remove it.

>>> This change is not eligible for stable@.

>>> Please Reply-To-All.

>> Great catch!
>> Reviewed-by: Petr Mladek <pmladek@suse.com>

>> I have already sent pull request with printk changes for 6.3.
>> I am going to queue this patch either for 6.3-rc or 6.4.

> JFYI, the patch has been committed into printk/linux.git,
> branch for-6.4.

Thanks and have a great day.

Marc.
--372313-13982-1679922971=:3348--
