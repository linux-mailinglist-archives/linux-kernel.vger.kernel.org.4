Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D19C6ED6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjDXVfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbjDXVfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:35:43 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1630359D1;
        Mon, 24 Apr 2023 14:35:42 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2a8ba5f1d6bso47427091fa.2;
        Mon, 24 Apr 2023 14:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682372140; x=1684964140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvvV2Db3dNXOEyxvu0ZhQaFJcicKRgzkj7yt5HDfa2o=;
        b=lknRgkQJMrf4tiJq6SH3IA3SoCAG6ZkEIf0+NGQQQC9iNPgCTPpKXhAJPam8HuFuXO
         GXxKFUfQYR0DwoJvj64TASyHew9cN/okcxuyKyu/7BVX/nL4l6dVHExp0nMjul4mX71d
         Odmkm3Z4Hth3nHYJ436/N0jNgvK9WCujLGepQt72Slma+CVnKrOF5BPv0vgZMCWpbtFI
         JBqk0LR5n0D+5kwdx1ENLMs4bdY5glKaWOyguC6hziIiHtyepwiusxPEuMyV+y2/je41
         uUSU/Y2bjUjy9iC2TudlubQvPRQAvgE5U1J+boLPo+6SaVDU8GP7QVvxso5QbHJ8QH1/
         bxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682372140; x=1684964140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvvV2Db3dNXOEyxvu0ZhQaFJcicKRgzkj7yt5HDfa2o=;
        b=KuDf/la/XTnMm6+tCsc8AT4Xa80x/sToGQGr6RZ0Ou/zZTSlJ38dsjyuKqU67IfB6S
         MespmWGANDmwDfwmnAPLQSThykIs2ClDVQduDhXVp/LOw4z9sRlD9kBXT64RG/Z1GcGa
         cDkiuckcaKj1XLJKAVUTNxWug1wVS+sKhtit0F0mB4n0g/oRXopJMYZOzQ/PvvVTrbYM
         5GNciLiVsnQS355C0j23cXW+hJcc5Bwn5kD0o7YRmxvRL7bD857Nm1J6zjI/42AJu14Z
         2Fuf8NWuJbvM/QesO94a1mya0YHaugm0ll5z2YoHSNI5+WKXfTbTpZUka4CPSTXRC7ZH
         7INw==
X-Gm-Message-State: AAQBX9fbf9tealDyhlAV/qY/i/WAmoyvxG06fDunBcu9z+CixGtKACRt
        Wo/WkvRcVXGzsqa6H+f4Bk8EN2p5HrMrOaQ+ikA=
X-Google-Smtp-Source: AKy350Ywq3L01KI+bc3Ftz5yqVWkxpyZWe7gaxtlwKjLlDRh5icglSTA8iJdzJcZYLpfqF6dsyIK4V8yiSW3DQ6jP/k=
X-Received: by 2002:a2e:9043:0:b0:2a9:f9ee:bd9a with SMTP id
 n3-20020a2e9043000000b002a9f9eebd9amr2771955ljg.38.1682372140325; Mon, 24 Apr
 2023 14:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-2-jorge.lopez2@hp.com>
 <dc902d52-7186-4095-9be9-60c728a24f05@t-8ch.de> <CAOOmCE-N9yMn7Cvr9bK5TpAwpv7_Lam1huWRrYaFzXVtf4v_aA@mail.gmail.com>
 <80c448f8-f043-460a-908f-e87e6b8215dc@t-8ch.de>
In-Reply-To: <80c448f8-f043-460a-908f-e87e6b8215dc@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 24 Apr 2023 16:35:16 -0500
Message-ID: <CAOOmCE8jYZ=dt9r47Vo3LPb0c8DOhK31-998S9ZCp0nPN3jcvg@mail.gmail.com>
Subject: Re: [PATCH v11 01/14] HP BIOSCFG driver - Documentation
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
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

On Mon, Apr 24, 2023 at 3:52=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> Hi Jorge,
>
> On 2023-04-24 11:11:41-0500, Jorge Lopez wrote:
> > On Sat, Apr 22, 2023 at 3:51=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t=
-8ch.de> wrote:
> > >
> > > On 2023-04-20 11:54:41-0500, Jorge Lopez wrote:
> > > > Based on the latest platform-drivers-x86.git/for-next
> > > > ---
> > > >  .../testing/sysfs-class-firmware-attributes   | 98 +++++++++++++++=
+++-
> > > >  1 file changed, 96 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attribu=
tes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > > > index 4cdba3477176..73d7b8fbc0b2 100644
> > > > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > > > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > > > @@ -22,6 +22,12 @@ Description:
> > > >                       - integer: a range of numerical values
> > > >                       - string
> > > >
> > > > +             HP specific types
> > > > +             -----------------
> > > > +                     - ordered-list - a set of ordered list valid =
values
> > > > +                     - sure-start - report audit logs read from BI=
OS
> > >
> > > In the treevie you sent the Sure_Start attribute does not have
> > > a "current_value".
> > > This indicated that it's not actually a firmware attribute but just s=
ome
> > > standalone sysfs attribute.
> > >
> > > In this case it should not be documented here, but handled the same w=
ay
> > > as the SPM stuff.
> >
> > I will update the documentation as indicated.
>
> This will also need changes to the code.
> Only the audit log stuff is needed then.

Ok.  Sure_Start will only report two entries; audit_log_entries and
audit_log_entry_count.
Other entries such display_name, type and display_name_language will be rem=
oved
