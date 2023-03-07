Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C306AF911
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 23:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjCGWmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 17:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCGWly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 17:41:54 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6771F7301E;
        Tue,  7 Mar 2023 14:41:19 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id m25-20020a05683026d900b006941a2838caso8051279otu.7;
        Tue, 07 Mar 2023 14:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678228865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CeVvunwdHuoUaMVyS5pFRs2OZmsVRqAhtJ35gavm5I=;
        b=UyWiG0cLvY9/SPxvtljXcUYCwewj5zbYpME3qGb9TbPnerKo/f7NPKP82agVKZ6uO6
         Usg0MZLNmwBMMoxUaN2F58T7QxwMCcqAgpfz/w+UXLsa2vdCHi8KYM1gSqRTmA44cu2V
         aLklngdHywjNy5D8P0zua1LIWLGctBi2GIQlfV64iUlBcXEJTFu1j3B72IvJxT/VPxfn
         9UfMTYZ30UBh7Ft/B41oA8LEEDmN0aNCmumY8XKX/8PcgdVUXZJ6nuaaB4KmPmU9jm5m
         LIa00JGy4Mn4SFw1pgoSIGvLaoRuU1Bj0WKOihMbO0BYcPoUZ6HZ2NOo8fga02VKmuoo
         03UQ==
X-Gm-Message-State: AO0yUKUKTnH3gwyf3Shg4cV2I2VpSkgO8rvddm7bx2Z4tzfp31lZLDt7
        CT6MzRPaALu3fPqfMQkAfQ==
X-Google-Smtp-Source: AK7set9nxIPAEEt9FwJLZSPnZ+3GYIXSHR48XHujvHBP9qDwFmZrwSwHrMb5uHv7tkNeZ1p0RxUHZQ==
X-Received: by 2002:a9d:603:0:b0:688:4670:e964 with SMTP id 3-20020a9d0603000000b006884670e964mr6826979otn.27.1678228864876;
        Tue, 07 Mar 2023 14:41:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x2-20020a9d6282000000b00690eeb8b436sm5747331otk.65.2023.03.07.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:41:04 -0800 (PST)
Received: (nullmailer pid 280601 invoked by uid 1000);
        Tue, 07 Mar 2023 22:41:03 -0000
Date:   Tue, 7 Mar 2023 16:41:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     marijn.suijten@somainline.org, Iskren Chernev <me@iskren.info>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        agross@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add Cortex-A78C and X1C
Message-ID: <167822886212.280531.2420228316244973879.robh@kernel.org>
References: <20230224130759.45579-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224130759.45579-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 24 Feb 2023 14:07:57 +0100, Konrad Dybcio wrote:
> Add compatibles for the Cortex-A78C and X1C cores found in some
> recent flagship designs.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

