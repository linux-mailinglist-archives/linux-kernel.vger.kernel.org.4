Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A96472E454
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbjFMNhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbjFMNhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:37:38 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BDD123;
        Tue, 13 Jun 2023 06:37:35 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-77b6e428f84so20954839f.1;
        Tue, 13 Jun 2023 06:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663454; x=1689255454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0vCNuqKUm55AaMm8pr0xyLnAFa80CEdl30TBTTMS60=;
        b=dtLXY6Z8CEWE/dulBgY/rErdpGbF1RTFjCzwQUtapclkkEnMuQKeGD+t+nZyk//IiO
         6CJZ1CHirh/I4uNj3yw5EWJIZ9CoOrv0HerIvI4DgttBnjLwYhTxzXpa7vjpD6JFxxVN
         6KxFhkUGGltcN7UFu1PLm9oGgX9XvxgonBbcDr/6wBXOjZpT+s1NrT6L3KdJbP71dLQ5
         cb2erf4/QwIbUikXJJKagDIE2iIUi322sNY2Rntrffe06ASbSmEf+CKxEFuecmqrbZW6
         BIrW6w3vCdQF+TVGHtnefPHdcaKwuy813VTY6q56nWeA8oVae7lK+fqSysMwoIzunss9
         pK3w==
X-Gm-Message-State: AC+VfDynnUZI1EyBrsM3GDqbri1rzTlM70EnlJZHqng07fGGdCMEPRm+
        ALXBUq6wjv4XIKncM8SAQg==
X-Google-Smtp-Source: ACHHUZ62snGsnwuzPVeMJrIoCjYOrS2BeG82fFxxbz6v9Ogo9rZm3dRMxRWqs0YOuqVaQpzlRcTc3Q==
X-Received: by 2002:a5e:8812:0:b0:76c:6f28:7e18 with SMTP id l18-20020a5e8812000000b0076c6f287e18mr9611143ioj.20.1686663454221;
        Tue, 13 Jun 2023 06:37:34 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h3-20020a02c723000000b004161fafff97sm3438751jao.136.2023.06.13.06.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:37:33 -0700 (PDT)
Received: (nullmailer pid 1772161 invoked by uid 1000);
        Tue, 13 Jun 2023 13:37:31 -0000
Date:   Tue, 13 Jun 2023 07:37:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, broonie@kernel.org,
        andy.shevchenko@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings:iio:adc: add max14001
Message-ID: <20230613133731.GA1767199-robh@kernel.org>
References: <20230613054601.31566-1-kimseer.paller@analog.com>
 <168663709022.652608.11756645774505315189.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168663709022.652608.11756645774505315189.robh@kernel.org>
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

On Tue, Jun 13, 2023 at 12:18:10AM -0600, Rob Herring wrote:
> 
> On Tue, 13 Jun 2023 13:46:00 +0800, Kim Seer Paller wrote:
> > The MAX14001 is a configurable, isolated 10-bit ADC for multi-range
> > binary inputs.
> > 
> > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > V3 -> V4: Added space between prefixes in commit description.
> > 
> >  .../bindings/iio/adc/adi,max14001.yaml        | 54 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
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
