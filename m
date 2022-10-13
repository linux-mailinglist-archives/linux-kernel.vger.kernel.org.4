Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957925FD349
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 04:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJMCfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 22:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJMCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 22:35:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1398285B;
        Wed, 12 Oct 2022 19:35:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id y5so492334lfl.4;
        Wed, 12 Oct 2022 19:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDYDa2ojxUzzkoRcXfBQCdYaE7OWB5IO4iNhZiRH/74=;
        b=LuMVT3GSBr9/hAJU2xDNoQM0/UPkqOn0/JQsDOxexxuWjUdqyFqIxD1H9YMSlsCzsi
         o5jfUSHzFpclFNaNtlT7eCRVz9vKKvSkqVFDSRW2ODfpi3bgsY+9LbW6NG3tIHIK5zkP
         BGqg0iFYJdimA+HtUdSmWwdFyDiBeF8uvRQpT/xnmRCCkSkohUwZxy7vFsF6wbZJlpkW
         uSWb/bZHbNpih3ICbXtCKuXTqJz9lngOQG5NMhcEV6wL+otrl9fJ5Xo4d9vphPV/kIKo
         /UJB+WrQyY9iPStK1rffHtwwrKykPjsSK6T7Hdv4rKAaqCIWGMpVSyVhsdNX2m/WXOxg
         g3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDYDa2ojxUzzkoRcXfBQCdYaE7OWB5IO4iNhZiRH/74=;
        b=3U7AKQXiqMF1i/+8OWtJn1GTDpaoBKewgyOY/1ht90gFucQ9KUT3xo8Qk6S7MlVLKo
         yFeZmlEXWIqRBlO36Hh/mmppkiqPPzuo2KDA87r0HWbUGM7Kz0ECSTg3uC2NOG3awcsx
         YYL4GICDVay0YxfmWRDA3mcZLZh8DBWoEVxrpcHjDCH9s70XlYt9XwuRjNxnVbI4GiTb
         yhz8n0X8ImOq/qBc/DIWfv/vCd29TBth4/eqS/D7d3+fslVS/rkuqTB+P14v16J2MLy7
         SJS1bnUjWYSGFCWFDzoPTKiLIPOyWuR2wZa2aOHIxutL/+qPI8HWg3KLHZo03UpUtAkC
         R1sQ==
X-Gm-Message-State: ACrzQf2zeL+/KjY9QWv15l9RoY7jdeQJmWByFM1Nh0s/OO/89bVWns6F
        7SFRDWw734RRTGJF6mOMbbXEPS49a20HbQG3Bag=
X-Google-Smtp-Source: AMsMyM5BO7jOs2tKkI/jONmwsexNW3mjpkziqPTokYaaa/Zdn7iVI5CFXWjkCmJhqU2AeuKLPGZFa6nGZq5koL79Dfw=
X-Received: by 2002:a05:6512:110c:b0:4a2:4119:f5c4 with SMTP id
 l12-20020a056512110c00b004a24119f5c4mr10737708lfg.606.1665628524384; Wed, 12
 Oct 2022 19:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1665467392.git.bobwxc@email.cn> <4e9675ac83a06f2597d069f44a94c4e2cbd7ab2b.1665467392.git.bobwxc@email.cn>
 <0ea779eb-d377-e119-616e-9cd8fc44c5ef@loongson.cn>
In-Reply-To: <0ea779eb-d377-e119-616e-9cd8fc44c5ef@loongson.cn>
From:   Alex Shi <seakeel@gmail.com>
Date:   Thu, 13 Oct 2022 10:34:48 +0800
Message-ID: <CAJy-Amn0YJao3j_AHyEJXKfeR5oYrL595is09zz-A+XAHda+0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] docs/zh_CN: add zh_CN/arch.rst
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        chenhuacai@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Reviewed-by: Alex Shi <alexs@kernel.org>

On Tue, Oct 11, 2022 at 8:27 PM Yanteng Si <siyanteng@loongson.cn> wrote:
>
>
> On 10/11/22 14:01, Wu XiangCheng wrote:
> > From: Wu XiangCheng <bobwxc@email.cn>
> >
> > Add an entry for all zh arch documents.
> >
> > Signed-off-by: Wu XiangCheng <bobwxc@email.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> > ---
> >   Documentation/translations/zh_CN/arch.rst | 29 ++++++++++++++++++++++=
+
> >   1 file changed, 29 insertions(+)
> >   create mode 100644 Documentation/translations/zh_CN/arch.rst
> >
> > diff --git a/Documentation/translations/zh_CN/arch.rst b/Documentation/=
translations/zh_CN/arch.rst
> > new file mode 100644
> > index 000000000000..690e173d8b2a
> > --- /dev/null
> > +++ b/Documentation/translations/zh_CN/arch.rst
> > @@ -0,0 +1,29 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=E5=A4=84=E7=90=86=E5=99=A8=E4=BD=93=E7=B3=BB=E7=BB=93=E6=9E=84
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +=E4=BB=A5=E4=B8=8B=E6=96=87=E6=A1=A3=E6=8F=90=E4=BE=9B=E4=BA=86=E5=85=
=B7=E4=BD=93=E6=9E=B6=E6=9E=84=E5=AE=9E=E7=8E=B0=E7=9A=84=E7=BC=96=E7=A8=8B=
=E7=BB=86=E8=8A=82=E3=80=82
> > +
> > +.. toctree::
> > +   :maxdepth: 2
> > +
> > +   mips/index
> > +   arm64/index
> > +   riscv/index
> > +   openrisc/index
> > +   parisc/index
> > +   loongarch/index
> > +
> > +TODOList:
> > +
> > +* arm/index
> > +* ia64/index
> > +* m68k/index
> > +* nios2/index
> > +* powerpc/index
> > +* s390/index
> > +* sh/index
> > +* sparc/index
> > +* x86/index
> > +* xtensa/index
>
