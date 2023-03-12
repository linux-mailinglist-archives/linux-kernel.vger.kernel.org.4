Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA06B63D6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 09:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCLIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCLIQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 04:16:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED9F3B3F3;
        Sun, 12 Mar 2023 00:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4598560AC1;
        Sun, 12 Mar 2023 08:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A80DC433D2;
        Sun, 12 Mar 2023 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678608968;
        bh=0CxKlfzb7DAkGaGk9kW8bEAcN3ooT/PpdVdgfIW2bbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P3T8bpXghGspIsuAUPoU+cHag/m1caQbEQiwm3xT3eBy/1U1BzWjbN4CRQc781qZc
         YlLq28I+FGG8Mdm8KXSoshJknp4uYeScIk+yeAIWTaEaS3IyxL8GgZFWVDFbJdkuna
         XWQoICIDiHq62gPrnsC5JKSZT+Xvq9n6SOPe54RwBcL1EwlR0+UDV1QMtmVY4722mi
         VFnuRa5itjPln5w77gDKwE4N2z93c4FInoYw3oeSKFn3ZhlnobpJuUjYYiRO1SSNDZ
         Tj0HasKM/TJduMplMCGnc4wq34QzfGwTtWGMwx+PTFBgJIHSRAketd5wbM5wYqZcQd
         IxFLww+wH7o6g==
Received: by mail-ot1-f52.google.com with SMTP id m25-20020a05683026d900b006941a2838caso5219056otu.7;
        Sun, 12 Mar 2023 00:16:08 -0800 (PST)
X-Gm-Message-State: AO0yUKXiMcnWQOlXXg2pYNuLUJ8ns8p4NgnXeXUrHSewLBSqjPAPeI7o
        ycYUXip7jz9lHrclAKEXYMz8QAwRNorqNYPjwTY=
X-Google-Smtp-Source: AK7set9QGqLr8JpOH2BPOnJRMxGL7RjjNarAnkuCvODrrNBgOnUVp+ppxFqRGDCYe6L+VCP+VXy0Oi9W7MB1GvGUNnU=
X-Received: by 2002:a9d:5f97:0:b0:688:d1a8:389e with SMTP id
 g23-20020a9d5f97000000b00688d1a8389emr10651605oti.1.1678608967933; Sun, 12
 Mar 2023 00:16:07 -0800 (PST)
MIME-Version: 1.0
References: <a10e1319-b631-6d3b-5e1d-b07223350502@igalia.com>
 <CAK7LNAQmXwpEpY84-fdLiwALSFLUEkfsOHejbqy33c6ceM=4Tw@mail.gmail.com> <68be269c-1b51-e0e2-0c2b-34235983889a@igalia.com>
In-Reply-To: <68be269c-1b51-e0e2-0c2b-34235983889a@igalia.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Mar 2023 17:15:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-SuyUC8d+zZbo65mp=wGAC3VawP2Acwp5y6X1P4gsiw@mail.gmail.com>
Message-ID: <CAK7LNAQ-SuyUC8d+zZbo65mp=wGAC3VawP2Acwp5y6X1P4gsiw@mail.gmail.com>
Subject: Re: About the .scmversion removal (commit f6e09b07cc12)
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kbuild@vger.kernel.org, nathan@kernel.org,
        rasmus.villemoes@prevas.dk,
        Nick Desaulniers <ndesaulniers@google.com>, nicolas@fjasle.eu,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:37=E2=80=AFAM Guilherme G. Piccoli
<gpiccoli@igalia.com> wrote:
>
> On 09/03/2023 21:51, Masahiro Yamada wrote:
> > [...]
> > Not a silly question, but .scmversion was intended for source
> > package creation (deb, rpm) in my understanding.
> >
> > If you want to use a fixed string for the UTS version,
> > please pass KERNELRELEASE=3D<some-string> to the build command line.
> >
>
> Thanks! It seems..it didn't work for me, probably I'm doing something wro=
ng.
>
> KERNELRELEASE=3D"6.3.0-rc1-gpiccoli" make all -j128

Try this:

make all -j128 KERNELRELEASE=3D"6.3.0-rc1-gpiccoli"






--=20
Best Regards
Masahiro Yamada
