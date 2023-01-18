Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD25D6723FE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjARQsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjARQsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:48:40 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC089303F9;
        Wed, 18 Jan 2023 08:48:37 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-15f64f2791dso5783524fac.7;
        Wed, 18 Jan 2023 08:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxaC/+vj0+0cmZsvPmWAUPTa0igCb7E0vBb71/KtRnM=;
        b=LK/ZJ/9TwSnXclLORbG1KImadD5WQutaOqYLdyv612o9daaFIql0N+GYvMubo9TVDT
         78Cs+qqYHEm3HNUmKL6iNeOjDnV5xSjfoVnHfCITcoFyXkaxPzoPrtgEUWBUrS4id8NK
         Uaca3M+4mlRHTmPor4IcWnEMz3U/nS+Mn2VSOAbhb2AixhbqJKduI9/fiWUqFKBtPHh4
         YSL6DwM4FwsgUGc8KUHtWbaXfJVCds5hPSUoeLro3sxt+2H4Dpv9r/FMFKREwkpWyPJx
         6Mky9OyQzlY5bDA8hohYBiKycALZLIZNb4iYLDbDno+aiSXFwUa3ZL0yGToZ32FGRGY4
         wHww==
X-Gm-Message-State: AFqh2kozCKh2EUFIcAoRBC0Zt+xvOhWjYJcjOvraSA61St58rGMLjJXU
        S+0lSOkyvpyiyCPCPbeMAA==
X-Google-Smtp-Source: AMrXdXspzsuKKi9p1SkaPBh1bqyhnNkFKbA/1xoHvQifmJAODs5ghXonjK8iX+dUNoevRqaM1aT+Ag==
X-Received: by 2002:a05:6871:430e:b0:155:37ac:d907 with SMTP id lu14-20020a056871430e00b0015537acd907mr3681620oab.18.1674060517072;
        Wed, 18 Jan 2023 08:48:37 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id q187-20020a4a4bc4000000b004a3c359fdaesm16818498ooa.30.2023.01.18.08.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 08:48:36 -0800 (PST)
Received: (nullmailer pid 147773 invoked by uid 1000);
        Wed, 18 Jan 2023 16:48:35 -0000
Date:   Wed, 18 Jan 2023 10:48:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chester Lin <clin@suse.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Andrei Stefanescu <andrei.stefanescu@nxp.com>,
        Larisa Grigore <larisa.grigore@nxp.com>,
        Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>,
        linux-gpio@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        s32@nxp.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: add schema for NXP S32 SoCs
Message-ID: <167406051498.147713.15394591575288533598.robh@kernel.org>
References: <20230118094728.3814-1-clin@suse.com>
 <20230118094728.3814-2-clin@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118094728.3814-2-clin@suse.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Jan 2023 17:47:26 +0800, Chester Lin wrote:
> Add DT schema for the pinctrl driver of NXP S32 SoC family.
> 
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@oss.nxp.com>
> Signed-off-by: Chester Lin <clin@suse.com>
> ---
> 
> Changes in v4:
> - Change the representation of available slew-rate DT values from register
>   values to real frequencies.
> 
>  .../pinctrl/nxp,s32g2-siul2-pinctrl.yaml      | 123 ++++++++++++++++++
>  1 file changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nxp,s32g2-siul2-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
