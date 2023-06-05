Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0E67226E2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjFENH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjFENH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:07:26 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22B4EE;
        Mon,  5 Jun 2023 06:07:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b1b86146afso30415491fa.3;
        Mon, 05 Jun 2023 06:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685970441; x=1688562441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6AWBTDpG34/EWY8Thq7a1h/Nl1InpKPLTTSry7qvJE=;
        b=VpBs0u+fENX9RcEg39Bo6tqOPKkjcSgj1nY9DLdILgwpSusCYdDvW9zW9sZQB9Ag9W
         NI6pNOJt0jn5hwIMVLISv85/a202rBEDLm3ieqa6cO2VGG/qGSgxHgMfIflGVG2Wa9qG
         P11P55TgYxilnm10LxF1CkMf8Y35c9zwuiJ2dHufaQPLbc//GsSCz+1FbEKGm1adPZ14
         n0oA224JggEQmuyHz/FiLmkUETFL8PfhlqW+sjV8Yllyjb2sFJbPD+AAoIGb37X6tCYp
         /dMTEY3OfIakuOsTNyOhnh95TxgMTtNmsJqxeA7cEEB1AApwoGb04/Lg9wliKVZnd6/P
         A1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685970441; x=1688562441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6AWBTDpG34/EWY8Thq7a1h/Nl1InpKPLTTSry7qvJE=;
        b=NflC4MK9gZRvdCt1sbWjxRt7eUFUfqsfrc7UxMDsgl4UdCKLseGdTSu6Otj1dU/Is4
         yo6PDtWluks/ZBGfMi1ZxISimyt1SB/GjsufABOGEemitNUA+c1UVoQH6pAx8wToAbBv
         hpTpIoXywBGnSMCNVXKlTNaFmzW0j/eTqWyl/jrEXs3UYexcEpEoWyOv2BI4fxJ7wmqG
         z8APbSFUftf6AOJXmWbXpWmW/ndi1pfhV8AuZdxr8Znls9yrcJrdZ8DEm3xJ03OXH+cz
         YEiJpxn0ynyfcUg4dK9aAZrR0xpbmcMsPMQBnltceyfPEXsR2FFeqOishfvCkm1Qk7zg
         NRkw==
X-Gm-Message-State: AC+VfDxwi1S2pxpjslK+ahl3K4mU8CQna7T0YaLAYigF13y5jT09TGVY
        u9m+Cx7TfXwJiTmg/Rr/ZbZIAkNXyqcwLZ3n6qs9Esyy
X-Google-Smtp-Source: ACHHUZ4CymYYxEqlTaDJBBHUqSZTWl0GK0OHPWXkjPHMEpk5B4dXP+bHTVroOgthn3gLpMFWGNU8EhJVo3g77/Whu1E=
X-Received: by 2002:a2e:b1c4:0:b0:2ac:77e9:c7b0 with SMTP id
 e4-20020a2eb1c4000000b002ac77e9c7b0mr4476429lja.9.1685970440606; Mon, 05 Jun
 2023 06:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230602131044.3297-1-jorge.lopez2@hp.com> <20230602131044.3297-13-jorge.lopez2@hp.com>
 <83d86690-fdbe-66fb-221e-5443851330c7@infradead.org>
In-Reply-To: <83d86690-fdbe-66fb-221e-5443851330c7@infradead.org>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Mon, 5 Jun 2023 08:06:43 -0500
Message-ID: <CAOOmCE9GnGrqzcnF54e1JgysqiFVVkjATFVuFAZVUQAZ-KvnLw@mail.gmail.com>
Subject: Re: [PATCH v16 12/13] hp-bioscfg: Makefile
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas@t-8ch.de,
        ilpo.jarvinen@linux.intel.com
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

On Fri, Jun 2, 2023 at 5:46=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
> Hi again,
>
> On 6/2/23 06:10, Jorge Lopez wrote:
> > HP BIOS Configuration driver purpose is to provide a driver supporting
> > the latest sysfs class firmware attributes framework allowing the user
> > to change BIOS settings and security solutions on HP Inc.=E2=80=99s com=
mercial
> > notebooks.
> >
> > Many features of HP Commercial notebooks can be managed using Windows
> > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > Enterprise Management (WBEM) that provides a standards-based interface
> > for changing and monitoring system settings. HP BIOSCFG driver provides
> > a native Linux solution and the exposed features facilitates the
> > migration to Linux environments.
> >
> > The Linux security features to be provided in hp-bioscfg driver enables
> > managing the BIOS settings and security solutions via sysfs, a virtual
> > filesystem that can be used by user-mode applications. The new
> > documentation cover HP-specific firmware sysfs attributes such Secure
> > Platform Management and Sure Start. Each section provides security
> > feature description and identifies sysfs directories and files exposed
> > by the driver.
> >
> > Many HP Commercial notebooks include a feature called Secure Platform
> > Management (SPM), which replaces older password-based BIOS settings
> > management with public key cryptography. PC secure product management
> > begins when a target system is provisioned with cryptographic keys
> > that are used to ensure the integrity of communications between system
> > management utilities and the BIOS.
> >
> > HP Commercial notebooks have several BIOS settings that control its
> > behaviour and capabilities, many of which are related to security.
> > To prevent unauthorized changes to these settings, the system can
> > be configured to use a cryptographic signature-based authorization
> > string that the BIOS will use to verify authorization to modify the
> > setting.
> >
> > Linux Security components are under development and not published yet.
> > The only linux component is the driver (hp bioscfg) at this time.
> > Other published security components are under Windows.
> >
>
> A commit message should tell what and why. E.g.:
>
> Add Makefile and Kconfig to build hp-bioscfg.
>
> It does not need all of that boilerplate info.
> The cover letter is good for that.
>
> The "why" part can and usually should include some background/history
> info.

I will update the commit message for all portions of the driver as indicate=
d
>
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  drivers/platform/x86/hp/Kconfig             | 16 ++++++++++++++++
> >  drivers/platform/x86/hp/Makefile            |  1 +
> >  drivers/platform/x86/hp/hp-bioscfg/Makefile | 11 +++++++++++
> >  3 files changed, 28 insertions(+)
> >  create mode 100644 drivers/platform/x86/hp/hp-bioscfg/Makefile
>
> thanks.
> --
> ~Randy
