Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B568039E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 02:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbjA3B51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 20:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjA3B5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 20:57:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C0D1C30C;
        Sun, 29 Jan 2023 17:57:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 402A8B80D7C;
        Mon, 30 Jan 2023 01:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9A8C433EF;
        Mon, 30 Jan 2023 01:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675043837;
        bh=YHmT4MUA98weBZS7vacMYPV3iqY0ECu7epOQAGBvov0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YjCDvxjVnl6Fk/GnFbOhbxqd5y+Q3YD74Yv2hbV3E5tcGQHunWlVuOi3wygDvOaaQ
         MiYGEIP0kKM+8K08SlQvHkOQP5BGoPSe9du0Ld+fZ4oO5jkFBgKHbCtbxRJ8tAYVcd
         X60A2RrnOp7it4fO/O9qi6BIkHkz6Q7+AKLVZR0YkoFMxRMiZR993xrcpvDdp0mPi1
         he3E5ezAG+wyXtPdft+NhXE9tokcY4ydsHOD6L59RBmbhN8uSRqd2yJ7PfkHCZHhpg
         SH5CdPVbJ6nGagqz13ZiS4wwSmzm8e/WyYkGby3B4J/H8kAaPdU9PZD16asU9eHqNp
         qpYKmcVT07Blw==
Received: by mail-ot1-f43.google.com with SMTP id l3-20020a05683016c300b0068bba72c8bfso1701454otr.13;
        Sun, 29 Jan 2023 17:57:17 -0800 (PST)
X-Gm-Message-State: AFqh2kp10xTffvgQiYsgOL/Bz0U6Fdhz/DxvFMoO7HaDSln64TtSSuQy
        noCpROBRPYDEcQYzglUO47kIJE+os8N53rMOK+0=
X-Google-Smtp-Source: AMrXdXshhcc5ZYk6xro06djR669RC5tzE6Nqx/48tpv+MXvMaBeEnZS/yLSqghfFhjuXSi2CHZNCfoyB2GQAFlK9Zm0=
X-Received: by 2002:a9d:6c4a:0:b0:684:e846:74db with SMTP id
 g10-20020a9d6c4a000000b00684e84674dbmr2923693otq.51.1675043836961; Sun, 29
 Jan 2023 17:57:16 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:355:0:b0:4a5:1048:434b with HTTP; Sun, 29 Jan 2023
 17:57:16 -0800 (PST)
In-Reply-To: <CAH2r5muSiYCHbHg8zgF1jNiEyafXBhH_pcytudU-4_LQ6DyUmg@mail.gmail.com>
References: <CAH2r5muSiYCHbHg8zgF1jNiEyafXBhH_pcytudU-4_LQ6DyUmg@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 30 Jan 2023 10:57:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-gKrZ4gZZjookTDSL9ATLtnapQrciJpFH=LzX_8-ZO9g@mail.gmail.com>
Message-ID: <CAKYAXd-gKrZ4gZZjookTDSL9ATLtnapQrciJpFH=LzX_8-ZO9g@mail.gmail.com>
Subject: Re: [PATCH][KSMBD] fix indentation in ksmbd config and note Kerberos support
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-01-30 9:01 GMT+09:00, Steve French <smfrench@gmail.com>:
Hi Steve,

> Fix indentation of server config options, and also since
> support for very old, less secure, NTLM authentication was removed
> (and quite a while ago), remove the mention of that in Kconfig, but
> do note Kerberos (not just NTLMv2) which are supported and much
> more secure.
>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/ksmbd/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ksmbd/Kconfig b/fs/ksmbd/Kconfig
> index e1fe17747ed6..4153e5491435 100644
> --- a/fs/ksmbd/Kconfig
> +++ b/fs/ksmbd/Kconfig
> @@ -33,17 +33,18 @@ config SMB_SERVER
>     in ksmbd-tools, available from
>     https://github.com/cifsd-team/ksmbd-tools.
>     More detail about how to run the ksmbd kernel server is
> -   available via README file
> +   available via the README file
>     (https://github.com/cifsd-team/ksmbd-tools/blob/master/README).
>
>     ksmbd kernel server includes support for auto-negotiation,
>     Secure negotiate, Pre-authentication integrity, oplock/lease,
>     compound requests, multi-credit, packet signing, RDMA(smbdirect),
>     smb3 encryption, copy-offload, secure per-user session
> -   establishment via NTLM or NTLMv2.
> +   establishment via Kerberos or NTLMv2.
>
>  config SMB_SERVER_SMBDIRECT
>   bool "Support for SMB Direct protocol"
> + depends on SMB_SERVER
I am wondering this change is needed in this patch ? There is no patch
description for this change...

Thanks!
>   depends on SMB_SERVER=m && INFINIBAND && INFINIBAND_ADDR_TRANS ||
> SMB_SERVER=y && INFINIBAND=y && INFINIBAND_ADDR_TRANS=y
>   select SG_POOL
>   default n
>
> --
> Thanks,
>
> Steve
>
