Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206F6BC380
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 02:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCPBz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 21:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjCPBz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 21:55:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772F523A6C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:55:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so1757156edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 18:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678931754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufDsCnepUTXOzJM2+beRgyDWu2qPzyR/ijQPsqIphUY=;
        b=KF3/5gKz860T5swAtm7hcfaFT/jdRD4FPmXybm3n6cYqi+3xP2il93iHugwDMaw5GF
         v6vgvLFcD1v2XYZ5IA7UieoJOHhe4bFaU7lw3pgqAVlxulCXV9hnn66reaIJo5O2zJrb
         v5u9Vfu+6aZHVdAZPNIEh2xcQocZYha2+vkv33W6d3o1iqUY/WMVvHaMnxfh426Mlzoc
         kGQhRhDHa86j7VkibWOfHiabSOowbrhtwAmWZQexDplKlibdxaRsW/HEFvcRSx1fDyOo
         qJalIcBlOf2cUnlop1EBQAMfA4NfqJAgJuosYGFetT3ryBDHXS74nazTGAMrco1y20q/
         4ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678931754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufDsCnepUTXOzJM2+beRgyDWu2qPzyR/ijQPsqIphUY=;
        b=CvfCecwyM43Ay/HvBWYTqiKUZON/RLkgqLFpJpxBuZ27ktawEex/xnwfqUCq4XBCXC
         KDmFqLpZnCIxv1ZPDGsmA+BzZFXPTUwgYEFf1ZpPxaVrmWKLIo09rSckRrbXjxtONQzh
         p8yVAgbQnukpz47iJDCIRqg6mbTUZbsyYQe02dQDvHFQwWekZLxzEX/SIIBHkMHb6f3c
         PMUPmeDurn2fD+mqj45/U7P9v1ruH8P7MJnJTRmD+QXJCYxfiV3EI39ZnpEu0At+dNjs
         2tIdb5CqMHfja4mgp2xZQw7kcoZ2eObwGr5jIfqcO2Qg0XVY8JtaPfScH7hio3jDIkwW
         Ty1w==
X-Gm-Message-State: AO0yUKWgP8AyqDlIwOl+o3kU9+PQHdUS5OwUGToFGmwxWbyPeRtTliFW
        76Zscy8sFTH/uB2blFYYGkuyrqVonPvuEebZbmNPw7fPTmznWD/p
X-Google-Smtp-Source: AK7set8yweo49a1Ycphsi2axltsssm4oxxjrMvsp/VUrKDPFLEIDZR/EezLLR2Z5Ji8gWEoMtfNSqn1KUPgSjzx8ZKs=
X-Received: by 2002:a17:906:191a:b0:8b1:7569:b526 with SMTP id
 a26-20020a170906191a00b008b17569b526mr4301468eje.11.1678931753977; Wed, 15
 Mar 2023 18:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230312201712.367545-1-joe@isovalent.com> <875yb5wwed.fsf@meer.lwn.net>
 <CADa=RyzQmTEFnpKehGoKihmz+EniibjWQ0P12XMwqgqQ8UcO-w@mail.gmail.com> <87r0trryj1.fsf@meer.lwn.net>
In-Reply-To: <87r0trryj1.fsf@meer.lwn.net>
From:   Joe Stringer <joe@isovalent.com>
Date:   Wed, 15 Mar 2023 18:55:43 -0700
Message-ID: <CADa=Ryz3T9OWkPC5ThWCziF7N0aB8unTQvCvq2erouknKEc4Wg@mail.gmail.com>
Subject: Re: [PATCH linux-doc] docs/doc-guide: Clarify how to write tables
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:14=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> w=
rote:
>
> Joe Stringer <joe@isovalent.com> writes:
>
> >> ...and if they do merit an exception, why would we prefer the full gri=
d
> >> format (which is harder to create and maintain) than the simple table
> >> format?  Most of the time, the simple format can do what's needed, and=
 I
> >> don't think it's less readable.
> >
> > I'm not opinionated about grid format, I just picked one. But this is
> > interesting - If simple table is the preferred format, then that
> > sounds like the sort of detail that this docs page should communicate.
> > For example:
>
> I think that either format is fine, both are readable.  I just
> questioned whether we should push people toward the grid format, which
> takes more effort to create, in the absence of a reason to do so.

Got it, thanks Jon. I'll spin a v2.
