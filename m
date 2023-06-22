Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1B77394DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFVBrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjFVBrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:47:41 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB931728;
        Wed, 21 Jun 2023 18:47:40 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-77e2bc54dc4so202998039f.3;
        Wed, 21 Jun 2023 18:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398459; x=1689990459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxMBzdhc3thRH3Ox9+FmX83JNR0DeAiToQS4RRJGXrI=;
        b=Nnm3HLAyKWC5r4NGlCMv1naKznca7j+xhFgZ19wqs+kZIPZ7czgzeOQIc5Nt4Wf2E1
         9MK7Ea+jwZo0Q1uIUcZSKLZ3KzWv3X52CT4Pw5ldtugf+y4ioQcg0Ff9QA1x56dCQ+5o
         86evCHu83dBh0Givv0to5ovGMQrCiXgZ2TztX0kN+uJ4VxYgsL5KISO+f9YBt5xOpNQR
         trcuDRDugoXnWTA0UZO9eeH3RuE2IrPUHOf95AJwld/ic+5PuTWPap7sAh4Z7OCp430/
         g2k1kB61xdynzElUW5fvamlHbZ5GC8Bav4ifk9DjmEhToLnJY7k92cy4RANmhr7VYtWr
         4hGA==
X-Gm-Message-State: AC+VfDzwR1SogbPQ2BPJfHcwBzofKa8cg2ERWgM3uQINJfjqwJpbqmgY
        WK71Qy7G0/x8fSYQa9QBaQ==
X-Google-Smtp-Source: ACHHUZ6ZzPBrrpWOu5FEgwqL3lvRij7Usol6i49++Dwr9iWEHwuipVBM2/HWj6E7d/cRmfokxgWfcg==
X-Received: by 2002:a5d:8455:0:b0:780:c221:89e9 with SMTP id w21-20020a5d8455000000b00780c22189e9mr2342065ior.5.1687398459283;
        Wed, 21 Jun 2023 18:47:39 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f15-20020a6bdd0f000000b0077a1b6f73b9sm1746146ioc.41.2023.06.21.18.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:47:38 -0700 (PDT)
Received: (nullmailer pid 36376 invoked by uid 1000);
        Thu, 22 Jun 2023 01:47:35 -0000
Date:   Wed, 21 Jun 2023 19:47:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konradybcio@gmail.com>,
        coresight@lists.linaro.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hao Zhang <quic_hazha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        andersson@kernel.org, Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v6 12/13] dt-bindings: arm: Add support for DSB MSR
 register
Message-ID: <168739845539.36318.15881976274380727647.robh@kernel.org>
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
 <1687246361-23607-13-git-send-email-quic_taozha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1687246361-23607-13-git-send-email-quic_taozha@quicinc.com>
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


On Tue, 20 Jun 2023 15:32:40 +0800, Tao Zhang wrote:
> Add property "qcom,dsb-msrs-num" to support DSB(Discrete Single
> Bit) MSR(mux select register) for TPDM. It specifies the number
> of MSR registers supported by the DSB TDPM.
> 
> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom,coresight-tpdm.yaml | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

