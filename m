Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03BFF74401B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjF3Qtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjF3Qtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:49:32 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5607D1BD0;
        Fri, 30 Jun 2023 09:49:31 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3459baa237bso9107515ab.3;
        Fri, 30 Jun 2023 09:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688143770; x=1690735770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFm+MwUTJ0Nrf5st/c0X4e2ak6wIZTxERF+a0wkzT1c=;
        b=EZ9vGeSgJuPE2tUkc1JAOJ1BvqGWz/a5IunxQIQHAXJ4xNxKS6VCy/De6dNyuJCkhF
         jCrSoOLIq3mVsO6VLHWa3osGoY4/XitxTQuIdQ7Ac/JI2QJsgiuZPdsB2PSEARqnDV10
         r25jHETDM7JMiPvfEc57UYIy+ZYE/5IXmCD27irJxfrDkcM8CugfH4Jcfl/zvlL9Pd0h
         DYGj8Yjh4DuSJ84NOUzUTxw2qlnkULXOsJ1qpXFlUsE7kDBReWEwLwxzayOR2qgb24XD
         owNlk2kJT+Nq24UeonjfzJYyNCosHQCleGwDpNKTkH9gnWHs76xq9wTZKOWONqW1ajz/
         /ByQ==
X-Gm-Message-State: AC+VfDw81jQsyB/cVK7cXPBf5q4yoCAyhDd+dnpXYC/gD+6B61RG5IFa
        bjqQ47EUPZy51hx2hdIFcaGGh7eDOQ==
X-Google-Smtp-Source: ACHHUZ7/4giS855SP320cWiO7+NFI00/wA7SRunbZLjvrL2Pjq26ubpM9I6uTDjHH7UIr0OG39MI8w==
X-Received: by 2002:a5d:94c3:0:b0:76c:71dc:55f3 with SMTP id y3-20020a5d94c3000000b0076c71dc55f3mr3486773ior.6.1688143770566;
        Fri, 30 Jun 2023 09:49:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k8-20020a02a708000000b0042aebaf294dsm2142602jam.146.2023.06.30.09.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 09:49:29 -0700 (PDT)
Received: (nullmailer pid 1887131 invoked by uid 1000);
        Fri, 30 Jun 2023 16:49:28 -0000
Date:   Fri, 30 Jun 2023 10:49:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@axis.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: leds: Read max-brightness from
 devicetree
Message-ID: <20230630164928.GA1884613-robh@kernel.org>
References: <20230630092248.4146169-1-astrid.rost@axis.com>
 <20230630092248.4146169-3-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630092248.4146169-3-astrid.rost@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 11:22:47AM +0200, Astrid Rost wrote:
> Add max-brightness in order to reduce the current on the connected LEDs.
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions. Note that led-max-microamp should be preferably used, if it
> is supported by the controller.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)

The patch order is wrong. You have to define a property before you can 
use it. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
