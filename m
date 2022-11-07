Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BB361FD02
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbiKGSNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiKGSMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:12:40 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34AD27CF3;
        Mon,  7 Nov 2022 10:11:16 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id f4-20020a056830264400b0066c8e56828aso5296816otu.1;
        Mon, 07 Nov 2022 10:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0D6OVZD+rAPMP/hoh0bQusyWB1khk2iGM0R5V/xmNp8=;
        b=WEJh3EcLIqjrq0obrfMddmNRCLa2Lwcy8acRwE7lkDSboT3KOQpsK7obTKh91NmOHY
         aY/9jzw780laCauMQFkSgPf5AEHbPt2pZnXPy/hp1lXVZ7RVfTxCjG3/UblN/WsDq/vJ
         ypG2Rc+mfRy+gNDIL5um4TtEyom/IkWpbyBg0La+3O/n9NpZJMmWrFX6oJDn2h+FsXCa
         AzmJqVnOU4tFeHTYpJlzO85adjdYZgK/hInK02kEWVMm8wwpvHzIXqourC0pN/IWIhjW
         Uy7gqmv4wGwG40KO1WuTnvleXmvo4gc5zwELVfEP8CrpxWBbLvfn8lofBt24wNgRtkQl
         JEsw==
X-Gm-Message-State: ANoB5pmKd0xIfr4y3x0TijG6JFhjhuhFwSR7tdgBESIP1bBDmWf0+VVe
        eroeeNZgZ9tcnCw/XRGe7A==
X-Google-Smtp-Source: AA0mqf5nHAp98AhScX8C1mpbn4jbE9ZM7lRdvCtv3X/Tkj5j0eJpBHjPGhLgkjp4BgSK7Is8vFsCDA==
X-Received: by 2002:a9d:62cb:0:b0:66c:e6c9:8704 with SMTP id z11-20020a9d62cb000000b0066ce6c98704mr3274349otk.61.1667844675752;
        Mon, 07 Nov 2022 10:11:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x12-20020a05683000cc00b0065c2c46077dsm3163833oto.67.2022.11.07.10.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:11:15 -0800 (PST)
Received: (nullmailer pid 1353624 invoked by uid 1000);
        Mon, 07 Nov 2022 18:11:17 -0000
Date:   Mon, 7 Nov 2022 12:11:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 10/13] dt-bindings: iio: temperature: ltc2983:
 describe broken mux delay property
Message-ID: <166784467673.1353361.2438556555715268552.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-11-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-11-demonsingur@gmail.com>
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


On Thu, 03 Nov 2022 15:00:38 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> The 'adi,mux-delay-config-us' property is broken. It was supposed to
> be in us, but the value is actually written directly to the register.
> Describe the fact that it is broken and how it actually works.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
