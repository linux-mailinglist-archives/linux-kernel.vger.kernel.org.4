Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8EF6804C7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235361AbjA3EI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjA3EIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:08:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B202C1ABC4;
        Sun, 29 Jan 2023 20:08:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4928F60D3A;
        Mon, 30 Jan 2023 04:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3023C4339B;
        Mon, 30 Jan 2023 04:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675051732;
        bh=UgVquuDBgV33u6k2CLOnXrKV/spFvDfCGPI87tPn2N0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=WiKCYyMzZSCpuBVIZBfi9G/KENwquU+Fnvj8PhopPnQGuNd9IHrPGwMgXV5ZRp0LV
         NwnlXE7vZld5+V1XA7MtyO9IzmkeHde3qUp67mayX3kKO98AGubt+buwBUanHs5JhC
         zE6fvPIGCWDUCjlOm9PK16cBM6y0loxODE2UJvaNNTru2gWDLXxb8hwD+bjHxoPvwe
         GNNWUlCh54yHqOjWKoY0WL6m2eXkpFFJ3BiWgRrOcoqPVfpvsZHSLCpxhjOGiJkTkN
         E7rPLNPdsA7TwD25wWT7R7NkeLj7p+ewSkAirjQO5Gce+d4ZyHVFp+mt/ZZlmdm77e
         OtMyX4rpkipog==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15fe106c7c7so13592853fac.8;
        Sun, 29 Jan 2023 20:08:52 -0800 (PST)
X-Gm-Message-State: AFqh2kpkIWgmCVHb3hn5Zq35eZptonknHhsSkPRctlX15JAfjI9kO/Tp
        b7V+IB5AV3JY4MIf+yMc9+OoTcpI4VhUjd2+Kdc=
X-Google-Smtp-Source: AMrXdXvaRnnewq7SHyltWs+Nc4wwKbNTn+EwQJj8KoLd0R45nhS0bgqOcw051dYp1jE7sIoWQDubhrj2UphgnQUKUjI=
X-Received: by 2002:a05:6870:8c11:b0:15f:de79:36c7 with SMTP id
 ec17-20020a0568708c1100b0015fde7936c7mr2462366oab.215.1675051731713; Sun, 29
 Jan 2023 20:08:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Sun, 29 Jan 2023
 20:08:51 -0800 (PST)
In-Reply-To: <CAH2r5msAxf7Wn2o298+P3zG6ChbuMhHYgVSUCCDCm0Cwh530HA@mail.gmail.com>
References: <CAH2r5muSiYCHbHg8zgF1jNiEyafXBhH_pcytudU-4_LQ6DyUmg@mail.gmail.com>
 <CAKYAXd-gKrZ4gZZjookTDSL9ATLtnapQrciJpFH=LzX_8-ZO9g@mail.gmail.com> <CAH2r5msAxf7Wn2o298+P3zG6ChbuMhHYgVSUCCDCm0Cwh530HA@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 30 Jan 2023 13:08:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_mamiP2bDT73OvvLXsS_haniD5MDiQDedQUhUv23JSbg@mail.gmail.com>
Message-ID: <CAKYAXd_mamiP2bDT73OvvLXsS_haniD5MDiQDedQUhUv23JSbg@mail.gmail.com>
Subject: Re: [PATCH][KSMBD] fix indentation in ksmbd config and note Kerberos support
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-01-30 12:15 GMT+09:00, Steve French <smfrench@gmail.com>:
> On Sun, Jan 29, 2023 at 7:57 PM Namjae Jeon <linkinjeon@kernel.org> wrote:
>>
>> 2023-01-30 9:01 GMT+09:00, Steve French <smfrench@gmail.com>:
>> Hi Steve,
>>
>> > Fix indentation of server config options, and also since
>> > support for very old, less secure, NTLM authentication was removed
>> > (and quite a while ago), remove the mention of that in Kconfig, but
>> > do note Kerberos (not just NTLMv2) which are supported and much
>> > more secure.
>> >
>> > Signed-off-by: Steve French <stfrench@microsoft.com>
>> > ---
>> >  fs/ksmbd/Kconfig | 5 +++--
>> >  1 file changed, 3 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
>> > index e1fe17747ed6..4153e5491435 100644
>> > --- a/fs/ksmbd/Kconfig
>> > +++ b/fs/ksmbd/Kconfig
>> > @@ -33,17 +33,18 @@ config SMB_SERVER
>> >     in ksmbd-tools, available from
>> >     https://github.com/cifsd-team/ksmbd-tools.
>> >     More detail about how to run the ksmbd kernel server is
>> > -   available via README file
>> > +   available via the README file
>> >     (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).
>> >
>> >     ksmbd kernel server includes support for auto-negotiation,
>> >     Secure negotiate, Pre-authentication integrity, oplock/lease,
>> >     compound requests, multi-credit, packet signing, RDMA(smbdirect),
>> >     smb3 encryption, copy-offload, secure per-user session
>> > -   establishment via NTLM or NTLMv2.
>> > +   establishment via Kerberos or NTLMv2.
>> >
>> >  config SMB_SERVER_SMBDIRECT
>> >   bool "Support for SMB Direct protocol"
>> > + depends on SMB_SERVER
>> I am wondering this change is needed in this patch ? There is no patch
>> description for this change...
>
> The "depends on SMB_SERVER" is needed to fix the indentation -
> otherwise it thinks that "config SMB_SERVER_DIRECT" is at the same
> level of indentation as its parent (ksmbd)
> See before and after screenshots attached.
Thanks for explanation:)
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

>
>
>
> --
> Thanks,
>
> Steve
>
