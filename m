Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3785B6C91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiIMLuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiIMLub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:50:31 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845B8AE71;
        Tue, 13 Sep 2022 04:50:30 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1274ec87ad5so31435291fac.0;
        Tue, 13 Sep 2022 04:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RcNQKqDpWZMHBl7FH++fUVwcpF5gBAwTAU2VtaJ7zk8=;
        b=QJFBliYmUkwCH5zXl81puN4P05lgDQq8s3NM5DFZVfjiAa4MeiobqSeT6RIZ21mYex
         2dMV4DWDML/6V05XdvaMbJ8hvS/bZSo05iIrQ8GXGFgCftPk/3AW9uEdA7sJRR9sJkGm
         d9F/cloq6c/drzpQmHruqJq2tG0yZ+jXbXwqyn2KXxEP2J54vsoTZhMoJwTQYBTOZH9h
         aaJWYAy0qYK0XYlxiScOKN8GD6wArivkejzouz179zVJWZezX38iF90j9Noax1hbMMBj
         zmsRchsiIfEnZbOGtnWRafDKcP+XdQUDm+tQcAahpdYIm+6Rll7IatEhhOxiEZnXH3xD
         F9wg==
X-Gm-Message-State: ACgBeo3dZzaFf885U7hi17jbcs461QyYyGSPS2UpxZKO1dKLFaSxowrR
        oUrbz1RgqIGyhpK21UPvyg==
X-Google-Smtp-Source: AA6agR5zbDzHhyyW8Ff1pQzgfFa2xGYLn9YbuydKW6sTC1re97ECIjGyY2S+XSe0oTgnBt0uMcVajA==
X-Received: by 2002:a05:6808:130e:b0:345:5de2:1095 with SMTP id y14-20020a056808130e00b003455de21095mr1258365oiv.130.1663069829764;
        Tue, 13 Sep 2022 04:50:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j83-20020acab956000000b00334c2e81dfbsm5126821oif.0.2022.09.13.04.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:50:29 -0700 (PDT)
Received: (nullmailer pid 3377303 invoked by uid 1000);
        Tue, 13 Sep 2022 11:50:28 -0000
Date:   Tue, 13 Sep 2022 06:50:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     linux-hwmon@vger.kernel.org, rtanwar@maxlinear.com,
        jonnyc@amazon.com, robh+dt@kernel.org, jdelvare@suse.com,
        devicetree@vger.kernel.org, linux@roeck-us.net,
        p.zabel@pengutronix.de, hhhawa@amazon.com,
        andriy.shevchenko@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/21] dt-bindings: hwmon: (mr75203) add
 "moortec,vm-pre-scaler-x2" property
Message-ID: <20220913115028.GA3377242-robh@kernel.org>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-14-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-14-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2022 15:24:41 +0000, Eliav Farber wrote:
> Add support for mr76006 pre-scaler which provides divide-by-2 scaling of
> the input voltage, so that it can be  presented to the VM for measurement
> within its range (the VM input range is limited to -0.1V to 1V).
> 
> The new "moortec,vm-pre-scaler-x2" property lists the channels that use
> the mr76006 pre-scaler.
> 
> The driver will use this list to multiply the voltage result by 2, to
> present to the user with the actual voltage input source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V4 -> V3:
> - Rename "moortec,vm-pre-scaler" to "moortec,vm-pre-scaler-x2".
> - Added mximum number if items in description.
> 
> V3 -> V2:
> - Add "moortec" prefix to property name.
> - Change property format to be a single u8 array.
> - Fix typo: scalar --> scaler.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
