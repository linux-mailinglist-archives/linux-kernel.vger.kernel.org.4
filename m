Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE8697250
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 01:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjBOAAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 19:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbjBNX7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:59:44 -0500
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607CC2CFC8;
        Tue, 14 Feb 2023 15:59:43 -0800 (PST)
Received: by mail-il1-f175.google.com with SMTP id i26so561578ila.11;
        Tue, 14 Feb 2023 15:59:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47c8N65+bA0va12esEad9F+wfY0jNc6/6f/7s5GMhO8=;
        b=AvH1VDkyHiH7A+NPzt1aag7xLpOhIfBS3fYkWDbWXoT6fpwxrdelCga1NXfFv2kbNH
         0/82DWQerVdabVyx5lbyI6GoSEhXXs5fCVu6ri2LKVg9myaMxF6IOj5Tu3LwPrVcfCD+
         +nchQYwZSLi5dc8UMegqxOp68PLJ3IQypQe8FLi7sU6VsfC9A5ov1QZN/vJbAv84uDyU
         8Jb0+RORkuVvLlayrCIdxGiwYdC0cKIs6nHRxCiTziXDK4W9iwAToQmMqOVMJn4xu4YF
         tId8opJ1SUCcVS0jVfgF0OVI7wTb80NJmgBcGevIl6LyMbPFK4t/aEf1Wr361FF8pGbx
         LGBQ==
X-Gm-Message-State: AO0yUKUOoS5am2yvvpOZGAgNKmfe+laX9q7DB6bHZHEKyNlSECBiW9XS
        Ys+LS5q+leZPufEj0SbJFw==
X-Google-Smtp-Source: AK7set+XH9b8ktNsasvbgIJRBQmFqKfQdWRX5JLUyb8R3zB6ZuA6Qqi0YDWXX0Dbqs+2khFXzLwNVQ==
X-Received: by 2002:a05:6e02:b2f:b0:302:a58f:38ab with SMTP id e15-20020a056e020b2f00b00302a58f38abmr527073ilu.0.1676419182555;
        Tue, 14 Feb 2023 15:59:42 -0800 (PST)
Received: from robh_at_kernel.org ([65.158.198.6])
        by smtp.gmail.com with ESMTPSA id g15-20020a92dd8f000000b00313f2279f06sm5044113iln.73.2023.02.14.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:59:42 -0800 (PST)
Received: (nullmailer pid 59144 invoked by uid 1000);
        Tue, 14 Feb 2023 23:59:40 -0000
Date:   Tue, 14 Feb 2023 17:59:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-media@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] media: dt-bindings: st,stm32-cec: drop obsolete file
Message-ID: <167641913806.58082.2803069837642065032.robh@kernel.org>
References: <20230211124540.71208-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211124540.71208-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Feb 2023 13:45:40 +0100, Krzysztof Kozlowski wrote:
> The st,stm32-cec.yaml was moved to media/cec directory, however the
> "remove" part disappeared during applying.
> 
> Fixes: 8f43766211af ("media: dt-bindings: st,stm32-cec: move to cec subfolder")
> Link: https://lore.kernel.org/all/20221208103115.25512-3-krzysztof.kozlowski@linaro.org/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/media/st,stm32-cec.yaml          | 53 -------------------
>  1 file changed, 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/st,stm32-cec.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>

