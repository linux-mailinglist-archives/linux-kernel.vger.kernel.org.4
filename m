Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1456E3293
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjDOQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjDOQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:51:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D956E1;
        Sat, 15 Apr 2023 09:51:02 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id l7so7914554ljq.11;
        Sat, 15 Apr 2023 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681577460; x=1684169460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXet3FvjNAYZpRFyfcai48gOgzNXMquSK1VZ/fXLHKY=;
        b=GU77ZnuksUJifhzXuR1GFczBg1JX5INqL4Z+0SUjbIkZlKgtkRy/zLsQm6/kXehyzV
         bZXRsusw85SLcjfQK4JzlOatKFGAUDFs19g2bc+P82OMWsmKls74ITxTD+1Gi6TeBgk0
         /2uKumWTuukBCrBzldHhwdQWTmPP1Rehezc6B5rBdwRQVsh1mQtCKGrSDE1dCZD1nNMJ
         1S2kSuEhQAxh+kZQiXrZPJeMldhS66/LTSLjVqOcnpFFnKWxa1KfRD21PF38EmTWarzr
         AdTzBY0YBVyGfv/0MvSA3yZo45vUtiA8ONxCDzRh9tZ+EfuSkMKNKb7d0ZuHsNYIKqkL
         jC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681577460; x=1684169460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXet3FvjNAYZpRFyfcai48gOgzNXMquSK1VZ/fXLHKY=;
        b=F9vdLf9kwCf7LCzhEISwur1qNlufRT4AsJS/xa92/M2jC/LbCAJWQ6Jvc1fX5vFF5t
         LXXRU/i35DJDRrTs1YQ+kh295t1OcCR2oCu3DcdCRw2KGAG3AzLuduTI2vqpilKvMnFL
         FYqMxcmkLLcHpORTe2XLMRQKZGbuYJ6ZaNESSm8ZbRhOyi3dxIOyZKrxqiYSmde7Yxyn
         QzyoqrGWHZp8Ysm/vgfKGwtyhD44pOTCs1anO7jfR28eS77PEpoKy2o/adkNBOBUhf3s
         s223UYX9cpBQUdIRaLcCLhx5Cmgak/dlS1q24BIwR/H/Bk8PzqMa1Mu2lBTXXKNKU4r4
         WXVg==
X-Gm-Message-State: AAQBX9fBW25zyeh4kw1nraJfdMEuQYrwg4KVlTR+2RVAU/U8Y0sZOsRh
        LJPId1fBSK8ixZckbg0HOfyLNr6qy4rmMG1MWwM=
X-Google-Smtp-Source: AKy350Z6p9ZnlkFCDw6hkL9FGjfXSpnwerKgnJpSc82xH1QjOKCPqenoR6sCUz4xvWJaRIRNPt4NVdjpll2IBtkJ408=
X-Received: by 2002:a2e:b16e:0:b0:2a7:6e94:750e with SMTP id
 a14-20020a2eb16e000000b002a76e94750emr3014790ljm.6.1681577460043; Sat, 15 Apr
 2023 09:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230327143733.14599-1-akinobu.mita@gmail.com>
 <20230327143733.14599-2-akinobu.mita@gmail.com> <CAMuHMdXhRvq3nktP4Kzjk8TuX1G=RfO3eOODGt5GRC6vGnfwzw@mail.gmail.com>
In-Reply-To: <CAMuHMdXhRvq3nktP4Kzjk8TuX1G=RfO3eOODGt5GRC6vGnfwzw@mail.gmail.com>
From:   Akinobu Mita <akinobu.mita@gmail.com>
Date:   Sun, 16 Apr 2023 01:50:47 +0900
Message-ID: <CAC5umyiE0sx=NJSV4kgvF-cfc2nB+kSxJdwp2-cXU0HZTbydLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] fault-inject: allow configuration via configfs
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, axboe@kernel.dk,
        Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=E5=B9=B44=E6=9C=8815=E6=97=A5(=E5=9C=9F) 23:53 Geert Uytterhoeven <gee=
rt@linux-m68k.org>:
>
> Hi Mita-san,
>
> On Mon, Mar 27, 2023 at 4:48=E2=80=AFPM Akinobu Mita <akinobu.mita@gmail.=
com> wrote:
> > This provides a helper function to allow configuration of fault-injecti=
on
> > for configfs-based drivers.
> >
> > The config items created by this function have the same interface as th=
e
> > one created under debugfs by fault_create_debugfs_attr().
> >
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>
> Thanks for your patch, which is now commit 4668c7a2940d134b
> ("fault-inject: allow configuration via configfs") in linux-next
> (to be tagged soon as next-20140414).
>
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1977,9 +1977,20 @@ config FAIL_SUNRPC
> >           Provide fault-injection capability for SunRPC and
> >           its consumers.
> >
> > +config FAULT_INJECTION_CONFIGFS
> > +       bool "Configfs interface for fault-injection capabilities"
> > +       depends on FAULT_INJECTION && CONFIGFS_FS
>
> noreply@ellerman.id.au reported build failures for e.g. m68k-allmodconfig
> http://kisskb.ellerman.id.au/kisskb/buildresult/14911188/:
>
> fault-inject.c:(.text+0x1ee): undefined reference to
> `config_group_init_type_name'
>
> This fails because FAULT_INJECTION=3Dy but CONFIGFS_FS=3Dm.

Oh, I just sent that build fix patch.
https://lore.kernel.org/all/20230415125705.180426-1-akinobu.mita@gmail.com/

Could you please check if this is the correct way to fix it?
