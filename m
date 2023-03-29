Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09966CEFBA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjC2QrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjC2QrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:47:22 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320D95276;
        Wed, 29 Mar 2023 09:47:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C6C5837E;
        Wed, 29 Mar 2023 16:47:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C6C5837E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1680108441; bh=gGKcyO5IJvGdKPUHgKqWzXoBTk0DhP0TVnP6Gp+Ugus=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sixA2vqVXrcdX2X+YAJM18lhWFqKVTPDhRua9B1KErOmcaYrxv9mHu20Ovz3wln4N
         Ghos+FY7cYJk1xXAn7nDbd66b31MP66QG1bK0yR+d7NdAbjezM8w6LLbQZxgGboA93
         9he4YJv0YPzbr0Ugr9OQ6bZNPIHUSBWtf55DQeEu3WvtpLVEV566K0q418FDHa1/Mi
         faDHnmc2euKTU3oT6k3WbPjSRE/vzqDbECnABkuxa9idUrHqXZo88JAChBmt/pkKHp
         HqX5fLcgbGlETUTsn/UG1sRPe3l1iFmVCw2O02I6SlN0971E300y7f+6FOS6icjyf/
         PyKzKrEC4EPjQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Akira Yokosawa <akiyks@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/sp_SP: Remove ZERO WIDTH SPACE in memory-barriers.txt
In-Reply-To: <41839138-3d85-ea82-7832-5da5f9addeb1@amd.com>
References: <c38176c7-c30a-4c2c-3516-8d3be1c267dc@gmail.com>
 <41839138-3d85-ea82-7832-5da5f9addeb1@amd.com>
Date:   Wed, 29 Mar 2023 10:47:19 -0600
Message-ID: <87a5zvjyi0.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> On 3/29/23 12:22 AM, Akira Yokosawa wrote:
>> As this file is included literally, ZERO WIDTH SPACE causes
>> "make pdfdocs" to emit messages which read:
>>=20
>>   Missing character: There is no =E2=80=8B (U+200B) in font DejaVu Sans =
Mono/OT:script=3Dlatn;language=3Ddflt;!
>>   Missing character: There is no =E2=80=8B (U+200B) in font DejaVu Sans =
Mono/OT:script=3Dlatn;language=3Ddflt;!
>>=20
>> U+200B (ZERO WIDTH SPADE) has no effect in literal blocks.
>> Remove them and get rid of those noises.
>>=20
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
>> Cc: Carlos Bilbao <carlos.bilbao@amd.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> ---
>> Hi,
>>=20
>> Offending commit is 259b007f5729 ("docs/sp_SP: Add memory-barriers.txt
>> Spanish translation") merged into v6.2.
>> As this is not a bug fix, I'm not putting a Fixes: tag.
>>=20
>> Note: It might be hard for human eyes to see where the removed
>> ZERO WIDTH SPACEs were. :-)
>>=20
>>         Thanks, Akira
>
> Good catch, Akira! Acked-by: Carlos Bilbao <carlos.bilbao@amd.com>

Carlos, when you put an Acked-by in the middle of a line like that, b4
no longer sees it.

Anyway, I've applied the patch, thanks.

jon
