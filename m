Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9B6DBF60
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 11:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjDIJsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDIJsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 05:48:36 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD2F2698;
        Sun,  9 Apr 2023 02:48:35 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e9so1861891qvv.2;
        Sun, 09 Apr 2023 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681033714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QLQShrovHbEUjILSSrUeG4lyLPMZPoiInz+6fDtZxso=;
        b=STnArrylRJgluZDmFBEorF8OGkIjK2tLTMBCLT3OXaY+bvuz9i1cJBr+lQGuKdPbic
         Qhyj5ayFqtjZbNJA8xmH7Vm+/e2drnyNjHbC9QluVxrQH70NUx3gosPHvx98mZhT1Oc7
         iuyRelstPpc9kXGoAQksfI04eJizbMgcsYgZSjJFofi3DrOmxdm+Z87WUdK4FRX6FJ/u
         aTqDPz6VyozNwOTt/nDrqivxQiynGSrDD/iuDu4DDMSAJRe+lIJqYRMRJ3UTcXtdtdKA
         UPgAoe6Sz9AEURd1y/7V6o90Q8U7ithdGMExFuGABSBOXYdOSIgsM6BnTPlBxCvAydIw
         X2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681033714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QLQShrovHbEUjILSSrUeG4lyLPMZPoiInz+6fDtZxso=;
        b=vMMo18/2tReyaHwrLbOScQNziMa/G/FcTbL3ilRP+Kz+TOZD2CKqmPU3lkCpSJRESr
         s2aYOHQYURl+F2rjvUJ5iwtdYn0hXmzsjcY31AzKn1ld5/IwMuu3gaW+cVNPE6N4/xhT
         sCp3eqfsgGt+ud87Pj4fDbj+6ODssnaw4+8RjLZivW74h9fLEm8b1dxVRUaz5Faalhq9
         UqIPKuTQHgVu5YG5tulksQ7CiZDZcvuTAP/Tj+7mWqGcsgqex3OXwcm9xzi9+0dCD04n
         ahSq9idOxpjelbQB7d2ZWjv7GmMyW+oe+I1hLZxfszmSteFqtP/VEflGsYFBwKFRMYm7
         sRyQ==
X-Gm-Message-State: AAQBX9fzlV/1S8tG8cTuKigm9RfcJubuyL7Qms79+I6K33pnBq/wP2Y8
        mxKbFEv6NPzk7mYshdDhMB8Ij+vgfkb0bRM5vq/WBmLSEnI=
X-Google-Smtp-Source: AKy350ZAlAFP+D9XYQ6XYj3Oop0QbuHx7IQyvZHnlKQIaQQ1sZX1j+e2F/tN30cZmUERNjmDx8tnY5hiNDi8QWSUzJs=
X-Received: by 2002:ad4:5990:0:b0:5e6:63d0:5ff3 with SMTP id
 ek16-20020ad45990000000b005e663d05ff3mr1392880qvb.10.1681033714302; Sun, 09
 Apr 2023 02:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1677331779.git.mazziesaccount@gmail.com>
 <41eafb0caa510cddf650cf5ff940639a184f3005.1677331779.git.mazziesaccount@gmail.com>
 <20230408113258.15a39576@jic23-huawei>
In-Reply-To: <20230408113258.15a39576@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Apr 2023 12:47:58 +0300
Message-ID: <CAHp75VdO5B0dwG3RedZ7iuij3gCB+UfnLHgKvrbSpbzBh3DORA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] doc: Make sysfs-bus-iio doc more exact
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Apr 8, 2023 at 1:18=E2=80=AFPM Jonathan Cameron <jic23@kernel.org> =
wrote:
 On Sat, 25 Feb 2023 15:56:16 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:

...

> Applied to the togreg branch of iio.git and pushed out as testing
> (in this case to be mostly ignored by 0-day ;)

One fix is needed?

...

> >  Description:
> >               Raw (unscaled) phase difference reading from channel Y
> > -             that can be processed to radians.
> > +             Units after application of scale and offset are radians.

The previous chunks and confusion in reading the above suggest that
period after Y must be added.

> >  What:                /sys/bus/iio/devices/iio:deviceX/in_massconcentra=
tion_pm1_input
> >  What:                /sys/bus/iio/devices/iio:deviceX/in_massconcentra=
tionY_pm1_input

--=20
With Best Regards,
Andy Shevchenko
