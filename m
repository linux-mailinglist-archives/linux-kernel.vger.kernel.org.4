Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443D17254D6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238395AbjFGGyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238386AbjFGGyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:54:10 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991B1BC2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:54:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f6d7abe934so58542925e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 23:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686120842; x=1688712842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlTH0flV9TBNUS7zdW2i6f3cA5YTTh8BFjhhvW+dIpM=;
        b=Rt30GKY69Mh+6r4StJU5NjbV6KeMtlHKUzAmLJbFN+w9biF4q2rqFNQyFgCL+9MCoE
         VTEUyWnlWgL4Gwfca/v927xpgm+wD19qMAgIOe4Xht4rnFVL12/6ZbxEydSUkGb35mVm
         y3PTdOFOUkwHNljaEJtOfL1SvoHfYBBTZeufh+A7TEzBM0EIOM/hl8z+arNncBCSKRER
         /8P0PVvq7r5X0/reS58QVYZGWNmsbhi9gZfhGX4LQKhyqQk/S+bjfcPIr0ocN4BusZEi
         GFQUXZRHRtEHAJUi2XkEoI9vRwZFAiJ3GNKtYe12yifOOFmuMLtkMk1/7QjkRkBomu9b
         fEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686120842; x=1688712842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlTH0flV9TBNUS7zdW2i6f3cA5YTTh8BFjhhvW+dIpM=;
        b=JLMMGYVn4r+dNlDDizUaGDC8kn5HUUqTrEehl7JS9pzVUK2obgN0UuaEIOuMIW/pV8
         krpTZoKR1aQTdTj1jKyiUhr0/nnxjmoUkWvIAV3VA4Imlwckm2Mnovf+hYCKLWUXi5Lw
         BJS+Yl902H3wXGOD6Z7sQsV3P6WBbNM9ggKQuqr2fgRBEL2cHbAxGMWMtDE92NxOioUM
         Xa/G6gO9N7xM1/Q4LyenH5ARmEa1aHcDZ7jJ7v/9ohG79xd7Khrku2/6QfOEYgq4LHv8
         ZLDGNpCahcS+rAkTvnmAmiETktORLkZytsWUL/5CpG5/907BnAZkFYn8Od5X2Zz0WDu6
         EA7g==
X-Gm-Message-State: AC+VfDxaK73IXoO8LLtiWyryok2ZMQNidKl4SZTjlYYKbYSfrzgXb6ly
        5tf1Oz3q/SjgEZPVxCWse8D1XpP3wgjy0wUVpTnNvra+8OiW6WvI
X-Google-Smtp-Source: ACHHUZ4arNb7UsrHj7mKJUYLXzNLWENDHyn7YEoqczSE7WZcrL8XedzE3jpTlbwWWeZMbZL6fPbEO00LdO61g9BlqTA=
X-Received: by 2002:a7b:c3c9:0:b0:3f7:3526:d96f with SMTP id
 t9-20020a7bc3c9000000b003f73526d96fmr3841067wmj.27.1686120842531; Tue, 06 Jun
 2023 23:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230606075843.GA2792442@rayden> <0fac8e65-fe05-4dbf-a634-4620f764e2bd@app.fastmail.com>
In-Reply-To: <0fac8e65-fe05-4dbf-a634-4620f764e2bd@app.fastmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 7 Jun 2023 08:53:51 +0200
Message-ID: <CAHUa44E5RjMqeTp1Sr_7=Eavu3T+q2YVg-V-_gLWpO5sjJ-Vhg@mail.gmail.com>
Subject: Re: [GIT PULL] AMDTEE fix for v6.5
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     arm <arm@kernel.org>, soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
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

Hi Arnd,

On Tue, Jun 6, 2023 at 1:47=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jun 6, 2023, at 09:58, Jens Wiklander wrote:
> > Hello arm-soc maintainers,
> >
> > Please pull this AMDTEE driver fix to add a return origin field to the
> > struct tee_cmd_load_ta used when loading a Trusted Application into the
> > AMDTEE. This change is backward compatible.
> >
> > Note that this isn't a usual Arm driver update. This targets AMD instea=
d,
> > but is part of the TEE subsystem.
> >
> > Thanks,
> > Jens
> >
> > The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80=
e3d6:
> >
> >   Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://git.linaro.org/people/jens.wiklander/linux-tee.git
> > tags/amdtee-fix-for-v6.5
> >
> > for you to fetch changes up to 436eeae0411acdfc54521ddea80ee76d4ae8a7ea=
:
>
> I see there is only one patch here, and it is marked as 'Cc: stable',
> so I assume  you meant this to be include in v6.4, not 6.5. Can you
> confirm that?

If you don't mind taking it for v6.4 that's even better.

Thanks,
Jens

>
>      Arnd
