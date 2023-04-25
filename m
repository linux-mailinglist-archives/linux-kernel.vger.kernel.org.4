Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CB76EE340
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbjDYNkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjDYNkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:40:11 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E9FF;
        Tue, 25 Apr 2023 06:40:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a8ad872ea5so56763861fa.2;
        Tue, 25 Apr 2023 06:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682430008; x=1685022008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcesIuzpK+VEGSU+S/FfSN/2SfK0JmwTeQlJxmdrzFM=;
        b=aRcTPUR3iqZnYw+Yr2fYBhV3LnFlC1Xe9QETZn5PYXINeHrAEut1aj9SXNTXB0DdWH
         ZSE89o67bN/v/j+9Npvdh55RprcsCwbSKLbi7vtKGpTCMeM0Wznee/H6bAxFf6M6Xgju
         iQcSMqqaWExrBlXdn5dNwZ0GwvABlSMpsd4lZnCA+b99Io0PFLRS/FGvCHTGPSLqhyZU
         cu4U6ITOyFugrxAPlaZOlSak1wpZyFllVa2ydRk2KSrlcyK8JBDzdhLPqp4/3BUA81RC
         9SGSknAZeCdLus2PjGfzdTPAWkQuLD083ZiaEbCR3xGNlOkRDp+RYi5YJipCcqulrKU2
         POzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430008; x=1685022008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcesIuzpK+VEGSU+S/FfSN/2SfK0JmwTeQlJxmdrzFM=;
        b=bhA7cEPoGldmekVjqqz7059sAS5dSrsRwsn5/uWOXg/57mMuxi/T0F8FGY1kHJwwn6
         ydTlA3yBm/CIx/aIt0RmVUDRb0vsMIcD5GJXrI0EfuOEHePds7gyRETrfnhvqT8Pn9Bf
         qbbcYGu1w8FRBG3zVf9r03QWmsr1ziGRui7I55SGN1GUTUxagw+4rA4Pl9qoLcZ4DxqW
         ZzxlmovDLwlZmSFWra8syjXIGz6wWdVW6sMAehAIxSipwZ3RTXw0kvka2lhRYQSibhM7
         JUdmJ5JpkOtgDGg/YCosUfcdv3iuiHGeARVujiIoMDq8TsmGXiTlBw/eCqkllCGhn3V6
         bQdA==
X-Gm-Message-State: AAQBX9dkRFpPh4FRPNFzNChSYniY3FhMEB0WLK9gCkGZxbPhc/RgBPUG
        7P8nmyU5zo+ubH44WkGdYbm1s41HiagcfEDoT1w=
X-Google-Smtp-Source: AKy350bbOzdNjLlA7R7eOdjlSWKPWRPT27ArhDGiTkuzHiDECXu9jbRZsA4ymCraoZiVUXRf66O7NdYmIhy/vTHzXU0=
X-Received: by 2002:a2e:3213:0:b0:2a8:e642:8cdb with SMTP id
 y19-20020a2e3213000000b002a8e6428cdbmr3317683ljy.49.1682430008375; Tue, 25
 Apr 2023 06:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-3-jorge.lopez2@hp.com>
 <b7c49593-13f9-44f8-b3b8-66551b01e966@t-8ch.de> <CAOOmCE_MdHnPb250DDYC6Hoqutod2m=2voBqFz4g0dLcmJ5PRQ@mail.gmail.com>
 <67108caf-2a03-4ef0-9f8d-819b0d6f0a2e@t-8ch.de> <CAOOmCE8dru7YOmZeTiEoDMiy7d6nTEih6D2H-AMrOykt=z1bhQ@mail.gmail.com>
 <CAOOmCE8SGn9JsWVXUDnKgWyxSzuCuiXzjsv3V737uNXPu2jykA@mail.gmail.com> <b4b9fb11-d6d0-42e6-9193-ba3c2c846071@t-8ch.de>
In-Reply-To: <b4b9fb11-d6d0-42e6-9193-ba3c2c846071@t-8ch.de>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 25 Apr 2023 08:39:43 -0500
Message-ID: <CAOOmCE8Q4g=jvqZK6m1hAGGDnM4GCOX6QoAcwqSYroSx11cE4A@mail.gmail.com>
Subject: Re: [PATCH v11 02/14] HP BIOSCFG driver - biosattr-interface
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

On Tue, Apr 25, 2023 at 12:28=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8c=
h.de> wrote:
>
> On 2023-04-24 17:14:57-0500, Jorge Lopez wrote:
> > Sorry for asking again.  I just want to be understand exactly what I mu=
st do.
>
> No problem!
>
> > > > > >
> > > > > > > +     args->command =3D command;
> > > > > > > +     args->commandtype =3D query;
> > > > > > > +     args->datasize =3D insize;
> > > > > > > +     memcpy(args->data, buffer, flex_array_size(args, data, =
insize));
> > > > > > > +
> > > > > > > +     ret =3D wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &=
input, &output);
> > > > > >
> > > > > > The driver is mixing calls to the UUID based APIs and the wmi_d=
evice
> > > > > > ones.
> > > > > > wmi_devices is newer and preferred.
> > > > >
> > > > > The driver  calls wmi_evaluate_method when initiating an WMI call=
.
> > > > > Where is the driver mixing calls to the UUID based APIs and the
> > > > > wmi_device one?
> > > > > WMI calls are made by calling hp_wmi_perform_query() which invoke=
s
> > > > > wmi_evaluate_method().
> > > > > Did I miss something?
> > > >
> > > > wmi_evaluate_method() is UUID-based.
> > > > struct wmi_driver is wmi_device based.
> > > >
> > > > The wmi_driver/wmi_device code essentially does nothing and is only=
 used
> > > > to validate that a device is present.
> > > > The same can be done more easily wmi_has_guid().
> > > >
> > >
> >
> > Are you asking to replace all calls to wmi_evaluate_method() which is
> > UUID based API with calls to  wmidev_evaluate_method() which is
> > wmi_device based?  Correct?
>
> To be honest I'm not 100% sure.
>
> wmi_device is great and perferct for simple drivers binding to a single
> UUID.
>
> But it does not handle multi-UUID logic as your driver needs very well.
>
> I would argue to stick to the legacy calls as it allows you to drop a
> bunch of code and makes the initialization flow more straightforward.
>
> But I don't know if somebody else won't ask for wmi_device later.

I understand.  I will keep the legacy code because the driver handles
multiple UUID logic.
Thank you for the clarification
