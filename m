Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE716C99BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbjC0Cvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjC0Cva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:51:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1273344B1;
        Sun, 26 Mar 2023 19:51:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ek18so29985166edb.6;
        Sun, 26 Mar 2023 19:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679885488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZyy2539DKmwQ79ZzNvti1gksI+Y/yJO34aazyo+MTk=;
        b=mPsonWTgp0xYYynNM6NUdzOwW3OpjziTFCuJBizN0XC8rG5du/n2vc5VFCMkYXsb+p
         nKVfpCRtAk6EL/aJiojq/gjueqAmy4nhnKcW405m2GWW/85r9Zmsh+NlJ2Lu3ohbptM4
         Yb7ktzrtbgpI4cmHxt5pukpLRrJs1tIA0IZy6Qc70QH1bb0CVNvBpSceK1j4RPcjqs8T
         d4A9tkTs1z5hGafpPChUBT7ICtNM5GIKKoV1eVeNPk0hYLn2Ev0rYJRsSOvlMqrsGJRV
         0iEybV7J26hxdPjGVrx9rMXG4pchKbEI1q1klteujp/sP5idcyRMj/tOQ1iKWtTApmAJ
         AQgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679885488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZyy2539DKmwQ79ZzNvti1gksI+Y/yJO34aazyo+MTk=;
        b=AWhaOygzXOs1TqgAm/2Pj2gq31NvHcfLercqu3EAYOtGkbg7U7mvTkco022UU1W+VZ
         cFmx0CXYp/xajtzYvWsS1jrX1FkhlZAICp5o2B6+ByxPeol4N3BaZDa2omyNa+B/sSPT
         +KYdZ9Dn+D7Y2BT2VxJ/OTtPphTu4WuJIXBxMri+DgSgsyb+/DUagBEuxOskkg4FB2Hs
         bI5ptketah10yn/75NzMBsRhDnZsWzKj7nMh1nSWMJAgXhgw1S/gEidZ6TsJmedGr1EY
         8cX8/PWNwLzpTcXeK8vNroCSOPXOPcObAcePHjA4OW1oai2XsrsDckiQym3w9eLULTRq
         hhcg==
X-Gm-Message-State: AAQBX9fnN+Knky6u7tsvzXXEUp5cRIgI4r47MvWajZ9shKJVEESDFChc
        i3cg2KRIWg0TPfsugpooC4E5MJLxt5fOq6NjajKBnitx0ZiyNw==
X-Google-Smtp-Source: AKy350a/rEv1Pdbougpaq3svQY6WheO/+HQwtvNtKVsuCDwZm4728T33s5T62eQlDTHDGlnQg3kcGX3K/WB6yVBK3M4=
X-Received: by 2002:a50:a6d7:0:b0:4fa:71a2:982b with SMTP id
 f23-20020a50a6d7000000b004fa71a2982bmr4809711edc.0.1679885488489; Sun, 26 Mar
 2023 19:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230323121437.28239-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230323121437.28239-1-lukas.bulwahn@gmail.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Mon, 27 Mar 2023 10:51:12 +0800
Message-ID: <CAJhJPsUY8zXC0FXLdM6YfRXNmxoVK4Tyk=Sdc_7ap9GugSTZJg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove obsolete file entry in MIPS/LOONGSON1 ARCHITECTURE
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 8:14=E2=80=AFPM Lukas Bulwahn <lukas.bulwahn@gmail.=
com> wrote:
>
> Commit c46496119ed0 ("clk: loongson1: Remove the outdated driver") remove=
s
> all files matching the pattern drivers/*/*/*loongson1*, but misses to
> adjust the file entry for MIPS/LOONGSON1 ARCHITECTURE in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=3Dpatterns complains about=
 a
> broken reference.
>
> Remove this file entry in MIPS/LOONGSON1 ARCHITECTURE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Keguang, please ack.
> Stephen, please pick this minor fix-up on the top of the commit above.
>
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8f8e846fc453..4aac18b5d5c1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14047,7 +14047,6 @@ L:      linux-mips@vger.kernel.org
>  S:     Maintained
>  F:     arch/mips/include/asm/mach-loongson32/
>  F:     arch/mips/loongson32/
> -F:     drivers/*/*/*loongson1*
>  F:     drivers/*/*loongson1*
>
>  MIPS/LOONGSON2EF ARCHITECTURE
> --
> 2.17.1
>
Acked-by: Keguang Zhang <keguang.zhang@gmail.com>

--=20
Best regards,

Keguang Zhang
