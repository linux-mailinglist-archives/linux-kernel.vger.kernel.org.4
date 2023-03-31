Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D7B6D236F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbjCaPDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjCaPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:03:22 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC12BBB9
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:03:21 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id eh3so90705375edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680275000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=284uuIzp37htGE1Cyqz8zv6IM9mt+Q3/Rg8O/gIrt9s=;
        b=kDcj0QENY0JHJFz1J18pgkJaE5w20/yoGjYa33AR1u2XPinZBZ0wh9C/ZyhP+xsBTP
         DZ4J3pZJjcc6D9RSQceKpNb0EsGYDoY+mNC1yMi6RWsjxF1sC6byOJd1hgd+MlX3QiXq
         ZFKWwy0O7J9J/VWWw/FiRluHx0nC0daGAEOOkJDqdBlJejH6Qz6L8thgy8vqSHFuXF0G
         Q0iLr4LCJ+2xRK+1dE59W93TX88RuTdwp9uAOssj5a6ZVET5gDVbLnYLf9VTH3prqL7R
         NRsnXbqvbsaXTsMOUXWAY6bhdg3pMXCEdfdWGKwkUIio+Ibrt3EAm7N8pNwx/aru4yZ6
         p83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680275000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=284uuIzp37htGE1Cyqz8zv6IM9mt+Q3/Rg8O/gIrt9s=;
        b=HVZNzI26e70tQ0nKl9w6UZml7JtTmru4Fto6PRJ7f3BqClnYjhG/R8aGBh3psSuG4R
         BvnC5hkLkbGw1WWlmN0IGMVLlZEgtVJyl0y6XZXscB8uzud3nIUhwt1cBKvGYjjXfzWm
         bK9xqhBPmCcMI988JwzBoxc9/upqkmU7gCa0b9u+Iik5iaQISEkIqiRq197UA4Yf0uNz
         9MFB6ooX48rmiVddKorrz0bNkDPqvqC+6qu9ONoFnJ6qZgn3jbpi7qknAaRJNDnYdRvv
         9qiyTtK9+pCMnColXB6iigiTYk5gRcA/vNMZ+5SWGo0EiUuRKFWAEh6W0Hp5ZrAK/iWP
         zSWw==
X-Gm-Message-State: AAQBX9d4v8aYdLgUGkJz1ANp6GQJ6R5iyM8Lc3JTFJ5KucxWmWFCMvrO
        KEeuxiBJ2knN1N1Hta1B5fog0UxQ7dQKvXd03DE68/x43+E=
X-Google-Smtp-Source: AKy350bA4ih4UrkiZ292pYQQOog5OLP5WG08x6Y2AxFx/7ljqZhCejYmJPlclzs70qhXxs6FLLgP3ulsBZif3Biklvc=
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr14114905ejc.15.1680274999562; Fri, 31
 Mar 2023 08:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230307202257.1762151-1-conor@kernel.org> <d7c3ec51-8493-444a-bdec-2a30b0a15bdc@spud>
 <09cdec20-c3c8-4eb1-9a74-87f429543d3c@spud>
In-Reply-To: <09cdec20-c3c8-4eb1-9a74-87f429543d3c@spud>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Fri, 31 Mar 2023 10:03:08 -0500
Message-ID: <CABb+yY0ocpdB5RWyxncM7VJzJde6G-WscTKbT2=GMt3uJAccVA@mail.gmail.com>
Subject: Re: mailbox,soc: mpfs: add support for fallible services (was [PATCH
 v3 0/8] Hey Jassi, all,)
To:     Conor Dooley <conor@kernel.org>
Cc:     linux-riscv@lists.infradead.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 11:15=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> Hey Jassi,
>
> On Tue, Mar 07, 2023 at 08:30:31PM +0000, Conor Dooley wrote:
> > On Tue, Mar 07, 2023 at 08:22:50PM +0000, Conor Dooley wrote:
> > > From: Conor Dooley <conor.dooley@microchip.com>
> >
> > I botched $subject, I blame copy pasting the branch-description from
> > lore and not double checking the output of --cover-from-description=3Da=
uto
> >
> > This should be a more suitable one... /sigh
>
> Replying to the one with a reasonable $subject... Are you okay with this
> revised version of the series (you were happy with most of the v2 IIRC),
> and if you are, would you be okay with me taking the lot via the soc
> tree as I have some other bits that depend on the changes here?
>
I am okay. Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

cheers.
