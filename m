Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D43474A41B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjGFTF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGFTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:05:27 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAE61BE9;
        Thu,  6 Jul 2023 12:05:26 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3461053677eso2487005ab.0;
        Thu, 06 Jul 2023 12:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670326; x=1691262326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=INiY27iokPzj3Y1hOMTtz8s7AtrmF9FaFbozx7zoZLU=;
        b=W1c723sDPJ2oAiZR+yMJ9083t92gMcyW7hoKzk4V1xIogizAq3Ilr1I6X8kOI//oYP
         zC3ICMq3N/qrqiMHQ7lhfUni4rEYNnK9DobgCq9ATSFT4Pk0FXTP4FSbGNA7ZLX9pneS
         W+YqN5/OCkiHIDQjQsc8K+oJf0yl42pIzcN8/qfP+fdGnWsSBUIsaxNlC/KsyaGrO4Du
         CoUOBtnTFdqG8mtZfBAW8xrCRB6qQ/XbpoEBibE59BygvFisElaJcehWVHRCduAc3yKM
         ZGdGDq7wnF+qeccOnWyPPaxQetfwy8/X0YMPSFkLP150eSejyB5S1imec49yroFWOBWS
         XdOQ==
X-Gm-Message-State: ABy/qLZGrRXYYDwJuhMYnbRqZ+Gk19NPnfHBiYYOIZsM4M1fy9/StGaC
        pw4OehahkwqtxEEcvHBYM8zBcb/MbA==
X-Google-Smtp-Source: APBJJlGq+znRNSnBSPJIa8qV/04lud2M3uRgd+NToHUyy9pq7rIwA8yfqAo9o7Op8Ys7KfdCPel/7Q==
X-Received: by 2002:a92:bd0c:0:b0:343:ef5e:8286 with SMTP id c12-20020a92bd0c000000b00343ef5e8286mr3482247ile.7.1688670325885;
        Thu, 06 Jul 2023 12:05:25 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a5-20020a92d345000000b0034248a56432sm698327ilh.32.2023.07.06.12.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:05:24 -0700 (PDT)
Received: (nullmailer pid 159125 invoked by uid 1000);
        Thu, 06 Jul 2023 19:05:23 -0000
Date:   Thu, 6 Jul 2023 13:05:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: gpio: Add HPE GXP GPIO
Message-ID: <20230706190523.GA155073-robh@kernel.org>
References: <20230705194544.100370-1-nick.hawkins@hpe.com>
 <20230705194544.100370-2-nick.hawkins@hpe.com>
 <046d4744-9521-7b5d-759c-6dedbafd9205@linaro.org>
 <31F41D4F-D386-48B5-B941-D5B7C691280A@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31F41D4F-D386-48B5-B941-D5B7C691280A@hpe.com>
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

On Thu, Jul 06, 2023 at 02:12:12PM +0000, Hawkins, Nick wrote:
> Greetings Krzysztof,
> 
> Thank you for the feedback. I see that due to a patch conflict I
> reintroduced some of the alignment issues you had me fix in
> a previous version. This was a mistake and I will correct this.
> 
> > > v5:
> > > *Removed use of gpio-gxp in favor of just supporting
> > > hpe,gxp-gpio-pl for now as the full gpio-gxp will
> > > require a much larger patchset
> 
> > Bindings describe hardware, not drivers, and should be rather complete.
> 
> This patch is intended to still cover the hardware interface between our
> BMC and our CPLD which gathers GPIO for us. The part of the binding I
> removed was a completely separate interface with different mechanisms
> for reading GPIOs. With that said I could keep these two interfaces
> separate in yaml files: Having a yaml for hpe,gxp-gpio and another for
> hpe,gxp-gpio-pl. Would this be a better approach?

If they are independent (and it sounds like they are), then yes.

Rob
