Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7E6DDDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDKO26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjDKO2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:28:45 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D1A4680
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:28:19 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54c12009c30so268304597b3.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681223298; x=1683815298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZfobvlUCC7J3xgHr6FQOiw2LjkyB6gvtu/1JOkJZMo=;
        b=YwK8pJ9uI8qWrURVIeDyg0ZVrNVImO8yisLnVmcklUK2t/1M8MMbwv4A2gPfrIu25U
         bW1pQD/qK8+ep8QAdp2Bgaps4gm5Mzvz9yqBA6V1gB7KUoG0rSgiGefqyR7N0b6mQEiv
         l2MEDSlugMZ44sA5NZZfvAFxE7M32G0G2G+sxmtwOGreMm7EY3k2dW0mcPnzMgdkmedy
         BqktCxoiuO/l/14J1TrtWkc6MZGiq0YKGzcEFqKN6ra8qQLs/DMiJtzKqxEYR8JOZ8fY
         yXpinKCeWS4f9YN5GEgZpIzOyFeU6EiDdr9Or9UTLvPRJVIbCzCUtF0hN6zEfR8LIyFd
         2CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681223298; x=1683815298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZfobvlUCC7J3xgHr6FQOiw2LjkyB6gvtu/1JOkJZMo=;
        b=Z9DL/gmHf2ShgMw+sbk9IA3mlUR7AtFDD6gvPJKJj32JbIwuWSlkdNeU5raKug51d5
         aP5W/JG0QrLTTF6UIsznqxI5DoWF8aAskdJBebfBWq/VjC38q0TF83mfbOyQSFvYho8Y
         ECdjSCl+QNYMcwnSJ9GV6JBzCxbqQw/t1KB75IYxXcHqQ5LztAozBCzH33ZtMryork23
         Vn8/Amxc2dmIs2/gu9rCkqBrElBGgMcKuzDHCC+twrVlD9Fu49Y6nWuQEXN+7XbyL+1u
         S0grNg0fIss51DQYL7Wb98UNY+bxEYRoZxTXmKz/4w3LxAXltTOFh7rZByy50E2QxPqy
         vabg==
X-Gm-Message-State: AAQBX9ffcrrn5VRISF+vLRAcTURakb+Fb1ouQUVLDmOxmMyAvvcLlKG2
        kHxu1PGiDt+H7KxGDpWWy0MzkIVKBpcuETDYhkbydA==
X-Google-Smtp-Source: AKy350Z9kzZbAxs/K4ubk+sdi2/tr79+TIi6vYp2YRsWABCQsOlOkg6Q4ykmV4ttthZT9jYNbA6TdBKab+FdV3LcYQU=
X-Received: by 2002:a81:a74a:0:b0:54c:7a1:ef50 with SMTP id
 e71-20020a81a74a000000b0054c07a1ef50mr6013376ywh.6.1681223297863; Tue, 11 Apr
 2023 07:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230410092634.4870-1-David.Rau.opensource@dm.renesas.com> <d9dac02a-328d-485e-9aff-158852eeb990@sirena.org.uk>
In-Reply-To: <d9dac02a-328d-485e-9aff-158852eeb990@sirena.org.uk>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 11 Apr 2023 07:28:06 -0700
Message-ID: <CABXOdTfGD_fyi+itsr9Nd834Pb6+4Ej8M9SM5AN=uhXQ1K4DiA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: da7219: Improve the relability of AAD IRQ process
To:     Mark Brown <broonie@kernel.org>
Cc:     David Rau <David.Rau.opensource@dm.renesas.com>,
        support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, bailideng@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 4:32=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Mon, Apr 10, 2023 at 09:26:34AM +0000, David Rau wrote:
>
> > This commit improves the control of ground switches in AAD IRQ
>
> In what way does it do this - what was previously unrelabile and how
> does this change address that?

One very specific problem is that da7219_aad_handle_gnd_switch_time()
is currently called after interrupts were enabled. As a result, the
delay time is not initialized if there is an interrupt before the
initialization. This results in a negative value passed to msleep().
Since the parameter to msleep() is unsigned, this causes it to sleep
forever which in turn causes a substantial number of hung task crashes
in ChromeOS. Plus, of course, the code doesn't really do anything in
this situation.

A secondary problem may be that calling msleep() with a potentially
large sleep time on a system worker isn't really a good idea, but I
didn't explore the impact further.

Guenter
