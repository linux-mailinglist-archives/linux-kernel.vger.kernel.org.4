Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E17643ACD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiLFBef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiLFBeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:34:31 -0500
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E151B791;
        Mon,  5 Dec 2022 17:34:31 -0800 (PST)
Received: by mail-ot1-f43.google.com with SMTP id s30-20020a056830439e00b0067052c70922so1602341otv.11;
        Mon, 05 Dec 2022 17:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQJzjzczHukY5OAQJSMJmAiOo4gpV8IN7ET194V+qnQ=;
        b=qTnr26XGtNqnsrgfsGjLBMqIIiklRLLkX04UV+ntWi9hrVgUc8Y7Wa3rpti99lWA7s
         uC5eRqf6OaFAFfh3Lf8W5T5cqt9wjXkEMINlQnuR86Jp3BnMc6SZCq8pctGPyVQpxCns
         aJPicmfSvUo/YgAs9W41nlQbzW5rLOSVVUx0fgkJTHROMniEnXrG80WeMWYsIfAOaZps
         1GgUS1TqZ0ohQvmHHn7CvsUcFQh0BBt1ZlXDmru4N22KFpSM6A1defvoIX6ZuX/s+whq
         Cx2Qy/RWAMtDnzJgbhtLMi+2hthkAiATRBN5gKDYnfYrGOa1SJ3Lk5UdZLjDudnbUBqq
         VePQ==
X-Gm-Message-State: ANoB5pnDH+KHPuL5kcAG3PuZ3SID0pF+QRoSVTNk40Auh8/U4PPGkL9R
        QFU/jqYNPowwUwP11JNItA==
X-Google-Smtp-Source: AA0mqf5DzZkVK2K4YFpkH/LzI3BUyeeHu5HQnlUzksKvWhTt/DprGhkm2DdoE4kzuhsh0ysvf3G/0w==
X-Received: by 2002:a9d:5908:0:b0:66c:39ca:a7aa with SMTP id t8-20020a9d5908000000b0066c39caa7aamr42624026oth.24.1670290470268;
        Mon, 05 Dec 2022 17:34:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x186-20020a4a41c3000000b00494ed04f500sm7333855ooa.27.2022.12.05.17.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 17:34:29 -0800 (PST)
Received: (nullmailer pid 3096190 invoked by uid 1000);
        Tue, 06 Dec 2022 01:34:29 -0000
Date:   Mon, 5 Dec 2022 19:34:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: thermal: cooling-devices: Add missing cache
 related properties
Message-ID: <167029046126.3095969.9611282339604758982.robh@kernel.org>
References: <20221104162450.1982114-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104162450.1982114-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Nov 2022 11:24:50 -0500, Rob Herring wrote:
> The examples' cache nodes are incomplete as 'cache-unified' and
> 'cache-level' are required cache properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/thermal/thermal-cooling-devices.yaml  | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!
