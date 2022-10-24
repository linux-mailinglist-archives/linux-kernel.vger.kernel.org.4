Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494A160A165
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 13:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJXLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 07:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJXLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 07:23:21 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A33B985
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:23:20 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id s28so7525948vsr.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awx4Y/bO+loraqXV2AwEp2ffosaIQWTq0T6Y6GrQT7k=;
        b=Cz6V7CP8AWHCdwsemLxu07MC9m7ITS+yO8mBsVa1Li7ubhohU9ejYTd6wpV/DBbAkH
         18PwV7GrJ5iAl+ZyO+WodecqmYYXHKjhfgUsjzCAH8jPdVorpUVaYbDC2cYrbpJscuZ9
         RxT/X9/kzbbL5ypjogrMqUXwUMk+HJmdNuSMOFptvq6hW2+jIFnNLUN8gmjbVAMbTsO/
         hore48c+Rbeimbyx3YUo4gMXWMfYRXZU5zNDFoJ1P+/pRh1xfuvA3EorJlzK2Nkag/lt
         nSy9gl84iB3rugxbdxIZObICASo2iYQoITLpWmm4RhdPDlVON+XeOoTiz8z77ht6Jd4x
         RahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awx4Y/bO+loraqXV2AwEp2ffosaIQWTq0T6Y6GrQT7k=;
        b=WVdQzwr0qdYeNsZZFxXg5e6H9+wJjKZClW4mvXrD4t9N+mC84V2MdZ5flWfks1OjTk
         4OYyDQtc3xMIff/yT/QT9FLe1JsQRrOQ05vcc2eetwHNaruBq/Z7AZU3PcvSVY29OUvz
         Y+pAIL0EI0DQW95jGYbc/+k6wiMpwax2cgyfZY+6fTeiNjhVye+cQd46r9c7uMUF87L/
         Q6nEJlrhLzHGmzdPqIKtPAv7QcymHAF1nhVorH+UVmmAEgDkphSKI59hJw9eV8jR4faV
         U03qI6Ur2DCaGFUgM0+rhSjVkNDZ3EuZ7UqDfqA1gISfQv7hAMyJBeirr0J4Q1xssjC1
         WXgg==
X-Gm-Message-State: ACrzQf3pzXtW+L97gBuyodDM/ZXLFoI4E6ieVR3lbLi0bH8hh/Ds2URt
        IXqlMs7UWtcBRYay9p9Pt4zpJFUX17vOm2HeKOk=
X-Google-Smtp-Source: AMsMyM4w1m/n473eX50mXZOCB5avuhNpyZkjf7DSvmHsNlfuajMASiPUtsXyBVnUfUSAi+5Mu8c5pAIHU5fijfO9em8=
X-Received: by 2002:a67:db0d:0:b0:3aa:12be:c26c with SMTP id
 z13-20020a67db0d000000b003aa12bec26cmr3828320vsj.26.1666610599422; Mon, 24
 Oct 2022 04:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221024084925.262289-1-tegongkang@gmail.com>
In-Reply-To: <20221024084925.262289-1-tegongkang@gmail.com>
From:   Kang Minchul <tegongkang@gmail.com>
Date:   Mon, 24 Oct 2022 20:23:08 +0900
Message-ID: <CA+uqrQDuJQ3yBY8_re===u0f97pyr_hn_VNu6LqLJAZnDeqhVQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] staging: r8188eu: cleaning up unused variables
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022=EB=85=84 10=EC=9B=94 24=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 5:49, =
Kang Minchul <tegongkang@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> This patch series cleans up unused variables in r8188eu
> causing coccicheck warnings.
>
> Difference between v1 and this patch is that this patch series
> include making function amsdu_to_msdu in /r8188eu/core/rtw_recv.c
> into void function.
>
> Kang Minchul (4):
>   staging: r8188eu: remove unnecessary variable in ioctl_linux
>   staging: r8188eu: make amsdu_to_msdu void function
>   staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
>   staging: r8188eu: remove unnecessary variable in rtw_ap
>
>  drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
>  drivers/staging/r8188eu/core/rtw_recv.c      | 5 +----
>  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>  4 files changed, 5 insertions(+), 12 deletions(-)
>
> --
> 2.34.1
>
Oh, I guess patch 4/4 can be fixed as well.
I think the function rtw_sta_flush can be void as well.

I'll resend the patch later.

regards,
Kang Minchul
