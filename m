Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE326B0DC5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjCHPzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjCHPyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:54:37 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA6B9C8A;
        Wed,  8 Mar 2023 07:53:58 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id y3so11364606qvn.4;
        Wed, 08 Mar 2023 07:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678290835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cu08O+oveXjlG4hSRpxEsAKCgw0qjXc+yrgYIWMlGtA=;
        b=J6/KAguNCwMsshMCb78c4OTbg9m9iAVNXryrwQm/2qZt+kRFiFkxzcQYS3dgqXACC8
         zbryOQVS70LTAqKvCQ0lovTAcg9hM67w6gUFylcBgArurIa5uFHRF5ua3Ogpluh3niyN
         2GK9yJHc0qsKq3ush+kPJkZLFb47Ojb+yz7tuuYBGkL6DkWMIJT7IB+1YEe4KnOVK00B
         Gn27+65phJNu1hqvZM7guj0jPeLmRSTq1zp/O0ATZ8tdgjdYOw2C/i/aMOc7UY6J9P/R
         nNnOtwhwRpDiqz13HVOcOjDeaxa3pWCkhhcBy5Z272z7Im25H5e2zk+Hk6hafY8ajsn1
         ROWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678290835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cu08O+oveXjlG4hSRpxEsAKCgw0qjXc+yrgYIWMlGtA=;
        b=6kQEwAz81WQz72VnFw6ccVP1YVpzM/eEs7gv+rxigvSFWKipnlIhzr6Mu5NJlgN/cW
         iwco8CrPvLJ1Ue6ZnwF7KpW5mHEOdWUN85qRAElw4/CaNjiDJtV8734gsqzSws3GoJds
         PEe9cRYOMCJU9eIq4zbBQrXHT6aE2N9PgTH/G62NgT5VmAcHKAuyChG0+ryPvzRAvI+j
         7wF0hd12LHroMYT8AwmWDDp2A3sys23Y0uHUoiBwBl5RwjPNu+vsY74QGN1od9Py20ys
         NSzqYn/t1BYb6/pqBzJT+WxMIkf6bKf30gor3OfMq3ZPoGr04UTe/1DbWFgNOjYPqcoP
         S/Jg==
X-Gm-Message-State: AO0yUKW4gzyDm+QLGSfMuf0KpuqEKSNyp9KwICZTT0r64b8m+beKUQqo
        23eMyrKGFwsYyktqt+a4zR6tNmqceFeew1RY8Rw=
X-Google-Smtp-Source: AK7set9LLlKVTkhBD/cNibGCjfUFiKzaOaS93UkVjMJjWyAJrm1ErnYLOx00xSK2/J9YcYTpa5K0AtTKVD7Zyb12zyA=
X-Received: by 2002:a05:6214:4c06:b0:56f:3aef:1633 with SMTP id
 qh6-20020a0562144c0600b0056f3aef1633mr4862503qvb.1.1678290835084; Wed, 08 Mar
 2023 07:53:55 -0800 (PST)
MIME-Version: 1.0
References: <20230307165432.25484-1-afd@ti.com> <20230307165432.25484-3-afd@ti.com>
 <CAMRc=MeLM-S+HEuaDPp0UpbHJYmAXfLuFMU2TyvK5KEywSxtQA@mail.gmail.com>
 <CAMRc=MfAqx5Wz2d5K1wWM0ZZ4WBu+Jhercw-z95zGvo_-v=OTg@mail.gmail.com> <9c705260-c04c-da2e-db9a-df3ddfb69efc@ti.com>
In-Reply-To: <9c705260-c04c-da2e-db9a-df3ddfb69efc@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Mar 2023 17:53:19 +0200
Message-ID: <CAHp75Vf9oMUmr473PSjcbXjEA+BFNpSPrLd22X=B378qNasrqA@mail.gmail.com>
Subject: Re: [PATCH 3/6] gpio: sch311x: Use devm_gpiochip_add_data() to
 simplify remove path
To:     Andrew Davis <afd@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Peter Tyser <ptyser@xes-inc.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Mar 8, 2023 at 5:50=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> On 3/8/23 4:32 AM, Bartosz Golaszewski wrote:
> > On Wed, Mar 8, 2023 at 11:24=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:

...

> > I see there's v2 out, backing it out then.
>
> Looks like I missed something that kernel test robot found, so there
> will be a v3.

Just split your series on a per driver basis. This will help with
understanding what's going on. Also use a cover letter to explain what
your series is for.

--=20
With Best Regards,
Andy Shevchenko
