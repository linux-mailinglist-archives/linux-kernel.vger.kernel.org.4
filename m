Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4622F6DF92C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjDLO5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:57:47 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC247696;
        Wed, 12 Apr 2023 07:57:36 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w19so7854941oiv.13;
        Wed, 12 Apr 2023 07:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681311456; x=1683903456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iMxXEh/refxEn2BVLKI2zG+gF/jaetDaYeI4Maspl7s=;
        b=3V1ECEK4nUXZsIDs14ektY4ee1VpMmpa0cFA5BdoJnVXNsvEQA7uVA4l9UMiywkssm
         X8+l9DFGfJ15LiZrZ1fkIO4HlD232eEzv648P1DKlmfO0fgliW7rci89O93NjsjL2Qrv
         kH4704CUJhE3yGNM9QAG4wTfkpErnsBi5InGD9WIku4Hq1zGQK+TxVDKdBM2GK89bosJ
         5fUJhld9Mnnaw8oULKjfbe5LSE2nuqq+VSvZxBiSVbj1wF5NRS2JT4WqdeBN9rqOfWS7
         0H/rw6a4ZspvGOsYzC6S17NeVRT05uDRkdQmtSbwpdzhWJn+Qh9ryhCf/H/U3esQzDYT
         qOXw==
X-Gm-Message-State: AAQBX9ctcNnKzdWcbGOkkFURkNiPEaRXLJkjzSscXmg0GIfzraU/ALhW
        kIMaub3aM4V11Q26wKiBMg==
X-Google-Smtp-Source: AKy350aqIqgD6ZUzUetWYjloDIl1Z+9gM07oApCpq4K8/QG9Y/jPsecHAHyYaHOlNFpjRXG8NcayTw==
X-Received: by 2002:a05:6808:281:b0:38b:a6be:7a57 with SMTP id z1-20020a056808028100b0038ba6be7a57mr3172426oic.28.1681311455736;
        Wed, 12 Apr 2023 07:57:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o2-20020a0568080bc200b0038413a012dasm6677495oik.4.2023.04.12.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:57:35 -0700 (PDT)
Received: (nullmailer pid 2357068 invoked by uid 1000);
        Wed, 12 Apr 2023 14:57:34 -0000
Date:   Wed, 12 Apr 2023 09:57:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        linux-remoteproc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: media: qcom,sdm845-venus-v2: Allow
 interconnect properties
Message-ID: <168131145406.2357008.9122812908931031702.robh@kernel.org>
References: <20230407-topic-msm_dtb-v1-0-6efb4196f51f@linaro.org>
 <20230407-topic-msm_dtb-v1-1-6efb4196f51f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407-topic-msm_dtb-v1-1-6efb4196f51f@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 07 Apr 2023 15:28:31 +0200, Konrad Dybcio wrote:
> Allow the interconnect properties, which have been in use for ages.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/qcom,sdm845-venus-v2.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

