Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47299633EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbiKVO2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiKVO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:28:37 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885CF6317B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:28:36 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id o17so1111243ilg.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gzHNTCuPBl1243bm48FKjt2m0TJt4ZAgEwgFxeyfelg=;
        b=AL3TCWiq8qz85gebwtmflSjU1TeY7vO9uOjerKfsr2hpsUEbbAdb0sqdA67uvzQ9Ul
         2yOt1LsxjMfUGlR10Aa+2x4LTc+feZY0fLlDlrVwOpo1/pavzg0bx3YnicgigF7Caz06
         rt1nVAb5bpishJPCpgh+eHrsesx3lf597h5C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzHNTCuPBl1243bm48FKjt2m0TJt4ZAgEwgFxeyfelg=;
        b=fXfApMRZGW0rI3i1Yh14L/mXn2ktQz0a/du4eZknl1SOj7YOUcaaWUL0Oqfj8hHQew
         N0WB9FXCFPPInszaj4rsSkjrsXDEw21rpXfCwNbGN+k6ybrjUiiMdPmCBxOj8UbgWaAP
         CNUYYE+wZgR5qSwKvGbDDLRZnJzun78fJuXzU5xJsr1NugNHVMUE2UN1pKi7VHmn6qgB
         oBN8kjjxN/QoOazGGN+mrcg2M2YlDOch4yb5xs7mPAuyIF8I8KbLchf9crfabirir175
         bdgwdWUlzamcxK+r1jeMikbRX58tGXyda13SsHqL+9oo8C/4oAhPrdgHsdo1F6QPrEYI
         aHhg==
X-Gm-Message-State: ANoB5pmZSZ0QHJophOlt3+aJWxX1ZiqVwGl1rTM7A3g16stxdkCDCLSP
        QAv0EnKpfwwba/5n6PAZLeVxjQ==
X-Google-Smtp-Source: AA0mqf5gm7VUPG1g1odiwwIbuTVfM7E/P5h6sxqOsZuLoFOtjNCNF/RBNtatfOLOK9rJX+Jum4PaWQ==
X-Received: by 2002:a92:1912:0:b0:302:5c57:c19d with SMTP id 18-20020a921912000000b003025c57c19dmr2821667ilz.226.1669127315866;
        Tue, 22 Nov 2022 06:28:35 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id r13-20020a92440d000000b00300df8bfcf5sm4837898ila.14.2022.11.22.06.28.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:28:35 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:28:35 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Harvey <hunge@google.com>, Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Adding DT binding for
 zombie
Message-ID: <Y3zck7tPA5WFd0p1@google.com>
References: <20221122203635.v2.1.Ie05fd439d0b271b927acb25c2a6e41af7a927e90@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221122203635.v2.1.Ie05fd439d0b271b927acb25c2a6e41af7a927e90@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On which tree is this series based? My earlier reply bounced for Bjorn's
old Linaro e-mail address, which suggests that the series might be based
on an older kernel tree (maybe downstream Chrome OS v5.15?). Please make
sure to base patches to upstream lists on the corresponding maintainer
tree/branch or a recent kernel version/rc.

On Tue, Nov 22, 2022 at 08:37:02PM +0800, Owen Yang wrote:
> Add an entry in the device tree binding for sc7280-zombie.
> 
> Documentation/devicetree/bindings/arm/qcom.yaml
> 
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
> Changes in v2:
> - Move binding item to Google series bottom.
> - Modify DT file for zombie.
> 
>  Documentation/devicetree/bindings/arm/qcom.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index c15a729a6852..f617923f7485 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -538,6 +538,16 @@ properties:
>            - const: google,villager-sku512
>            - const: qcom,sc7280
>  
> +      - description: Google Zombie (newest rev)
> +        items:
> +          - const: google,zombie
> +          - const: qcom,sc7280
> +
> +      - description: Google Zombie with LTE (newest rev)
> +        items:
> +          - const: google,zombie-sku512
> +          - const: qcom,sc7280
> +
>        - items:
>            - enum:
>                - xiaomi,lavender
> -- 
> 2.17.1
> 
