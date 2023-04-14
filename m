Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1786E6E2130
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDNKnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjDNKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:43:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118034EDD;
        Fri, 14 Apr 2023 03:43:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v6so17017357wrv.8;
        Fri, 14 Apr 2023 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681469022; x=1684061022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gNgu8/gxif8nw/9Y5K0MGzuFATQ+lD23DX1qBxOYNkg=;
        b=ntAbmdAOB87jM3sQ1csEnjg8Ag2twQ61Xl4Zun8ptqhKrtHZW0l/Ym/JRVy/wivAxG
         0iCwa+T0dMBud5YuzRit4k36il2soQGcLf8+/lK+bAayzf6YbqTpFHjUzh6Pc8CdHOz0
         WaDKsMNbgOaUnSfDKFLcPlvEcLb6kEvQCZyrXH4MFDxPrddhS4olJZScbQFnISQmZB6f
         omhoUqu8q9HF84Z17yIRcStxAYWiyOPDHkj1IPBOf1pMpcjVsHrtKEDRPSmUl4zC/nIU
         g5VHTYWrGX8fl4wNdWzKP+NmClpjAcONTGZa0Mm+7qA35L7WkTGYe3InJ+adt4e2hXjc
         O7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681469022; x=1684061022;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNgu8/gxif8nw/9Y5K0MGzuFATQ+lD23DX1qBxOYNkg=;
        b=b8z43wj6i8F9zqIols2IF8VjF0sDEnNa69coHL5zGSdRPyGxkAxu5hjeiDGwsAHqhr
         YuegnhxB5ygTG9ogFDSnFR3LHywJUED3+JDdCEd5Yz6ukX/s+Iv8VnI7nA4KbivOBdh3
         1tKY+pOAFeGyk85QHMRHVTZHiLFMSzbK/2kzUrvNKOcDv6SF1FZTXwglRBv8ssiu/UWs
         QTI67JlMP4ogdK7VkOBxw+zORvqfPaMMRioCYSjkeCFGMRHigjxTOXtpWuE82ctceKmP
         kqB+vEUWto4be2NAc98oFNB1WLyCxZ7tWDJX4oZx+AELuuqvcVdE18Psbxn/9TF0JQQJ
         1kHQ==
X-Gm-Message-State: AAQBX9dp2UGDySHowuQ8VvrHaBsLUjgCkIeQmGe9DJ/WUpY8Kap0Vnv9
        +rD+tuqUftr8DRY/AbMZF+BdaZjmVwKU/i2GeNo=
X-Google-Smtp-Source: AKy350a9U4k0Iy7pNu4JvvfTjZIpwao5lJtg7D3YdN7kFR3yOSYuAwqTS/atSnBgWjuR+uOrNsHldqse3GCOgZDpLYk=
X-Received: by 2002:a5d:4248:0:b0:2ce:ac97:6f51 with SMTP id
 s8-20020a5d4248000000b002ceac976f51mr927213wrr.13.1681469022498; Fri, 14 Apr
 2023 03:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230414004455.19275-1-dipenp@nvidia.com> <373eacb8-be3f-6b95-3e08-f0ff36f79891@linaro.org>
In-Reply-To: <373eacb8-be3f-6b95-3e08-f0ff36f79891@linaro.org>
From:   Thierry Reding <thierry.reding@gmail.com>
Date:   Fri, 14 Apr 2023 12:43:31 +0200
Message-ID: <CA+PwDYeTkWp9vXMec99H2OKOGhx0mOrnthT08=JkMkEsi4NDPw@mail.gmail.com>
Subject: Re: [V6 0/9] Add Tegra234 HTE support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dipen Patel <dipenp@nvidia.com>, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, timestamp@lists.linux.dev,
        krzysztof.kozlowski+dt@linaro.org, brgl@bgdev.pl, corbet@lwn.net,
        gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 09:36:15AM +0200, Krzysztof Kozlowski wrote:
> On 14/04/2023 02:44, Dipen Patel wrote:
> > This patch series mainly adds support for the Tegra234 HTE provider. In
> > addition, it addresses dt binding comments which prompted code
> > changes in the existing HTE provider driver without breaking the
> > Tegra194 provider. The comments raised concern how existing code
> > retrieves gpio controller node
> > (the node is used to help namespace conversion between HTE and GPIOLIB).
> > To help simplify that process, new DT property is suggested which adds
> > gpio controller node in the HTE provider binding as phandle property. To
> > conlude this patch series:
> > - adds Tegra234 HTE provider
> > - modifies existing provider code to address new dt binding for Tegra234
> > without breaking it for the Tegra194 chip.
> >
> > The V1 patch series:
> > - Adds tegra Tegra234 HTE(timestamp) provider supports.
> > - Updates MAINTAINERS file for git tree, mail list fields.
> > - Updates devicetree and API documentations.
> > - Enables HTE subsystem, Tegra194 and Tegra234 HTE providers
> > by default in arm64 defconfig and dts files.
>
> All your emails miss PATCH prefix. Use `git format-patch` to generate
> proper versioned patch. Stripping important part messes up with our
> filters. We have quite a lot of emails, so proper filtering is important.

I used to get this wrong as well because I didn't know (or perhaps it
didn't exist yet at the time) --reroll-count|-v and used to manually
override --subject-prefix.

Thierry
