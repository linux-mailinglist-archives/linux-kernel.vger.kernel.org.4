Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416BD6CA676
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjC0NvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbjC0Nu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:50:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06C055B5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 06:49:53 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1679924989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJ/Iifk8gJvVjRX7fay+GykpLmeO4YnIOdUs73byc7Q=;
        b=LOag1ijPHcIppAPj/dG2zudUUl0ZVy8KrTLPA26F+VyiqtdV/eHzWgtezDZrm80GCjwU8U
        v9NUmttn/QEJO8aqx5MVwlHr39I0EqqhNI84wo/axVn6i6qrZdrZPDYiJKKGE1Skyrt0lK
        LLKMthdr8IjN2zTheGcL6bUovdTKDjtu8WXvdEGSEJ5902gAm7ocnrXyxVdit8TbxJ//X9
        83CiLpTf7XbZvkrG8l/RgCvgKmunkM4ufGak/Sckp0aAlKN0B3UVvlaHWx53bEvcmbXsuq
        lQab05r+nGB3/x+T5dhu90zoxM22zOddnvy5n3AJGFo6X+12YQSFAU61WoNz6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1679924989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nJ/Iifk8gJvVjRX7fay+GykpLmeO4YnIOdUs73byc7Q=;
        b=hzk7PwuOgRQ09QYqQ+O7MMESw0nFWej5jJoWHgRh8MGnr4Y8OeCBVvP0vcKZW4DJ6/8He4
        8C8Xsy+MA2C+PeDg==
To:     David R <david@unsolicited.net>, Borislav Petkov <bp@alien8.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
In-Reply-To: <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
References: <943d2445-84df-d939-f578-5d8240d342cc@unsolicited.net>
 <20230327074952.GAZCFKoDOiJUdtse2H@fat_crate.local>
 <e8d15248-e694-79d7-da9c-b4485b471e14@unsolicited.net>
Date:   Mon, 27 Mar 2023 15:49:48 +0200
Message-ID: <878rfi718j.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27 2023 at 09:13, David R. wrote:
> On 27/03/2023 08:49, Borislav Petkov wrote:
>> On Mon, Mar 27, 2023 at 07:43:52AM +0100, David R wrote:
>>> I have the following panic after upgrading my kernel. Working version is
>>> 6.1.10, so something has happened after that.

IIUC 6.1.11 is failing, right?

>>> 6.2.x kernels crash in the same way. Attached config.
>>>
>> Please send dmesg from 6.1.
>>
> Of course - attached.

Thanks for the info.

       tglx
