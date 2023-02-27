Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B93C6A4DF4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjB0WXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjB0WXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:23:12 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6508615C9E;
        Mon, 27 Feb 2023 14:23:11 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-17227cba608so9040263fac.3;
        Mon, 27 Feb 2023 14:23:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGidbQmDp0y8QHK1i8MQiE3zuAGUVCeiQUrW3n/jLQA=;
        b=F/woyTEOr8uPklHdwhH6MWNcTNFHV0rc6KZ6t/RVkEthvUE+Ei0mbXdnS8xLgw09zZ
         H2i3FIgzFoMhBrKWlmk0A9Kdm1SaRnepXQsPTVZmro0fBeOUOETaH0+JufrVjaFx0JUA
         rL1X2TildnJqetin/ouyEnJ/hEdqQKtalhWKZuh+5kAnXXF/wGEiAuoQjyDayfOBHK0R
         yOhIjOB4cTn8Kd5AHzAV6FrbYR26Lkf4TImGo0wn6JR52KID4XbPFMFDlKWzhry5mBV1
         5LhFKYvMMugED1q0uje61PAwKIeuKqgpgLoGcAX5s1PVgKLdK4/HbWwMg98ob+eQm4Vj
         8iXA==
X-Gm-Message-State: AO0yUKXXD8NppjFac+A3Pubu05rwNZ7G/y/WK4WOgNL9W+U0M8hgKiYP
        obM3j5IQMq/ltI/3drWvti9Hk37e/g==
X-Google-Smtp-Source: AK7set/Usgaz2hjzp8Gr6Ihin9hinyRkpzjsT99cLWKoo13twDWuN7/AAI9t8LMvnbIpKemlE0N/Pw==
X-Received: by 2002:a05:6870:588a:b0:16d:ba05:23a7 with SMTP id be10-20020a056870588a00b0016dba0523a7mr232309oab.26.1677536590586;
        Mon, 27 Feb 2023 14:23:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 66-20020a9d04c8000000b0068663820588sm3170854otm.44.2023.02.27.14.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 14:23:10 -0800 (PST)
Received: (nullmailer pid 1207434 invoked by uid 1000);
        Mon, 27 Feb 2023 22:23:09 -0000
Date:   Mon, 27 Feb 2023 16:23:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     Sven Peter <sven@svenpeter.dev>, Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <asahi@lists.linux.dev>, Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] dt-bindings: input: touchscreen: Add Z2
 controller bindings.
Message-ID: <20230227222309.GB1048218-robh@kernel.org>
References: <20230223-z2-for-ml-v1-0-028f2b85dc15@gmail.com>
 <20230223-z2-for-ml-v1-1-028f2b85dc15@gmail.com>
 <e26318db-77b1-4876-8a40-f707d11b5857@app.fastmail.com>
 <CAMT+MTQ0bZiGpEFK9w3zncB-ZcCLY_tp1d5Wc0MJUMjWqc61jA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMT+MTQ0bZiGpEFK9w3zncB-ZcCLY_tp1d5Wc0MJUMjWqc61jA@mail.gmail.com>
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

On Fri, Feb 24, 2023 at 12:08:42PM +0100, Sasha Finkelstein wrote:
> On Fri, 24 Feb 2023 at 12:04, Sven Peter <sven@svenpeter.dev> wrote:
> > Now that I thought about this again after the brief discussion we already had:
> > Do we even need to specify the device name? Is there any reason we can't just
> > always use something like "Apple Z2 TouchBar"?
> A similar protocol is used for primary touchscreen on idevices, which

Similar? So close, but somehow different.

> need different
> userspace handling. This is to make the driver potentially useful for
> people who run
> linux on checkra1n-able devices.

It is sounding to me like you need different compatibles. Don't try to 
parameterize the differences with properties. Unless you can define all 
the differences up front (hint: you can't).

Rob
