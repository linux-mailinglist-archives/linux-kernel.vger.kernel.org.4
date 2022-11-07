Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7061FA98
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiKGQyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiKGQyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:54:02 -0500
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270281B1DE;
        Mon,  7 Nov 2022 08:53:59 -0800 (PST)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13be3ef361dso13287336fac.12;
        Mon, 07 Nov 2022 08:53:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PcP8wC7lb5ag85bvZs+rYndJyQLHPkyds3DxDsQNOc=;
        b=DE7gh0cWiKRGtTkbFvRD7OP8dmx8xfH2e0PfKKCJp75HpXW0SifI8kPWufctauQUNd
         nC4ILka48G4Ausj5VluP4ei8K+6uPD/v9hZYOEVx9taT4nrCTCjb44rvSFpCFBYtrThP
         p60k/v/1VnvvVx7yerUHZDNtY5cbdv5aUSK2tVEU47narkjIWbzbhyomZdk8Bcm3pg9u
         kjckT+YtJw9ltyBIpnmbJV/eGbJBfpMdabvE2dEQKlBSDvIhY7ckgA57GJ1iqa8oKZ+1
         URB6QK6HEVWlmkshA7VeKm5oxz/j7A3o4Z1sjQgVtWd1sG2jYQbRu4SLXeBwmXwGxcvm
         gmyA==
X-Gm-Message-State: ACrzQf29cRoZMl9/f6wDbyulZ/0yVlskWbCsFWEuD2O1C2RUhZa7rG8v
        3X9UvqQ19nMAjj1vRB0bG3otYzNvsw==
X-Google-Smtp-Source: AMsMyM5TZkLd6F+o2p7/Lwc56E/Qc2MgZFrunv0JFh+6G/BRXz4sInHxVmUkPArq6yQ0Q0dHUZ9gSA==
X-Received: by 2002:a05:6870:96ab:b0:13b:8fb9:47a with SMTP id o43-20020a05687096ab00b0013b8fb9047amr39251897oaq.15.1667840038904;
        Mon, 07 Nov 2022 08:53:58 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v26-20020a4ac91a000000b0049e9a80c690sm2374793ooq.1.2022.11.07.08.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:53:58 -0800 (PST)
Received: (nullmailer pid 1231990 invoked by uid 1000);
        Mon, 07 Nov 2022 16:54:00 -0000
Date:   Mon, 7 Nov 2022 10:54:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v4 06/13] dt-bindings: iio: temperature: ltc2983: require
 custom sensor tables
Message-ID: <166784003974.1231935.5638789744921485795.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-7-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-7-demonsingur@gmail.com>
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


On Thu, 03 Nov 2022 15:00:34 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> The driver will error out when a custom sensor type is used but a
> custom sensor table is not provided. Require it in the binding too.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
