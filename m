Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55D641609
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 11:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLCKpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 05:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiLCKpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 05:45:42 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01E2765C;
        Sat,  3 Dec 2022 02:45:41 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 53E4F723;
        Sat,  3 Dec 2022 10:45:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 53E4F723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670064341; bh=7W8iEOJ2Z1sorKwITz1MMnhfqrnysZ8urK0DUwqqR1Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NC6jvyPxn8ZGMsK34v3rRzO3a6cXnLr8E9L7l5PGJ+PNrSm2y64FlTixUpCuchEj6
         5jQEaxsmyn7XJVYtSMbVyhZrcQWvcv49OL/Tq/4gVmVibwp8qGK2upCQ48RyjuVZal
         cntlSNvA9Yy+X1WS1UmWZ5zfKkA/+vkhHAa/KGc3H3DPJl3lbzQNTmA8jIfT5iD7wx
         uzKZdTW69VgO5+erWqFHOyEtkbsc+oJDB1wX7r3nGz+j0r3IfijiB086025eLZ0kQ4
         zLZQDIBip7hYxV4ZefdzHD1tNZ/PJ04KP7Oxh3G0dxfTxmGQOxW6rOHIu/M03r/utb
         qW3onNcEMW0Mg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: riscv: note that counter access is part
 of the uABI
In-Reply-To: <87359wpy9y.fsf@meer.lwn.net>
References: <mhng-72f383f6-a85f-4587-9fa6-f85fb9f27ec8@palmer-ri-x1c9a>
 <87359wpy9y.fsf@meer.lwn.net>
Date:   Sat, 03 Dec 2022 03:45:35 -0700
Message-ID: <87y1rooje8.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Palmer Dabbelt <palmer@dabbelt.com> writes:
>> Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
>> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>>
>> I think I merged the last one of these, but if the doc folks pick it up 
>> that's fine with me.  Otherwise I'll take it when it comes back around, 
>> so folks have time to take a look.
>
> "Doc folks" applied it, thanks. :)

Actually, I take that back.  I'd missed this part from the patch:

> Based on an, as yet, unsent v2 of my other uABI changes. I don't expect
> it to be applicable, just getting a patch into patchwork while I don't
> forget about this.

...but b4 happily picked up a couple of *other* patches from this thread
and applied them instead; I've now undone that.  Sorry for the noise.

jon
