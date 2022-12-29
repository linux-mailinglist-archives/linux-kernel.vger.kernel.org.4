Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C92658C99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiL2MQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 07:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2MQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 07:16:48 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B9810B5B;
        Thu, 29 Dec 2022 04:16:47 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2BTCGSXj012049;
        Thu, 29 Dec 2022 21:16:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2BTCGSXj012049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672316190;
        bh=14PpacKJgo2neHei6j5lJeMmEBhGQjnABsPBU3dCVJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZAqiWCA/JNESfwI4rGhPKJxLNz+5YNENkSL8UeAnVuWb5qp7S3rk5NwOT9wdwPCbd
         DYXufbrhYfDyC3UxpZAZQCWxKdvgyA5XB+RORb0x+oQXg7+tdzbTNZCZIiMxZ7czYJ
         QflsB5V8IZVqh5V6XkMXMo659yJ+XYx9BR8KPbxl2YyhvdNnnxPv80YIqad/3aFicM
         BMA6AHe+3HcI+03KnrNJP69wQug0vjb8mVp76svfnMeztlfEW8QK5FvWTB82wcX89+
         6CbizIRuBbWb7y9RMgeVch/QvrkhEPctFtG2OfI7V1vtQXg5pcVFUPo9NGPcBM9GUX
         zENFq/4eQX1Pg==
X-Nifty-SrcIP: [209.85.208.180]
Received: by mail-lj1-f180.google.com with SMTP id g14so19202748ljh.10;
        Thu, 29 Dec 2022 04:16:29 -0800 (PST)
X-Gm-Message-State: AFqh2kpik7BP/mZYNQInBZ3tIef9MuPhwFbK1IP7wtCXWlE3q3ZkJ25w
        baMgXVzxtZ6C4E6pYIfSevHa/w+k3QCMVh/jVPk=
X-Google-Smtp-Source: AMrXdXsZOgr0/wsqC1av+uNn4WhHu98TqqlZIoTuAUSvkIaBIGHohwzzYnyuV55/S0q8Djijl5mVeqlV1QNKws3b2fQ=
X-Received: by 2002:a2e:bd06:0:b0:27f:ae17:68b4 with SMTP id
 n6-20020a2ebd06000000b0027fae1768b4mr929945ljq.422.1672316187797; Thu, 29 Dec
 2022 04:16:27 -0800 (PST)
MIME-Version: 1.0
References: <20221229080813.908450-1-masahiroy@kernel.org> <CANiq72n1uvzwWZ2pcn6yxQDMMYjaB5BpW1aVv149=n1HHnA=SA@mail.gmail.com>
In-Reply-To: <CANiq72n1uvzwWZ2pcn6yxQDMMYjaB5BpW1aVv149=n1HHnA=SA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Dec 2022 21:15:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNATymyvd_wQmCnjyBo5QOM=3PsT_EqP0ir6DnshE58nR4g@mail.gmail.com>
Message-ID: <CAK7LNATymyvd_wQmCnjyBo5QOM=3PsT_EqP0ir6DnshE58nR4g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: sort single-targets alphabetically again
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 7:08 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Dec 29, 2022 at 9:08 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > -single-targets := %.a %.i %.rsi %.ko %.lds %.ll %.lst %.mod %.o %.s %.symtypes %/
> > +single-targets := %.a %.i %.ko %.lds %.ll %.lst %.mod %.rsi %.o %.s %.symtypes %/
>
> My bad, sorry. I added the `.rsi` near the `.i` due to the similarity
> in purpose.
>
> But it should go after `.o`, right? With that change:


My bad - I will send v2.



>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>
> Cheers,
> Miguel



-- 
Best Regards
Masahiro Yamada
