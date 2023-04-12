Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223F56DF8AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjDLOhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjDLOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:37:08 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1118D9745;
        Wed, 12 Apr 2023 07:36:33 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-183f4efa98aso20085557fac.2;
        Wed, 12 Apr 2023 07:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310180; x=1683902180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnuVW5Vp/+EHlp3UdQMcKQ8pXzh4inb4O6e6LBWQKfA=;
        b=hO3k/7a2ckZriB3J4lqhZQFfbA/J3EOrpGJAGkktvclAUl6RQFi4Iigl1dXuyuiw+m
         h5MEdhXa6LUAwwkBHKsdKT3NNHUL8bUwpN67SX2iryXruM8KBCDa+umZEQTnlIFio5TH
         H5arETo6HUlv58TBP2AQ8mlGxPflFxoZ30uPi/fHCZ9Dh2MNWl3UrhGBWE0S+1u4q1BW
         0oZ2BgZ1KMq0tyuPmwfuLXu+DeRt/ZgOBf7XBRFHdftPRPXVgd7mxeYT217QSnCZywMW
         hjCMyoqjnJ3r3jgQsFrx/igCvAI+exmf3y3hqEQjKGNxCNa+SHmPG1G4iaD9RfY3L16W
         PnrQ==
X-Gm-Message-State: AAQBX9dDlB7LxPOlIcCzxdDmZDt4MMvcihn1whhfnRhlNLkFLnEaDkpG
        fK9k/z1wwMTeNVQ0IYwTmg==
X-Google-Smtp-Source: AKy350Yrb4lQU2MjSsBsCSaX0JiNW9MIuuGctZGj/LJOLA9/nYNk7N26TsBKUAGKiWf9TDUJUEj+Sg==
X-Received: by 2002:a05:6870:51f:b0:17b:1214:5fd7 with SMTP id j31-20020a056870051f00b0017b12145fd7mr10030861oao.17.1681310179916;
        Wed, 12 Apr 2023 07:36:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a056870d20400b0018045663fc5sm6230397oac.48.2023.04.12.07.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:36:19 -0700 (PDT)
Received: (nullmailer pid 2328230 invoked by uid 1000);
        Wed, 12 Apr 2023 14:36:18 -0000
Date:   Wed, 12 Apr 2023 09:36:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: iommu: Convert QCOM IOMMU to YAML
Message-ID: <168131017435.2328084.7641188921075798677.robh@kernel.org>
References: <20230406-topic-qciommu-v3-1-aa0e4f018191@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406-topic-qciommu-v3-1-aa0e4f018191@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 20:47:28 +0200, Konrad Dybcio wrote:
> Convert the Qualcomm IOMMU bindings to YAML.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v2 -> v3:
> - Add additionalProperties:false & required for ctx subnodes
> - Drop the IOMMU consumer device from the DT example
> 
> v2: https://lore.kernel.org/r/20230406-topic-qciommu-v2-1-b8547622b2a4@linaro.org
> 
> v1 -> v2:
> - Include missing header
> - pad the addresses to 8 hex digits
> - add 'reg' to the mdp device
> 
> v1: https://lore.kernel.org/r/20230406-topic-qciommu-v1-1-03f17717a447@linaro.org
> ---
>  .../devicetree/bindings/iommu/qcom,iommu.txt       | 122 ---------------------
>  .../devicetree/bindings/iommu/qcom,iommu.yaml      | 113 +++++++++++++++++++
>  2 files changed, 113 insertions(+), 122 deletions(-)
> 

Applied, thanks!

