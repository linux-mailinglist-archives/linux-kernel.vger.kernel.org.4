Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D9E70DABA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 12:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbjEWKl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 06:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjEWKlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 06:41:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1387FD;
        Tue, 23 May 2023 03:41:23 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684838481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5IDoUkMZYcy3m8hLAjYH+IXhjOmdCGUJy4q89JOe5rU=;
        b=vVjS5XN8ObPqhOpIkFNfFOKL0jFb5LAv+EEpmA+a07/xa9dteEqBOFWyBvpDwJolqHU8GD
        rNwj7OCvY+KmNSKDpAyLcj9Ot5edT42jDJwJj200mCiaWWUXm816ynmVraqE0x0OFSjKrR
        JLPIobbJkTC5FjqorZNl5rgRYDm2Q5uwiwW0iQISpS++oYkw43CgD+Vvtw/o/Kp0SkJdpt
        OeB3BiI6EI4SmLs6BZ8Y6+Oq7SngMz/HHg/AAGMhHBZZPHVcOUr016IrPjNJ2+5YcVo8zs
        CMDRT05bbnFbX97fjFOPrkE461M6QbhY1VkiL3iQwi3wJb5CVOL9owqpPJnK6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684838481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5IDoUkMZYcy3m8hLAjYH+IXhjOmdCGUJy4q89JOe5rU=;
        b=xDEyCPTE8BeFYLNUOhKDueCcXYD1z4J9DEo/ocM7qUgJ9sqnIkJCRqyxrQRdtT7AxaJq+t
        fSNIV1AdqpyUgyCQ==
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: + fix-mult_frac-multiple-argument-evaluation-bug.patch added to
 mm-nonmm-unstable branch
In-Reply-To: <6e6b2dc1-1fab-4506-bbad-41edaafd7231@p183>
References: <20230522211514.E0037C4339C@smtp.kernel.org>
 <87ttw4udzv.ffs@tglx> <6e6b2dc1-1fab-4506-bbad-41edaafd7231@p183>
Date:   Tue, 23 May 2023 12:41:20 +0200
Message-ID: <87o7mbuy7j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23 2023 at 11:48, Alexey Dobriyan wrote:
> On Tue, May 23, 2023 at 01:45:40AM +0200, Thomas Gleixner wrote:
>> Changelogs have to be self explanatory and if the shortlog, aka
>> $subject, claims "bug" then there has to be a reasonable explanation
>> what the actual bug is.
>> 
>> Seriously.
>> 
>> All this is documented, but obviously documention for changelogs and the
>> acceptance of patches is just there to be ignored, right?
>
> I don't want to return to kindergarten and document problem which every
> C programmer learns exploring MIN(a, b).

A quick summary what the bug is, is _not_ kindergarten level.

Why does a reviewer have to do his own analysis at the patch level to
figure out what this solves and fixes?

It's 20 seconds of courtesy on the submitter side which saves a lot of
time on the reviewer and maintainer side.

Thanks,

        tglx

