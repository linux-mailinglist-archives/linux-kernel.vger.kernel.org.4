Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C26EE3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbjDYOdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233838AbjDYOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:33:02 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955EF13FBE;
        Tue, 25 Apr 2023 07:32:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2a8bcfbf276so53404951fa.3;
        Tue, 25 Apr 2023 07:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682433171; x=1685025171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbBZp2UwvFnYA0QA/lQDtuNJIeFok3sFwNh+5GowoR8=;
        b=Uy6Z5S2VL0AK4rynnr993GVmWtQt3z579fvWKHOVhHGpSu3KhmhMHBg6V02/M4urIW
         f+1ehqWqGCaMHVwa+tUFIioKakNNxkBtZ/lgWrbGQ5b0WDkCE69Rep2uEQaFSZ/i9hcp
         MJPbiyNMEzL5j807zYpYs0CG6R4aRiqd5EpmBOB7UBqMFZUp2IuaCzxYdAneWKBv2lqv
         infynBbRA5uXMi9eVEiLyX3tGisrriY+DhWSPg/GFua0Wc7F5P5jb2gX7CI3YB0gEs+d
         vRVfFg92JtFuo9+DOaG0FS2AAMO6u0CW35qLFb2kR8TsiNVz5eFPwhh1Jr8+4uAl1YQf
         1zfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682433171; x=1685025171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbBZp2UwvFnYA0QA/lQDtuNJIeFok3sFwNh+5GowoR8=;
        b=CF/BBfwFGeWFN1edl1LNrTzz2wcHxFEdrME99tz35usPaTVdSHVqH6Qg3OUP4Bq+nY
         h7EKWWhJEt1sZIrE2nRGfq2qe/AK7JqequejXXEMCHk2lfSy4ZOIJ+67eQl8aS85iMuD
         TBY6MQ6Lm7LlmXt84ChBOwhutv5K7cY+cMEf+ImU+p38Kl1KYniaN3lrpGMTdvfvR7Kb
         cw2krBuhpsmn0cY6TqoW+t+AjHeYLxEweEyhmoD+CqpIikWJBd5YzqmeJWEnTry2Q46Y
         2MoJz0ImXra/OxxTEzZcnSd0E4d+94ClelbSxXRA+5kq8j08YWy6q/JbFbcyGW//NTtm
         z4YQ==
X-Gm-Message-State: AAQBX9f9c3lerQmEVgIeEsIVBtyiV+GQLHnFrG8BYSFprtXIImD94Gv/
        qaKxe+lsGvNjNA9fU5Tv5aarDGXI8GpEyoK2zud1Yqh8vbw=
X-Google-Smtp-Source: AKy350bwtv8/nbv7mZxvJxWUlZt1sO4by2cW608vPG2BMPNGnotkC85t7kiKTixLzN2up79Qf6GpnjKEANPR/ODC+/Q=
X-Received: by 2002:a2e:9214:0:b0:2a7:a719:5936 with SMTP id
 k20-20020a2e9214000000b002a7a7195936mr3747878ljg.19.1682433171389; Tue, 25
 Apr 2023 07:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230419151321.6167-1-jorge.lopez2@hp.com> <20230419151321.6167-4-jorge.lopez2@hp.com>
 <38929a45-79de-964b-5d6f-cfa44099b35e@gmx.de> <6c05cc9e-815d-7a94-8b2d-f17fd5d47354@redhat.com>
In-Reply-To: <6c05cc9e-815d-7a94-8b2d-f17fd5d47354@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 25 Apr 2023 09:32:27 -0500
Message-ID: <CAOOmCE_W7_pgQT=8bQBi8_0pD74O6uen6-8p0Orvi1qjEcaHng@mail.gmail.com>
Subject: Re: [PATCH v10 03/14] HP BIOSCFG driver - bioscfg
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de
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

On Tue, Apr 25, 2023 at 5:34=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi All,
>
> On 4/19/23 20:04, Armin Wolf wrote:
> > Am 19.04.23 um 17:13 schrieb Jorge Lopez:
>
> <snip>
>
> >> +static int __init bioscfg_init(void)
> >> +{
> >> +    int ret =3D 0;
> >> +    int bios_capable =3D wmi_has_guid(HP_WMI_BIOS_GUID);
> >> +
> >> +    if (!bios_capable) {
> >> +        pr_err("Unable to run on non-HP system\n");
> >> +        return -ENODEV;
> >> +    }
> >> +
> >
> > Currently, this driver will no get automatically loaded on supported ha=
rdware,
> > something which would be quite beneficial for users to have.
> > Since the HP_WMI_BIOS_GUID is already handled by the hp-wmi driver, may=
be this
> > driver (which also already implements a function similar to hp_wmi_perf=
orm_query())
> > could register a platform device which is then used by this driver? Thi=
s together
> > with MODULE_DEVICE_TABLE() would allow for automatically loading the mo=
dule on supported hardware.
>
> Both drivers can already co-exist since the old hp-wmi driver uses the ol=
d
> wmi kernel functions and is not a "wmi_driver" so there is no need for
> a platform_device for this driver to bind to since the wmi_device is
> still free for it to bind to.
>
> This does indeed need a MODULE_DEVICE_TABLE() statement for
> the bios_attr_pass_interface_id_table[] id-table. Note only for that
> table, because the HP_WMI_BIOS_GUID is present on models which do
> not support this and we don't want the module to auto-load there.
>

I am considering adding a check for the  HP_WMI_SET_BIOS_SETTING_GUID
and HP_WMI_BIOS_GUID during the initialization process.
The driver will report a message If HP_WMI_SET_BIOS_SETTING_GUID is
found or not.
If HP_WMI_SET_BIOS_SETTING_GUID does not exist, the driver cannot
change the BIOS settings.

> Regards,
>
> Hans
>
>
>
>
