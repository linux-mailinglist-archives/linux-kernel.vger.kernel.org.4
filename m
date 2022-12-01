Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C5763F87F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiLATmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLATmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:42:04 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0EF9790F;
        Thu,  1 Dec 2022 11:42:04 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id m204so3139150oib.6;
        Thu, 01 Dec 2022 11:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dur5RhOwHPW6ErE9GhhtlulRkcLhMx1ZIi5Xd1tlnQs=;
        b=6nDuY5qwVyPfN9wYmm5QHaYG8INoWxopiKF4awh4/2z6sBYi1/jUwoMeqnFUyCp1S/
         agJaG1SlMvxm8llviw2oAU+mpWRgtq/0KRQ+162jjET21UP3l9OHqcTkwmtw74I59vSr
         iKoWaW2viBwNNxJSx7hAadq6wr75hbDDv51czDbGfJTPCCOC1tP6/rreJJAM7fPQpnVL
         5s4hAM9gz6rKm8rrQo4E1df+vY3ZZW82omUMmlxTFeHjmGAfcQVTkbEXkH9WcTqMut+M
         9rYa/PtM2hWQrLBNl8Z1h10fPMub3wQVPhIVPgyeZ4Zfi1IuA9Y5h8HzLem1URBzgUPw
         7i8Q==
X-Gm-Message-State: ANoB5pndqgJx2Il96CPupiuoYX2mb5po/sIuSd/FXs0j2gjPw40Pw5ou
        b6lEYZfIRJXFEipoOfPg8g==
X-Google-Smtp-Source: AA0mqf5cmTu8JwySJqKQ+jAawgWFQ+PAHGLNr9cF+cN3zf1Mjh47oQpxsLHcZAIVBKaJTBy/qmZlDg==
X-Received: by 2002:aca:bcc2:0:b0:354:4a93:10f7 with SMTP id m185-20020acabcc2000000b003544a9310f7mr22638410oif.220.1669923723413;
        Thu, 01 Dec 2022 11:42:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 124-20020a4a0d82000000b0049fcedf1899sm2121070oob.3.2022.12.01.11.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:42:03 -0800 (PST)
Received: (nullmailer pid 1218518 invoked by uid 1000);
        Thu, 01 Dec 2022 19:42:02 -0000
Date:   Thu, 1 Dec 2022 13:42:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, chrome-platform@lists.linux.dev,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v8 2/3] dt-bindings: mfd: Add compatible string for UART
 support
Message-ID: <20221201194202.GA1215903-robh@kernel.org>
References: <20221130131245.v8.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221130131245.v8.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130131245.v8.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 01:12:55PM -0700, Mark Hasemeyer wrote:
> Add a compatible string to support the UART implementation of the cros
> ec interface.
> 
> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> Changes in v8:
> - Update commit message
> 
> Changes in v7:
> - No change
> 
> Changes in v6:
> - No change
> 
> Changes in v5:
> - No change
> 
> Changes in v4:
> - Changes in commit message.
> 
> Changes in v3:
> - Rebased changes on google,cros-ec.yaml
> 
> Changes in v2:
> - No change
> 
> ---
>  .../devicetree/bindings/mfd/google,cros-ec.yaml       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> index 04962bb29576e..26787e4574b8d 100644
> --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> @@ -28,6 +28,9 @@ properties:
>        - description:
>            For implementations of the EC is connected through RPMSG.
>          const: google,cros-ec-rpmsg
> +      - description:
> +          For implementations of the EC is connected through UART.
> +        const: google,cros-ec-uart
>  
>    controller-data:
>      description:
> @@ -222,4 +225,12 @@ examples:
>              compatible = "google,cros-ec-rpmsg";
>          };
>      };
> +
> +  # Example for UART
> +  - |
> +    uart0 {

serial {

> +        cros-ec {
> +            compatible = "google,cros-ec-uart";
> +        };
> +    };
>  ...
> -- 
> 2.38.1.584.g0f3c55d4c2-goog
> 
> 
