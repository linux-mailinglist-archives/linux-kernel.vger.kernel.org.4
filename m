Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEE760E9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiJZUGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbiJZUGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:06:07 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB739DD9B;
        Wed, 26 Oct 2022 13:05:47 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-13b103a3e5dso21738078fac.2;
        Wed, 26 Oct 2022 13:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8qncsC9xPu94G/T5fG+zgjmNukegSk/8gNgKQ5y1M0=;
        b=cyFqBu1mkDx7uEdn9zkCZOJovCzCl9KWa/WpUPzBapaBEH0s5XX/tPMyV3Ww7ivQ9D
         pyepfe5B3vBSoFwzcb74E1h03zZSCzJt0jX0VfZJqdlq8NBXUi9dymZ5Y/RbsZ544JY4
         a9VKl6x/zTXA0wYk7pdFJkb2iPIzsh+2OfvMf0HRHnHRNOL5DVnj0dvWoVXPxaeZiyB5
         3e2TJ5c+SNZmXGZTIM9KQ1b73qCbTaS3hFnWrBEjT1gorSX2LVWUN8F+V6hV46I54IH8
         EcpS0zGw31KJLOIXj2nK/fCpfO6yvajfYkDfPrdz8CYj2svKhruWP2KBAEAvhiPEp+FC
         A66w==
X-Gm-Message-State: ACrzQf2LZf8CKhtRVytLFs6Aun4cSGK9Y9Hr1z4f3IBYXOO79adbUaf9
        OYniBnWhfAkzP3CQApwWbw==
X-Google-Smtp-Source: AMsMyM70mglyRsxqAETtVdkw+wTL6ksgSKf2Ku8kFNVix9+hRc9gP3Y5EtRgcR4KDuQavTwAPufMGA==
X-Received: by 2002:a05:6870:f59e:b0:132:bcd:565f with SMTP id eh30-20020a056870f59e00b001320bcd565fmr3231569oab.254.1666814746869;
        Wed, 26 Oct 2022 13:05:46 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y18-20020a056870429200b0010c727a3c79sm3665071oah.26.2022.10.26.13.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:05:46 -0700 (PDT)
Received: (nullmailer pid 1077392 invoked by uid 1000);
        Wed, 26 Oct 2022 20:05:47 -0000
Date:   Wed, 26 Oct 2022 15:05:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: iio: temperature: ltc2983: support
 more parts
Message-ID: <166681474700.1077088.13998072512445461947.robh@kernel.org>
References: <20221025081842.1896748-1-demonsingur@gmail.com>
 <20221025081842.1896748-4-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025081842.1896748-4-demonsingur@gmail.com>
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

On Tue, 25 Oct 2022 11:18:41 +0300, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Add support for the following parts:
>  * LTC2984
>  * LTC2986
>  * LTM2985
> 
> The LTC2984 is a variant of the LTC2983 with EEPROM.
> The LTC2986 is a variant of the LTC2983 with only 10 channels,
> EEPROM and support for active analog temperature sensors.
> The LTM2985 is software-compatible with the LTC2986.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml | 59 +++++++++++++++++--
>  1 file changed, 55 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
