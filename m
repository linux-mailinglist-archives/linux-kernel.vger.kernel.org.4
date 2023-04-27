Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBE26F0ED6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 01:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344392AbjD0XQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 19:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344179AbjD0XQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 19:16:18 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154ED2701;
        Thu, 27 Apr 2023 16:16:18 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54f9b37c634so112328087b3.2;
        Thu, 27 Apr 2023 16:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682637377; x=1685229377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGpWkonDzJU7+QB3sE4Mk+2aNDCSINLhf6pizTNjlbk=;
        b=gjHN8YelBpsoiAqUzc4CL4MWJqhS6Jdye5Gd4OKpOLBYPxYCEnw4PyrwrVtN5tJd4C
         vNywh+vFVW/Sxm4t8Pm0wgLaVZbT1SFuhlkAjfnIRMuSTDllEp39spv0qP+cTAFQM06n
         JJ5lGuKz1I6YFpvjAsiEQV/OH4D1WHc9l/nLRCl2+QIizbEWk4amnXGctNG+5e5gi/E+
         A0neO7GHsSase8Vfx2zrBxJQgWxeyNHFvKGAb7y8TlC87sEJQRwCPXUuIfzcvUlZO3fV
         kV96cmTLs8G7vz9VbdtLotc/AA378cJUhTMAWhVO2Ciq01jQZYqq0jhiNYOYlrYsxclH
         Zjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682637377; x=1685229377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGpWkonDzJU7+QB3sE4Mk+2aNDCSINLhf6pizTNjlbk=;
        b=MBDki3/hcAAjZDZGSzGGzfJNp+7I+0+VC+bSOC3M4dWhJp042Y09XN3GpxvBGYyJRe
         yhloYMKc54WjW/fyOx/5bepbpZLWRse0hhV5Uo8qfJb2HKoDbeJtdFNWnlzQKHk+CV2X
         OhURGSfe52QoMKxlqmpfyM3JaWfCRoA99WffOhp9uAMWqksKsrS3IfgXEfZpS/0vmeJv
         kx0d0xcGZ+VrMvQBVOF4T2pvhmA4b0o7NcQRXwdm5BC20ThRoOYfXr/d+OGz6eN3psQI
         tHiODG0cY24JBRLB2ZWOWHE3SONRnDabOdcwgSNA3jwBxaayXqx3LE0t4jvv7pFLjg4p
         DfBw==
X-Gm-Message-State: AC+VfDyj5iVlI/GyiP7+OYNMX3OerfDzZNYRlkjtFzr45WCCfUBpRZAP
        ekGGNlRyTu9v9y/L7ZUwuNfnisPAjhoEU3quKJ8=
X-Google-Smtp-Source: ACHHUZ4WO1LJTTgQo9Y82F8sUVKEwnGwETAY5RAvp1c5jQLhZ9s9sPxvB3CTr5pWPyMa0/gwbDNqldVKoq65NmbOi1w=
X-Received: by 2002:a0d:dd88:0:b0:54b:fe8c:350 with SMTP id
 g130-20020a0ddd88000000b0054bfe8c0350mr2556618ywe.19.1682637377262; Thu, 27
 Apr 2023 16:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230426184420.99945-1-samsagax@gmail.com> <720c2b48-ca48-4ee3-9158-f453e48cb012@roeck-us.net>
In-Reply-To: <720c2b48-ca48-4ee3-9158-f453e48cb012@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Thu, 27 Apr 2023 20:16:05 -0300
Message-ID: <CABgtM3i+HZJDearvBK-sBrWnfqdrsuNCDYfxASC3QVsn8rAy-Q@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add AYANEO 2 and Geek models
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hello Guenter and thanks for your quick review.

> Please run checkpatch --strict on your patches. Never mind, I'll apply th=
e
> patch anyway - I see the other entries are the same.
I've run it before on the other patches... did something change in the
checkpatch?
Nevermid, After this one I may submit a patch to fix all styling in one go

> That makes me have a closer look at the code. What is the purpose of the
> odd typecast anyway ? Why not just
>         .driver_data =3D (void *)aya_neo_2,
> and
>         board =3D (enum oxp_board)dmi_entry->driver_data;
> ?
I don't know why but the compiler would complain with the casting from
enum to void*.
Found out that explicitly casting the enum literal before casting it
to void* works and
the compiler stopped complaining so I went with it.

As a follow up question, since this driver has become more AYANEO than
OXP since its inception,
 wouldn't  it be better to change the description?

Joaqu=C3=ADn Aramend=C3=ADa
