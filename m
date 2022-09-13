Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96FE5B6C82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiIMLrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiIMLrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:47:48 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644A81DA61;
        Tue, 13 Sep 2022 04:47:46 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1278624b7c4so31372866fac.5;
        Tue, 13 Sep 2022 04:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=zwSnmmW9c+Ts7krnQsWbtT17568s5+nJLz8Ng8pC+7M=;
        b=KnvVbvnw7bZqn+1VbUVVHCV7flOiFfpmjGDNFieRuYRtTa7ZdQm1QK9XdLfYj41RTV
         iLEN2GkuLWq5P4nj2G6wIGyM8J7x4TVyBsuprWe6mBiOFoouY7C1ZGsosbFljKTq3r71
         iF3qRlaf6nTEdQKAJuATvDCTEqQuuAaoinXRjK4MjfwaUmB8VyDd6aSBDj11U/wnAZct
         gjH+3SAgWzOwK/r9+qUbOxhuoIE3reczW+zmHY5PTFJ/1OOsYPvesGmd3lk6wq05Bczk
         aNqDT8IQnCCYpqhMMmJQZOOK9WmKbzsnJs0DZOhdRavAkayxFZPbLv7dvDAMQR2RevPQ
         pLKA==
X-Gm-Message-State: ACgBeo1Un0L7BcF50vlvLIiL+BU+dznQvVFXBXAGCamPFvN+6pirr6ew
        deGgVBocijNvw4EKHd5Y4FnufHEzpA==
X-Google-Smtp-Source: AA6agR7Gcws0NSAaNookEqV9I1SSNF45SQkEm0rrdw2P+fUg+cLmMKTf9SWyA2fPZBvuW+razReVVw==
X-Received: by 2002:a05:6870:8982:b0:12b:49eb:887d with SMTP id f2-20020a056870898200b0012b49eb887dmr1626012oaq.278.1663069665611;
        Tue, 13 Sep 2022 04:47:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c18-20020a4ac312000000b00435ae9a836asm5375818ooq.15.2022.09.13.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:47:45 -0700 (PDT)
Received: (nullmailer pid 3373559 invoked by uid 1000);
        Tue, 13 Sep 2022 11:47:44 -0000
Date:   Tue, 13 Sep 2022 06:47:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        hhhawa@amazon.com, p.zabel@pengutronix.de,
        andriy.shevchenko@intel.com, jdelvare@suse.com,
        rtanwar@maxlinear.com, devicetree@vger.kernel.org,
        jonnyc@amazon.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 10/21] dt-bindings: vendor-prefixes: add vendor prefix
 for Moortec
Message-ID: <20220913114744.GA3373508-robh@kernel.org>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-11-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-11-farbere@amazon.com>
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

On Thu, 08 Sep 2022 15:24:38 +0000, Eliav Farber wrote:
> Add device-tree vendor prefix for Moortec Semiconductor Ltd.
> Website: https://moortec.com/
> 
> Moortec were acquired by Synopsys so link above leads to:
> https://www.synopsys.com/solutions/silicon-lifecycle-management.html
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V4 -> V3:
> - New patch to add moortec to vendor-prefixes.
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
