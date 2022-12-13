Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCF864B7B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiLMOsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235921AbiLMOr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:47:57 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30B10FA;
        Tue, 13 Dec 2022 06:47:52 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso379238otn.2;
        Tue, 13 Dec 2022 06:47:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qoS1m9v1jpkb8s6aLa7HLv1oFhQX0EhDST3RwQlvIrw=;
        b=kAxf83FQztsbZBwqBMTjuMyC0aAIWQ+CtKyEtag82Vrl7A596/JfFEYY2VeGbTso0E
         nnUrYaPBiBg4/2LhJQkq11a2TtWCYkYgGiabaNN2jK28P4dXbEdEV603qDJ6VXbuMvh8
         2dh2nkGYnJO0noROt2mrW/fv1jUzl9wpkchv6aldkmPj+MFFB6uU5g65L3I9rVgHn/cd
         Gw2WBB6+yWecdTJUsKMcqK26Jty03izWv/Ny9ijiodO3+c6zT2FVmn7uza+JQwSpVsch
         yZZuEEfZGM8lBcnMO0Q5XCjleqYC6Rm2NRbt4x+J9to5r80oIaqKl+v0sLt/c8kzktpt
         ZFSg==
X-Gm-Message-State: ANoB5pntlx2jZBVJ1BsQrCGZhk0LdmcQzT7U9pv5Xwp/+Ps6UfCsrRPY
        M5w9/ruYK0sgIsx61fQOHg==
X-Google-Smtp-Source: AA0mqf4GN9I1IHzd3ml1gT1dfuTjn8a9iKflHneFi+UG9Dpxxr+OQWVWlld8CgiSmIacZdHRwoYL/Q==
X-Received: by 2002:a05:6830:3359:b0:670:7e0a:e742 with SMTP id l25-20020a056830335900b006707e0ae742mr7455552ott.27.1670942871625;
        Tue, 13 Dec 2022 06:47:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bq20-20020a056830389400b00670679748f9sm1265426otb.49.2022.12.13.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 06:47:51 -0800 (PST)
Received: (nullmailer pid 991654 invoked by uid 1000);
        Tue, 13 Dec 2022 14:47:50 -0000
Date:   Tue, 13 Dec 2022 08:47:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kun Yi <kunyi@google.com>, Jonathan Cameron <jic23@kernel.org>,
        Krishna Chatradhi <ch.naveen@samsung.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Eric Tremblay <etremblay@distech-controls.com>,
        linux-hwmon@vger.kernel.org,
        Supreeth Venkatesh <supreeth.venkatesh@amd.com>,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Akshay Gupta <Akshay.Gupta@amd.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: correct indentation and style in
 examples
Message-ID: <20221213144750.GA969237-robh@kernel.org>
References: <20221213092643.20404-1-krzysztof.kozlowski@linaro.org>
 <167093911583.912886.13512120412056690614.robh@kernel.org>
 <2172e561-ec0f-5c4e-96d2-ceb2010f2673@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2172e561-ec0f-5c4e-96d2-ceb2010f2673@linaro.org>
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

On Tue, Dec 13, 2022 at 03:19:54PM +0100, Krzysztof Kozlowski wrote:
> On 13/12/2022 14:46, Rob Herring wrote:
> > 
> > On Tue, 13 Dec 2022 10:26:41 +0100, Krzysztof Kozlowski wrote:
> >> Fix mixed indentation to 4-spaces, remove unnecessary suffix from
> >> i2c node name and use lower-case hex.  No functional impact.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../bindings/hwmon/adi,adm1177.yaml           | 12 ++---
> >>  .../bindings/hwmon/adi,adm1266.yaml           |  6 +--
> >>  .../bindings/hwmon/adi,axi-fan-control.yaml   | 20 ++++-----
> >>  .../bindings/hwmon/adi,ltc2947.yaml           | 20 ++++-----
> >>  .../bindings/hwmon/adi,ltc2992.yaml           | 26 +++++------
> >>  .../devicetree/bindings/hwmon/amd,sbrmi.yaml  |  6 +--
> >>  .../devicetree/bindings/hwmon/amd,sbtsi.yaml  |  6 +--
> >>  .../devicetree/bindings/hwmon/iio-hwmon.yaml  |  8 ++--
> >>  .../bindings/hwmon/national,lm90.yaml         | 44 +++++++++----------
> >>  .../bindings/hwmon/ntc-thermistor.yaml        |  2 +-
> >>  .../bindings/hwmon/nuvoton,nct7802.yaml       | 16 +++----
> >>  .../devicetree/bindings/hwmon/ti,tmp513.yaml  | 22 +++++-----
> >>  .../bindings/hwmon/ti,tps23861.yaml           | 16 +++----
> >>  13 files changed, 102 insertions(+), 102 deletions(-)
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> 
> This is fixed in second patch which points to: I need to change their order.

Humm, I was scratching my head how this occurred. The cases of 'i2cN' 
don't get checked by the I2C bus schema.

Rob
