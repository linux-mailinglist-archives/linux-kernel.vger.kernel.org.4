Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47C563FA29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiLAV6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiLAV6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:58:22 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AE39383C;
        Thu,  1 Dec 2022 13:58:21 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so1847655otg.6;
        Thu, 01 Dec 2022 13:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMmEEW9nhsYjLdoVEX/XJSzRD/PGxz+ahARY6QfwUlw=;
        b=wNqtbN+Afjz89taY0u9clZGFN5ifkDfQXQLBGZD+eVRElF+FE9DJKIHODIdNNYJMTA
         ECZAzPC3gwS1qmbKnMd91ax/to237jZisKD1lEEGrSfOxXqwfYpS9N//tlapWNA0abkf
         +NXy0ULnooinAGmcJ7XF4XI/3EiEs5UXlNtJ2Zok06A3bLjbNunNcHjvXKEedCYvqatD
         L5uZ0f08ZuQ/gE9r296bEElwKO7AEFgcSyqPwP2kI6nnhBAIhCpJEMVQDwEqM59X2uOj
         zQYPoq9MrOdfVVXB5iM+3CbN5Ul5XQbsSit9GDPjXdCWSJTRHF9dVGbQ/gjnkIIoUsSY
         0h6w==
X-Gm-Message-State: ANoB5plT/ERroKWsuCl2WC4UNw1//2hMaP2oZ94Aa2GO2AAeqjPbs+p7
        1w4Z5py6G9NVXRf0AklEiw==
X-Google-Smtp-Source: AA0mqf6AYmSS9hCCipjLKVxHNWwf4lMfqM82+JjJbYgzcji3aY0tw19h/MvlDxIM1yeUomemkeRqjA==
X-Received: by 2002:a05:6830:374a:b0:66e:76f1:23e1 with SMTP id bm10-20020a056830374a00b0066e76f123e1mr2134223otb.35.1669931900561;
        Thu, 01 Dec 2022 13:58:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a7-20020a9d4707000000b0066e7e4b2f76sm362989otf.17.2022.12.01.13.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 13:58:20 -0800 (PST)
Received: (nullmailer pid 1518708 invoked by uid 1000);
        Thu, 01 Dec 2022 21:58:19 -0000
Date:   Thu, 1 Dec 2022 15:58:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Otto =?iso-8859-1?Q?Pfl=FCger?= <otto.pflueger@abscue.de>
Cc:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: display: panel: mipi-dbi-spi: Add
 missing power-supply
Message-ID: <20221201215819.GA1510935-robh@kernel.org>
References: <20221127191433.1363395-2-otto.pflueger@abscue.de>
 <20221127191433.1363395-4-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221127191433.1363395-4-otto.pflueger@abscue.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 08:14:32PM +0100, Otto Pflüger wrote:
> The power-supply property is only mentioned in the description and not
> listed in the properties section of the binding. Add it there.

That's because it is described in panel-common.yaml already.

But I guess it is somewhat useful to define it corresponds to Vdd.

> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---
>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml  | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
