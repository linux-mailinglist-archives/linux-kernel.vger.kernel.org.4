Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7CDB6D880F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 22:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDEURP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjDEURM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 16:17:12 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEEF12D;
        Wed,  5 Apr 2023 13:17:11 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id w13-20020a4aca0d000000b0053b8aa32089so5861117ooq.5;
        Wed, 05 Apr 2023 13:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680725830;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OQOX6eGu/Msze5vAJMDaVTPdFAjqpUW6bhbOsSGAyY=;
        b=bPwaOlO+SJwEuYM2mkZWE8kCY8wfRU23IM2r5yaxBfeTIziRsJJy1tiv1+40/bzouB
         F4s/qmiKKIh2uY/IzZNkE1Od0mkgw4RHojKLzblW7HG/LNTKjnWHZBDzgHLMtrkrkfOr
         iCRz5B9qd6FabqHS2rIQUpsYWa2JSCDmCFSxtMYuNqVARmI45ILc17+DdSaEK2r3V81U
         zugosi3r3VCCMUB/ZJjR/OIoSMlkXtPvG5KLIS97RPmoIQ6x2BGeY30jvDvI0hSfCmVT
         snkfU9lsqa7yOG4TH9d5+tIIPDK/2DiruLQo56EIUBwbjUYVS9HbVHe7lXArsK18ZVsV
         xJYA==
X-Gm-Message-State: AAQBX9cZZIi3wGlvcVV/TJ0BREVsF07tfFedmj+d1tBHxBW3RzZNKUnw
        Egqo8Pk0Br8SvgkQTWQ/lw==
X-Google-Smtp-Source: AKy350YyfRc5VOBijOdtqIuvlBwkwOVQvAsMScMxJVO/NQJb6Ghh39BLxjbMtDwi5xdb+WK9fiQYoQ==
X-Received: by 2002:a05:6820:1341:b0:53b:1086:7a09 with SMTP id b1-20020a056820134100b0053b10867a09mr1601609oow.3.1680725830623;
        Wed, 05 Apr 2023 13:17:10 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i7-20020a9d6507000000b0069436b64bb1sm7188405otl.79.2023.04.05.13.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 13:17:10 -0700 (PDT)
Received: (nullmailer pid 414310 invoked by uid 1000);
        Wed, 05 Apr 2023 20:17:09 -0000
Date:   Wed, 5 Apr 2023 15:17:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com,
        quic_harshq@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v6 1/8] dt-bindings: usb: Add bindings for multiport
 properties on DWC3 controller
Message-ID: <20230405201709.GA397286-robh@kernel.org>
References: <20230405125759.4201-1-quic_kriskura@quicinc.com>
 <20230405125759.4201-2-quic_kriskura@quicinc.com>
 <63bfaa1e-c627-bfe1-0bef-d001dae41014@linaro.org>
 <c18db964-1af7-7bbf-0d0f-cbb037f7500a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18db964-1af7-7bbf-0d0f-cbb037f7500a@quicinc.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 07:45:07PM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 4/5/2023 7:31 PM, Krzysztof Kozlowski wrote:
> > On 05/04/2023 14:57, Krishna Kurapati wrote:
> > > Add bindings to indicate properties required to support multiport
> > > on Snps Dwc3 controller.
> > > 
> > > Suggested-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > ---
> > > Link to v5: https://lore.kernel.org/all/20230310163420.7582-2-quic_kriskura@quicinc.com/
> > 
> > You did not test it at v4 and you got report for this. Your changelog in
> > commit msg does not mention fixing it.
> > 
> > It looks like you did not test it for the second time (or sixth time).
> > 
> > Best regards,
> > Krzysztof
> > 
> Hi Krzysztof,
> 
>   I did do a dt_binding_check and I got the following result:
> 
> kriskura@hu-kriskura-hyd:/local/mnt/workspace/krishna/skales2/skales/kernel$
> make DT_CHECKER_FLAGS=-m dt_binding_check
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/snps,dwc3.yaml
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/dtc/dtc.o
>   HOSTCC  scripts/dtc/flattree.o
>   HOSTCC  scripts/dtc/fstree.o
>   HOSTCC  scripts/dtc/data.o
>   HOSTCC  scripts/dtc/livetree.o
>   HOSTCC  scripts/dtc/treesource.o
>   HOSTCC  scripts/dtc/srcpos.o
>   HOSTCC  scripts/dtc/checks.o
>   HOSTCC  scripts/dtc/util.o
>   LEX     scripts/dtc/dtc-lexer.lex.c
>   YACC    scripts/dtc/dtc-parser.tab.[ch]
>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>   HOSTCC  scripts/dtc/dtc-parser.tab.o
>   HOSTLD  scripts/dtc/dtc
>   LINT    Documentation/devicetree/bindings
> invalid config: unknown option "max-spaces-inside-empty" for rule "brackets"
> xargs: /usr/bin/yamllint: exited with status 255; aborting

This indicates your yamllint version is too old.

Rob
