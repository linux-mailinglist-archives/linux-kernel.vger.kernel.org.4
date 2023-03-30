Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99AB36D0686
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjC3NZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjC3NZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:25:21 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5229029;
        Thu, 30 Mar 2023 06:25:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id hf2so18372890qtb.3;
        Thu, 30 Mar 2023 06:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680182716; x=1682774716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O2Ubc5rjxRC/a64POIEP8GbnAE630EsjMg26nf6HLM=;
        b=Ozjyy4twCccU3pofK5Sim+Ize+PeJer3yLuQkl1L8vsJcMq5TjbYzAX+nhN7wZLvTH
         BgCwYz5UyDYOMFE6RaRD84EpxH5GwXe62hPf/KdWnVYny7ixW9PypByB2JJ8KmEBcAXb
         Pm35jGXF6Jr+7SdtK6nep99+sq74D0hS1gbBQwsgIXjwhsRrSjasB4upkq12PNGBxkIJ
         vKgFXXMIjQSjGZoUSTkN23gCIuFg9LtoqWVctlEtD5LE1iw4RY0z9U1savM55hCuE9b2
         e2vao1FAPeZXzkXjne+BSuLaHASI1EpOEf59pM+QI4AM/lkUNO6lIQ26OV7exi8Gwbso
         H9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680182716; x=1682774716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O2Ubc5rjxRC/a64POIEP8GbnAE630EsjMg26nf6HLM=;
        b=E+4QLRYmqOyTmthvrp8sZx2ojZ5MDvwrBGqsuq0xS/vbVEs3tWL50/ikAr8/5ouQzQ
         J5JE6QDbaKwmClZLpS8bIW6Ly20t1/DycMFi65rYvPnmZesjA6rB6A4/ExnXG4U+FrSF
         T8vJ9vxJsxYaaHHatobsWCMMYApVs3oaSuEcMr2CRZRADebYcDx7n3T2b2cjvHy/ucME
         al5mhnqr4Gxz86RrlXVTc2mGYufW3aHf59GvQLcWmCU1d2NC1UUaQutBfPAwpuFklauX
         0xGAansEPu/OUFQFrCb08JFAsPddy6Mk38jUdh0dfip5Dk4Aq+trnCAhk4s9gtKzH4ty
         XTFw==
X-Gm-Message-State: AO0yUKX8cUXp0gdAtNHmjf8n5qjLrVyXyHRJRoAoQD9J+7HSN6PdH8jd
        S8Rcjj/paUJ/cFto2RrAB3vyO9dBurtl37Tfxc6gtVCcJuCF+2XzU2onCQ==
X-Google-Smtp-Source: AK7set/dTFyzIvXShJ0B8CE4kH+Ix/xXepReeCxZvmIN82acOmDoGmMahlFeJmBJWNqosX2AU6lE6crg17NdnkEdJro=
X-Received: by 2002:a05:622a:1648:b0:3e3:8587:21f8 with SMTP id
 y8-20020a05622a164800b003e3858721f8mr8888935qtj.8.1680182715805; Thu, 30 Mar
 2023 06:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNcKc9BP0t1q=TaFF6fjjJU-MNcoLt_LT1rVKbHsUXiAw@mail.gmail.com>
 <CAJZ5v0jv0BYE1pgCEJDsadfzH0ZnZYfwJuScPMQcpFYSJPYL6w@mail.gmail.com>
In-Reply-To: <CAJZ5v0jv0BYE1pgCEJDsadfzH0ZnZYfwJuScPMQcpFYSJPYL6w@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 30 Mar 2023 18:25:04 +0500
Message-ID: <CABXGCsO+3jtA-UZK4mRuUKNg3mpyf9gPCJ4Y==n7o4KQHOa+ig@mail.gmail.com>
Subject: Re: [bug/6.3-rc4/bisected] WARNING at cooling_device_stats_setup+0xac
 caused by commit 790930f44289c8209c57461b2db499fcc702e0b3
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rafael.j.wysocki@intel.com, rui.zhang@intel.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:07=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Thu, Mar 30, 2023 at 9:52=E2=80=AFAM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi,
> > The release 6.3-rc4 brings new warning messages to log:
>
> Thanks for the report, please see this patch:
>
> https://patchwork.kernel.org/project/linux-pm/patch/2681615.mvXUDI8C0e@kr=
eacher/

Thanks, after applying this patch the issue gone on all my PCs.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
