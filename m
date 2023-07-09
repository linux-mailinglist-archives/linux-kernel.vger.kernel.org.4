Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B274C01B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 02:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjGIAA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 20:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGIAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 20:00:55 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC970D3;
        Sat,  8 Jul 2023 17:00:52 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-7918b56b1e1so1126003241.2;
        Sat, 08 Jul 2023 17:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688860852; x=1691452852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCTYOFpZ33F5UhgemDclft92cknyKeyRtlgFADnqHWw=;
        b=FGjGp/5lxuVEZkuZWmh5w2IVh5U1D+j17NreINRb8RWNJl0qmLm3RKcIy/p0KdxZUQ
         zVeS6ihFXJPSYvG/5lcBr40wbBr+wUHx4ZgFizrxHCd3yV6KbnRutUErmq56ph/sYMXn
         6YwZclgJLVsJXSKiTNlloO/fvNIXpFK4I5iRgeyNBHxMIpj6BJdPQGYPMDISR85huQjt
         PQyQ4A8yWT01bFRrizqNVW5zg0FErnPp82vzEbE7L43ugKjLRzTgvdx+c9VfNWu/bWjy
         r8qh9KsPnznq5i4sayiN9nOy90Xlm887qdZ3CafcFwmuMfIr1rj9pTvfqRgWzXSYEnSH
         D1YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688860852; x=1691452852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCTYOFpZ33F5UhgemDclft92cknyKeyRtlgFADnqHWw=;
        b=goNVGfR9XzDpS1c0noEoqpTpGDmPHhAO8om8CCKytUybM3QES6Jq9UwBSxV01UU9d1
         Wbqvnab+Ka1O8NOFb6MyrwChQZF/4CZZKllmZcLu5sjorM6Ht5i3IaOrSQQKXrmE6Kzn
         nmGlGRwLHIhB02N8NyAqJk6wC5cISksopS176Wa/B0tR8DP6sb4Yd8xCr4yA4giew9Dz
         LBtDfLey09Wj7t8PabjNgjwkst1nPC3UjxjkQdqVp14slegIt690eynwffp2bDvGlg5y
         iNSqdoHdgB/WJjpwccmBV0+AN+THG62895blgvV67KkHic+47rxfwaUuEwEimAQY8ZbK
         RA4w==
X-Gm-Message-State: ABy/qLaMwgJ7/MJcTRXdTfYtemKzqNr9ALeqSjn2N1zUj+6hFgFlCrux
        /5c6dIC3VCaAR9Ymm3WE/tgkdNCm5ASqtRnXaow=
X-Google-Smtp-Source: APBJJlHDtm11y7Gufvz4Gqec/NdH2pk7IDgpiKTKFnJaCaJR+CTIONi0xDNiCGcBLGGDfcIbBTwGJCuNj3yHuFr+fdg=
X-Received: by 2002:a1f:d486:0:b0:453:b080:632d with SMTP id
 l128-20020a1fd486000000b00453b080632dmr6263863vkg.0.1688860851887; Sat, 08
 Jul 2023 17:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
 <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
 <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info> <CAAJw_Zu=MPtGPARgCB2fteP+7F793YDFXE9RuzSH8EqYBS-OOw@mail.gmail.com>
 <64b8732f-6319-9f10-b82a-b4a3dd8d4b8e@lwfinger.net> <CAAJw_ZvZNQzrFyQizJnKe5PerqqAUOmPYd6cnjAcvs68xNdwSA@mail.gmail.com>
 <ff646259-8ce1-f1fe-4627-cdf99321dba8@leemhuis.info> <0068af47-e475-7e8d-e476-c374e90dff5f@lwfinger.net>
In-Reply-To: <0068af47-e475-7e8d-e476-c374e90dff5f@lwfinger.net>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Sun, 9 Jul 2023 08:00:40 +0800
Message-ID: <CAAJw_ZvBUpMMC886CDdsLFW6bUG69X78zVfre7gCfu=aTR1xGQ@mail.gmail.com>
Subject: Re: Linux-6.5 iwlwifi crash
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        lkml <linux-kernel@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 8, 2023 at 2:07=E2=80=AFAM Larry Finger <Larry.Finger@lwfinger.=
net> wrote:
> I am certainly no expert on iwlwifi, but this change looks suspicious:
>
> @@ -10,8 +10,7 @@
>   #include "fw/api/txq.h"
>
>   /* Highest firmware API version supported */
> -#define IWL_22000_UCODE_API_MAX        81
> -#define IWL_22500_UCODE_API_MAX        77
> +#define IWL_22000_UCODE_API_MAX        77
>
>   /* Lowest firmware API version supported */
>
> The parameter that was originally set to 81 is now set to 77.
>
> Please try the attached patch.
>
> Larry

Larry, tried, but that didn't help.

Thanks,
Jeff.
