Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7861FA46
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiKGQp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiKGQpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:45:49 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5661EC7E;
        Mon,  7 Nov 2022 08:45:49 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13ae8117023so13285690fac.9;
        Mon, 07 Nov 2022 08:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LL6EKjyc/nV8owhc1hnShWucPSvisAZzkVS4VmjNis=;
        b=GJ6JgPBPTgmB/kUws9TIB2UdO7EEjK0qEh5snCBSj+J/xLDpgHi+tVKF8vt3Xdv6fJ
         IltY/ef29JJ2e7oWnK/YbOJdcMAfsH+B2KlDpNtXMNw6lBMlNCmWxFSJA3qbAxSiE8ja
         9W+WRi93XsvSO8WXvA1BFiuhCUxPqkmJQvu/ar7dH5+lBuhHYgk4hDVYpdl34E/K6Y3o
         XAT0OVJnCXqnOo3e7vAkPRycL00L6AYCGuflTnEYQkb5QHFHweDSfiLniPJfQsta+8xX
         s+0zaqgheCGb8n38N11+DIgN4uUcy0ojFMYN7rNtvqYLuN2E9yzMzmZkoaKlopG5R+Kz
         zZ0Q==
X-Gm-Message-State: ACrzQf079CxIuLuXADtjCY1/ebJMMbCcb0Usa/njct0ioOrMFJajzHxt
        PJZGPeGzACXlGXxOzVsGDg==
X-Google-Smtp-Source: AMsMyM7IXk1gyeleD7WKF7UQKxaVX8zNXKv0RqTqPZ16p2nvlqJt7Ccs+rJb9N0k696e2BoEhkKEWg==
X-Received: by 2002:a05:6870:9123:b0:13b:85a2:6995 with SMTP id o35-20020a056870912300b0013b85a26995mr31787068oae.122.1667839548487;
        Mon, 07 Nov 2022 08:45:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id en7-20020a056870078700b0013191fdeb9bsm3283619oab.38.2022.11.07.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:45:47 -0800 (PST)
Received: (nullmailer pid 1222990 invoked by uid 1000);
        Mon, 07 Nov 2022 16:45:49 -0000
Date:   Mon, 7 Nov 2022 10:45:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 02/13] dt-bindings: iio: temperature: ltc2983: add
 default values
Message-ID: <166783954944.1222932.12703505071568474375.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-3-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-3-demonsingur@gmail.com>
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


On Thu, 03 Nov 2022 15:00:30 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Binding properties should have default values to let the reader
> know if they should change it. Add them based on driver logic.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
