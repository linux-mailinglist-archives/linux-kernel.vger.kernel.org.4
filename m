Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70EB72E455
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbjFMNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbjFMNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:39:04 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7FE90;
        Tue, 13 Jun 2023 06:39:03 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77797beb42dso198360139f.2;
        Tue, 13 Jun 2023 06:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663543; x=1689255543;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NcBdZErqsjsJbb1XeL6NTW5W80TO2Hu3XzH2QbgM4vs=;
        b=Fkjimx7yURyhdKiAEU9wuLQ1FNej9yFosNNo7ztTRxX1E1BXyT6q2bHVZ6OTENlIr8
         p/IyCttZv/akUDnuoU1chp14+Qv4cWX5De/Z28N+lY0n9Q7OrFUDrfO7VdyVVNqosbCk
         wSJj3gVCIcBqDWqDepgB8+LKvqv5PVDXjhOwJBliXXuqh7+gUniIlOdFk8CO2RH9Tzfk
         2Ufut8WlcQUoHL1r1kjzzCGPj6HwqhOZ/tBjqmgsJ6qNIe/gFagXzU+E4bQoLCc7sxfL
         DubBPJmNqN1aJbBHjRTBpvuTRuv7KNg7Vz3lMP32Xy9MXAHN4OMjG8FM30HqelZBorQV
         4ZKQ==
X-Gm-Message-State: AC+VfDy1Ot1ViZn6XLPQUaFFxPKZ1S0S0gIP/49bxHz7yde2yRuP1QPC
        VbNupqFHE7ySXg9cjJ/GHw==
X-Google-Smtp-Source: ACHHUZ7jcGpRe3Cd5W5wXSlee8IXC8Lymu/Ol6jXMP2/8PbohbGXne+2fontpCxEiSpU2xe9dP7AWQ==
X-Received: by 2002:a5e:8301:0:b0:762:f8d4:6f4 with SMTP id x1-20020a5e8301000000b00762f8d406f4mr10453310iom.8.1686663543136;
        Tue, 13 Jun 2023 06:39:03 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s5-20020a02cf25000000b0041f62ba9a37sm3478049jar.104.2023.06.13.06.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:39:02 -0700 (PDT)
Received: (nullmailer pid 1774228 invoked by uid 1000);
        Tue, 13 Jun 2023 13:39:01 -0000
Date:   Tue, 13 Jun 2023 07:39:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: regulator: max77857: Add ADI
 MAX77831/MAX77831 Regulator
Message-ID: <20230613133901.GA1773446-robh@kernel.org>
References: <20230613080552.4492-1-okan.sahin@analog.com>
 <20230613080552.4492-2-okan.sahin@analog.com>
 <168664792963.1147059.8156399408819922296.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168664792963.1147059.8156399408819922296.robh@kernel.org>
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

On Tue, Jun 13, 2023 at 03:18:49AM -0600, Rob Herring wrote:
> 
> On Tue, 13 Jun 2023 11:05:49 +0300, Okan Sahin wrote:
> > Add ADI MAX77857 and MAX77831 Regulator device tree document.
> > 
> > Signed-off-by: Okan Sahin <okan.sahin@analog.com>
> > ---
> >  .../bindings/regulator/adi,max77857.yaml      | 83 +++++++++++++++++++
> >  1 file changed, 83 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/adi,max77857.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml: $defs:qcom-pmic-mpp-state:properties:qcom,paired: [{'description': 'Indicates that the pin should be operating in paired mode.'}] is not of type 'object', 'boolean'
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

Unrelated, this can be ignored.

Rob
