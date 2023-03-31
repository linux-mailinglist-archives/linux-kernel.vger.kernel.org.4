Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E596D28D4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjCaTxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCaTxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:53:02 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919951BD6;
        Fri, 31 Mar 2023 12:53:01 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-177ca271cb8so24349631fac.2;
        Fri, 31 Mar 2023 12:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680292381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OR6Sr6ibp9FVI2jjBSZUEmNbqrgLKUfxZHmJ3tN2tJI=;
        b=I52xrOA6byNN0ChLX3RKJ5uFGad8+cNj1DKl0OHOR/fqBCLUCwhnAkiia+BmgIpjxW
         Sl5yFIX8j4nQOV/HvB4YD5J4b/4T5NXBoO/V4SayUC2n1dodk4UNQCGi0cIfpvQjBEwu
         lUmOrGbJ+aMf+vV1tLqaQd99sg955J/Qy1BA3oW2gHVTc5ZpOnS8eUf0HvA51NwkfpH+
         bktdIWjzdefrsrTP6xxP/S7/TdwtqRti5QZuWRzgWxLaz/N3SmOQ0NoG8b45bteofvDS
         O2k84ii1Q9xSakpJ0vLnI4lYNLzzMENCVecbmp/YzrSpAVkNLKnegyKtSk8CLZbDN8mb
         OLIQ==
X-Gm-Message-State: AO0yUKVFHQl86gzXbSSKVqNCuA/yC//+TiOpG0AhlveMj6evAU6eY3Qx
        Sf1hieUvXTjJ0pCcJ6NIJEyg40n70Q==
X-Google-Smtp-Source: AKy350aVgOblYLSQB383WBUZwUCaOxItDWChiJ9N7LF68Gj3/qWb/jew5Lt93ZW0Oov6eR+Q0ew0Hg==
X-Received: by 2002:a05:6870:fbaa:b0:177:824d:e944 with SMTP id kv42-20020a056870fbaa00b00177824de944mr16919253oab.51.1680292380887;
        Fri, 31 Mar 2023 12:53:00 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r4-20020a056830134400b00697be532609sm451922otq.73.2023.03.31.12.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:53:00 -0700 (PDT)
Received: (nullmailer pid 2120917 invoked by uid 1000);
        Fri, 31 Mar 2023 19:52:59 -0000
Date:   Fri, 31 Mar 2023 14:52:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: display: xinpeng,xpp055c272: document
 port
Message-ID: <20230331195259.GA2098403-robh@kernel.org>
References: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326204224.80181-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 10:42:21PM +0200, Krzysztof Kozlowski wrote:
> Panels are supposed to have one port (defined in panel-common.yaml
> binding):
> 
>   px30-evb.dtb: panel@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/display/panel/xinpeng,xpp055c272.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)

Applied series to drm-misc.

Rob
