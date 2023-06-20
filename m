Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF673709B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjFTPga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 11:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjFTPg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 11:36:27 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A1D186;
        Tue, 20 Jun 2023 08:36:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51a4044b7a1so5994672a12.2;
        Tue, 20 Jun 2023 08:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275384; x=1689867384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WuHhq1Zy5qUmJ5a4jIXN+p9JZTXV2dJnQP66DH/WzqU=;
        b=Y7rB4XOdGd7XzJAe+O4Yu0w0erIIAm6VX3FxbUzfG6JP2Xo0/2WsYGt6YrXuZafX0g
         rcBqVx3d4+ak0FtfECwfp908EyaIuARUmyoaxbVCH9Q8BR7Hgz4JAuTXtL56jbGYjA1l
         +sLM2eTqBWltuvthM9yiydyJyW9yLy8boO1WO8O1Gy63oxFerXY+GDKwtRDqHmzP7lbG
         9eEXUhjbQWYjE5hq+kTz7NKCC9t6hGrVF3asmYr3V5FuP9F9aii2AcERzkTtiBS89mv7
         y5frx3u6tRJ+ZXiK3aF3J6pm8ggDIwmvLVeY8ZYRK9bAVnEjcbPTdU4KOYw5LNKBU08R
         KrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275384; x=1689867384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WuHhq1Zy5qUmJ5a4jIXN+p9JZTXV2dJnQP66DH/WzqU=;
        b=D81E3l0M5grKtoG4ONpDzQQKMhmeuB/iL0b/oQhCAZ5OEIrRlog/D3Q5SctO+mNeEY
         X0G9rXw6X1yZHpfSpAeT4FLR1XIa4Pq/Hhx4tBk/+nZyKSNSPoUmYkR7tHzCN6F1zExl
         Cuw8uGfV6qsDX/PJQGKQWfIvK0+XO1KCkdMxlgB65SUlzZIwLo0JjZb7Qx9LrUjiwJmT
         6JDvqAob8/39zFPvn4DMyQIFVvnA/3mhGXqsEFniVbbDRdlpgiCOLkYtRZEez/VHoCYk
         4MwXVY6YfYnwabQz8wa3PFIFSHmdLpheOXUQxKgACU+8ywnu2dfaCd+lgC7ww47s4hPJ
         BQLg==
X-Gm-Message-State: AC+VfDxSNKsyIRuB4oXlqh+CI+dnl5iF3PYQ1yXAvHjj0ixQ8mXdkwQJ
        mmSwWrhTgWjan0j3uzpWg/N3dQS2xqwjcntCw4c=
X-Google-Smtp-Source: ACHHUZ7UFay18KbgM1QiR5c87EH5SB+paPab33Pc4k7BArUBr5Wv8HVAYADtzt+o5XtU4YpvpgW7MrD6uS7HK92R0NA=
X-Received: by 2002:a17:906:eecd:b0:973:da59:7c91 with SMTP id
 wu13-20020a170906eecd00b00973da597c91mr11921423ejb.51.1687275384433; Tue, 20
 Jun 2023 08:36:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230602152626.284324-1-hugo@hugovil.com> <20230602152626.284324-6-hugo@hugovil.com>
 <2023060454-cotton-paramount-e33e@gregkh> <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
 <20230604134459.3c3844012e9714fa2a61e642@hugovil.com> <CAHp75VeWFPBmsD8zsSAaQGNNXtfgLtQuM9AMGfLPk-6p0VW=Pg@mail.gmail.com>
 <20230620100846.d58436efc061fb91074fa7e5@hugovil.com> <CAHp75VcWSVgA8LFLo0-b5TfKWdHb2GfLpXV-V3PZvthTv1Xc4A@mail.gmail.com>
 <20230620113312.882d8f0c7d5603b1c93f33fb@hugovil.com>
In-Reply-To: <20230620113312.882d8f0c7d5603b1c93f33fb@hugovil.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Jun 2023 18:35:48 +0300
Message-ID: <CAHp75VfGm6=ULW6kMjsg2OgB1z1T0YdmzvCTa3DFXXX-q_RnfA@mail.gmail.com>
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
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

On Tue, Jun 20, 2023 at 6:33=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Tue, 20 Jun 2023 18:18:12 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Jun 20, 2023 at 5:08=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.c=
om> wrote:
> > > On Sun, 4 Jun 2023 22:31:04 +0300
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > > did you have a chance to look at V8 (sent two weks ago) which fixed a=
ll
> > > of what we discussed?
> >
> > The patch 6 already has my tag, anything specific you want me to do?
>
> Hi Andy,
> I forgot to remove your "Reviewed-by: Andy..." tag before sending V8
> since there were some changes involved in patch 6 and I wanted you to
> review them. Can you confirm if the changes are correct?
>
> I also added a new patch "remove obsolete out_thread label". It has no
> real impact on the code generation itself, but maybe you can review and
> confirm if tags are ok or not, based on commit message and also
> additional commit message.

Both are fine to me.

--=20
With Best Regards,
Andy Shevchenko
