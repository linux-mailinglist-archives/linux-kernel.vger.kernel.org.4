Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8BC6BDC97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCPXCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjCPXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:02:30 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8864DBDD0B;
        Thu, 16 Mar 2023 16:02:21 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id r4so1875955ila.2;
        Thu, 16 Mar 2023 16:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679007740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWKucRSSjmR55YaxW3vFOx7lym0VxFoZUeEDxOK0nv0=;
        b=3SNw22zkqV0a+XimhJPI7VZ/H0BX4UTzqG9Mv1SYQvQx/QIgEU0zvOleyE6q++Ngd+
         pw4KfP14rTONSRRvw3KSDR/udWMrptttk+7LVBnKJeCvwtwc+jIxKC2BipbJIaZ9w6b5
         klOZBhxjk2LL5XYfAwnIeT4IU1g6mp+i8zJxHImr50f+uy6y/9UPUdPvPGFbuUHxb6Xw
         k01z2Inj1FXhNTWtQ9zcg+m1XgXHfJM0LEfGj2CNFFNC8QKk1i4YIB7GlUQpbPWDW5C4
         +/LVl62MRCQ5eIPRWjTy5AF0vneCKCEjaTdNoN03aL7kNAHIAu4qVF55OCrKyev1T6yl
         3C/Q==
X-Gm-Message-State: AO0yUKWD5+TZDNvOVmXDYsX3+pVA52FegsvkazCocBLqO58ppKFuVdiG
        pEXmm85q1EuJacdCH0evHg==
X-Google-Smtp-Source: AK7set92aKdGbpcZZyqFvlSPYqdynwG67jsS6BpeGQBtJTWKzl+WmX1os7w4hj93Cx3MmUnuEkNq4g==
X-Received: by 2002:a92:c243:0:b0:323:2bbb:ba4e with SMTP id k3-20020a92c243000000b003232bbbba4emr7685589ilo.30.1679007740546;
        Thu, 16 Mar 2023 16:02:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id s20-20020a92c5d4000000b00315d1153ffcsm151976ilt.65.2023.03.16.16.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:02:19 -0700 (PDT)
Received: (nullmailer pid 4048542 invoked by uid 1000);
        Thu, 16 Mar 2023 23:02:18 -0000
Date:   Thu, 16 Mar 2023 18:02:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: qcom,sm8550-pas: require
 memory-region
Message-ID: <167900773675.4048467.1808457908272178646.robh@kernel.org>
References: <20230309082446.37362-1-krzysztof.kozlowski@linaro.org>
 <20230309082446.37362-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309082446.37362-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 09 Mar 2023 09:24:46 +0100, Krzysztof Kozlowski wrote:
> The memory-region is defined in device specific binding, not in
> qcom,pas-common.yaml, thus also require it in the same place.
> 
> Fixes: 084258d60712 ("dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp, cdsp & mpss compatible")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

