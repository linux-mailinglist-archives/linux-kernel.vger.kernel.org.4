Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB66166BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBP7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiKBP7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:59:02 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D872C10D;
        Wed,  2 Nov 2022 08:58:53 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13be3ef361dso20733800fac.12;
        Wed, 02 Nov 2022 08:58:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ez/PUmxuGl+IVYCmGsAHMErXKfYZDRw77P5pQjGih6E=;
        b=Op7RsqIXO3Lms8ir+A8H+fkH+3q46Tl975rMwj6Thk9cNIObifNb6V9l5cVMwQ3nsz
         5qm6/ucx18pNRq4NC7t2TBXFpgY1NktUnQ//RUkKQRTMfxP6rSifYmNA4Pna/usYX3jJ
         4kHrX1v4+aHBoA0CtqKJpxxE9VTs6bMOZ+52TcLkrD93bDdbkvtuUZsA0WslZgQZCprn
         zxgFK8eI4KWURtZJ9FNB+KwoYFoLmwj5VqMhuzYtZvVyJRX6Wlg3KcHt5y7vYx+oTZBG
         X8KnWuBJHkocLWNf01NZzzAiRVwvAAbzDpO9hrgJjfP1oMY19vp5Byx3Tn9dlJCB6Ky1
         SFpA==
X-Gm-Message-State: ACrzQf18BaEy7I3L5clv6pc+N+pgMbuu8o8G2qfYr0E/tUkZzHxW2wOU
        5uhrWOVP+5lWG9TrNgPmyA==
X-Google-Smtp-Source: AMsMyM7Cat8+KWNK0HaiBdycxJtsHwnuu9t7VFB0U/JjOYUIOzmhQBXhCzRIJt93pNXJsfBEB2T3MQ==
X-Received: by 2002:a05:6870:f61a:b0:132:49:bd11 with SMTP id ek26-20020a056870f61a00b001320049bd11mr23712739oab.228.1667404732368;
        Wed, 02 Nov 2022 08:58:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h15-20020a9d6f8f000000b00665919f7823sm5132944otq.8.2022.11.02.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:58:51 -0700 (PDT)
Received: (nullmailer pid 3970254 invoked by uid 1000);
        Wed, 02 Nov 2022 15:58:53 -0000
Date:   Wed, 2 Nov 2022 10:58:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     linux-kernel@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: iio: accel: Add docs for ADXL359
Message-ID: <166740473228.3970163.15922622826176609739.robh@kernel.org>
References: <20221031105129.47740-1-ramona.bolboaca@analog.com>
 <20221031105129.47740-3-ramona.bolboaca@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031105129.47740-3-ramona.bolboaca@analog.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 12:51:28 +0200, Ramona Bolboaca wrote:
> Update ADXL355 existing documentation with documentation
> for ADXL359 device.
> 
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
> ---
> changes in v2:
>  - Added missing spaces in subject
>  - Changed Accelerometer to Accelerometers
>  - Fixed dedvice typo in commit message
>  .../devicetree/bindings/iio/accel/adi,adxl355.yaml        | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
