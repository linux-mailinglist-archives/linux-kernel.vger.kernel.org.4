Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A2465443F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbiLVPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:24:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911293057F
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:23:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id l10so2302803plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 07:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TDClChrfZ3CM22ZB33Zhm+2Cm6wH/+CI7RGcO5VoIOc=;
        b=AYVTaF/tvAYpuIo2cO2xMxmq3YZvWi6+P+eVf4M2dI7HOuiq+2MDwl9LaSf6k0Q2xf
         NPHYSfR6YtiIB6asp9gGjWy6wsf5bQqUmdZKu8QRBhEQexhf4MPLOISEx2aK/8TtHlRR
         9I0GHuT1G2mp1O09pJVNg/G1QrXj+crjTKvH5W/otSK3mQHE5PUZue0pcWA0IzIY7YIa
         T862w3cdjToAA1KJ8OLiVpzIreW30gXsmU2eQRnmzGYKrelk4mTnN/8Jp6campkRPvy0
         8rzwDwpHB0AKhWdyF6sQB12XHCcM6n9NxBPz8QOhnuMGRR88luDh6utQet3lP0CHMrwn
         QQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TDClChrfZ3CM22ZB33Zhm+2Cm6wH/+CI7RGcO5VoIOc=;
        b=y6YSa1/CPfn2JFO0fri6nC0IZ5t4QBx3RV7sWnuTmuIYVoFjA77Vh898FQL2XzzwY9
         HXZ3upq8qcSfsEY8WRxOTnqKnIWUfICMkE7/b5BdOVNlTL+2JJLXL6GZLogHxc5ZixIa
         6xU9kRtaS47E/mhDPKoYrXCfMzEABn+Q96PfNIFoHO3eVopklddVqZPbOvoZ8bBORADq
         1NRXJGPp34utnt4FW4BqBrylY6zKyzaXTwwRz2+6BRebaf5aNrS5R2Wwf/dCqSkVkWXK
         Quz1BJsOrkQI7jVftgI1fAFrlrBpYmYSsD6Pp4X8C9fYW0W1lHjoaL7N1YTMwB4zesnw
         9RUA==
X-Gm-Message-State: AFqh2koQvMav82ZOJj8bBVH9tK3TcZBnXQab6BvV2cq6ihdqmMQxaHkw
        4YOB+RX0Y3lx//H3Zwc18KsCwPR/Cv7jvFAXco+zRg==
X-Google-Smtp-Source: AMrXdXtPZ0oPZ7gYP9RSL3je4qwX/SGfRW2HgVpAuXOcyTc9fXtZevwi3y3gE3yeLHcQmvVrDyFyxm2Jmt9mOlc9J18=
X-Received: by 2002:a17:902:dc83:b0:189:9ee0:cca4 with SMTP id
 n3-20020a170902dc8300b001899ee0cca4mr578301pld.74.1671722607302; Thu, 22 Dec
 2022 07:23:27 -0800 (PST)
MIME-Version: 1.0
References: <20220726200739.30017-1-semen.protsenko@linaro.org>
 <CGME20220726200747eucas1p226a18ed7760741ddaed94483ba1f9228@eucas1p2.samsung.com>
 <20220726200739.30017-2-semen.protsenko@linaro.org> <7e9e509a-0ef7-087d-e379-14fb58e3e14f@samsung.com>
 <CAPLW+4n-Lf6je61rxdJ9nJnX9h9F8F-y+qikG7eFF0avQpMV9Q@mail.gmail.com>
 <CAPLW+4mPeX-cQR_oLKh+zPwEXuwfQtk2t2USP77C6Y9UmgYq_w@mail.gmail.com> <3751c425-aefa-a3b4-62f4-53d7e369bc1e@samsung.com>
In-Reply-To: <3751c425-aefa-a3b4-62f4-53d7e369bc1e@samsung.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Thu, 22 Dec 2022 09:23:15 -0600
Message-ID: <CAPLW+4=-cqQPmQi57_ARn1C6LqK+LffrFEgLqi6Lwb=YJ7sRSw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/exynos: Abstract getting the fault info
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        David Virag <virag.david003@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 22 Dec 2022 at 07:20, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

[snip]

> > So, what do you think about this?
>
> Okay, go ahead with your approach. If I find a better way, I will rework
> it then. I would just like to have the code for fault handling for hw
> v1, v5 and v7 similar as much as possible.
>

Thanks, Marek!

Joerg, can you please apply this series? Please let me know if I need
to rebase it first, but I guess there shouldn't be any issues, the
SysMMU driver doesn't seem to get updated often.

> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
