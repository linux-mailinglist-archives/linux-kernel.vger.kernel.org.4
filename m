Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC0E74385C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjF3J2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 05:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjF3J2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 05:28:45 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FE23585;
        Fri, 30 Jun 2023 02:28:43 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-51d9695ec29so1685569a12.1;
        Fri, 30 Jun 2023 02:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688117321; x=1690709321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZCBSgni0sr8gGqL9uMypHbMvj7usQCYMwxdwYXW+jA=;
        b=QRJY4EEw4g4/61MzEr/J5K3QI0OJoUCA5DROKENJS/ku/aNTGEPqXdfTm0SMgoekR5
         XC6xdT9A46C8ytjZyw27lTco5+zkYCQ6Sx+E8Qw/rwCZjwhBSvzNkjjR9FT/uEL1LO/Q
         UHfiqD9hqOYgoaZ+6OSLomuOJFJvmiwpEtClVR3s0nzaw1Qo4h4XcXcrwDJNNxlvPj/n
         NTMLJtUpoq0XFRK5ck4PqsWC7eKdKCCyRaw4w3F5vDQA/uwNgauOdYVhrKLqe7KztF1Z
         RTzyVc2NZ0vIR2KPiHL670A6QcN0Q8aNgNpbU0Y9y65QJlNq4g4IzpSyo3vDR9Vh+1jV
         dbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688117321; x=1690709321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZCBSgni0sr8gGqL9uMypHbMvj7usQCYMwxdwYXW+jA=;
        b=QIZ0mz+Ddq5qMUCTmjVo2yMi9z6Akwtx5pALBoSJeh5C4PS+cGOZsPF8bwQ6jHYRaY
         BUh6rB1RmhK+rWVIqbbb1RNUgoIYlenbBh5fyVi0iYbgQ3kgwQaAx/rARqD4ZQTeYdfi
         kPr8svqV2y475sL0jeZO/1fIP/PTb8wEkjYA4SF3uQMIrMqAaVX+b48TcWOxCOeaJ2A6
         3ZY5xCLv6zxm7ZvPSmQ/XtxeDAfiaDjfYbkrsqWseuf96443W8M/eoCfxtWbUSuLzm4N
         Yb0gINuoI5Kr1HNAfs5gHbwra9ilimkJux0sK6KkoA8t1XtYPnVQHAkdgtbzYQYoVSgq
         TMPg==
X-Gm-Message-State: ABy/qLZmTXSAJfTlFnVnIudlsmBX4Vqjz9N7ohjZjnhYZ4Cow6NBOU/+
        ITaiQpRNbr7MwaVKHl6Vr/eyX9oY4+B2LiANg/8=
X-Google-Smtp-Source: APBJJlFMq2w/PbJ55327XebcvTTEwXkX993DxpgiQLo04cpZ/EAYzg2QeasZ9plssJgPvzLr9TsHaiWzwcGwfTIgqXA=
X-Received: by 2002:aa7:c256:0:b0:51d:9ddf:f0f3 with SMTP id
 y22-20020aa7c256000000b0051d9ddff0f3mr1120614edo.31.1688117321377; Fri, 30
 Jun 2023 02:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-21-git-send-email-quic_mojha@quicinc.com> <0ac3e4cd-485e-43a4-ae76-4c462a8145ed@quicinc.com>
In-Reply-To: <0ac3e4cd-485e-43a4-ae76-4c462a8145ed@quicinc.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Jun 2023 12:28:05 +0300
Message-ID: <CAHp75Vdpg8R0FtECk_bqdVMQW7Nz_EY0pacaL8PA+0Xcfkyt3Q@mail.gmail.com>
Subject: Re: [PATCH v4 20/21] firmware: qcom_scm: Refactor code to support
 multiple download mode
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mukesh Ojha <quic_mojha@quicinc.com>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
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

On Fri, Jun 30, 2023 at 8:25=E2=80=AFAM Pavan Kondeti <quic_pkondeti@quicin=
c.com> wrote:
> On Wed, Jun 28, 2023 at 06:04:47PM +0530, Mukesh Ojha wrote:

...

> > +static int set_download_mode(const char *val, const struct kernel_para=
m *kp)
> > +{
> > +     u32 old =3D download_mode;
> > +     int ret;
> > +
> > +     ret =3D sysfs_match_string(download_mode_name, val);
> > +     if (ret < 0) {

> > +             download_mode =3D old;

Why is this old variable needed at all?

> > +             pr_err("qcom_scm: unknown download mode: %s\n", val);
> > +             return -EINVAL;
> > +     }
>
> minor nit: %s/-EINVAL/ret
>
> > +     download_mode =3D ret;
> > +     if (__scm)
> > +             qcom_scm_set_download_mode(download_mode);
> > +
> > +     return 0;
> > +}


--=20
With Best Regards,
Andy Shevchenko
