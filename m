Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F0366A460
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjAMUsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjAMUrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:47:40 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5695B88DDC;
        Fri, 13 Jan 2023 12:46:50 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id s124so1815940oif.1;
        Fri, 13 Jan 2023 12:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OyV33OUJhlI5mwm69sd2O9VmK+PLImRqzdV7apRGPI=;
        b=Sq3sVIFm9IGjdMMzLwg0/JDW9bOfBEd6kD8j7G2PjWmCIkXik2Kmqa2UOErL1IqUb4
         NNTEUCrMObdnCqJilrpp+qdRs2ePnTYyT9YeOlDtdtU2pLXDMsKOkf5YtJSNRO+2+l1O
         0njLW0SsD1bS8lufozGf6Ds1UBcPlwozqXLno9YyY96utDJ8KCNOKzm+TRrun7ZvR8+F
         Ywk7bVkvrcmlwXrOyl9lQj+cDPKXjtQYdp3miVyUbeXRptvZ0pqATUHD9IulrhCnAR3V
         lW+6OxvlnP1Bga28mn4m5z8As1VYSvG2PaNoRKDrrCOJ9yGqd2enONWhEYq7YEGaVOYP
         TfCg==
X-Gm-Message-State: AFqh2kpqAMhNq4/jsuoXEnJkNgrLW7UUXYrVmU4PQW/1siJEjlZ/xqBQ
        1/mPTqStGtZeLDHfK8nPPg==
X-Google-Smtp-Source: AMrXdXvgM0nwUjelEFyWvjA8p6YbDz6iLcaYHxcRZS7w24OHTPmEhdC9mh67Ds8JNlwgfrNKRnuaLw==
X-Received: by 2002:a05:6808:18aa:b0:35e:1a0f:7dea with SMTP id bi42-20020a05680818aa00b0035e1a0f7deamr47989197oib.12.1673642797896;
        Fri, 13 Jan 2023 12:46:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q10-20020acad90a000000b00354932bae03sm9630099oig.10.2023.01.13.12.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:46:37 -0800 (PST)
Received: (nullmailer pid 2893298 invoked by uid 1000);
        Fri, 13 Jan 2023 20:46:36 -0000
Date:   Fri, 13 Jan 2023 14:46:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6] dt-bindings: soc: qcom,rpmh-rsc: Update to allow for
 generic nodes
Message-ID: <167364279598.2893245.18171316624883671372.robh@kernel.org>
References: <20230112203653.23139-1-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112203653.23139-1-quic_molvera@quicinc.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jan 2023 12:36:53 -0800, Melody Olvera wrote:
> Update the bindings to allow for generic regulator nodes instead of
> device-specific node names.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,rpmh-rsc.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
