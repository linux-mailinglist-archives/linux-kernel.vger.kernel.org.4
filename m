Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A98616A4F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiKBROj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKBRON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:14:13 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF925E99;
        Wed,  2 Nov 2022 10:14:07 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id y67so19886168oiy.1;
        Wed, 02 Nov 2022 10:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTIZIOjl8oF+5s5jwaijQ6Kthz0JlQiH4L1lxXq0VtA=;
        b=ihFX8qtC3EN5GYG1oHt6iJaQK4EC+rid4vMWu3uZdgeh43xVD1S+10sZCLDwPe02sA
         J4KsHqjluFn+4XHOv+zPA8k7PM17MvE0OgErRHRM6TJYok4uZvK1zIHdN9oEA6dMjdLz
         HnkzWbyqqc2osYE0a/YEo8r37yaeHAq34EfOPv0itlWn2JjKUYENdZwMsQDo1A2t4c3g
         9nKjroQJrP/3toV+n9h3J02Y0YpPR437zOzPw6BPzIscoGhiBTYB+ALtC/v7mWImXTwU
         FxBgYWNICEe5ZqBiq2krfg66C9Ch7cMd0Oj4d2YrsNgj4nDSiLc5mMHGmDUww9+pzePm
         e+cg==
X-Gm-Message-State: ACrzQf1DpioM3MUGpX/ztQ7b3iUMqr9MRi+X4AOc6SU/y3mSRhrun5jQ
        8jVh270P5d7iw4qXxsazWA==
X-Google-Smtp-Source: AMsMyM48p193/o2iDWjqe7mgVtGRjDXeBC3cmuZcEgnEuSbO7vYriIpF7gBPOO01bKgUQlv33gHJww==
X-Received: by 2002:aca:6007:0:b0:35a:1bda:d213 with SMTP id u7-20020aca6007000000b0035a1bdad213mr7581750oib.181.1667409247069;
        Wed, 02 Nov 2022 10:14:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l25-20020a4acf19000000b0044b125e5dabsm4655265oos.35.2022.11.02.10.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 10:14:06 -0700 (PDT)
Received: (nullmailer pid 4138810 invoked by uid 1000);
        Wed, 02 Nov 2022 17:14:08 -0000
Date:   Wed, 2 Nov 2022 12:14:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     samuel@sholland.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, hverkuil-cisco@xs4all.nl,
        wens@csie.org, mchehab@kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 1/3] media: dt-bindings: media: Add Allwinner H6
 Deinterlace binding
Message-ID: <166740924781.4138628.17832140187371545203.robh@kernel.org>
References: <20221101123201.3021129-1-jernej.skrabec@gmail.com>
 <20221101123201.3021129-2-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101123201.3021129-2-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 01 Nov 2022 13:31:59 +0100, Jernej Skrabec wrote:
> Allwinner H6 Deinterlace core is used for deinterlacing interlaced video
> content.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../allwinner,sun50i-h6-deinterlace.yaml      | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/allwinner,sun50i-h6-deinterlace.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
