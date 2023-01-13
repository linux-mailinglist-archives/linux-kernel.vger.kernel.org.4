Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B77E66A2D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 20:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjAMTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 14:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjAMTZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 14:25:07 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E80E7C3BD;
        Fri, 13 Jan 2023 11:25:06 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-142b72a728fso23306031fac.9;
        Fri, 13 Jan 2023 11:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgr//xXkYPL9n4vs1A+PgwPGoyGXYfgse884MeK5694=;
        b=oxQBpYt/2DiOQtO9623W3kXl10g7EcqRgqLfVO7UpzUXj1HCpmRFWdXgxnZ9Aglabb
         FEBn3LKaqe+sLA7OFegMwOhiSDQvmVZkDmSCgyBCB0weSbTxzyqUgwCEh5Of4wdBIsUi
         dAstAxjScdjs9d8hfnPdRajv+xRmlP7a4EnanjQlRFs46hCv+1BMmyzmOUSFJrGonlzk
         /BoFxVfmineI42jLZ9BCD9sO5KxWQm8NC9qvDMxCQkK4Kf1hz0H8j9UYQGeBqWsDh5JT
         aIXy0LAkieP87OFrHlOyHZWanU+94eeBY6mCycnHz8kdPtGPL0mSkamratoQkLRoHal+
         CLKg==
X-Gm-Message-State: AFqh2koEj13VJSsCOtPPusr61pwYhL/Dj+lLOP+YI22NzMF0EEh+POov
        0pGQTplK+Ft6YQD7tFOOsQ==
X-Google-Smtp-Source: AMrXdXul3xp8r9UUB5bdtH/VsjabzSgcSHDpc3tGLQ8MT3AqzsjBIRXpuVWaFeCHd9j+AzV3avm11A==
X-Received: by 2002:a05:6870:ea92:b0:156:c187:7bdb with SMTP id s18-20020a056870ea9200b00156c1877bdbmr6409512oap.3.1673637905253;
        Fri, 13 Jan 2023 11:25:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd13-20020a056870d78d00b0014fe4867dc7sm10819622oab.56.2023.01.13.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 11:25:04 -0800 (PST)
Received: (nullmailer pid 2803813 invoked by uid 1000);
        Fri, 13 Jan 2023 19:25:04 -0000
Date:   Fri, 13 Jan 2023 13:25:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        upstream@lists.phytec.de, riku.voipio@iki.fi,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org, pavel@ucw.cz
Subject: Re: [PATCH v2 2/2] dt-bindings: rtc: Move rv3028 from
 trivial-rtc.yaml into own schema file
Message-ID: <20230113192504.GA2800695-robh@kernel.org>
References: <20230111163404.3526248-1-w.egorov@phytec.de>
 <20230111163404.3526248-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111163404.3526248-2-w.egorov@phytec.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 05:34:04PM +0100, Wadim Egorov wrote:
> Move RV3028 RTC bindings from trivial-rtc.yaml into microcrystal,rv3032.yaml.

That's obvious from the diff. What's not obvious is 'why' and the commit 
message should answer that. I assume something about it makes it not 
trivial.

> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
> v2:
>   - Update subject 
>   - Remove not needed quotes
>   - Remove start-year
>   - Use unevaluatedProperties instead of additionalProperties
> ---
>  .../bindings/rtc/microcrystal,rv3028.yaml     | 54 +++++++++++++++++++
>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
>  2 files changed, 54 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
