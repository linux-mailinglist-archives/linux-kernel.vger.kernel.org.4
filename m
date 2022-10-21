Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3836072F1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiJUIxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiJUIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:53:10 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C841125437E;
        Fri, 21 Oct 2022 01:53:08 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id bs14so2763097ljb.9;
        Fri, 21 Oct 2022 01:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eizb7N3bu2n05M5ghdt2hPY1rJNDJn8OFWYirn9hQHU=;
        b=bl7YSiDR4nOEXF69XS5hW0a54M6d7/EgjS2Ojz/wEZdScu4zn2r7ipl2fKF8PacJ24
         wEMlNyKNJjLWyWR3O0cz9Gt2CYhlmCHEBdT8/wFwlGj1zklEJQ/4e5NyZkov1gERqkc9
         //DlfK1Ep95C/9OqOlsoV/aLg1XPdnGJ8rOj0X/4zJ+ymFrAJyAfzDYEhn/u8XL3khm0
         6taHzFq1K1e5+XjLtz3EW0ghGy/Jn+fuCQZxMV7ENF+NyrXWScojfuoM2rhE+EoEVl+U
         OeaJpFMEWhATBiaJMkdah9p+O5AC+B52T3XnBH1Wel0jVTr089lWEHt/NmF113bDw2YO
         n4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eizb7N3bu2n05M5ghdt2hPY1rJNDJn8OFWYirn9hQHU=;
        b=bN3T6yRYncVwtdQ35JQeGABlvGjxWq/4KQEnUqVT0XGI2AihMVOAYq+pQw4nRKq9K0
         jT9gWS6EFRLoxtnWcf9bR80gBb7g6GK6Vg5bIKrNpXNQu05SDJ+YPdWOXqsj/pMGK+qk
         mAgVS/k+M9KEZkCPF17WM53548Aw2IfxcIWH1OM/xY02BLsciCGUEdCRj76IzbV1uXHU
         1BqsjVsGt8Fbiexs9W05rZ7aELU6wCqq+lqURrtmaMiYFV0cAsRfJWSVB67JtlU9Y15N
         XoaM4mzUPwrTWX4Y5uCw1ULJKg4iWv21TIPntkiTYNFJJ8kZyxJDO1JLoh05Al5cLEyZ
         EBEg==
X-Gm-Message-State: ACrzQf3mOmbKtOhzixe7pPt6ZiuvLE1KpPCY4pcJrygwGa4FZjViSYOf
        doQ2YyCo864j5+ipMb8jgKM6Dk1ft9t8lWmFD2I=
X-Google-Smtp-Source: AMsMyM7GIRqgThOeoDmVWLt/zv5EzFfBx6OIJb78ZOgWqOwCkAvudIo6Z37nBr9//f9xCJV17qRmMcj0LLsKoVx6vFc=
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id
 k1-20020a2e8881000000b00255779025e6mr6405991lji.525.1666342386867; Fri, 21
 Oct 2022 01:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221021083501.347066-1-me@lirui.org>
In-Reply-To: <20221021083501.347066-1-me@lirui.org>
From:   Alex Shi <seakeel@gmail.com>
Date:   Fri, 21 Oct 2022 16:52:30 +0800
Message-ID: <CAJy-Am=sP47+n6ZQUjjQVzu5frsnBjnc7ZxGsz9M4uK7cZ96iw@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Add subsystem-apis Chinese translation
To:     Rui Li <me@lirui.org>
Cc:     Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
        Jonathan Corbet <corbet@lwn.net>,
        Wu XiangCheng <wu.xiangcheng@linux.dev>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it's better to come with some real doc translation.

Thanks
Alex

On Fri, Oct 21, 2022 at 4:36 PM Rui Li <me@lirui.org> wrote:
>
> Translate subsystem-apis.rst into Chinese.
>
> Signed-off-by: Rui Li <me@lirui.org>
> ---
>  Documentation/translations/zh_CN/index.rst    |  5 +-
>  .../translations/zh_CN/subsystem-apis.rst     | 66 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/translations/zh_CN/subsystem-apis.rst
>
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/t=
ranslations/zh_CN/index.rst
> index ec99ef5fe990..1250f2afd928 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -53,10 +53,7 @@
>     core-api/index
>     driver-api/index
>     =E5=86=85=E6=A0=B8=E4=B8=AD=E7=9A=84=E9=94=81 <locking/index>
> -
> -TODOList:
> -
> -* subsystem-apis
> +   subsystem-apis
>
>  =E5=BC=80=E5=8F=91=E5=B7=A5=E5=85=B7=E5=92=8C=E6=B5=81=E7=A8=8B
>  --------------
> diff --git a/Documentation/translations/zh_CN/subsystem-apis.rst b/Docume=
ntation/translations/zh_CN/subsystem-apis.rst
> new file mode 100644
> index 000000000000..5ceca6c3ca1b
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/subsystem-apis.rst
> @@ -0,0 +1,66 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: ./disclaimer-zh_CN.rst
> +
> +:Original: Documentation/subsystem-apis.rst
> +
> +:=E7=BF=BB=E8=AF=91:
> +
> +  =E6=9D=8E=E7=9D=BF Rui Li <me@lirui.org>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E5=86=85=E6=A0=B8=E5=AD=90=E7=B3=BB=E7=BB=9F=E6=96=87=E6=A1=A3
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E8=BF=99=E4=BA=9B=E6=96=87=E6=A1=A3=E4=BC=9A=E4=BB=8E=E4=B8=80=E4=B8=AA=
=E5=86=85=E6=A0=B8=E5=BC=80=E5=8F=91=E8=80=85=E7=9A=84=E8=A7=92=E5=BA=A6=E5=
=8E=BB=E6=B7=B1=E5=85=A5=E8=AE=B2=E8=BF=B0=E4=B8=80=E4=BA=9B=E5=86=85=E6=A0=
=B8=E5=AD=90=E7=B3=BB=E7=BB=9F=E7=9A=84=E8=BF=90=E8=A1=8C=E7=BB=86=E8=8A=82=
=E3=80=82=E8=BF=99=E9=87=8C
> +=E7=9A=84=E8=AE=B8=E5=A4=9A=E4=BF=A1=E6=81=AF=E7=9B=B4=E6=8E=A5=E6=9D=A5=
=E6=BA=90=E4=BA=8E=E5=86=85=E6=A0=B8=E6=BA=90=E7=A0=81=EF=BC=8C=E5=8A=A0=E4=
=B8=8A=E4=B8=80=E4=BA=9B=E5=BF=85=E8=A6=81=E7=9A=84=E8=A1=A5=E5=85=85=E6=9D=
=90=E6=96=99=EF=BC=88=E6=88=96=E8=80=85=E8=87=B3=E5=B0=91=E6=98=AF=E6=88=91=
=E4=BB=AC=E4=BA=BA=E4=B8=BA
> +=E5=8A=A0=E4=B8=8A=E7=9A=84=E2=80=94=E2=80=94=E5=B0=BD=E7=AE=A1=E6=9C=89=
=E4=BA=9B=E5=B9=B6 *=E4=B8=8D* =E5=BF=85=E8=A6=81=EF=BC=89=E3=80=82
> +
> +**Fixme**: =E9=9C=80=E8=A6=81=E6=9B=B4=E5=A4=9A=E6=96=87=E6=A1=A3=E7=BB=
=84=E7=BB=87=E5=B7=A5=E4=BD=9C=E3=80=82
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   driver-api/index
> +   core-api/index
> +   locking/index
> +   accounting/index
> +   cpu-freq/index
> +   iio/index
> +   infiniband/index
> +   power/index
> +   virt/index
> +   sound/index
> +   filesystems/index
> +   mm/index
> +   PCI/index
> +   scheduler/index
> +   peci/index
> +
> +TODOList:
> +
> +* block/index
> +* cdrom/index
> +* fb/index
> +* fpga/index
> +* hid/index
> +* i2c/index
> +* isdn/index
> +* leds/index
> +* netlabel/index
> +* networking/index
> +* pcmcia/index
> +* target/index
> +* timers/index
> +* spi/index
> +* w1/index
> +* watchdog/index
> +* input/index
> +* hwmon/index
> +* gpu/index
> +* security/index
> +* crypto/index
> +* bpf/index
> +* usb/index
> +* scsi/index
> +* misc-devices/index
> +* mhi/index
> --
> 2.30.2
>
