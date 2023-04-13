Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 713F36E07DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDMHhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjDMHhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:37:08 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EA883D2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:37:07 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n203so2607972ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681371426; x=1683963426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JrIOkoqNa4l7cqOirMtnXosK8aTIQGEDDZDGV4W2aNE=;
        b=Kv2hZemh+4CLk2fHXoGEYgfSjsnRNVFLpK7CFGhNKYp4AKJkm1mDYkLPoLOcj4zDR+
         kINv6htC+cTuBqBnzCSsD3Zjf+yT6zfeZpLwFnuYIxGKQ83M0XBCOpPIrK0nqkckbT3I
         HRlpl6/T/rVxpuLmkFFXl1f3sCVD71jnM4VZJlVcke/EUP9ic9gZlN+CFmv0RhKI9bTj
         e0l/WeB7d+Q1o5wPONr3Wr63lS/5C2nMWZ94MPWBUiljNd6dpmBxxZvCwn2wkLqZl89g
         NDM34wLHEHxD/WU3H3aKsLLlIwoBp1WS0rMGs6LRMpA5z8M9cuh5eeP+UaiHaJm613x8
         NpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681371426; x=1683963426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JrIOkoqNa4l7cqOirMtnXosK8aTIQGEDDZDGV4W2aNE=;
        b=KWieccaFDJAXj5NL5s0Rh2xeX6G+EZfksT5Q25Rtd58DY7YXB1OrdU/X75aoACFifi
         BJpnxR15xTl/p+u2ZM5Qd7RXgO9tcYJzY8AXE8f+KY38rlWFl+id1IWiNTZ1BZlgUdmy
         wGuh8LRyvKChdmR3IvHekaaJrtLEwz6Cw9EvhZYpEAlIqzcWNxdKydsYz19Pwb1w3tAZ
         yZNRUi+aJwOVVrnqGBeA0MVDfb9Hu0xUTg833afW0ZDzjZD6lor0ZAObGC5ckPeKAxpj
         3u27zB6Fi2HIe3YRXFO0MboyIk3kPScs1XNiebBmJQiq4IOXqug3iosZiRglstfQzywr
         F3qQ==
X-Gm-Message-State: AAQBX9f3VtxGB6yyCXg3SCpor2x8DPjqL7frZ0xdByqYcVXdUwgF1sSd
        e9glCnFNh2CVzGeeDRUexWDUC6UdntA6+E5KZzam4A==
X-Google-Smtp-Source: AKy350a0L9E2liQ2C3VPt6HJwo9mVSSTy114EXniZeJn3aEl6VSxaTEvhE9/+HhS3MFl1vWVxXa2zYrCtjVFpbdGad4=
X-Received: by 2002:a25:d6d4:0:b0:b8e:ec30:853e with SMTP id
 n203-20020a25d6d4000000b00b8eec30853emr663375ybg.4.1681371426300; Thu, 13 Apr
 2023 00:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230412-topic-lenovopanel-v1-0-00b25df46824@linaro.org> <20230412-topic-lenovopanel-v1-5-00b25df46824@linaro.org>
In-Reply-To: <20230412-topic-lenovopanel-v1-5-00b25df46824@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Apr 2023 09:36:54 +0200
Message-ID: <CACRpkdbnAPGdQzJv9L9r0BtXyGHBxQ3SLktj+wUKRs7NuBVq=Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] drm/panel: nt36523: Add Lenovo J606F panel
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, csr@novatek.com.tw
Cc:     Jianhua Lu <lujianhua000@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I added Novatek contact email to responders.

Hi Novatek, can we have a public datasheet for NT36523?
We are developing a Linux driver for NT36523-based displays
and we need documentation. Thanks.

On Wed, Apr 12, 2023 at 9:46=E2=80=AFPM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:

> Some Lenovo J606F tablets come with a 2K (2000x1200) 60Hz 11" 5:3
> video mode display. Add support for these panels.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Thanks for the best effort to use documented commands and best guesses
for defines.

The rest we can detail if we ever run into a datasheet.

Novatek doesn't have a single email address in the kernel
log so no idea who I could mail about this, I think I even tried
their webpage at one point, no answer. But I put their contact
mail on the To-line let's see if someone answers!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
