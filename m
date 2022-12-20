Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E61F65268C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiLTSrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiLTSqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:46:44 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D771AD9A;
        Tue, 20 Dec 2022 10:46:10 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1443a16b71cso16413190fac.13;
        Tue, 20 Dec 2022 10:46:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtGYA4nYrfpj33PGdbVkenftz/iHxuFbKXLM7Hq+aW4=;
        b=erzt+9qJl15+mvqRmgPgo2R+KmGp7Ma7dev8piaHQfpU9k8FGYC9DHDTlhvbFnEb1n
         Bs4nGr9UO7FJuoVwgQnGpwPL7zUFxzR+qhliHLIDNKl0ojAJPQqeCbJp1r76LI1tRti1
         N0vrEJer9VE62lBRi0kAL75jKBib9i5CgHauiR0TSMqBlaXHdqRWS6CVTEbsvgbULsTj
         F+kX7rUaMFbaVKkpW4N3NKTvvFXer/7iz3zIrKoQBV6+t9Whnn1q5pwFkJ6W35TtO5PK
         HUO/BwoMGap1VT+/jIbnyADaRuOmVIb5q4+BfRBpNWF7psnz0Z8DkP3hIEVHhn8s/Wv0
         +5lg==
X-Gm-Message-State: ANoB5pkStcEFLi0/SG00hAV0igMQqq06795V3fQ4IKjKFc4EqYuAziBT
        IjH910e6x9hdK5DVS6t20g==
X-Google-Smtp-Source: AA0mqf4O68SSZaVnZpk87bzzNvcns3v8OXsGoUJYBI+nOMXBUa8lR9WDvgexUnTy4bpkQsGY4tiZWg==
X-Received: by 2002:a05:6870:ec87:b0:144:6a45:bafb with SMTP id eo7-20020a056870ec8700b001446a45bafbmr25763414oab.42.1671561969241;
        Tue, 20 Dec 2022 10:46:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eh5-20020a056870f58500b001446480a042sm6309134oab.58.2022.12.20.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:46:08 -0800 (PST)
Received: (nullmailer pid 893173 invoked by uid 1000);
        Tue, 20 Dec 2022 18:46:07 -0000
Date:   Tue, 20 Dec 2022 12:46:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     dmitry.baryshkov@linaro.org, konrad.dybcio@somainline.org,
        dianders@chromium.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        quic_abhinavk@quicinc.com, daniel@ffwll.ch, robh+dt@kernel.org,
        robdclark@gmail.com, devicetree@vger.kernel.org,
        swboyd@chromium.org, agross@kernel.org, sean@poorly.run,
        quic_sbillaka@quicinc.com, dri-devel@lists.freedesktop.org,
        airlied@gmail.com, vkoul@kernel.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v15 2/5] dt-bindings: msm/dp: add data-lanes and
 link-frequencies property
Message-ID: <167156196670.893113.12368377615757761659.robh@kernel.org>
References: <1671227102-21717-1-git-send-email-quic_khsieh@quicinc.com>
 <1671227102-21717-3-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1671227102-21717-3-git-send-email-quic_khsieh@quicinc.com>
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


On Fri, 16 Dec 2022 13:44:59 -0800, Kuogee Hsieh wrote:
> To increase the flexibility of supporting different DP main link configuration
> at different platform, add both data-lanes and link-frequencies property
> into endpoint so that different platform can specify its own main link
> combination of both data lanes and max supported link rate.
> 
> Changes in v7:
> -- split yaml out of dtsi patch
> -- link-frequencies from link rate to symbol rate
> -- deprecation of old data-lanes property
> 
> Changes in v8:
> -- correct Bjorn mail address to kernel.org
> 
> Changes in v10:
> -- add menu item to data-lanes and link-frequecnis
> 
> Changes in v11:
> -- add endpoint property at port@1
> 
> Changes in v12:
> -- use enum for item at data-lanes and link-frequencies
> 
> Changes in v13:
> -- revised changes at port@0
> -- use correct ref schemas for both port@0 and port@1
> -- mark both port@0 and port@1 are required
> -- add line between data-lanes and link-frequencies properties
> 
> Changes in v14:
> -- add "unevaluatedProperties: false: to endpoint at port@1
> -- remove unnecessary quote to $ref
> -- re store "$ref: /schemas/graph.yaml#/properties/port" to port@0
> 
> Changes in v15:
> -- re store desciption of port@0
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>  .../bindings/display/msm/dp-controller.yaml        | 25 +++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
