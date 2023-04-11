Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696886DE725
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 00:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjDKWUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 18:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDKWUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 18:20:15 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B79A3C2F;
        Tue, 11 Apr 2023 15:20:15 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B387A5BF;
        Tue, 11 Apr 2023 22:20:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B387A5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1681251614; bh=vDkrXH2k6AQCgQ/vIworgpYA/A9rb4bI87aU5AynegU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F8zCZv2w4C/UnEX84gCjsCckOtxo8qsV4VXTbddV8Vce8mm5AqzzVO0h1j4oOYhry
         rqVVpLy4N044zHGlTiGaihpiSPvf84Md0IZmhDKb58m+ZckRby3kqzMm9bjId1BgWg
         S4fXuvDK3f1YAtf8mE+VBao6JGFMifdIwk2IOLzkc9g78C5+EvMdt1/HC/6ssWd7Dq
         mOpVnI6JLbZZc97gD5I5Bsq2K/bGcNaMR8hjnMNkXSvJf+iKt35LBaCoHlii2JSL3X
         cGNwFlpFwHM8m7I7Uq9Fc2dajFySYuxO99PyVWloAwiQg0mi3FNwS2xONncD78PnWz
         uggphSxZ3QsUg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] Documentation: firmware: Clarify firmware path usage
In-Reply-To: <ZDT39frTIqpX5p9O@kroah.com>
References: <20230402135423.3235-1-f.fainelli@gmail.com>
 <87y1mzcq9y.fsf@meer.lwn.net>
 <1f4b874b-bd1e-17ff-51dd-19bf2d73214f@gmail.com>
 <ZDT39frTIqpX5p9O@kroah.com>
Date:   Tue, 11 Apr 2023 16:20:14 -0600
Message-ID: <87wn2i9i3l.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, Apr 10, 2023 at 04:12:32PM -0700, Florian Fainelli wrote:
>> I was not sure whether it was on purpose or not, Greg, will we break
>> anyone's use case if we strip off \n from the firmware path passed via
>> sysfs?
>
> I do not know, sorry.

I would be amazed if anybody is putting newlines into their firmware
path; that would be kind of a silly thing to do.

That said, I've been amazed before.

I'll go ahead and apply the docs patch, but it still doesn't really seem
like the right fix to me.

Thanks,

jon
