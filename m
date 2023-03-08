Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91E46B02E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjCHJ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCHJ3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:29:25 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A2A02AC;
        Wed,  8 Mar 2023 01:29:24 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x3so62943521edb.10;
        Wed, 08 Mar 2023 01:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678267762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb6Q00e+HEqaZjot221yGVLISrvzrfTEPXm/ALNb0H8=;
        b=nmYJWVQ34bPDBBoQ3GEozviGhZNyZgrsNiIRypZnUHezXZG2PVP3RBNRHXQj2MJH9C
         5BEv5YjP2USmPhh1It3oIubc7qcckHL7jW+rLvFGHJsQqeUYCLxLmdXV8Pg/L0WkF7ya
         SrSRqwyqI01OYtVisRZcePC3FdrnTZZcFeAKlk4TYXYgzk+aMVp+5Bhe5g3uyfEiTStc
         RSDGkqZ9Qd/MluZzkQcXTEKg8TfPILYeu/oaD1D5xQexNO3XqmESeSQFB8/A1RsYKe5D
         s18Tstbp5FBQkThKBpll4KJc1UjpwqFgDeBvuHHHobUDVoRjTEi6mLpfO0MYHVctyH9R
         DDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678267762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mb6Q00e+HEqaZjot221yGVLISrvzrfTEPXm/ALNb0H8=;
        b=mOsR5yTltXKu6lqN5x1gSImzcM7jA9guuHn+/QpjHLHrYwy5kiy/ZABmwkNODDv2Fq
         veE1zXDx/sHaS/mn99mLzdLLHyGzRiGueX0FaSJlCSo5yOkeZ/MoS0t1C3aFnZd+4CuJ
         Ji9uVLhXXx4Vz47z03LaQ+pJ3dpuiMVgZnEA91M7EcQPSHgwcHjCW1FOSxWe5qrsJxvc
         eJV0xp9ZLYNSvPgd0DUvQgiEiDxcwdM/6snojle3kgrj4Uz/BoQjVsKACMZlmHumsDHg
         M8l9F51ort5n5sb0s+rnpWNdTMXOvmG6eWmsLNaV3HyK2wUfmcI0rm1f6K/V/8BtNNUN
         ANvA==
X-Gm-Message-State: AO0yUKV0ie9EZ9l8qFVlvF6nL1t4+X8jIiLKqiiLVgurDOYf6xyFlUlm
        Fy4cJfN71ra3H/h4YSy7rKPkLZZdeMqM4AoWKstbMLAU
X-Google-Smtp-Source: AK7set/DxNgjZSUxLxJC+f7Cs087nAkn/HTSrcq8CEewUTHmmTNP0NL0F0QkUVL04oONaYvdoVRTRc2KI/O2I8g+r5s=
X-Received: by 2002:a17:906:30d7:b0:8b1:7569:b526 with SMTP id
 b23-20020a17090630d700b008b17569b526mr8020562ejb.11.1678267762779; Wed, 08
 Mar 2023 01:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20230308083759.11692-1-clamor95@gmail.com> <f1df5968-4322-3f67-3da8-c10ea50386a8@linaro.org>
 <CAPVz0n24odz4bxt8nRe08-UJFoaDSTGMAPfj2b2RBG+ZbwntfQ@mail.gmail.com> <190897d3-39b6-fb7c-dc18-dac580fadea6@linaro.org>
In-Reply-To: <190897d3-39b6-fb7c-dc18-dac580fadea6@linaro.org>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Wed, 8 Mar 2023 11:29:11 +0200
Message-ID: <CAPVz0n37tyi0ErjGJFGUviX0p4+ZuxHm=4K16FnfDoUztbtXTA@mail.gmail.com>
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D1=81=D1=80, 8 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 11:11 Krzys=
ztof Kozlowski
<krzysztof.kozlowski@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 08/03/2023 09:58, Svyatoslav Ryhel wrote:
> > I would love to, but max77663 uses max77686 rtc
> > https://github.com/torvalds/linux/blob/master/drivers/mfd/max77620.c#L1=
23
> > how to handle this?
>
> Don't top post.
>
> Hm, so it seems max7763 is already documented via max77620. I missed
> that. Add the new property to max77620, not to max77686 RTC. It does not
> look like RTC's property, but the PMIC's.

There is no max77620 yaml, only txt. Add property to txt?

> Best regards,
> Krzysztof
>
