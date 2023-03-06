Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2452E6ABA41
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCFJpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCFJpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:45:11 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7207A21A25
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:45:10 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id v48so5983759uad.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 01:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678095909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKoFWJJzSudk3nwRzBdKY9XPLk69RDQhGQ1+c6jaE2w=;
        b=Jt+t7xzqgKO/SnwFDFBrMQVqKg4vkZ8v+66kRuYjaxIodjiBTMtEkmNBw6XQrbQeGF
         1XUJ0E1ZxMsrReSl56g4sTJ/oEv6hKRojODN1rLZT7OKr2oblJvvOsGcs/8pPAuMTKwL
         6bXkLGyO0y2gGM34BwAeWhD1P/hY8iT1MiLBKR3NKw6oNh4GhstX4hXxjeMok6vUibGi
         a7xRaXu0aQstZEdmNLJIzlznSrYLeqyfHnhpgq0RR7CiNrkMA/qJj6d70F/sr5m56TFu
         qYjOGk7nyFo0mYiS003DYJ8p4L/HHzpcenC3CW6TM29LJUKfTmCntSeFiSLIixkYQFwz
         N3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678095909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKoFWJJzSudk3nwRzBdKY9XPLk69RDQhGQ1+c6jaE2w=;
        b=dKdMJH0sOjngvK3PiV6YHsE/QsyRC7N2p7OuF/rVJS0EP6LUb0wGJXP+lP88/8133L
         3cHMCsu8tCaZbNsvfiw7u0WixiOILAplkCsixMO3cq+dv2GxDiq46Mo47um7irQqsrop
         eQDADeuIb1FSvUpRrPjYIQwlAp2AeMG6XLOtq/f2onoYCmGFPBBjc5WfQU6MbPx9nSsr
         uEfOD9PiY9ZL0ehJuNjuoXuUoW/FIfnWJPtYyu1LnOBrAn4ZBsKr6daGWHpRLo9vdRPi
         uiqdjS2QjoUyQ4ygkL0Ly4fUGEU84zYAfu4y9D+/G0Y/9s1Qy68qaXuwJbFDknrb1bj2
         LcRQ==
X-Gm-Message-State: AO0yUKUTDiQkN6Hrm2+reaiqOyjmD2RK+XcZiGfBkvIUZpenhCBtHoEN
        hinWYoKnQ33iOuh8rnq4VEksHrhVVYpU3JUwQ6sJQQ==
X-Google-Smtp-Source: AK7set/bEVRc8TI95CoemZJh7+KtzC91SN3MLNASgDT+0oDrOOyzFT9nuOIx89wi/0U6lCt3IQk5Z4optHbj/h0U3h8=
X-Received: by 2002:a1f:2dcb:0:b0:401:42e5:6d2e with SMTP id
 t194-20020a1f2dcb000000b0040142e56d2emr6168043vkt.1.1678095909486; Mon, 06
 Mar 2023 01:45:09 -0800 (PST)
MIME-Version: 1.0
References: <20230302081711.27334-1-zhuyinbo@loongson.cn>
In-Reply-To: <20230302081711.27334-1-zhuyinbo@loongson.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Mar 2023 10:44:58 +0100
Message-ID: <CAMRc=Mfn8p_zVTruzJ4=5bWSmocg7y-Dvz85ogxawxixp_jbow@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] dt-bindings: gpio: add loongson gpio
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 9:17=E2=80=AFAM Yinbo Zhu <zhuyinbo@loongson.cn> wro=
te:
>
> Add the Loongson platform gpio binding with DT schema format using
> json-schema.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied, thanks!

Bart
