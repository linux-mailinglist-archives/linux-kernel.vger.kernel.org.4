Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA6161FA66
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiKGQtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiKGQtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:49:23 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AE326C0;
        Mon,  7 Nov 2022 08:49:22 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-13b103a3e5dso13328625fac.2;
        Mon, 07 Nov 2022 08:49:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v1FcMI1W1SmjGd6XaKTb3qum+fvKXRGAq/VvqZlFrQA=;
        b=u5LnBl+PDsgLTS/S9gJgyuTMu+pdYVLmJ/mcVBtyErRK7PsHNT/QWVRbVc1G7TpSk+
         spoamPE1ewjgNBe3Sq9/cOt2O2uLzFl8E26uFguMfixA+NUgkJ9VUnnEaoylWTwJLKxw
         KiUu8Q8drrjxnXV+/+YEdVm83GPuP5nZF8uH3TYzBK9/iXEoCvJ/daFm9sJEbrqiB3Wi
         jdPEnNdFneV9VipQgzQvNxgrGQLMNBle4qNz9kWp1VrPUyrHtmllyTH0GNtkLlOreX9Y
         u7lroNEoB0bbFZIAVfmxNIkY0vMT0t9qd6XdVkTQrkaNpkRCbfefw7h7s9z/SuCjZsQo
         bC7g==
X-Gm-Message-State: ACrzQf24KBZ0OkX6i3PQaUw2SUjro7W8u5cpfZyqY/tQnNVDSdBuyYTC
        d2481xBRxTKTb4Ts04CBLSAejrTfBQ==
X-Google-Smtp-Source: AMsMyM5DjhlpJkvZyaM7G3cFffKZbudMLPbI0U81vPVl5CJJj5610WawN3LRm7B+pn//4POpQb0+5w==
X-Received: by 2002:a05:6870:c34e:b0:13c:19bc:6e41 with SMTP id e14-20020a056870c34e00b0013c19bc6e41mr40827690oak.115.1667839761702;
        Mon, 07 Nov 2022 08:49:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d5c87000000b0066c495a651dsm3089170oti.38.2022.11.07.08.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:49:21 -0800 (PST)
Received: (nullmailer pid 1226841 invoked by uid 1000);
        Mon, 07 Nov 2022 16:49:23 -0000
Date:   Mon, 7 Nov 2022 10:49:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v4 03/13] dt-bindings: iio: temperature: ltc2983: use hex
 for sensor address
Message-ID: <166783976258.1226785.14051502096301320224.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-4-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-4-demonsingur@gmail.com>
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


On Thu, 03 Nov 2022 15:00:31 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Addresses should be in hex, fix it.
> 
> Although the driver initially specified 1-20, it can be made free-range
> since the address is supposed to match reg, onto which we can impose
> restrictions based on the compatible property value.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
