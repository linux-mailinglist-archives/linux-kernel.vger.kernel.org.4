Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A59B6E0910
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 10:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjDMIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMIk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 04:40:27 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9FDE83F0;
        Thu, 13 Apr 2023 01:40:25 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id x8so1655197uau.9;
        Thu, 13 Apr 2023 01:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681375225; x=1683967225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR9oAsEqqSJ0R2pFXfntzEB7epac7imvXHJFieh7XNc=;
        b=EXcOeKawcDWaoVk5e3gqC3nUqXD42wxCOZWYFXFA29IwBkZWaiNm8kA6kFbkcm9ze+
         GzxhBdeEUAHmMmkVqkzmyNtSOKoVkuTOsI4LoK2ZalJKLLsJFbMf08w0Kgc6DAB4UEGV
         gmm2fge7pAdLp4ZhwU5SuJ2f8kHXJDNVJv1FhKP0QgezrRjF3hK9dJXJshlDGJrSMEE+
         te+ZtlZ6ZYE88SJsKfkeInljA7gKj9W7z6YB2Te+ouuHQ7oGa/MvQGbpeQWcswUYQ+5F
         DAKe1IXKQVD8wnti1NgTIM1atpOQOwHg54mA/UqbEfLZw57RdQP++B12jqzstnGQOc4K
         wbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681375225; x=1683967225;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR9oAsEqqSJ0R2pFXfntzEB7epac7imvXHJFieh7XNc=;
        b=VRajZNhSj7w8vqiqJLE2atgcqHzcQ2QfaIuLpGQvJahG3t0e/SRfC+DWY5Jq8ERxnV
         uq8zofLAonq3R0n92bPFS/7ufowljIDbnu2p6ApfJKTc/AUfU5b97a6qwQ53taz/8lRH
         kY1xHP8DHQFUIVKcUOdo2UJ+5enEmRQBI5BT47hQ7yzJ9oBulhu0x0L3/3MUKvIeNzTK
         tTbC/kxJ0AVi28vG+7WwQK4V6TUsRKU7hFQW96s0mOU+pcDRMwUyng0rNZrFgGhD6vwA
         Ipi1sv8EVtESZTR6IM58FrwsY/4el15kHQ1QBGs4bMIbzMtoaFxR8JcG+616X8Ro7+JI
         3bJQ==
X-Gm-Message-State: AAQBX9fV99KpEWsSsvBJD8M9D/NR67dG4qmiJw4HaCx2vbOBs1AXeW3o
        +QPjUDcUZKBiHZmtgR4pAi3i3M8jcWFvbfSwENpF00tJpbY=
X-Google-Smtp-Source: AKy350aEYnBSyoRaFuYQ2mQMCdl7Xchlnl9DiSVGURlcydSvSaTwd3gTqLeoV1Q9pyFTlArwnYdc8K1LheyDmXPlFjk=
X-Received: by 2002:a1f:1694:0:b0:440:7b2:d101 with SMTP id
 142-20020a1f1694000000b0044007b2d101mr493452vkw.3.1681375224681; Thu, 13 Apr
 2023 01:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230320095620.7480-1-di.shen@unisoc.com> <6055bc39-5c00-d12f-b5c3-fa21a9649d63@arm.com>
 <CAHYJL4qL+nJuiN8vXGaiPQuuaPx6BA+yjRq2TRaBgb+qXi8-yw@mail.gmail.com>
 <637a3bb1-ba1c-e707-01b7-06c1358583ca@linaro.org> <CAHYJL4rnfVp+X3imbxWzUd9ixTFAPe4ioLyi-t50PwhL0y5v8A@mail.gmail.com>
 <da59b4ef-1532-1b3a-7a73-9a095d8c9390@linaro.org>
In-Reply-To: <da59b4ef-1532-1b3a-7a73-9a095d8c9390@linaro.org>
From:   Di Shen <cindygm567@gmail.com>
Date:   Thu, 13 Apr 2023 16:40:13 +0800
Message-ID: <CAHYJL4qJwKHFsCPUvLzmUEAJtEfHDAO23D5=0zAXOYSCABJ8_g@mail.gmail.com>
Subject: Re: [PATCH V3] thermal/core/power_allocator: avoid thermal cdev can
 not be reset
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, Di Shen <di.shen@unisoc.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xuewen.yan@unisoc.com, jeson.gao@unisoc.com, zhanglyra@gmail.com,
        orsonzhai@gmail.com, rui.zhang@intel.com, amitk@kernel.org,
        rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have discussed this question in patch-v1:
https://lore.kernel.org/all/f6aaa5f1-495d-a158-14d8-ddb2bffbd9c2@arm.com/

Simply put, we use the trip_temp in the Android System; set different
trip_temp for thermal control of different scenarios.

On Thu, Apr 13, 2023 at 3:37=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/04/2023 06:51, Di Shen wrote:
> > Thank you Daniel. Any comments would be appreciated!
>
> Still thinking about the changes...
>
> For my understanding, why do you change the 'switch_on' trip point on
> the fly ?
>
>
>
> > On Tue, Apr 11, 2023 at 3:51=E2=80=AFAM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 10/04/2023 04:09, Di Shen wrote:
> >>> Hi Lukasz,
> >>> Could you please apply this patch if there's no more comment? Thank y=
ou.
> >>
> >> Hi,
> >>
> >> I take care of applying the patches. Give me some time to read the cha=
nges.
> >>
> >> Thanks
> >>     -- Daniel
> >>
> >> --
> >> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs
> >>
> >> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> >> <http://twitter.com/#!/linaroorg> Twitter |
> >> <http://www.linaro.org/linaro-blog/> Blog
> >>
>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
