Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0976F7099
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjEDRNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEDRNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:13:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A174EC9
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:12:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307664010fdso406542f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683220375; x=1685812375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kddkMECWVqpDHWo8u3obun/sMKv5JNOK16rXJVgFx4g=;
        b=LOOkQU6n9tZyRfwdWMsGPy6aLyJfZxBcZwYdRCAQ9umZn6cN0gLH+p93ev7FnwrMRA
         NbRkWvvBVxSMZNqOUuWQUtSKP2TsBNKH5v4PNOvPkZhihSHgZk97wQqcxgYxPCCSLIIl
         lvW572eEAcmp0BTPpbmx8wBPF718WrmwX6LmTUVxDLY3Ky6pQdVqRauIEjSkuih0FSBF
         qow/nBQVdOmsZw/s3SPf5BoQIX1C036ioczaiYShWh20sjVWZ71NC8lJjOlWc5EUO36N
         OiXgZ6FMupA3/w/TEZR4+liF5SzHpETSQDXKZrhx7T4hgiVILnSCi7bDgXtSGgDz9YfX
         j7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220375; x=1685812375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kddkMECWVqpDHWo8u3obun/sMKv5JNOK16rXJVgFx4g=;
        b=TcO0N4n6W/ELil1uTu//3jdSVHhldTD6eAaBpC9G5xjUbOaH8B3L10OM1cUpKd7fH6
         yHuRYRX4ngBZJHFM0j2qCZ2czcMCCRALNN1twsUsZyebCGeWrpAkqLuTMsGtBC3UUUvt
         mwZAGwFz8u6+EjLIhipXZ5U4HxdX7iBFP62sU1fEueXqG5pdEeg0nNIBc5QkQ81aUCLv
         Hh0rJEV96PICmo2aEOIy7D0/ddupxpaqTiMC2pe+3NEqQj4sh23u1isRg73VCoe5Hwpk
         uekUXgu19UARjTvaXVJUK5YnANg5Uo9n7fvlUPLKkryYRELzrduhJlhWXmcQH7GZFjvk
         hR2w==
X-Gm-Message-State: AC+VfDxJQaZJ9ZG23HmDfo1xDbhIMJOzax3qPWFiTZWG9oPISU6Y3CFe
        6z/KRzq9h7OdKk1MEdE5Xe2+ao7AGjXp+/h4kE37Sw==
X-Google-Smtp-Source: ACHHUZ7QxZl1x5phuIX1RVMMYcOgzgMlXlTEPdp+xl3jrd8L/fw1k3OPIva4SO7dTMcMaHMRdDpUBxe7jqpzTrGx8UA=
X-Received: by 2002:a5d:504a:0:b0:306:35d1:7a98 with SMTP id
 h10-20020a5d504a000000b0030635d17a98mr3021869wrt.8.1683220375596; Thu, 04 May
 2023 10:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230502053534.1240553-1-bhupesh.sharma@linaro.org>
 <20230502053534.1240553-2-bhupesh.sharma@linaro.org> <faefbbed-0f62-e569-455d-0d21b363f8f3@linaro.org>
In-Reply-To: <faefbbed-0f62-e569-455d-0d21b363f8f3@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 4 May 2023 22:42:44 +0530
Message-ID: <CAH=2NtzfH+7XMFdCq0JENgpJymsHNUfzwhWmDx=g8xBJ4aACpA@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] dt-bindings: phy: qcom,qmp-usb: Drop legacy
 bindings and move to newer one (SM6115 & QCM2290)
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, kishon@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.baryshkov@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2023 at 21:55, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/05/2023 07:35, Bhupesh Sharma wrote:
> > 'qcom,msm8996-qmp-usb3-phy.yaml' defines bindings for several PHYs
> > which predate USB -> USB+DP migration. Since SM6115 and QCM2290
> > nodes for USB QMP phy are being added to dtsi files by followup patches,
> > move these bindings instead to the newer style
> > 'qcom,sc8280xp-qmp-usb3-uni-phy.yaml' file.
> >
>
>
> >    clock-names:
> > -    items:
> > -      - const: aux
> > -      - const: ref
> > -      - const: com_aux
> > -      - const: pipe
> > +    maxItems: 4
> >
> >    power-domains:
> >      maxItems: 1
> > @@ -71,6 +69,42 @@ required:
> >
> >  additionalProperties: false
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - qcom,qcm2290-qmp-usb3-phy
> > +              - qcom,sm6115-qmp-usb3-phy
> > +    then:
> > +      properties:
> > +        clocks:
> > +          maxItems: 4
> > +        clock-names:
> > +          items:
> > +            - const: cfg_ahb
> > +            - const: ref
> > +            - const: com_aux
> > +            - const: pipe
>
> I am pretty sure I acked it and there were no changes here... but since
> you did not include it, then lets keep the clock order the same as
> sc8280xp. ABI is anyway affected, right?

Yes, I forgot to include your Ack in this version :(
Ok, I will fix the clock order in v11.

Thanks,
Bhupesh
