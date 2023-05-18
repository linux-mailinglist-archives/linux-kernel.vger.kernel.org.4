Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29617088AD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 21:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjERTxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 15:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjERTxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 15:53:12 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F7E10CA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:53:08 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f38c23b06eso12709881cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 12:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1684439587; x=1687031587;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X2ZIW3/zhnIFMYl2SIXYWW32n4UkaG67XbnF9QSk/Zo=;
        b=3XJm5gCHLZOX3R1qQjvAG/qqS+kWajScO5VvbP50imfF5dc0ykewGK23RbdYI3nepx
         mbgmmvEoKEo/U/p9KIUwoITDrm1EuDAtat83AlcRYdX1UMmAT89cSdQ5qCbq5YpBOSFT
         4zpQcWlkd6du1fomIMn3L5hV5za1WI/rhUetD49WocbC/wHyDGpSC7VsMlgpLIR57Y2h
         q38yrJIpnIeWIYv64MWkVQv0GXk0X7+KMGCW459GOOhsM1fwziJquc6iTEpOYcbQ1NUK
         9Vw7iyFbYcmwAa/4EFixJc1/TrxfpyQxpxuvBexpf3iB0HLMozm68Y4h8wwfec6azTeh
         6quQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684439587; x=1687031587;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X2ZIW3/zhnIFMYl2SIXYWW32n4UkaG67XbnF9QSk/Zo=;
        b=QceMfbWCv3vhmp2rISvE18w0K/GWyB4dGfHk38SSxJde3n1FZUkQzfruPPtXCqyM9q
         jmmk6NbxOSrzWjEe6V4omBF/34PyqZsbQGjNAgkA4Fi7OgLEeA+GCGjwKr3K3ty8NeHK
         uHuCkKWih6EXThi/bqA+oSYYPYFNa8eQ6jR40zZc0833HQlJRpWEEccxR8rgXm+V8Gv0
         LmHPn99WDtXCfEupzWBLNDvqRJ2LAbXl2BED1P8P6eQDTKKhCl/sz/TZCrRYW5clncKU
         4lNCN2B2MZkYNEBOSxrjTU8z2qSPXcFDEgE0Uf9343cT8vAP+Xf+tpo5mtmxeplE2+oI
         P5Qw==
X-Gm-Message-State: AC+VfDxLvacvGvJH91181gemisA7kuMe5YQZkbW2nymwSbazT64TO79f
        r6KFsLPPmpK28EE/Lk1AJYVE8g==
X-Google-Smtp-Source: ACHHUZ400+fCF4iB93FLo6GI5Ln196cPScZGaszV7wbm14gR7sskZOOuCxe8qRLOx1wHhql9ypvElA==
X-Received: by 2002:ac8:59d2:0:b0:3f4:e317:1dec with SMTP id f18-20020ac859d2000000b003f4e3171decmr1773453qtf.13.1684439587408;
        Thu, 18 May 2023 12:53:07 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6c0::7a9])
        by smtp.gmail.com with ESMTPSA id x5-20020ae9e905000000b0075931950b5esm612015qkf.74.2023.05.18.12.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 12:53:07 -0700 (PDT)
Message-ID: <a9a9017cceb65aeca285a06c7b46970788301ce8.camel@ndufresne.ca>
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Date:   Thu, 18 May 2023 15:53:06 -0400
In-Reply-To: <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
         <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
         <CAHk-=wgzU8_dGn0Yg+DyX7ammTkDUCyEJ4C=NvnHRhxKWC7Wpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lundi 08 mai 2023 =C3=A0 09:27 -0700, Linus Torvalds a =C3=A9crit=C2=A0:
> End result: you and the media tree is on my shit-list, and I will not
> take any pull requests from you that aren't just fixes.
>=20
> Not just this release, but the next one.

I'm expected to be flamed for getting in the way, but whatever. To me this
decision lacks any kind of consideration toward who will be affected. This =
will
hit those that makes the new features and are working hard to convince thei=
r
customers to go mainline first. None of Mauro or Hans will truly be affecte=
d by
this. Everyone affected by this decision were completely unaware of the pro=
blem
in the first place and could not help it.

Punishment and shame is not something I encourage or think is nice in gener=
al.
Its the reflection of a strong frustration and the spontaneous need to hit
somewhere it hurts. It brings no benefit to anyone and likely convince the
skeptical to go away. In the end, it is the leaf contributors (the one that=
 have
the least authority on the project) that takes the hit, having to tell thei=
r
customers they'll only get their stuff mainline in 6.7 even though they mig=
ht
have done everything right to get things on time for the next window. This =
kind
of methods is purely negative for everyone, there is no win of any sort.

regards,
Nicolas
