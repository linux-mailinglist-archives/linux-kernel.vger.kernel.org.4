Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFCB6E2ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjDNUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDNUA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:00:27 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C09558B;
        Fri, 14 Apr 2023 13:00:25 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2a8b1b51dbdso145881fa.0;
        Fri, 14 Apr 2023 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681502423; x=1684094423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fsAjVtRNvN5zm39fMMVB4mviKYMCjTZNyrnVaf04gOA=;
        b=cVbH8BgBfOeR4ebCQ8PifhRz0cN/rtOuaXnBaqeQZvjypu65fZC8QvdZzkqEYKU7wE
         S6zNzX9Oi/JSKuJ8WIMB3Anv06dNR+w3sOOgnJEQRPk8UrduTNNX4lvmBlSBgc9W+76Z
         872JDyFDRBXdm3/qe8fKuUzDr7oLs4GDHer/QQqT1Wj04rkhj7DIpbrRTnuJC5PgFaUq
         SavN0cijH67LJudrFAwIYxoMtMsEk/5Cu4vCIeW30xNEZTZEjVRT+aIQSNKgHKZ22mSv
         CB6oKEN6hNToSGMYw+WL6a2Oqoh5LQ6jKdcdy0XNpnk09jLn23mf0vCjhFrHiIHKkr0c
         EyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681502423; x=1684094423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsAjVtRNvN5zm39fMMVB4mviKYMCjTZNyrnVaf04gOA=;
        b=Or3+qR9fw4pT9JZqMBW6mT+BkWYUSoLpnC92dIaGKDyOwNvsEdrJcGOoFrjf7gj8m+
         f+OK881uVnlWmB0gC5aWjTzu/D3uNnny/yazO0vXPvvHN7c8yuPHZLQd9c/8lU7JhC3E
         bUfSqwPZRxp+rBC4O/unVxx8aWkSrrHqndC3IGVcTabkyPpEs0ygOBREcwP3AYMRrxZ6
         wmByYChxfF+ijKFwHmZNQ1jKL5vVw5PcNCk+5ehsUnG98wpq1g8ora5kstqGFdyDF4kg
         x3MZ0XCfuYmdEBQD8QgO41ZJiVAHQP13vfB/QQoE0hyoIcya38dMw4115viYJ/IXEJn+
         6kCQ==
X-Gm-Message-State: AAQBX9cOy6J95eIJLUsXkCEz7khdR9vSmCcuXwQouyYlK007ozrOWdeX
        +9JadnLGVoF1QqAvE4Nj5pFNW9sF4QUIUaT6bJE=
X-Google-Smtp-Source: AKy350boIx4qDnRkE7T7rJAlV6+DI0cLBhpj0Qu4rpGBj+t/Yued1P2KE+KMJtglgBpNGg99hMFs1RzdeUEtcM/msK0=
X-Received: by 2002:ac2:532c:0:b0:4ec:4f38:10d6 with SMTP id
 f12-20020ac2532c000000b004ec4f3810d6mr28702lfh.2.1681502423341; Fri, 14 Apr
 2023 13:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230412144821.5716-1-jorge.lopez2@hp.com> <f91ee2ff-3a24-4e2b-bf68-f1c5400b7462@t-8ch.de>
In-Reply-To: <f91ee2ff-3a24-4e2b-bf68-f1c5400b7462@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Fri, 14 Apr 2023 15:00:02 -0500
Message-ID: <CAOOmCE-pfQa8_yn7zOkt9dBR9VpnnJF=dsvByZqLM=qcvoEx+Q@mail.gmail.com>
Subject: Re: [PATCH v9] HP BIOSCFG driver - Documentation
To:     thomas@t-8ch.de
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Thomas,

On Fri, Apr 14, 2023 at 10:27=E2=80=AFAM <thomas@t-8ch.de> wrote:
>
> Hi Jorge,
>
> On 2023-04-12 09:48:21-0500, Jorge Lopez wrote:
> > [..]
> >
> > +What:                /sys/class/firmware-attributes/*/authentication/S=
PM/statusbin
> > +Date:                March 29
> > +KernelVersion:       5.18
> > +Contact:     "Jorge Lopez" <jorge.lopez2@hp.com>
> > +Description: 'statusbin' is a read-only file that returns 'status' inf=
ormation
> > +             in binary format. This file provides a mechanism for comp=
onents
> > +             downstream (e.g. Recovery Agent) can read the status and =
public
> > +             key modulus.
>
> This is still missing docs about how to interpret the contents of the
> "statusbin" file.
>
> "components downstream" -> userspace.
>

I will provide the details in Version 10.   Additionally, I am working
with the architect to understand the need for 'statusbin' in their
upcoming features.

>
> I think we can start with the code review.
>

I will send all files with Version 10.   To aid in the review process,
I will keep all ..c in separate reviews.  It is less confusing that
way since there is commonality between them

> Could you also provide a sample of the attribute files?
> I'm especially curious about the different instances of the sure-start
> attributes, including current_value, possible_values and the auditlog
> properties.
>

What type of sample are you looking for.?   I can provide you with a
tree display of all attributes and some output samples for different
attribute types.
I will include sure-start  attributes, including current_value,
possible_values and the audit log properties.  Please let me know if
there is anything else you want to see.

> Also is the userspace component for this published somewhere?
> If so it would be useful to refer to it from the commit message.

Linux components are under development and not published yet.  The
only linux component at this time is the driver (hp bioscfg).
The only published components are under Windows ONLY.

>
> Thanks,
> Thomas
