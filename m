Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF237455C8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 09:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGCHNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 03:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjGCHNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 03:13:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A6ACC
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 00:13:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b890e2b9b7so4219875ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 00:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688368399; x=1690960399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gdmjGHia+jKRSyCfrlTQ/eoeJlaZFLf9ynF3dOskcU=;
        b=NvLnU7Qf/4miEBTDIGynlVerZgG0j9kKifoHjbQVSC6ehgAanCaXlPKMu+PmHOhH/W
         hse8ugMIDG8mOC6T5lA3Avc6jFOEW5oUpK/wCWq/zbTxKP5NZUPtgS2URd0k5+6UJ49n
         LVX9JT8k+BFKqrW4xc6QH0OTb7ek9woEnDoWByxPRPaAv8TFcyf6cAq1UoF5il86lRvS
         xQNTG1stp8WLkMwMO3pG8hVHge8hJaqie7QFqgWN28/bOODImQ+0aO169hYoG+3NfPBr
         6BJmBm0a6GvpaG6lD5Wg9meRp+eLIAcBTSLIrBoI7waD8UNZ5XEyl3eg5LekT2cOoaTq
         dH7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688368399; x=1690960399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gdmjGHia+jKRSyCfrlTQ/eoeJlaZFLf9ynF3dOskcU=;
        b=ZLLKYeVTxl9UDVcBWD2CXxoV2tH9P/8xjj8K/aEGmytWJ0N7KyT8yQLQe8qH28AqEX
         B/pnIyiTzOAXpmNiGhFpZORuTLF54w03Omwe58W9L1BOJr5iECNQ9xNaV+D2/uAzl/gD
         5sl1y3d5T/gQtvae3h39emM6opqOtkjl0huHmSYZP+jOyHRJl9yo+qM+37oycHQhNsrf
         alWSvkI+dSMnu1in28ssvohsO//tcRHjwVW3NVQJdJstBTER/YqmBqqjg4hveOY9krij
         YonarVKxu9m+EcAqwGFq/hW7VS3iIvH1700Lt64NtvRxicvnpUd2M0iZVYrtGv6GCwFG
         YB8w==
X-Gm-Message-State: ABy/qLbIrXTzHBMCUeDt7v63UTqajEPrbzXPeyQCh6AxgBB4bTytvUnL
        Z91A7nfOeqLsGIp7ZLnS9qw8aGfl4Mc9rai3cO7DZg==
X-Google-Smtp-Source: APBJJlH4H1LJEkNForC6tZD4lPdH33Iimwz3Zzeu94n+d3up/GqFuSavaNHzUS7dGulmfroxCq8D+yD98kWMqXzpoSw=
X-Received: by 2002:a17:902:da92:b0:1b8:525a:f685 with SMTP id
 j18-20020a170902da9200b001b8525af685mr9718943plx.37.1688368398730; Mon, 03
 Jul 2023 00:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230702103516.139440-1-rgallaispou@gmail.com>
 <11ec64ad-8fb8-e94d-2019-d3deb399084b@linaro.org> <4aba0e4a-87f0-1810-bf4d-a2f278e51e8b@gmail.com>
In-Reply-To: <4aba0e4a-87f0-1810-bf4d-a2f278e51e8b@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Mon, 3 Jul 2023 09:13:06 +0200
Message-ID: <CAGE=qrpE9pP4m07VT+RRLhPysF+wO690mF7ChToJYcArKm_nGg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: st: add buswidth property to stm32f429-disco
To:     =?UTF-8?Q?Rapha=C3=ABl_Gallais=2DPou?= <rgallaispou@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jul 2023 at 05:21, Rapha=C3=ABl Gallais-Pou <rgallaispou@gmail.co=
m> wrote:
> >>              spi-3wire;
> >>              spi-max-frequency =3D <10000000>;
> >>              dc-gpios =3D <&gpiod 13 0>;
> >> +            buswidth =3D <8>;
> >
> > There is no such spi property.
>
> While I agree with you, I saw in staging drivers that this property was
> fetch in the device-tree by the fbtft core.
>
> Should I document those in or try to do it another way ?

You cannot use undocumented properties. Whether this should be used at
all, depends what's this, why other properties cannot be used etc.
