Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C716BAC13
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjCOJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjCOJYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:24:10 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A9E34C35;
        Wed, 15 Mar 2023 02:24:08 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id t13so8692384qvn.2;
        Wed, 15 Mar 2023 02:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678872247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctWTceq67BQqT/ahbjMi0pgtgv0rjXdzqZhTL7tmzsw=;
        b=Ctc7Rj+dSZCN3KhAqhyb16sDdB9ZnZZc01TmQNLAMrMTk3ZXN56xJzMzQJlY0S/yrm
         SG5fIlbFPtemX2P4G0egy1WbAkaXybN1WdyO/BtDSO/o4lFBCijTbcWabyOKxHy5p8ih
         7d5iBHgrUvkGw20mdrNmBIdoaOnD6FPvYeKmdQC0OPW+AggK21GwagOgZW4AqzLUeec+
         FS7ut6HpV69+02iC9S39ewB5P+XJQNtithqjgZ7RGyhN3NXV6fuwaZ28gUQ1db6zOYwI
         tgHY+m6ihhRLrQxdtcluIQwczTmTg2upGI+DTlPQm05iO5is4/ELgZKBQmPvexCWhuK7
         D2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctWTceq67BQqT/ahbjMi0pgtgv0rjXdzqZhTL7tmzsw=;
        b=Tjbr4yFILILC6jNcvg/3/iQYHhlYCWwPEIoSrz27yfuk4KpVjUrGQP6c4gwWT5rkvL
         nc2V7rADGrMqsRbbc6eAJesiPcIlb2sHyBYz3dwcrtwSpM9neTS4NsLFXPmaO8eo8R27
         BmqEmK/HX0nNqILqgDGbhQZTg1XRGjzfBO5BHhyGSvejJwX1v+fWDP0GCBegsyJ3qUaZ
         ObqJjftOicYKbg5sm8pEPa3NEhajW0FqLqlows8TWHzt6YZLiVi+yoPeU/PceNLAx+Fn
         VVCwEPvak33SVYbx1B1a2ozrOQj1slNu0Vq2QgYB8pbJkeFOBi3q5mee0+1T46itdyHZ
         jDCQ==
X-Gm-Message-State: AO0yUKWW4QpqPCmLVWo88LD3rSO9ZA67O6AoJVSII6nrPoFUDwzhmzpI
        UReH9yqfeWWIMCUvqhv/2jsSITwE3n8NI4Qy+nU=
X-Google-Smtp-Source: AK7set/7kbTkUcqW3E49Zgn5wo17wfaKjlp0wPxUUmY//N29SmJCL51ZjjmpiaY8tkQJVfwiDyF14ns64oeUqPjAeRw=
X-Received: by 2002:ac8:5c48:0:b0:3d3:6fb6:abbe with SMTP id
 j8-20020ac85c48000000b003d36fb6abbemr972162qtj.0.1678872244095; Wed, 15 Mar
 2023 02:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230314221609.22433-1-asmaa@nvidia.com> <20230314221609.22433-3-asmaa@nvidia.com>
 <CAHp75VeMWvywh1PmA5SxStqM17e4KjU1voPr2rdYCyZVdEsRPA@mail.gmail.com>
In-Reply-To: <CAHp75VeMWvywh1PmA5SxStqM17e4KjU1voPr2rdYCyZVdEsRPA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Mar 2023 11:23:28 +0200
Message-ID: <CAHp75VekqZhEYd35XWWH4W_qUDfknwm_ouzqkjsgFkUrMeODyQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] pinctrl: pinctrl-mlxbf: Add pinctrl driver support
To:     Asmaa Mnebhi <asmaa@nvidia.com>
Cc:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        niyas.sait@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 11:21=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Mar 15, 2023 at 12:16=E2=80=AFAM Asmaa Mnebhi <asmaa@nvidia.com> =
wrote:

...

> >  drivers/pinctrl/pinctrl-mlxbf3.c | 318 +++++++++++++++++++++++++++++++
>
> Ah, cool, so it's a typo in the GPIO driver then.

And Subject here should be "pinctrl: mlxbf3: ...".

--=20
With Best Regards,
Andy Shevchenko
