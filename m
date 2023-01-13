Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C1166A4B2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 22:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjAMVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 16:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjAMVBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 16:01:23 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630F53D5D9;
        Fri, 13 Jan 2023 13:01:22 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d13so2772097qkk.12;
        Fri, 13 Jan 2023 13:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pt9wDu+LePqDkarLCg0TYoySNbJ6aVRsIECGx7EpuCc=;
        b=lu+NQVC2IOqzpyGQnHqDNHqs0MBsb9C5IZQnD1DxGiFEykM4uZJaokfC7SoaWAIMt8
         Bh6UYtaC1+P2Jg/mte05K4sVLD2WgMixqPqIrRliIcEPnhuBYGIzICOYahnU6Y2s4bgL
         jrxhTBDCsZUUsiER1ISfDMSUuNrQ+24YQSvlPNt51rqakSYMzrDhcQqT1YPEsJ/uLopW
         kkbF11oleAiUSDlg8HzSbjCvRQNvxqfxxdJJ4ZzLbTJjiUMHdJ0iYv5WU2EKgiCJlMtv
         vifS8h/QO/E6v7Vom+lOlXnaR7dro7IFn2p2KXGfh+11Fda+tfFJB4zHMKCK8P0nEge0
         OdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt9wDu+LePqDkarLCg0TYoySNbJ6aVRsIECGx7EpuCc=;
        b=CJ8gGDJwLVvBMeovbCo6nHYtzt3eJgeBfqVZT6vCyhELnl0Yx0CPT62qRHvZQAAkqC
         y7yj8qIyq4lG/NjhQ84NgvS/2o70lFSzLCDpjsIxPmq0j2M5hjm4KKJEEP8jhYMy12B4
         Z3Su6wTFosa3jweR4ssYJHb1EoukhySppYaxasb5/rCkXNGp5l06ao0ME8/NChiQz7cZ
         CSR4ke0UHsOlPCLV3sCXABpYhm1EopRe+uME0/bgnTls9ysnb69rR4cWvqpYsT1coatV
         ZlNlm6+ag18e6Vgyw7mVQLTG1J4PG9hslr2U1wOikh8y4+U7UFCclYz3LAEk8D+8E/rB
         mi7w==
X-Gm-Message-State: AFqh2kqdfZlcLuHUs0PFmuJ/Olr6oWL9CJyqkh/JwIrHH1ctOaNHR29Z
        piYUtQO1BkvAMHTyLk1Epr+cpTphMNt+g4dud+I=
X-Google-Smtp-Source: AMrXdXs0kxp9rxLCja0vpZObCJjT9qP8fb1iWEfU5Nv/eoJMIFF4E4Rj1Uf5bR38Q7OFXWhzqbpxGo/R2F6uSjOCbvA=
X-Received: by 2002:a05:620a:51c1:b0:705:c63f:1fa8 with SMTP id
 cx1-20020a05620a51c100b00705c63f1fa8mr1101954qkb.504.1673643681450; Fri, 13
 Jan 2023 13:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20230113133320.7531-1-abelova@astralinux.ru> <c0c7d2d7-648d-feb3-14ea-c2ab3baddfb1@ispras.ru>
 <CAHp75Vf3SZEFmXoqm8-ynyYq5p8Eme93Da87RbCP5-9hzAzrZg@mail.gmail.com> <15a05909-a373-09af-c0bf-1b35fd019bd5@ispras.ru>
In-Reply-To: <15a05909-a373-09af-c0bf-1b35fd019bd5@ispras.ru>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 Jan 2023 23:00:45 +0200
Message-ID: <CAHp75VcsqMufyaSk0FWyUBHQOL_TJjMmmfECpkAfQVUSNp33jg@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH] iio: chemical: scd30: Add check for NULL in scd30_i2c_command
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        lvc-project@linuxtesting.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 9:27 PM Alexey Khoroshilov
<khoroshilov@ispras.ru> wrote:
> On 13.01.2023 21:47, Andy Shevchenko wrote:
> > On Fri, Jan 13, 2023 at 8:41 PM Alexey Khoroshilov
> > <khoroshilov@ispras.ru> wrote:
> >> On 13.01.2023 16:33, Anastasia Belova wrote:
> >
> >> It seems it is better to put the whole validation loop under if (rsp)
> >> check.
> >
> > No. The entire patch is redundant.
> > The code that calls this function is under the control of the same
> > driver, so we know how to avoid shooting in our foot.
>
> I see, there is an assumption that response is NULL iff size is zero.

Yes. ->read() is called with (NULL, 0) and the code copes with this.
A similar situation was discussed recently and Linus T. rejected a
proposed change in vsnprintf().

> May be it could be documented, because naming of arguments does not make
> such assumption obvious for fresh readers.

Documentation improvements are always appreciated!

-- 
With Best Regards,
Andy Shevchenko
