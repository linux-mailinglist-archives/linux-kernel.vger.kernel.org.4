Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF01654F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiLWK5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWK5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:57:03 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393D37F86;
        Fri, 23 Dec 2022 02:57:03 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id k3so2204685qki.13;
        Fri, 23 Dec 2022 02:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW+LCcAtlGnRQKKQ3bVeCpYjp1F+jYu+AIxRn9diqUs=;
        b=MMOaugASq3E4MFvLrio0/ZW1VXQCotOLhNNAUOPPmGgVnRfnS8C4yF8PmSsxDhKLny
         H7LrIAdIBSfPESmusfMvHeWuaEF9VK+k7w5BFX4NhpxQJ/s/O9AkXuK56+tdIJ1UmOjr
         e95LjXVsPaOUviXdvosRdXvXC96/lR41+XPdv+qoyuAGqoCbrw4lKIxW+JsI+U8QxHwm
         RdfyDN8OuGp/YJumggdpg9EvwpSmDNhYJcn+i3uDL2Ma99y5/d7PS/+RmwFJcLNQd6F5
         pN8Jy9evlPN3T+MMZ1OTJ8MXKCkY3Syii6nrulUnX4sESX1wu6g5cHBYS4q86AiAw2od
         mQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WW+LCcAtlGnRQKKQ3bVeCpYjp1F+jYu+AIxRn9diqUs=;
        b=a9HFV7qz1zcGpoth4GXOLvbkGGxU5ufLYmyajOB+fQ7UHCPpEQKHMkDO4qJQ6hKAII
         DGUcDFT+6dAcR5N8nldgjZQ1+YpK39VnKFs4/EY1ofGqg9WaW7ex+pvrGNzn5iG7Xbxi
         uRdxvt/Ae829+bo3h0r7WRlDibTkzSvBi5iMuwT9nOJSVnx7Iy0lWTqCbK3YTlGnqAfI
         KBKNSKpv4Y/tOmTtA75Y3oEbM+e+nkn4YXwJDU9S2uVsroayYjnKWPiFeapMWWeqny0a
         g7yxqzJG4d++foJQb80UauqBU1L3L2it5xCwtiHFWo59FDCSm41oz5lm4hf6vDjWPgSK
         dgOA==
X-Gm-Message-State: AFqh2krH33J+n2HzfeRjy5GHlUAkrzF5omq++XJ12GE8ixMB9YA7KfoD
        wM6TSNmy0azUFohDjrvCewwqFBJ6jd7NWfjsI+E=
X-Google-Smtp-Source: AMrXdXs3OQEmrbpBSV9ypraWiPlBrwwNdX2kuAZfYaCPRX7BNnG+oSFP9+O8PP+2MoKDXqmAbzfgt4zhO6vH0kOCrSM=
X-Received: by 2002:a05:620a:8cf:b0:702:219a:130d with SMTP id
 z15-20020a05620a08cf00b00702219a130dmr411267qkz.407.1671793022215; Fri, 23
 Dec 2022 02:57:02 -0800 (PST)
MIME-Version: 1.0
References: <Y6UdvrhLjS0/8Oic@VM-66-53-centos> <9a73d8fb-8a73-f8db-2ca7-51bf67cbf659@linaro.org>
 <CAMmci2UkBVaBgYMF8JaZkL==b9-0AB90VPGK7SNdNV5w5Zyzhg@mail.gmail.com> <62e62d16-aa18-4487-db98-d767f1f9d438@linaro.org>
In-Reply-To: <62e62d16-aa18-4487-db98-d767f1f9d438@linaro.org>
From:   ty <zonyitoo@gmail.com>
Date:   Fri, 23 Dec 2022 18:56:50 +0800
Message-ID: <CAMmci2UPxbu_nMJyqz5q_3Efw-gHawEbzBPkMyW7cGqMf0f-SA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] dt-bindings: arm: rockchip: Add EmbedFire LubanCat 1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Wenhao Cui <lasstp5011@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it. 2/3 and 3/3 will have the Acked-By line in the next PATCH version.

May I ask whether there are any changes required in [PATCH v9 1/3]?

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E4=BA=8E2022=E5=B9=B4=
12=E6=9C=8823=E6=97=A5=E5=91=A8=E4=BA=94 18:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On 23/12/2022 10:42, ty wrote:
> > Hi, Krzysztof,
> >
> > Sorry, we do not know the process, this is our first contribution to
> > the Linux Kernel. There is no change since the last review of this
> > file.
>
> So I linked you the process and explain it.
>
>
> Best regards,
> Krzysztof
>
