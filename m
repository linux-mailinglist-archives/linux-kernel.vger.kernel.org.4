Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC65F690CD2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjBIPWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjBIPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:22:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EB3170E;
        Thu,  9 Feb 2023 07:22:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bk16so2107147wrb.11;
        Thu, 09 Feb 2023 07:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxFq7fZlqbGjwXiI/Fc+o/rdi2Z7DhXh24vJqm8qfmA=;
        b=nJ+n1AC5uVNxc0cXP8KNa/VvP56pb7WfWEWS/VYSLPFHWYIyaQb/UFpYmbxF13aY1Q
         OWFjFanjY9RbX8QkEE4x2/Uh0QT8ZTwGe7XHx/6B/RB5Q0YUP9Eq/88a9/ndUu+lrWmr
         furuJSHUyCRCYs8wlGEN/5tO3DaE7bPDq1aZkQDJL0CjJ6LqLzJVVMzFvOrMkL8yja12
         D6qZLkmL8+vxl1/guzbu/mBgsUm/tmhRHGmZNhZYkIX5Wztewy4gFwz6BtOGtcHyqL9h
         c2Uu1k0BuZBMpzYag2Owd8yV+5JnTRfZGdYu7smjgpAEkoRzjLSSNW/wXWtUM2Kz6tOJ
         RwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxFq7fZlqbGjwXiI/Fc+o/rdi2Z7DhXh24vJqm8qfmA=;
        b=wvivJmFi+vg6AO44DE0TyatCIS3t/tgV5M7kioxE4RHaEv5X197TcTgLjLjdZUO5C+
         WMemjtCO4B7FIzs+7js821HS1Xo7o/ZxsgcKcCZbC2NbRWQeo8ArbREq9rTxSfHu2BSA
         gOVOzppaVvAxNjzMFYRlz+DI9c4XaBCv/IQY42TfFNk6wlpOJPzWbI/ETz46McxzaOOl
         k24dopxYgcu/+Vq45mmuhIaYaUZ7ckOmqb4CAZOuw5Bt55tqhCXV7IoVT1yi2rNBZcOV
         v2CPYuyQp/qAmJSe38wRXy1xeK73bZB7zbp3TkY4H1riUfQTm4BEufdflPYqH6x91xQB
         /urg==
X-Gm-Message-State: AO0yUKWo5cbuyy1oHQxt6jGEtv66Q1f19cSJZkvar0ZarVLiblWgJu6z
        FFI0KevXhHbFDCLDIEYbjr8=
X-Google-Smtp-Source: AK7set8R7kHBC6zkISR04QehfHSNISlKwiGpLqx83p5E5vQRTm7hFnY0RGGgNm+RKbNrxKMW8+AH3A==
X-Received: by 2002:a05:6000:110e:b0:2bf:95fb:e5b3 with SMTP id z14-20020a056000110e00b002bf95fbe5b3mr11258205wrw.33.1675956170534;
        Thu, 09 Feb 2023 07:22:50 -0800 (PST)
Received: from ?IPv6:2a02:ab88:368f:2080:d12e:7ef:c89a:f600? ([2a02:ab88:368f:2080:d12e:7ef:c89a:f600])
        by smtp.gmail.com with ESMTPSA id x15-20020adfec0f000000b002be5401ef5fsm1499739wrn.39.2023.02.09.07.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:22:50 -0800 (PST)
Message-ID: <9e42dec3978c535d6bee6a8bd0c4137a23b70998.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: exynos: add mmc aliases
From:   David Virag <virag.david003@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Henrik Grimler <henrik@grimler.se>
Cc:     krzysztof.kozlowski+dt@linaro.org, alim.akhtar@samsung.com,
        m.szyprowski@samsung.com, jenneron@protonmail.com,
        markuss.broks@gmail.com, martin.juecker@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Valentine Iourine <iourine@iourine.msk.su>
Date:   Thu, 09 Feb 2023 16:22:48 +0100
In-Reply-To: <CAL_Jsq+y2_aHXsxj4sx0KPATDi9-7mujruowpbq2kxro4e13zg@mail.gmail.com>
References: <20230128133151.29471-1-henrik@grimler.se>
         <20230128133151.29471-3-henrik@grimler.se>
         <CAL_Jsq+y2_aHXsxj4sx0KPATDi9-7mujruowpbq2kxro4e13zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-09 at 09:06 -0600, Rob Herring wrote:
> On Sat, Jan 28, 2023 at 7:32 AM Henrik Grimler <henrik@grimler.se>
> wrote:
> >=20
> > Add aliases for eMMC, SD card and WiFi where applicable, so that
> > assigned mmcblk numbers are always the same.
>=20
> What does WiFi have to do with mmcblk?

Some devices use SDIO WiFi, which is usually on mmc_1.
An example of this that I could find is in exynos5250-spring.dts.
