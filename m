Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58122708C75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 01:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjERXgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 19:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjERXgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 19:36:10 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F91729
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:35:34 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75778c1121aso30885485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 16:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684452933; x=1687044933;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+bBjc2pOJ6Uyq/nBco+oaTCPhBKha0MzdONm56qSxM=;
        b=eGqkxBNa8fLPRzs2kydWg0Cmz1vo4RaRuNqVOyM1/Tny8uOhIAtF1+FiSVfQNU4qb5
         M2hmsG7BzvCO1NYFir+QR+OW6VmULSg28X1+gPo06ghfJ6yMTk0tfP+eLUZpgnMh4eUF
         Es/GiPB9OkLXSy+JRa45lOuvPb/OK/4v0PA4+xNpnNlB37qix3uVxKhFTVHRoAv57p2h
         uSJJsZJEg/OSI61aC9ZQEI3LZvp8QWYVBT1sZb7Na2z0u+N1h0oQPOHaWGKp+a17RwZW
         qrt1lmO7Xzov3JM9L0yO64xatoBdpmPMLVfQd4ZqXU6CD23H0pFZ8MS1883cfK3zmddL
         KFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684452933; x=1687044933;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+bBjc2pOJ6Uyq/nBco+oaTCPhBKha0MzdONm56qSxM=;
        b=aTjY0/4SRPMNSDtqJuklVLKQRkZKcBY/Z6vy1vXjbxNXcinsLQ60SxCQ89wzlcP7F7
         fB1QgKDqs4LpMWnene5un0hHMyEI0maHdmNXS5OX+6OLbPzka1Up4hmIM+YzOPA5FDdF
         RE4BkHrwLvoTtqFA3VN2Y6SdnJWUbzTNEOTRZPP0xEKvUefSrM9wMeBxHF6tRfzn56xS
         i0RAE/SI7C5EofyaN6/qKt2WEmZGpOXWF0Gmjc9gqu758ShqzlyCEF4tpKw3vrFq34yY
         7QHab73vPPMPxhcS7wU/5RnT8fHeIx5s6lzSclK6ksdMDpyqPWXv4K3cJ0eQhUzcLN9o
         Q+ZQ==
X-Gm-Message-State: AC+VfDzM11gP4Qex39CUEHy8xHfCu8LAxh1ICemAkhLgfFS4Y6RkFClM
        xKHJMSFDfCQle5ulMG8dL/Qu8RUygY9iatxEHUQ=
X-Google-Smtp-Source: ACHHUZ60JZ5V4fp4GT0w+1msyOxlDt1MJPV/XmSWJhiARevOTYPUocbFvLN5qAhEwAr0l7MBemqN2IkoiDEvgUJMGfY=
X-Received: by 2002:a05:6214:509b:b0:5df:55b5:b1a with SMTP id
 kk27-20020a056214509b00b005df55b50b1amr1345397qvb.4.1684452933475; Thu, 18
 May 2023 16:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPiR4Lwd0NTecp8GMN9YVLU4OXTiHm-z7Gsa_4-LEm1ZQ@mail.gmail.com>
 <CABXGCsOWCp=KYFFvWA6ExUotUJe=YViZEsomqkCJb7dwNUFAwg@mail.gmail.com>
In-Reply-To: <CABXGCsOWCp=KYFFvWA6ExUotUJe=YViZEsomqkCJb7dwNUFAwg@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 19 May 2023 04:35:22 +0500
Message-ID: <CABXGCsNECpnkt1LRTKuGcJdN=mPyFt1sW6c8tY86Ba_pUrCNvw@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
 - RIP: 0010:amdgpu_bo_get_memory+0x80/0x360 [amdgpu]
To:     "Olsak, Marek" <Marek.Olsak@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 8, 2023 at 3:40=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> No one can reproduce this?
> I prepared a video instruction which can helps:
> https://youtu.be/0ipQnMpZG1Y
>
> 1. Run script which would calculate watchers:
> $ for i in {1..99999}; do sudo curl -s
> https://raw.githubusercontent.com/fatso83/dotfiles/master/utils/scripts/i=
notify-consumers
> | bash; done
>
> 2. Run the game "Devision 2"
>
> 3. Run 20 windows of Google Chrome with such script
> $ for i in {1..20}; do google-chrome-unstable
> --profile-directory=3D"Test-2" --new-window --start-maximized
> "youtube.com" &; done
>
> I hope after it you see the desired backtrace.
>

I found another way to reproduce the problem.

Demonstration: https://youtu.be/6cvs4cCMo4M

1. Run the game "Devision 2"
2. Run 20 windows of Google Chrome with such script $ for i in
{1..20}; do google-chrome-unstable --profile-directory=3D"Test-2"
--new-window --start-maximized "youtube.com" &; done
3. Run "nvtop" and got kernel bug.

After it "nvtop" stop working until reboot.

Can anyone confirm it, please?

--=20
Best Regards,
Mike Gavrilov.
