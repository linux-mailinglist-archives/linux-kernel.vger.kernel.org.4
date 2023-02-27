Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32146A4615
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 16:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjB0PaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 10:30:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjB0PaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 10:30:06 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0635CD33B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:30:03 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s18so3789123pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C3CiTz6/U/wp7PbRBroAtOi46dRTbSRjLVEEIMUQC2Q=;
        b=t63O5GUZbiYu0E2Iv90UTLjmnGposoSLT86162BArw0Irfznqxy6utUICLMgtQEMoy
         x2gQAGoq0hbLQKgwYQ46RVODILjOF34YuHukJ1LNW4zrArzN3A5N8j9VMzIa9mUZM5oz
         7ojmkcoceOdKJaC2/YKOwITXDzhbPk6reQGOb5i76EbficlVyQoEwnE4FNmRzuc3gNHz
         zs63fRtuK99zF0XFYd/john6EQiTF72dVstg15kHRzsdsrxjVdk0yoBD/9UYU+T6dMiF
         s8ig9/0obN/eY/QpwXcTFWJOYFao0X27AIju6TNj1gJGMpk2+v9jwoK0SV9G3bLkgjPu
         Fbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C3CiTz6/U/wp7PbRBroAtOi46dRTbSRjLVEEIMUQC2Q=;
        b=31JUum8D8lZxYdvAK6v0LgGK3kP8Vm+Tq16uU7H/U2Tt/3k8gU7kF9ePq8hcpa5i2z
         Ujy2fP0CCzzCYL+HtO2RR9K1MwJmTFhb4XNbBqXoPpCnXeOliIb4i2a/RJGfl4Yriila
         DlDK0Da3FCP/8Es7TvXUBgHCw/3uOWlL+/zhwkqjM+uAnen8ddIT6BWniqQEOvIM0Wr4
         Djtf8g1+Kr9UGeXiYxHk/zwhLKAIcIe/67QB1JrVf2Wa5swWvGcLxTG1g5+yFY5/Z9kc
         FAQXzOVLCfBBh4CukzeZhmym2+nC1+RylAntQSizgR5I5sNLr1gciFQ3rs5/DV0qMjxK
         CSTw==
X-Gm-Message-State: AO0yUKXE0mxGQh2MANHJCJY4fB8gDJBbCpmRdMWmu3UmZwFajiSz7Ws3
        rk1Ij/ZCnknn5nMs+exsYhwXePBY9tHsw7ozY8HtLg==
X-Google-Smtp-Source: AK7set+7LTRYPwxWDQdVcUkKgAc5mbndJdDNy+xbyWDoXGOU3VITUok2DNZgeTmScaFCqO7eK2fKN67w1eFSpM8e3Xs=
X-Received: by 2002:a05:6a00:1621:b0:5f1:b1:6dc4 with SMTP id
 e1-20020a056a00162100b005f100b16dc4mr1746557pfc.3.1677511803345; Mon, 27 Feb
 2023 07:30:03 -0800 (PST)
MIME-Version: 1.0
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-6-victor.shih@genesyslogic.com.tw> <CAPDyKFrWf2vmC_KMnMfT=GQc_uf2oerzXn4cO3SE02MmHHxArg@mail.gmail.com>
 <CAK00qKB4-UHkP4D2ZU50L7aBzcYwRXPRd-HFnWzHEZvvLtm9bg@mail.gmail.com>
In-Reply-To: <CAK00qKB4-UHkP4D2ZU50L7aBzcYwRXPRd-HFnWzHEZvvLtm9bg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 16:29:27 +0100
Message-ID: <CAPDyKFr6aGgGT24WTLE6E9NX_T0px4kCzn3KQzAgb+UPebE6_Q@mail.gmail.com>
Subject: Re: [PATCH V6 05/24] mmc: core: Add definitions for SD UHS-II cards
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Jason Lai <jason.lai@genesyslogic.com.tw>
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

[...]

> >
> > I think this better belongs in the struct mmc_host, please move it
> > there and then also rename it into "uhs2_app_cmd". Note that, there is
> > also one case in mmc_sd_num_wr_blocks() that sends an MMC_APP_CMD, but
> > without calling mmc_app_cmd(). This needs to be fixed.
> >
> > > +       unsigned int    power_delay_ms;         /* waiting for stable power */
> >
> > This seems to be unused, so let's drop it!
> >
>
> This power_delay_ms is used in the sd_uhs2_power_up function.
>

Correct. Although, the value isn't being set, which means it's always
0. Is that deliberate?

I realize that we are going to end up calling msleep(0) for this case,
so there is a delay being done anyway.

[...]

Kind regards
Uffe
