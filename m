Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E35728421
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236616AbjFHPte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236671AbjFHPtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:49:32 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3B430FC;
        Thu,  8 Jun 2023 08:49:05 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-77a103c5ebbso26898339f.3;
        Thu, 08 Jun 2023 08:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239274; x=1688831274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXjBGljhHz59Zize3+I5E64W6oWTW0cFp0RasFFgf5Y=;
        b=PxmT/WazptUz0zeVMAC26qXGX43JVIHAQyXiyrizJxqlJIe3RHonUdKBDX2kj3LDZT
         IKy0VWme17pwD2eLWDG4bkzpaljf4PII8ZCKEIArkty+Xk+nt0uYtA41PfsX+1xEKpb0
         /IQKUrIP4jsBqm55NTyMrhHZNgFZmpW47LplsYiu8nXkaAUdlxTUDtBI3SH2DeIs70/b
         BSMENhP8yE6Csh3lrrokhzHU1K7IOLu+fyiCDuTLtnOYOt32zUFbhwejxTg8PYBpbYZ3
         g4ser55qhJelMrA6fubGJb+SYI+ty7DdiBkYRL9lVC5PlFkD4PFVJtumE8mq6oH5ixcU
         SEBA==
X-Gm-Message-State: AC+VfDxfI0+orth5ifltbiimle5VrXFvUJXywcZY1pq07Li8KNNLyCx0
        Een7z0tq8mseFXgVO/Srag==
X-Google-Smtp-Source: ACHHUZ7cZm1Ty9Z8MpDiMawbjWmZUYWUMfyBaKOm2S1ZMrktNWBcpJmoHGY0RkhmqfsBGRZqUmnxGg==
X-Received: by 2002:a6b:e609:0:b0:76c:79f9:9b29 with SMTP id g9-20020a6be609000000b0076c79f99b29mr6920477ioh.3.1686239274534;
        Thu, 08 Jun 2023 08:47:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id x5-20020a6bda05000000b0077024f8772esm439692iob.51.2023.06.08.08.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:47:53 -0700 (PDT)
Received: (nullmailer pid 2754560 invoked by uid 1000);
        Thu, 08 Jun 2023 15:47:51 -0000
Date:   Thu, 8 Jun 2023 09:47:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: connector: usb-connector: add a gpio
 used to determine the Type-C port plug orientation
Message-ID: <20230608154751.GA2750742-robh@kernel.org>
References: <20230601-topic-sm8550-upstream-type-c-v2-0-3bbdf37575c3@linaro.org>
 <20230601-topic-sm8550-upstream-type-c-v2-1-3bbdf37575c3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601-topic-sm8550-upstream-type-c-v2-1-3bbdf37575c3@linaro.org>
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

On Wed, Jun 07, 2023 at 10:05:00AM +0200, Neil Armstrong wrote:
> On some platforms, the Type-C plug orientation is given on a GPIO line.
> 
> Document this optional Type-C connector property, and take the
> assumption an active level represents an inverted/flipped orientation.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index ae515651fc6b..c3884eed6ba4 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -114,6 +114,11 @@ properties:
>      description: Set this property if the Type-C connector has no power delivery support.
>      type: boolean
>  
> +  orientation-gpios:
> +    description: An input gpio for Type-C connector orientation, used to detect orientation
> +      of the Type-C connector. GPIO active level means "CC2" or Reversed/Flipped orientation.
> +    maxItems: 1

There's no such GPIO on a USB-C connector. Please explain this h/w 
better (in the commit message and/or description). Perhaps it is simple 
enough logic to leave the GPIO here. Perhaps there's more to the h/w you 
are not (yet) describing.

Rob
