Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756E56ED7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232454AbjDXWP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjDXWPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:15:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0576A59;
        Mon, 24 Apr 2023 15:15:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2a8ba5f1d6bso47788071fa.2;
        Mon, 24 Apr 2023 15:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374522; x=1684966522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5UP7FGVhzXdLz5iNJ9W7/3mzISJ7lFKbYrpdcyd0K4c=;
        b=rFZhJXyhnhQMxNtKliFDYrs9WJ56GWxeQkyKhAdFXSnV/qEpzJk6s7gKC8APzmAEGC
         OXFj3OpN/XTjz1IYRu1Rx5dyDyC0xBS1TKiRTFtEjEGLX40zN0j65kwpKsqRYnjiUAmf
         Y9+I583vBY0i9dprdGPDMzhzlnAD1O8S6f77RLCEbolwA+MC5BXYr5pTCLHrGEFxCivC
         8Kfj25FVOhFmCl0iz99fO9jGb90mmbzdUNQpEMQad6n4H84FnDKWcvc2W5Sr3uv96lLj
         a+XjNGZajQaYDCx5mBLFdghlVQ+S9fEeC67JtykVkRPiKoaerYl4cZKWp+3EKvBIrn+I
         01cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374522; x=1684966522;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UP7FGVhzXdLz5iNJ9W7/3mzISJ7lFKbYrpdcyd0K4c=;
        b=GEFbIhZ9AfGeZLHTjnmwWQxFHPHVIQ7RXGsqf1Tl8gdQ/FqSIeJRbC7i2z2nyLPqf3
         oj4sSBWxATMnnm8dw9qNoxpfiQyn90Om3Pby+YsxuDoVIY9Y7XwFnZMB6O97OfskErAk
         qCwIJZBCTIDrdaAyZJ5TuWG8OVfiJuobvNrYmSaMbh2nIINgttxLHyY3ZY6A5jR/I4aP
         1T9PabDGByEJsCfcPHtAodNiNQp3wLteUYpk+tLns5LYNmIdZ/FH4hhS+V+4fAaOVLBl
         egDiIDsHiPVPFRT61Y2uOm5eR6YoYGIOHNqm0i2ntJoKgrkQ1QXWgxTOz+sSUj+RoHod
         87vw==
X-Gm-Message-State: AAQBX9ehsaIgoka6yz0n+15a5jJCFJiwrlDVwin9Gc9ICeEFcVMplPIp
        1evxyx/EWfy1a9BNIPIH1ogAM/RsSfFHggARCeA=
X-Google-Smtp-Source: AKy350bK379v+0wKKHkuBxIPRu/TPM76BjJ5es5FmF246WAd6QmI7UB4BOl2YgvleGyE4WkHOZ159NdHbFybuph58TQ=
X-Received: by 2002:a2e:80c5:0:b0:2a8:b79b:7e81 with SMTP id
 r5-20020a2e80c5000000b002a8b79b7e81mr2992508ljg.30.1682374522001; Mon, 24 Apr
 2023 15:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230420165454.9517-1-jorge.lopez2@hp.com> <20230420165454.9517-3-jorge.lopez2@hp.com>
 <b7c49593-13f9-44f8-b3b8-66551b01e966@t-8ch.de> <CAOOmCE_MdHnPb250DDYC6Hoqutod2m=2voBqFz4g0dLcmJ5PRQ@mail.gmail.com>
 <67108caf-2a03-4ef0-9f8d-819b0d6f0a2e@t-8ch.de> <CAOOmCE8dru7YOmZeTiEoDMiy7d6nTEih6D2H-AMrOykt=z1bhQ@mail.gmail.com>
In-Reply-To: <CAOOmCE8dru7YOmZeTiEoDMiy7d6nTEih6D2H-AMrOykt=z1bhQ@mail.gmail.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 24 Apr 2023 17:14:57 -0500
Message-ID: <CAOOmCE8SGn9JsWVXUDnKgWyxSzuCuiXzjsv3V737uNXPu2jykA@mail.gmail.com>
Subject: Re: [PATCH v11 02/14] HP BIOSCFG driver - biosattr-interface
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Thomas,

Sorry for asking again.  I just want to be understand exactly what I must do.


> > > >
> > > > > +     args->command = command;
> > > > > +     args->commandtype = query;
> > > > > +     args->datasize = insize;
> > > > > +     memcpy(args->data, buffer, flex_array_size(args, data, insize));
> > > > > +
> > > > > +     ret = wmi_evaluate_method(HP_WMI_BIOS_GUID, 0, mid, &input, &output);
> > > >
> > > > The driver is mixing calls to the UUID based APIs and the wmi_device
> > > > ones.
> > > > wmi_devices is newer and preferred.
> > >
> > > The driver  calls wmi_evaluate_method when initiating an WMI call.
> > > Where is the driver mixing calls to the UUID based APIs and the
> > > wmi_device one?
> > > WMI calls are made by calling hp_wmi_perform_query() which invokes
> > > wmi_evaluate_method().
> > > Did I miss something?
> >
> > wmi_evaluate_method() is UUID-based.
> > struct wmi_driver is wmi_device based.
> >
> > The wmi_driver/wmi_device code essentially does nothing and is only used
> > to validate that a device is present.
> > The same can be done more easily wmi_has_guid().
> >
>

Are you asking to replace all calls to wmi_evaluate_method() which is
UUID based API with calls to  wmidev_evaluate_method() which is
wmi_device based?  Correct?
