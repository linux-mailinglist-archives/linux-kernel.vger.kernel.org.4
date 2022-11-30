Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCD063E299
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 22:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiK3VVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 16:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiK3VVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 16:21:10 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929C38B190;
        Wed, 30 Nov 2022 13:21:09 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id g51-20020a9d12b6000000b0066dbea0d203so12068523otg.6;
        Wed, 30 Nov 2022 13:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gi08F4NWfWUD6xCY5Oe/H+pMh+Tsy5vhl0xYTUkWfy4=;
        b=1L0ta/566RNKSs8nSanYDs57H9zlyOyfHJ8btaggL6P915cI0vi9Ui+Qma9ia/Q2/9
         tINOFIImCBWI+EV9mQxqkac3ncQp+SRwE5e0T8sTkSy/H65QpIb0liBGbCyqv7/aDr0D
         N1Hy5saKmPdRXqsA06BLdRUWbXXTwWSPj/Le71vLYTDc/oIeYCHfol8q7jxWoXv2Q7y5
         j+r1SBYmSn2sL8wC7ONI87CnSNwJcGP4JCp637eEaQ5ui3pYlOsMngvpux4DTRKxtEKl
         1OShkOWY2uUS0/blG9njvy1k7/LR4nZ0ujj6l0P1CL7+AajKEcQszPkFR7CXKpVzkUWg
         PliQ==
X-Gm-Message-State: ANoB5pl+Ye/sysnzMYD3HvY2qBLdS/lfQ8vQmW8HZ2aD+Tyk4amYWTs8
        1JPdYmbVU2JAQJqiTkkCDQ==
X-Google-Smtp-Source: AA0mqf7EzQaJL4U41dyICm11dMO218s52uDWXRqd7idPvN3kRcJFt2MnosdYJY3z480sFpT4JrD3+A==
X-Received: by 2002:a9d:748e:0:b0:66e:39ed:9a26 with SMTP id t14-20020a9d748e000000b0066e39ed9a26mr12801490otk.130.1669843267451;
        Wed, 30 Nov 2022 13:21:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i9-20020a9d6249000000b00668953207b2sm1336435otk.80.2022.11.30.13.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:21:07 -0800 (PST)
Received: (nullmailer pid 2947797 invoked by uid 1000);
        Wed, 30 Nov 2022 21:21:05 -0000
Date:   Wed, 30 Nov 2022 15:21:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rahul Tanwar <rtanwar@maxlinear.com>
Cc:     devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-lgm-soc@maxlinear.com, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 1/4] dt-bindings: x86: apic: Convert Intel's APIC
 bindings to YAML schema
Message-ID: <166984326482.2947738.18134914819874377432.robh@kernel.org>
References: <20221124084143.21841-1-rtanwar@maxlinear.com>
 <20221124084143.21841-2-rtanwar@maxlinear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124084143.21841-2-rtanwar@maxlinear.com>
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


On Thu, 24 Nov 2022 16:41:40 +0800, Rahul Tanwar wrote:
> Intel's APIC family of interrupt controllers support local APIC
> (lapic) & I/O APIC (ioapic). Convert existing bindings for lapic
> & ioapic from text to YAML schema. Separate lapic & ioapic schemas.
> Addditionally, add description which was missing in text file and
> add few more required standard properties which were also missing
> in text file.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---
>  .../intel,ce4100-ioapic.txt                   | 26 --------
>  .../intel,ce4100-ioapic.yaml                  | 60 +++++++++++++++++++
>  .../intel,ce4100-lapic.yaml                   | 57 ++++++++++++++++++
>  3 files changed, 117 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-ioapic.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/intel,ce4100-lapic.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
