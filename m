Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36CA5B5EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiILRKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 13:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiILRKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 13:10:16 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761BD1261D;
        Mon, 12 Sep 2022 10:10:14 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-12b542cb1d3so15335482fac.13;
        Mon, 12 Sep 2022 10:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=H+eC+D1EpLweVFQ6KYEwzGMz7cCBHgt9KoW63rykd5M=;
        b=nchISQvkfkDMcCgkNpYWuPbtZamJ0UKnrBKWlZttKEqZXrh9hYAbgxeHZUoEi1iVzX
         3Fnku2eiYI1zuQAh4v6odex7nBDO+9RsVkovYMbp4fSSj/6JBal9tRLbQADLVgDn2HvA
         ZKbnwXIP7Wg9gtsvNldorBu3c+Pi5ad1RzVGrozXfXPahzOL6tFV75JDVUUgKE4nzBHM
         F9T5OtD35/C8cxhJXVa2XI5/4y8qKJKv+K1pK9jQcev/unWCO4Oijv2+47ch2kDFDRZL
         eFLY3sVwx7pebXchyCP+9kx6AxdkDYvljQj/nEeB7aHzZNtMDMVfbsowt3aVM8+uyO7d
         xtKg==
X-Gm-Message-State: ACgBeo0ymh8cA9LSiohWQdduSD7ejswxCBKdXP6IUeIRrlruYv8HO51o
        WOB68smrZOecXzIUBQhynQ==
X-Google-Smtp-Source: AA6agR5OI24ze1C3DwDH1kYGQX5w3a4JtPGUcIzsYckZohS0aoB+WsqIkel2p5j9gBLePwnB/LHh8Q==
X-Received: by 2002:a05:6808:11c7:b0:347:cab3:9e5d with SMTP id p7-20020a05680811c700b00347cab39e5dmr9355582oiv.217.1663002613773;
        Mon, 12 Sep 2022 10:10:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b40-20020a056870472800b0012696ac05d5sm5862989oaq.19.2022.09.12.10.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 10:10:13 -0700 (PDT)
Received: (nullmailer pid 1481293 invoked by uid 1000);
        Mon, 12 Sep 2022 17:10:12 -0000
Date:   Mon, 12 Sep 2022 12:10:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bharath Kumar <bkumar@qti.qualcomm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Anirudh Raghavendra <araghave@quicinc.com>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 03/10] dt-bindings: misc: fastrpc: Document
 memory-region property
Message-ID: <20220912171012.GA1481161-robh@kernel.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
 <20220909133938.3518520-4-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909133938.3518520-4-abel.vesa@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022 16:39:31 +0300, Abel Vesa wrote:
> Add memory-region property to the list of optional properties, specify
> the value type and a definition. This property is used to specify the
> memory region which should be used for remote heap CMA.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> Changes since v2:
>  * addressed Krzysztof's comment by specifying what's the use of the
>    memory region
> 
>  Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Applied, thanks!
