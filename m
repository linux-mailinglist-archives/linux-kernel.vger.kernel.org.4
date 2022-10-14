Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A235FEF7E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJNOAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJNN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:59:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131661D1E3B;
        Fri, 14 Oct 2022 06:59:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5BBDB35D;
        Fri, 14 Oct 2022 13:57:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5BBDB35D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1665755871; bh=Abv6s4+AyE061CuCDcgUYBTnfSnTzrxjzZD6LtmkGTQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eRpflk+vwPWOcvT4OOl4lMmZqMNic8q4DT4h84r3vjyOes3MHAIpTw86BDaiaOBju
         wI2M5rhgSixyj2DmJh2ujKT8kjEGNtPIlIskF20JWlLptsgIaRz7V/TBp38Nke1Trr
         yTEE4j6CM8CGB0xp0XPbNLspAjKp2UHwkYfGgqke/ZF6n3JapOZ71/8foD2bilUCp0
         Aid5guNsC7tTXWoYO6ROjvIQykl4ipi73vW2JY1wIcdHfquvWeaMSmXvueOePQrRXh
         VmAkEstLxQoz6bGimxJDMKqBFU2UqNVRi711RDe1L3+KP5Ex7eK16K20lVUeJ0GpyY
         x+DnN2tFREsww==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org
Subject: Re: [PATCH 2/2] Documentation: Add HOWTO Spanish translation into
 rst based build system
In-Reply-To: <c351e1f6-29ad-2b93-09e4-c7f9d038d112@amd.com>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221013184816.354278-3-carlos.bilbao@amd.com>
 <Y0kqHBwaYvZwTp9M@debian.me>
 <c351e1f6-29ad-2b93-09e4-c7f9d038d112@amd.com>
Date:   Fri, 14 Oct 2022 07:57:50 -0600
Message-ID: <87sfjqh5i9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> On 10/14/22 04:21, Bagas Sanjaya wrote:
>
>> =C2=A1Hola Carlos! Gracias for start writing Spanish translations. Howev=
er,
>> the patch can be improved, see below.
> Hola Bagas, thanks for your feedback :)
>>
>> On Thu, Oct 13, 2022 at 01:48:16PM -0500, Carlos Bilbao wrote:
>>> This commit adds Spanish translation of HOWTO document into rst based
>>> documentation build system.
>>>
>> Better say "Translate HOWTO document into Spanish".
> So, for the commit message here I just replicated what prior folks did,
> see:
>
> For Japanese:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/Documentation/translations/ja_JP?h=3Dv6.0&id=3Df012733894d36ff687862e9cd3b=
02ee980c61416
>
> For Korean:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/Documentation/translations/ko_KR/howto.rst?h=3Dv6.0&id=3Dba42c574fc8b803ec=
206785b7b91325c05810422
>
> I think I will leave that commit message, it is slightly more informative
> than "Translate HOWTO document into Spanish".

Just so you know, the standard advice (as found in submitting-patches.rst)=
=20
is to use the imperative mode in changelogs.  Some maintainers are quite
insistent that things be done that way.  I'm not one of those, though,
so I think the existing message is fine.

Thanks,

jon
