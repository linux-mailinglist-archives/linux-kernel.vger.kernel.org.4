Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E9D613FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJaVf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJaVfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:35:55 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DF2F1A;
        Mon, 31 Oct 2022 14:35:55 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso7478589otq.11;
        Mon, 31 Oct 2022 14:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+/zgHOS0Ou1UV4VzQv0RccN8iu9tqxyYtVPteOxY5g=;
        b=lzOCG1yTZm7nBkYeRMfrWlbcZqpjxwW9Ceqdu1DDOT8/UCNYPcLq22qoudoKRehMib
         flEcK6BoPu9oRlAU3fdH3DY0rL4leXte7WtiKqfJzRuGuIypbzggOSlpZjAOtHRtj1dR
         1LLumPwkbU7/mWZl8PtAUTlu+G1lJmve0ab8g3rCQRA3DtT6gOiL5hGhff+gBQVsHRp/
         6X6fbCUGkQUwDVgmzr9Ja2aFgks9RKmo1bqcg2b4+GSRGExVMtpJKzH08ep99z42YYRy
         LBRkP8R5Z951I5Ziy4XzsDmvkZRTB6iKzcpDEFfEb92dcahAGlv2wqLvQBGFbo6D2+4z
         RTEQ==
X-Gm-Message-State: ACrzQf1GZ5st1W5f1uXz+s8/oq2e1gnEL0ljoKcyUBzJhmz1IZ8M9r+a
        8UyEeWYJzDac57Nj4RXdMQ==
X-Google-Smtp-Source: AMsMyM72rdo/aoWJur3C5dAMhoEQwG8HKWvr8NuIFDI13Uf6ox91SAsgLi3VAkbfir4Vdo8AvdftmA==
X-Received: by 2002:a05:6830:3156:b0:661:e5d1:725d with SMTP id c22-20020a056830315600b00661e5d1725dmr7783335ots.312.1667252145823;
        Mon, 31 Oct 2022 14:35:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z13-20020a056870460d00b0013c50b812a2sm3586826oao.36.2022.10.31.14.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:35:45 -0700 (PDT)
Received: (nullmailer pid 3612387 invoked by uid 1000);
        Mon, 31 Oct 2022 21:35:47 -0000
Date:   Mon, 31 Oct 2022 16:35:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jejb@linux.ibm.com, krzysztof.kozlowski+dt@linaro.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        martin.petersen@oracle.com, quic_cang@quicinc.com,
        konrad.dybcio@somainline.org, andersson@kernel.org,
        vkoul@kernel.org
Subject: Re: [PATCH 06/15] dt-bindings: ufs: Add "max-gear" property for UFS
 device
Message-ID: <166725214647.3612331.2799684267401119391.robh@kernel.org>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
 <20221029141633.295650-7-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029141633.295650-7-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Oct 2022 19:46:24 +0530, Manivannan Sadhasivam wrote:
> The maximum gear supported by the UFS device can be specified using the
> "max-gear" property. This allows the UFS controller to configure the
> TX/RX gear before starting communication with the UFS device.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-common.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
