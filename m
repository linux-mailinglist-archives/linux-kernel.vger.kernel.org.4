Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57826EE7B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbjDYSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjDYSru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:47:50 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0C319AB;
        Tue, 25 Apr 2023 11:47:49 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso6786023e87.1;
        Tue, 25 Apr 2023 11:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682448467; x=1685040467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmQcifGaNqWREsm6+3IKR1nGGFi3wZLObSgYonuw3U0=;
        b=pzyuBJEK0Qe+TSnjm+6vir05cngf+kduk0vEqeZs0zM9S2JxF3a9uqIlr+RuupOc+a
         XwpaIbzim3lrMxOUw+UyjhPA3pEJ9AHrrYYVRUPY5WMLZZ1MxU4JVjm16A5Jq0ZXG6li
         YKZMr2+tlSJ2ihht90MmyHZKwPOkUlVcnQ9PtOf/F9FcJYwyDbOS+Jk4EUOPEFuw3DHh
         JxQdAZNyux/pbvWjoedPLAN9/V1R1J8iVftDg9f5F/a7f+wnpG7UZbCidsSnrHP1jyqD
         66H8yKUZm14D2Qrv6MCE1XZK1QWcx4iWEsTi9S725XaO9f7jUs2Hwuho8x6Mak7oQGQo
         zNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448467; x=1685040467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmQcifGaNqWREsm6+3IKR1nGGFi3wZLObSgYonuw3U0=;
        b=E/eutNiFGPERtQNLyjzZzBJHmTcfI0kUtPSlaSGwjw32KIl6oZJHyx5bl30mJfYdhz
         9WBi0yIJs7fTPkxBbg7ETQNCxMx5NQSaYupS1OR+xOVquLFbrqbfk9GS0WfRUNXExBqO
         Z8JXexdMWAz5gnanh9EhDdj07vkVZD6AM7IaYJW6tUNPQyFDMnIzllfTSofVEbNjWwXj
         E9uWyuWOWsaySVKelnEkkUiO+zGySYgCtxQobRAG1922cknXgd/QvJHqDsMc3kGK/n3v
         AtmexGMH2PIobI2hPLbwd3JGmy8ubvTbZ7aRJJVDbcElPs6zTaX/kKR1hoVcYVV56HMU
         tiRA==
X-Gm-Message-State: AAQBX9dbtVJkMGsv9S7CBxSeVvQp433w91tkXB+ID3BmXHpHEW1UKr+C
        ywiJCsmIhtiepntoZFXEybv/TSw2LZEUVNJfYfI=
X-Google-Smtp-Source: AKy350Z4GHSyyIt4uc9mvfsVOvXPR2DMIDPWN21NHb/tcDjB5sG5OgrnQlMLkelyALEjxTIX2BJB4Y2rvLaEj4AnnCY=
X-Received: by 2002:a19:a40d:0:b0:4ed:cb37:7d95 with SMTP id
 q13-20020a19a40d000000b004edcb377d95mr4820301lfc.44.1682448467464; Tue, 25
 Apr 2023 11:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230419151321.6167-1-jorge.lopez2@hp.com> <20230419151321.6167-4-jorge.lopez2@hp.com>
 <38929a45-79de-964b-5d6f-cfa44099b35e@gmx.de> <6c05cc9e-815d-7a94-8b2d-f17fd5d47354@redhat.com>
 <CAOOmCE_W7_pgQT=8bQBi8_0pD74O6uen6-8p0Orvi1qjEcaHng@mail.gmail.com> <9216dfe9-eea0-b0c0-3630-339a2b60aa2d@redhat.com>
In-Reply-To: <9216dfe9-eea0-b0c0-3630-339a2b60aa2d@redhat.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Tue, 25 Apr 2023 13:47:22 -0500
Message-ID: <CAOOmCE_bp8yvDagQZFE+a4nSEnW1LnU0j+8JH18Enh3A=Naekg@mail.gmail.com>
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

On Tue, Apr 25, 2023 at 9:59=E2=80=AFAM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 4/25/23 16:32, Jorge Lopez wrote:
> > On Tue, Apr 25, 2023 at 5:34=E2=80=AFAM Hans de Goede <hdegoede@redhat.=
com> wrote:
> >>
> >> Hi All,
> >>
> >> On 4/19/23 20:04, Armin Wolf wrote:
> >>> Am 19.04.23 um 17:13 schrieb Jorge Lopez:
> >>
> >> <snip>
> >>
> >>>> +static int __init bioscfg_init(void)
> >>>> +{
> >>>> +    int ret =3D 0;
> >>>> +    int bios_capable =3D wmi_has_guid(HP_WMI_BIOS_GUID);
> >>>> +
> >>>> +    if (!bios_capable) {
> >>>> +        pr_err("Unable to run on non-HP system\n");
> >>>> +        return -ENODEV;
> >>>> +    }
> >>>> +
> >>>
> >>> Currently, this driver will no get automatically loaded on supported =
hardware,
> >>> something which would be quite beneficial for users to have.
> >>> Since the HP_WMI_BIOS_GUID is already handled by the hp-wmi driver, m=
aybe this
> >>> driver (which also already implements a function similar to hp_wmi_pe=
rform_query())
> >>> could register a platform device which is then used by this driver? T=
his together
> >>> with MODULE_DEVICE_TABLE() would allow for automatically loading the =
module on supported hardware.
> >>
> >> Both drivers can already co-exist since the old hp-wmi driver uses the=
 old
> >> wmi kernel functions and is not a "wmi_driver" so there is no need for
> >> a platform_device for this driver to bind to since the wmi_device is
> >> still free for it to bind to.
> >>
> >> This does indeed need a MODULE_DEVICE_TABLE() statement for
> >> the bios_attr_pass_interface_id_table[] id-table. Note only for that
> >> table, because the HP_WMI_BIOS_GUID is present on models which do
> >> not support this and we don't want the module to auto-load there.
> >>
> >
> > I am considering adding a check for the  HP_WMI_SET_BIOS_SETTING_GUID
> > and HP_WMI_BIOS_GUID during the initialization process.
> > The driver will report a message If HP_WMI_SET_BIOS_SETTING_GUID is
> > found or not.
> > If HP_WMI_SET_BIOS_SETTING_GUID does not exist, the driver cannot
> > change the BIOS settings.
>
> Right, adding a check for  HP_WMI_BIOS_GUID to bioscfg_init()
> sounds like a good idea.
>
> That + add a a MODULE_DEVICE_TABLE() statement to
> the bios_attr_pass_interface_id_table[] id-table.
>

Will do. Thanks

> Regards,
>
> Hans
>
>
