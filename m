Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A0C63B434
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbiK1V1Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Nov 2022 16:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbiK1V1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:27:23 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C722F2BB1A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:27:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
From:   Sam James <sam@gentoo.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [BUG] Add missing <linux/string.h> include for strcmp.
Date:   Mon, 28 Nov 2022 21:27:04 +0000
Message-Id: <06233B0E-53AC-4499-ABF0-8CD8B718278B@gentoo.org>
References: <20221128132507.98fab35cba20ce3f81810fcc@linux-foundation.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
In-Reply-To: <20221128132507.98fab35cba20ce3f81810fcc@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (20B101)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 28 Nov 2022, at 21:25, Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> ﻿On Mon, 28 Nov 2022 18:15:55 +0100 "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> 
>> starting with v6.1-rc7 I can't build my tree any more:
>> 
>>  HOSTCC  scripts/mod/modpost.o - due to target missing
>> In file included from include/linux/string.h:5,
>>                 from scripts/mod/../../include/linux/license.h:5,
>>                 from scripts/mod/modpost.c:24:
>> include/linux/compiler.h:246:10: fatal error: asm/rwonce.h: No such file or directory
>>  246 | #include <asm/rwonce.h>
>>      |          ^~~~~~~~~~~~~~
>> compilation terminated.
>> 
>> Bisect did show your patch as the first bad one:
>> 
>> commit 50c697215a8c "Add missing <linux/string.h> include for strcmp."
>> 
>> Reverting it makes compile succeed.
> 
> Thanks.  I queued a reversion patch.

Thanks, I can't look into it properly right now so this is the best course of action. I'll test cross and the like then submit a fixed one in a few days.
