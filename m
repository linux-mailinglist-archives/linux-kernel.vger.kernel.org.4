Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E137602F91
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiJRPXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJRPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:23:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC3D0CD9;
        Tue, 18 Oct 2022 08:23:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id bh7-20020a05600c3d0700b003c6fb3b2052so3305500wmb.2;
        Tue, 18 Oct 2022 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:from:to:cc:subject:date:message-id:reply-to;
        bh=bEddq63SNEjeM/xMvu/ByxpDSe5rVs/O0NJXLl0d3Xg=;
        b=gE7AGVea8ljT1IZHd4CmvcafBr/enqORfbdBqrgjJSrVGOOKPY4ywo7IeiIrQ4fywQ
         gGszJUNF2NeKfFoHUPRtFvPEspit2YSpFRUvPiEzhL7vwfDme0ymoDPUyXkErRgHREor
         CVHrUmmhl4EnlfNPBACKMfwWD7Cfq1rRqjVLE4X7/UoyEzHRNSE2G4+fZ5kz4vyQq3RV
         Gq6NjMEKfrzAqX7plM5nLqGKAaeAo1PUfqwaZMh7cMslP4rh6iK04VkQSKzeia1omlP2
         UWG39AfB76XqX9a9VyIPZkeki2r2wX1ytOjcOtnYcvwQbb+SgU9QBsDFGpreb+T1klDt
         okRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :references:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bEddq63SNEjeM/xMvu/ByxpDSe5rVs/O0NJXLl0d3Xg=;
        b=0UfGsMGXQ5zaYOgqOa1rtlRueBRlApBqSBvYhKbfHluxO1Oi6X5bcoZs+0hxhbXxg6
         0MV1dD9ga/sulmLJvbtOn3mMTYfU1KxD7u+/l9vbIXtAWsVAWLToBsuucYdqSHfi/NSo
         nzmKA2BcwpjXfH5e0h+mb4dNGUTJqgbkJ2+ZlOA1hajImhnwS6a35RCpnLP5jqP0lzSY
         kcCdqwreUJMUkVdixc7OR5/LYEjPfjbaSvDBHfMhG5uX8zlXm4phHVlgK7kuNkv96Q/A
         tqFMKlaNzS8DkPb9u4bUltZR+IRZb7g8kxYLdjAn8eS9njQNhj3l7lEXihtIOtcD8bln
         Qjjw==
X-Gm-Message-State: ACrzQf12VwKfPToUNxPuRFRITTte2XD6NnKoO1bdMLOSG5JcCivcPGb2
        rz3Gbe2eYgaki7TuOtcH11A=
X-Google-Smtp-Source: AMsMyM4daIGfqDv/NZF1S01gyC5tFEmQdv3UTJqAdeeUQvv25Fu5Hg5RKSgZXfi/kzn0A0QnspLPOg==
X-Received: by 2002:a05:600c:1509:b0:3c6:809a:b5a1 with SMTP id b9-20020a05600c150900b003c6809ab5a1mr23993837wmg.71.1666106584459;
        Tue, 18 Oct 2022 08:23:04 -0700 (PDT)
Received: from localhost (94.197.29.248.threembb.co.uk. [94.197.29.248])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c1d0600b003a5f3f5883dsm20187232wms.17.2022.10.18.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 08:23:03 -0700 (PDT)
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
 <20221017184419.62d365c1@jic23-huawei>
 <LYfRwE3pxZfgZBDC6gwvsSrHWqcSQXHK@localhost>
 <CAHp75VfL5TXvoVY8Zq946eUJYetLt2Od2m26mUSPGxsdF=TC-Q@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, lars@metafoo.de, linus.walleij@linaro.org,
        brgl@bgdev.pl, michael@walle.cc, samuel@sholland.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 00/13] Add support for AXP192 PMIC
Date:   Tue, 18 Oct 2022 16:15:37 +0100
In-reply-to: <CAHp75VfL5TXvoVY8Zq946eUJYetLt2Od2m26mUSPGxsdF=TC-Q@mail.gmail.com>
Message-ID: <HMq7csUe6Gk3DrWRzgEmM5kpQ9DomiFs@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, Oct 18, 2022 at 2:06 AM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>> Jonathan Cameron <jic23@kernel.org> writes:
>> > On Mon, 17 Oct 2022 00:43:22 +0100
>> > Aidan MacDonald <aidanmacdonald.0x0@gmail.com> wrote:
>
> ...
>
>> > Lee has recently expressed that he keen to take as much of these sorts
>> > of series as possible via the various subsystem trees.
>> >
>> > As such, it is useful to call out in the cover letter of such a series
>> > if this can be done.  For example, patch 9 (last IIO one) can't be
>> > applied without defines in patch 6 (I think).  Thus I'm assuming Lee
>> > will do an immutable branch with at least those patches on it.
>> >
>> > Perhaps worth expressing if that is also the case for the power
>> > and regulator subsystem patches?
>
>> Yep, the IIO, regulator, and power subsystem patches all depend on
>> the MFD patch.
>
> There are two types of dependencies: compile and functional.
>
>> Specifically, patches 6, 9, and 10 depend on patch 5.
>> I can't get rid of this dependency because the variant ID (AXP192_ID)
>> has to be defined centrally in the MFD patch.
>
> It's not clear which one you are talking about. If it's functional,
> then each driver can be taken separately via each concerned subsystem.

Johnathan was talking about compile dependencies -- the defines he's
mentioning -- so what I mean is compile dependencies. Patches 6/9/10
do not compile unless they are applied after patch 5, because of a new
enumerator AXP192_ID defined in patch 5.

Regards,
Aidan
