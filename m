Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCC860E9F1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiJZUJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiJZUJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:09:32 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C19D2CE;
        Wed, 26 Oct 2022 13:09:32 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id u132so7107048oib.0;
        Wed, 26 Oct 2022 13:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSvnZNFrY/t8hO+otMGCt6SYXbtg48WlbzdEKm92cOU=;
        b=2ZEgHfTwt8hV0VbpyZzqciIfiWJkBHJXhYWiOUOsXSH2hC8WwFjxYYaTXndXjQlE7p
         3LmQSEmNmNoarxroFkDJfOycJNFZk3zRkW+WR29MwTOEOCqEAVR3IACa9S/4JPlxEMmJ
         CO3FowK6oICRzh8gssHk6yinOnwd74FHbc9vFCyMUo4wB0hewQEuFLPkOzIrpho0z3CY
         CmygEERux7NvQ3NWI/SBRcmJiEqJs61ao5C4aXi+zJoXlgMSLsswvL85daeyrDsGJI1G
         lUEKelWn5KeGQe0ZUUP9wxiBBsEeHw5KbMlG1htflpVVcZ6BbsnICT1hm4ZnINcgIpot
         talw==
X-Gm-Message-State: ACrzQf11YKBgk4uI/o25LexLhjibdbTAneI1S9J1ueveCThP4e5esNMC
        mB4V43yJFRP7SXKMmefLQg==
X-Google-Smtp-Source: AMsMyM6ntSDBnaABx1qDKv9FZuOk6gTVL2XjZEhmCAZh+IkqC1YfWA1d8IotgbNQZ/dmGPF9Q1UpYg==
X-Received: by 2002:a05:6808:10d6:b0:355:526b:fc0d with SMTP id s22-20020a05680810d600b00355526bfc0dmr2896689ois.258.1666814971774;
        Wed, 26 Oct 2022 13:09:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x35-20020a056870b42300b0012752d3212fsm3653703oap.53.2022.10.26.13.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:09:30 -0700 (PDT)
Received: (nullmailer pid 1103965 invoked by uid 1000);
        Wed, 26 Oct 2022 20:09:32 -0000
Date:   Wed, 26 Oct 2022 15:09:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        patches@lists.linux.dev, Craig Hesling <hesling@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v7 2/2] dt-bindings: cros-ec: Add ChromeOS fingerprint
 binding
Message-ID: <166681497103.1103616.12500217142449534506.robh@kernel.org>
References: <20221026003641.2688765-1-swboyd@chromium.org>
 <20221026003641.2688765-3-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026003641.2688765-3-swboyd@chromium.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Oct 2022 17:36:41 -0700, Stephen Boyd wrote:
> Add a binding to describe the fingerprint processor found on Chromebooks
> with a fingerprint sensor. Previously we've been describing this with
> the google,cros-ec-spi binding but it lacks gpio and regulator control
> used during firmware flashing.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/mfd/google,cros-ec.yaml          | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
