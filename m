Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAFC5F6EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiJFUIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiJFUIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:08:46 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2ABF8;
        Thu,  6 Oct 2022 13:08:44 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-12c8312131fso3467456fac.4;
        Thu, 06 Oct 2022 13:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8F5207qKWTdErH9oHBWKoYirrR+W+bJ9Qiy7Wsdnr0=;
        b=uJYPgxs8oVM5qXhwONEblEui4r+5zag9eWQdAt4UA2vOTcvVSIdNpZGK7fmtuMvNWq
         OTkQ/mllKVEhAkvs/ytE4pPD0jsN69OTJP3H9+F7n+lEZEbUerdU/BlRrnOD4VZhZybo
         ZcvB/ait/VZe3fApsJNYomtkOvb6ee7zIeREbcCXInoJn3L3M5qajWnU86BrzLVdmtnA
         sivRGgpFtYOEE4jRJv5UtfRdAYQIoVbCWwRGjvdNnbEqfjvcpcyCmPsGKW42MCcKQ5N2
         Lr3USdFhsukuNFgq9ad9y+QpwkLpvst7Zijep0QDD9qmiL9npQhaIQV/5v2kqqUaeqxc
         ItFg==
X-Gm-Message-State: ACrzQf0WcS1pR8hnntn/VfVbYLfz3pX1nowKguYuFfDSfNkcrjKdIe1z
        WNni9JIST7Ixq2iASBE2cQ==
X-Google-Smtp-Source: AMsMyM5/X6guZDh/yiFZK1QItP5Pl1xGZJ2HG/voT2jGeJqQrE4zzY0wAuDa5/TYRIENEmIuKGO09Q==
X-Received: by 2002:a05:6870:958b:b0:132:f094:fc99 with SMTP id k11-20020a056870958b00b00132f094fc99mr791213oao.112.1665086924183;
        Thu, 06 Oct 2022 13:08:44 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id x4-20020a056870434400b00132cf083105sm295062oah.7.2022.10.06.13.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:08:43 -0700 (PDT)
Received: (nullmailer pid 90139 invoked by uid 1000);
        Thu, 06 Oct 2022 20:08:39 -0000
Date:   Thu, 6 Oct 2022 15:08:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, dianders@chromium.org,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 3/4] dt-bindings: input: touchscreen: Add goodix
 GT7986U touchscreen chip
Message-ID: <166508689161.89649.5155955593934499402.robh@kernel.org>
References: <20221006105823.532336-1-sheng-liang.pan@quanta.corp-partner.google.com>
 <20221006185333.v7.3.I52e4b4b20e2eb0ae20f2a9bb198aa6410f04cf16@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006185333.v7.3.I52e4b4b20e2eb0ae20f2a9bb198aa6410f04cf16@changeid>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 18:58:22 +0800, Sheng-Liang Pan wrote:
> Add an goodix touch screen chip GT7986U.
> 
> Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
> ---
> 
> Changes in v7:
> - goodix gt7986 dt bindings added in v7
> 
>  Documentation/devicetree/bindings/input/goodix,gt7375p.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
