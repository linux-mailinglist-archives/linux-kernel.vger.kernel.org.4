Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C8361692A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiKBQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiKBQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:33:44 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E682CDF5;
        Wed,  2 Nov 2022 09:29:35 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id r10-20020a4aa2ca000000b0049dd7ad4128so95115ool.13;
        Wed, 02 Nov 2022 09:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgD8c+pefwqTCjp2v4u0OtX3VghETalJ8uHDLcccGzQ=;
        b=zlqlswkLUKufG+m9jLI/Fa6baHeiPPTIXVPdL4vx5qO3XIOwa4S44h2UOu5Ayqskq8
         YYKoK94a3w0PSOoDl9Mv11g/iQsd4Y40eh7s7D2ot30Ekx9RWDFq7lCE1or9/Z1zQGYR
         VCeKBSwAFSuTgkpc8qa1SczaElRfrfV2+l2goDIZ8iXXQvWKuSI8+IiF0y54dFhldopb
         ZFIMFy0duNDI7qCacBtd0zQmLOjv8ZOVI9uvcpXpHdwx+SqVVqKBdcYjF/AWafXiEsns
         3sdolsQfh2OL/3O7lcwntfJhdcdckNQ1HhEbCqETaIeqYn8Zuja/CEQFl+/ViOM91KVl
         rp4A==
X-Gm-Message-State: ACrzQf0+oAi2mH1D49SUADYXRqVJDs26dxR1Ww1O4K1eFEKEYY3v7fOx
        M019vGRrXg/jjC9XDf3PZQ==
X-Google-Smtp-Source: AMsMyM74yiL/T5nDD23UaKKVS5GHu3Kuf6izs9ibgsU02irwitzkoseK958529BgSkAtG008UvX57A==
X-Received: by 2002:a4a:be95:0:b0:47f:73a4:9f16 with SMTP id o21-20020a4abe95000000b0047f73a49f16mr10820469oop.39.1667406574244;
        Wed, 02 Nov 2022 09:29:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx12-20020a0568081b0c00b003539686cb7bsm4718234oib.53.2022.11.02.09.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:29:33 -0700 (PDT)
Received: (nullmailer pid 4003916 invoked by uid 1000);
        Wed, 02 Nov 2022 16:29:35 -0000
Date:   Wed, 2 Nov 2022 11:29:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com
Subject: Re: [PATCH v2 06/15] dt-bindings: ufs: Add "max-device-gear"
 property for UFS device
Message-ID: <20221102162935.GA4002811-robh@kernel.org>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-7-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031180217.32512-7-manivannan.sadhasivam@linaro.org>
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

On Mon, Oct 31, 2022 at 11:32:08PM +0530, Manivannan Sadhasivam wrote:
> The maximum gear supported by the UFS device can be specified using the
> "max-device-gear" property. This allows the UFS controller to configure the
> TX/RX gear before starting communication with the UFS device.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-common.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> index 47a4e9e1a775..5dcd14909ad5 100644
> --- a/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> +++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
> @@ -73,6 +73,11 @@ properties:
>      description:
>        Specifies max. load that can be drawn from VCCQ2 supply.
>  
> +  max-device-gear:

Needs a type $ref

> +    description:
> +      Specifies max. gear the UFS device supports.
> +    enum: [1, 2, 3, 4, 5]
> +
>  dependencies:
>    freq-table-hz: [ 'clocks' ]
>  
> -- 
> 2.25.1
> 
> 
