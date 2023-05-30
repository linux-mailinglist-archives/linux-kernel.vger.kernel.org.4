Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD52C716367
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjE3OPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjE3OPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:15:02 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9BE53
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:14:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2af98eb6ef0so49025191fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1685456069; x=1688048069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYxgvTgmLTiwEy0syweRb4z2Wkk8dETXQo0MhrTGxn0=;
        b=kIpkGI4ZNZ0nH7PFH1QiZ30yrckiIkIv8R03VbUtOObUkZp3udHzY7xRjqvUgLbzv4
         qvWEllpP4gpMZGoM5YECSa0GZDe1/Nb8Q6X2dZha5M9fnIl6oNrozACSqzBPCOV6mql+
         UjV/unhhcFii5eKQ8b5fmuozsqZlsfsHdDd7x723q5sbjPddY6/VLuC2DaXicdoIYftM
         ixY7eJgIDOPDIyDlZm2xvnpnOXqQcVo7kNp3ikI16CwfNzpH/XTDdJA9lLTLCFHnrks7
         hS28483dExR54SdyAzZExFXUIjC2QePnOliAuDeUM7aRuO3d8c86ru22t55YKklvk3Fx
         ePZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685456069; x=1688048069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYxgvTgmLTiwEy0syweRb4z2Wkk8dETXQo0MhrTGxn0=;
        b=eejRC5ysIx3oPx0PtcFMaCMYRNspCEW+/JDrD2fVbwZfv/ukkUvusRsP8NUlo8fpv0
         JShbR0Or3BE1IKzeVKtODvig5kNO3m0B1IPSrIqExW2gHO9uAWRBndCeUgSVZYq9zypH
         xV1MYhjnWg9QqX4ZdzPpRrDNZ27bEJwpQgfRXmK/WyTBICITIs7I5n4q8VT7LYO2DBg7
         It8J9vwTX9suHu4H86TlXJOnWlmDmkymPK/G0b5ZtfjG0auYPVO6sw0BECesIEeVWjn2
         xV5Ets310puj644j4FDdl+KHM9alIsRqhYrVFx2yCkfjxPu2Xo+C2790ae7B/F4g2Ayu
         gAfg==
X-Gm-Message-State: AC+VfDytLEY5jPcDsjClKUPUQgPKfkdgRIXMJ6pkuvn1aj0zTwruhg5I
        ygM9P9CUXaPlgrD8uvq/wutrZj3rCCxjYT7H+HxxLhL4iwGiwyIqNiw=
X-Google-Smtp-Source: ACHHUZ6Jmb5YfXTJ5I8UNoc6cbVJCh5qVWnqBmBmC27letc2gcpGL0W5K38DbbyVU12c470hm9xSn1FBa9yZclZJE1E=
X-Received: by 2002:ac2:518f:0:b0:4f4:4cd4:2586 with SMTP id
 u15-20020ac2518f000000b004f44cd42586mr726914lfi.20.1685456069005; Tue, 30 May
 2023 07:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-52f8af07-f3fc-4674-94ea-abbe2108907a@palmer-ri-x1c9a>
 <20230524092530.7773-1-andy.chiu@sifive.com> <3656227.v5FYL8H6MN@basile.remlab.net>
In-Reply-To: <3656227.v5FYL8H6MN@basile.remlab.net>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Tue, 30 May 2023 22:14:16 +0800
Message-ID: <CABgGipUZL79faigrFpjeHVyyqZDFSdOL7fiEpJojZmg1f9-rCQ@mail.gmail.com>
Subject: Re: [PATCH -next v20 20/26] riscv: Add prctl controls for userspace
 vector management
To:     =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc:     palmer@dabbelt.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 12:16=E2=80=AFAM R=C3=A9mi Denis-Courmont <remi@rem=
lab.net> wrote:
>
> Le keskiviikkona 24. toukokuuta 2023, 12.25.30 EEST Andy Chiu a =C3=A9cri=
t :
> > How about adding the following 2 patches to deal with the problem.
> > However, I am concerned if this makes ELF_HWCAP too complicated. e.g.
> > Future extensions may as well want to do something here after we create
> > an entry here.
>
> Fine with me but I feel that we are missing the bigger picture here, as t=
o
> what the usage pattern/guideline for the prctl() on userspace side should=
 be?

Yes, I agree the use of this prctl is only meaningful for the init
system, or some ansenstor processes that make policy decisions. And
with ELF_HWCAP reflecting per-process's availability of V, which is
decided by either the prctl/sysctl, programs/libraries do not really
need to call this prctl unless they are doing aforementioned stuffs.

I am going to document these when rolling out the next revision.

>
> Maybe it was already discussed, and I just missed it, but I couldn't find=
 it in
> the documentation.

We had discussed the potential theoretical abi breakage[1], and came
out with a need of a prctl/sysctl interface for distro's early
userspace programs.

>
> --
> R=C3=A9mi Denis-Courmont
> http://www.remlab.net/
>
>
>

[1]:https://lore.kernel.org/all/mhng-47aa965a-2b25-4ac0-984a-c2e6f3a051ee@p=
almer-ri-x1c9/

Thanks,
Andy
