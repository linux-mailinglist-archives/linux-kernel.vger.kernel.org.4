Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878C561FCEE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiKGSKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiKGSKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:10:30 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459C2BC8;
        Mon,  7 Nov 2022 10:08:08 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id n205so1914044oib.1;
        Mon, 07 Nov 2022 10:08:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2fAwzmrkHSP0Y+WfKfQdu7RYOEhg49XbOCTpdKi2Co=;
        b=5brPM52RkGut4K2jXQ01Bt6DmnvlLNnXdkCeyxRtHBOLccGiflQCllwiT3cb4QkGw8
         sBrZHn985xTTxyQPzCrMUW1BATs3rg4aLG/FKGGNVylZlF4IAPMAnFs/SDQ3X56upRsW
         DUYZWceOZfflX4T/TAfMBvNyn5BUQP/p+ADU8cir16d03YeB49H+FguawL9MhYzXJQ+o
         XUqtoprOYa2mtYfyn6iXbemJOAzoz6bTKv4l50vW9V0oPQGiBKC41UeVgLlb0yLSBeIh
         A8Glh25jvh2jrX5zgGDsHIAyjS42qIlB1Vg1/ArLS9JvuhvL2s94Rt5wsIhvU6lXdex3
         LURw==
X-Gm-Message-State: ACrzQf0mffcFKKdr/Lj+dcj/P4MLkiq8cETHjtZhv36yXdVty5W35e78
        Cire+8JrzythInllmq/rvl7igvioNA==
X-Google-Smtp-Source: AMsMyM5C0EVui3Rxf5LKhczxtVBOV+fkU6/wnetbywNsyVf6MG6toKebB33pQil+DrTuj8zDG1CzQQ==
X-Received: by 2002:a05:6808:1248:b0:354:2c04:c35b with SMTP id o8-20020a056808124800b003542c04c35bmr34693365oiv.143.1667844488069;
        Mon, 07 Nov 2022 10:08:08 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cm5-20020a056870b60500b0010d7242b623sm3415585oab.21.2022.11.07.10.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:08:07 -0800 (PST)
Received: (nullmailer pid 1316731 invoked by uid 1000);
        Mon, 07 Nov 2022 18:08:09 -0000
Date:   Mon, 7 Nov 2022 12:08:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH v4 08/13] dt-bindings: iio: temperature: ltc2983: change
 default excitation for custom thermistors
Message-ID: <166784448804.1315737.13515754745039297465.robh@kernel.org>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
 <20221103130041.2153295-9-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103130041.2153295-9-demonsingur@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 03 Nov 2022 15:00:36 +0200, Cosmin Tanislav wrote:
> From: Cosmin Tanislav <cosmin.tanislav@analog.com>
> 
> Excitation cannot be set to auto-range when using a custom thermistor
> or Steinhart sensor type. Default it to 1000nA to match the driver
> and remove the auto-range value from the enum.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/temperature/adi,ltc2983.yaml          | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
