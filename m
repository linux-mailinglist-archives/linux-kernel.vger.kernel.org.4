Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96021686475
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjBAKig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjBAKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:38:07 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35E661BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:37:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r9so15324130oig.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 02:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ufispace-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V9HXHdBtE5H4bl8z/S/UD0KX8Uzi+CVOeWYp/70CnSU=;
        b=6xUaW2l5sWqpJ9TK3pv/glxvIHBTA8EnnmR+lTHKGUThsQKl5pk2G//7BD7YWy1XC4
         kfnM0sOkk6wZW8fZ0tVL8rtT3hSIvQudjtBaLzShMDy+OmCERyzmgKkjV53+fp9NFgwR
         4FtTNbTX90KlCL+IQX4+cSt1tWfq2npLAQtMryHUeZSmh07M84IVN/tAg/Ce1+x1jZ27
         VjuCrUvk9ImitmogqZUoWkIZ8v4l1Og7luvlxkY1oBrtrgs1jydber4iMOqzeuEugkmB
         5PzOQylKm3xsGSryk1ic3Plp6ZxKDf1vwvRhUjIZB0OggVXO4+XYbhQX/Ia7kYHKWMFc
         GIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9HXHdBtE5H4bl8z/S/UD0KX8Uzi+CVOeWYp/70CnSU=;
        b=r71Mhuieka93JA7GIa2OykvV6VtAIK7XHni7PC/DYk4hojRlgPmTcacUld3EFdc0aA
         DcwrHi3kSeKUYpN5/IN9MM65D4sdUtzzs1h2ohq+C2krkYHdZclXa4uLQ9v7Rex8RILW
         MyQy0eS6nqkDUdKwX9Z0C8li7UjnORbmhTYT00D8XUKWK+y2Qo/Dj8Qs9kwHhqbAt/cJ
         sSgVKXF+nJ2ZZ2yyzAIr12qRYAV7pmF2KgVITJlX8xH2EMFaiEd+duIhKPzD4ea6H2WF
         49NQLmomfmcAQlDdzWFMTIUpofQRTNU5rG/aNC4tvUW6ognp7/ozzX8bMvm7tHP2EGgC
         9itA==
X-Gm-Message-State: AO0yUKVhivHPSqCMuHtQTsJ25idGWzz9DqU5a+mm7rElawVSQVbcQy9z
        5u0Xzyw1ZjiS1xADXK980Hb9wk/d1/oAFLnBPjOcmg==
X-Google-Smtp-Source: AK7set9uClQE84nhhdw56rlphOg08vTFoT3Prz55IEhG5el860pUruT6tsfWOA+cHt+lT7rtFaHQAc0KJmxs3Zn/kg0=
X-Received: by 2002:a05:6808:d4b:b0:378:7ba4:b818 with SMTP id
 w11-20020a0568080d4b00b003787ba4b818mr146767oik.144.1675247878050; Wed, 01
 Feb 2023 02:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-4-jordan.chang@ufispace.com> <3e242c03-f8fd-2136-0263-2306acb9f610@linaro.org>
 <CAJ3czeT1O3iw2S_SK3z0C6dMiJ+-fUrWXPox4LJpJkMy_rVsJA@mail.gmail.com> <307017b7-2ecf-2ce5-4031-27bb6f09feb1@linaro.org>
In-Reply-To: <307017b7-2ecf-2ce5-4031-27bb6f09feb1@linaro.org>
From:   Jordan Chang <jordan.chang@ufispace.com>
Date:   Wed, 1 Feb 2023 18:37:47 +0800
Message-ID: <CAJ3czeS7y6xj+DAJy66oujOfk73kAaJWiQsWAwL-4D2CaFimJg@mail.gmail.com>
Subject: Re: [PATCH 3/3] ARM: dts: aspeed: Add device tree for Ufispace
 NCPLite BMC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org, jay.tc.lin@ufispace.com,
        eason.ys.huang@ufispace.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your reply.

On Wed, Feb 1, 2023 at 6:14 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 01/02/2023 11:06, Jordan Chang wrote:
> >>> +     gpio-keys {
> >>> +             compatible = "gpio-keys";
> >>> +
> >>> +             fan-status-int-l {
> >>
> >> Does not look like you tested the DTS against bindings. Please run `make
> >> dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
> >> for instructions).
> >>
> >> These will bring warnings. Missing generic name,
> >>
> > I have run the `make dtbs_check` command, and did not notice the warning
> > message 'Missing generic name'. It shows lots of compatible failed messages.
> > - /ahb/ftgmac@1e670000: failed to match any schema with compatible:
>
> You can run it with DT_SCHEMA_FILES=gpio-keys
I see. Will fix the naming issue.

>
>
> >>> +
> >>> +&i2c4 {
> >>> +     status = "okay";
> >>> +
> >>> +     psu@58 {
> >>> +             compatible = "pmbus";
> >>
> >> Where is this compatible documented?
> > Can not find the corresponding document.
> >>
> >> Did you run checkpatch? Did it pass without warnings?
> > Yes, I did run the ./scripts/checkpatch.pl and there were two warnings left.
> > - WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> > - WARNING: line length of 104 exceeds 100 columns
> > I just ignore those warnings that Joel has informed me in the previous
> > mail loop.
> >
>
> Hm, is it then correct compatible?
I think it might be since it did not show the fail message.

Best regards,
Jordan Chang
