Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E229374BE29
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjGHPZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjGHPZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6691709;
        Sat,  8 Jul 2023 08:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D725260DB6;
        Sat,  8 Jul 2023 15:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB4EC433C7;
        Sat,  8 Jul 2023 15:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688829953;
        bh=GG8YM0Puer7whZwbzMM2expgs92RcpYarOVPk2QuQQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QJAp9t44wg3H5l/6KehNF3hh94tDQDRJmMHuON21x0/pNYOVrkrSUDQy1lAGlTzbp
         xB3+CbBsT+xvpmW311+IXpfVWvujbhCvXv7Z6gLRpdRcnMX/4pFqdUwDinmLfIPCXd
         znWhSfej1nqPe12tTpYwRf/PZsfNHHtYruAd8l801L1wK9LirBvRNdsR17B+muPKQY
         bBN+ul5Mvv/mZJvdFSI+O9J2z/2LxpjqkeT/gKKCjbpRzZEhpF7jDZsEiIeXqaNHd0
         y26BI0AnXJT+qHku7q+xxcxZ2Z3gGW1SnumiDultg+J9GJC/obYoY/qFAfoQAZ2j9m
         K/DwJQpv5QH0Q==
Date:   Sat, 8 Jul 2023 16:25:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jishnu Prakash <quic_jprakash@quicinc.com>
Cc:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <quic_jestar@quicinc.com>, <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Luca Weiss" <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Message-ID: <20230708162541.1a15ed14@jic23-huawei>
In-Reply-To: <20230708161259.7af17fa9@jic23-huawei>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
        <20230708072835.3035398-7-quic_jprakash@quicinc.com>
        <20230708161259.7af17fa9@jic23-huawei>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >  properties:
> >    compatible:
> > @@ -27,10 +27,11 @@ properties:
> >            - qcom,spmi-adc5
> >            - qcom,spmi-adc-rev2
> >            - qcom,spmi-adc5-gen2
> > +          - qcom,spmi-adc5-gen3
> >  
> >    reg:
> >      description: VADC base address in the SPMI PMIC register map
> > -    maxItems: 1
> > +    minItems: 1  
> 
> ?
Found it now.  This needs documentation that it's providing multiple
base addresses for gen3.  Also needs to only apply that to gen3...


