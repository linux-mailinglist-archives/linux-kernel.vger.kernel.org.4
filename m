Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1710E633EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiKVOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbiKVOO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:14:56 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B27931371
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:14:53 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z15so7142445ilp.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LEL1JXswoOciVAB7l+D8H9Ys9DuQbRdeYUgr6HvaLqw=;
        b=MhoLcQBFckWDFoDg/M7iUydo9q5aZ7pkg26LYanhGBenLbgjSmIVEERV9lkhER7B3+
         o1VsgYj4gLYiRVz5vDSqPbBNDpkJW5F/kisyISsnQbUcjt921Uyp1vYOn/UPubl9D0fH
         8l5DjTTDDuQ54KdbZtmr4qbj0vMMrL0pXjCBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEL1JXswoOciVAB7l+D8H9Ys9DuQbRdeYUgr6HvaLqw=;
        b=cFRRNOYBcmn8rZPZHblpX3rGnjuHTEsokkwVxf/nImEWLcTk+S2bDnahH9GEOzuXqC
         9XwLLuwbHWuCWynk+uq0tZFBrwrdZdIEZO+vWHnFV75YPzKBN09ZmlU/2pjc8YGbPxsv
         d6MGl8XAIXjYvKxRoU2EHY6zfWrW0kJg4M6r+beithy3n1GPHMKBDl9Rsass7rk12r/r
         G/6qmoyjmxqgaNg7HrMVhcYaqlJb3gQJkoYFRQ+PFI+5znxbsRkp3y7gvlVFHJtNp8mt
         MiATfQbigSf+qkp0SZWC6GBoCFnY+Cw5dzy9Um323ITn+PFGZx69f7YxyhfzwWohR1m/
         rZfw==
X-Gm-Message-State: ANoB5pkFP1BEI/SOzQ4xiOnUaVnVda7+q9gQCvTT1+icRZnT+rF42y9B
        6qPoMsvKlA7sv8ncjn82Yj8xIg==
X-Google-Smtp-Source: AA0mqf6AvoSY6d8Nm2gnt1RXrtBwi6z5AKeyinvHIG5EWef+8UxlGGkkQm3AESyFb45bS39V7A2tIA==
X-Received: by 2002:a92:d702:0:b0:302:5898:73d1 with SMTP id m2-20020a92d702000000b00302589873d1mr1738474iln.65.1669126492985;
        Tue, 22 Nov 2022 06:14:52 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id y18-20020a92d212000000b002ffbf49a0d2sm4887435ily.84.2022.11.22.06.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:14:52 -0800 (PST)
Date:   Tue, 22 Nov 2022 14:14:49 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Owen Yang <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Bob Moragues <moragues@chromium.org>,
        Harvey <hunge@google.com>, Stephen Boyd <swboyd@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Adding DT binding for
 zombie
Message-ID: <Y3zZWWCJ8aYphD7f@google.com>
References: <20221122203635.v2.1.Ie05fd439d0b271b927acb25c2a6e41af7a927e90@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221122203635.v2.1.Ie05fd439d0b271b927acb25c2a6e41af7a927e90@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:37:02PM +0800, Owen Yang wrote:
> Add an entry in the device tree binding for sc7280-zombie.

nit: s/an entry/entries/ (there are two of them)

> 
> Documentation/devicetree/bindings/arm/qcom.yaml

Drop this

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
