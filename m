Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9389744104
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjF3RRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjF3RQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:16:48 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531643ABD;
        Fri, 30 Jun 2023 10:16:44 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-345f1e0abf9so2161425ab.3;
        Fri, 30 Jun 2023 10:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688145403; x=1690737403;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9a96p4nXmM7UUxKlVBsq9k7hSMemNxawVrLqd8ipKj8=;
        b=XhLkM8794V1peo05iful+PhqqlqpCEmn1cYMrRKsdrptsHAPl+cnpqUMT4ZjeobIid
         Yw8MYxC3n/A2sDQMdlv7bjmBY8qRJ9B+MB99WSZnfbfK5bZ4G8qr7O5OCPQJTedbRTO1
         HO+S7JrMBW/zP4tPD3dzk9YrHxO2wxETirGi2bS/siAzK00QvR90Fex2oOQd0diFSI4S
         KZjT6/DfQNn0HD0rwPTIf8fTXX80KnXa+mc0VXDQXjDLlmYLX0Q5UYSjY3Bwbp0AdloR
         hz3gFlyrTYeE2DHtOGb49Fjty5h+CTWUnbZ3/ZfDs2tjb5JQvZQyBrlpdt99L8/NE3JS
         6k7w==
X-Gm-Message-State: AC+VfDxJSE5955G13qJhyBys76imCGiIoEtv2NRb+WqDT9DleQQb8u0X
        q4WylGdRfJ9NBn1+Sg7fsQ==
X-Google-Smtp-Source: ACHHUZ4TG0ayJG3EWPbPYbZj3rgrjyxxPMQsTEoDTOyBjbOJkG7vyxBO+XUhNCci0ZX2UdGwi3KqWw==
X-Received: by 2002:a5d:8f93:0:b0:786:2672:5331 with SMTP id l19-20020a5d8f93000000b0078626725331mr3287816iol.2.1688145403547;
        Fri, 30 Jun 2023 10:16:43 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id eq16-20020a0566384e3000b0042312dc690csm4475085jab.132.2023.06.30.10.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:16:42 -0700 (PDT)
Received: (nullmailer pid 1984849 invoked by uid 1000);
        Fri, 30 Jun 2023 17:16:41 -0000
Date:   Fri, 30 Jun 2023 11:16:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nikita Bondarenko <n2h9z4@gmail.com>
Cc:     linux@roeck-us.net, bcm-kernel-feedback-list@broadcom.com,
        sbranden@broadcom.com, devicetree@vger.kernel.org,
        wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, f.fainelli@gmail.com,
        robh+dt@kernel.org, rjui@broadcom.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: watchdog: brcm,kona-wdt: convert txt
 file to yaml
Message-ID: <168814537940.1984386.4796056831739397927.robh@kernel.org>
References: <20230418170341.28805-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418170341.28805-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 19:03:41 +0200, Nikita Bondarenko wrote:
> Converted txt file to yaml. No additional changes.
> 
> Signed-off-by: Nikita Bondarenko <n2h9z4@gmail.com>
> ---
> 
> Changes in v3:
> - updated commit message
> - updated the compatible definition to probably fix "compatible is too long" warning
> - updated example to how it was in the txt file
> 
> 
> I do not have this warning when I am running
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
> maybe I run it without some additional variable?
> 
> But I checked arch/arm/boot/dts/bcm28155-ap.dts, it includes bcm11351.dtsiv which contains
> compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> which probably causes a warning
> This is exact how it was in txt file example.
> 
> If I put it in an example in a yaml file, dt_binding_check does not pass.
> Looks like the issue is in the enum type of compatible. It does not allow multiple strings.
> Updated to not to use enum. The example with two strings in compatible passes the checks.
> 
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTEX    Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dts
>   DTC_CHK Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dtb
> 
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dtbs_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> 
> 
> v2 patch is here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230402135555.62507-1-n2h9z4@gmail.com/
> 
>  .../bindings/watchdog/brcm,kona-wdt.txt       | 15 -------
>  .../bindings/watchdog/brcm,kona-wdt.yaml      | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> 

Applied, thanks!

