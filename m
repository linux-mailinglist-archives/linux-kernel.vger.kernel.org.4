Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC660661394
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 05:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbjAHEau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 23:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjAHEaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 23:30:46 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8789E10B63
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 20:30:44 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4a2f8ad29d5so73036247b3.8
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 20:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kt9p2IMAmrSyERl3/U7i0v+zp4np9fq2eUdHApu7VTU=;
        b=pT9oB3gCOh9Olem1CL4ZptIfhZu3ih/w0CHNl5txBD6uDO8QZc5/YamNprQliZoQdn
         GpMmZH9faKqCTcf00MjGdwIdvu2ugw44fia5VL8KMrIBfoKtwN6FKALj0Yc7NuCpRIU9
         UyOZgNyiirnDctamK78u0sveWraO+Ewj4rbQI6m6+7eNdqtDIn4bSHzPaGobOvTv36IG
         9Uz7PKhWZr6+2WCYNS0TMyIz8TzykOMZv+mQXS9+6awNyr5m015mtPN+8GIMMfPj/EoB
         EN/4PcxZ7z/SYHaX/bXg7leyo1MY2W6JXSP8RDyPe4EDyO6YH98fFqG19PNe+Tx6CerP
         5xQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kt9p2IMAmrSyERl3/U7i0v+zp4np9fq2eUdHApu7VTU=;
        b=1f6OvTjZh0ge3Q/BuARCilrCBraljbUqrZpYXvSmgy8/JXPA8IVaC6Dgv0roYF7tSI
         5v/8XZFriVdbrX7HhXPes4F3V+cyD0WqwjPnqhgBpH41vcVwn1nn+/N+kxkqmo4ByFCL
         6PY3qXbejPyqCSMvo5kihEz1IiSHJDFvlRTfyCaITpkjDcKiMtBBfrNyaNqDtMCmVuHJ
         iJ+vbHcuRZCawn7MSpGRScC5em5rCJb+Gs0VcOLoxZV1vJbyornamW8yVqbTeihikpzz
         QAIhYT6qmI7+bCZoclZv/pejYJtRBuOENIKPtXBhoks0E+O2m3TlchWkO3pHBye2+fJy
         UmFw==
X-Gm-Message-State: AFqh2kpdnatDuft7YpCaC9FtXAld28RbzHaLTKAjNf2iVr26It2fTUb5
        //CUEQAEA9jrie207nd5kfkhoYekSpTT3bPmpmiP9A==
X-Google-Smtp-Source: AMrXdXupKOrz3kfWpdoIVvgaHEW/1EFkbbRv7qhXGij2SiXMJYFOMgAAq+lAoxnV+wvlFubmGSDdQAW+GkFJDC7oHQk=
X-Received: by 2002:a81:6702:0:b0:477:b56e:e1d6 with SMTP id
 b2-20020a816702000000b00477b56ee1d6mr5927657ywc.188.1673152243641; Sat, 07
 Jan 2023 20:30:43 -0800 (PST)
MIME-Version: 1.0
References: <e0ced334-e6c1-caeb-322a-f67a23ee58da@linaro.org>
 <CAA8EJpr0A=VjWEv6NPaZ-t_3TgNaWpsVO8_inJhxqoThry_zZA@mail.gmail.com>
 <17e2d99d-31e5-b29a-e729-4f4d70b2efbc@linaro.org> <CAA8EJprcVT=vyEhU0Nbtr4Wu1YxcGs+NLNxtpTaFtaJSTqvgYw@mail.gmail.com>
 <3afcb445-7a62-ced7-eb54-1b2d8a9085ce@linaro.org> <CAA8EJpp8jnZV1Wkw1T6g95s0QNZLKKN_ve+tqmNsFVCFo0wudg@mail.gmail.com>
 <dd8ce88f-63ab-274a-7992-268003411da1@linaro.org>
In-Reply-To: <dd8ce88f-63ab-274a-7992-268003411da1@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sun, 8 Jan 2023 06:30:32 +0200
Message-ID: <CAA8EJprG9e_wHrM3BNs5bc+8dFbB22iYbJk7MWb8SZwuF=s5+w@mail.gmail.com>
Subject: Re: Annoying message on the console for the db845c board
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2023 at 00:51, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 07/01/2023 23:07, Dmitry Baryshkov wrote:
>
> [ ... ]
>
> > I've tested the v6.2-rc1. With the firmware from linux-firmware I do
> > not see these message. I posted the output of savedefconfig for my
> > .config to https://pastebin.ubuntu.com/p/t4KzQ4QWSF/
> >
> > Could you please recheck with this input? Maybe something is missing?
>
> Yes, with your config, that has been fixed
>
> Thanks!
>
> Would it make sense to ensure defconfig has the same options to run this
> platform ?

Yes, please send a patch. We might have missed something in the defconfig.

>
> BTW I noted a lock issue: https://pastebin.com/274Xz7Aa
>
> Thanks again for your help

You are welcome.

-- 
With best wishes
Dmitry
