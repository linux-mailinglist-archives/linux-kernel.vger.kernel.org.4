Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F37652693
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiLTSt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiLTSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:48:54 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960A82190;
        Tue, 20 Dec 2022 10:48:42 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1433ef3b61fso16442329fac.10;
        Tue, 20 Dec 2022 10:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ytKaJkMhcvyfNKM2LNQIaycFjXnKishY4XMYjat3yc=;
        b=JzzMX/yvg3efT0tMy7JssV57UHB/gW2ruQmZlUcgUlUosKlxOqSEJJtdG4WHHz024f
         Cvl2mXq1URaEdBx+2i7SuZE9xb+bhTrsrj1iFYjgOUb2purycsF0OnENNECefrS+x+4a
         3G+A2IGXRqrRwDoek3tvv+eZGEV/pd2TD3pgl8ekO9pG19zLC0e07nLnetCvbR1LwPdy
         Z8leve/1Mr04EnDKYdYVVW+LyK6rSmcHntn6zJq7LBUIQ58M0YrzsyVJL4qCbssnIX9f
         iP8uoftNE0HpNsmogULuCeDisVvrEj9vPnxYOWNlztmV6Unk4k/YBlqJgcseUHXUVg0H
         8BZw==
X-Gm-Message-State: ANoB5pnPBekGbWrX/GVpUlnTOKt4YxwcCFkI8YuHq+LSLscqsU2QqaKA
        YbyEWPNNqFggKUgy+NRHUZePUMntIQ==
X-Google-Smtp-Source: AA0mqf4SRyJy7+XouzDY3uISlvGtTQkbw79hhvNlfAChkrQEvzGGiMW+1fdsHNwtusTeEayYpN3CWw==
X-Received: by 2002:a05:6870:cb8a:b0:143:834c:f722 with SMTP id ov10-20020a056870cb8a00b00143834cf722mr21344510oab.25.1671562121889;
        Tue, 20 Dec 2022 10:48:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fo29-20020a0568709a1d00b0013297705e5dsm6397852oab.28.2022.12.20.10.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:48:41 -0800 (PST)
Received: (nullmailer pid 896525 invoked by uid 1000);
        Tue, 20 Dec 2022 18:48:40 -0000
Date:   Tue, 20 Dec 2022 12:48:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Melody Olvera <quic_molvera@quicinc.com>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Odelu Kukatla <quic_okukatla@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: interconnect: Add QDU1000/QRU1000
 devices
Message-ID: <167156211955.896464.4722147232675381976.robh@kernel.org>
References: <20221216230914.21771-1-quic_molvera@quicinc.com>
 <20221216230914.21771-2-quic_molvera@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216230914.21771-2-quic_molvera@quicinc.com>
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


On Fri, 16 Dec 2022 15:09:13 -0800, Melody Olvera wrote:
> Add separate schema for QDU1000 and QRU1000 interconnect devices
> to document the different NoCs on these platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../interconnect/qcom,qdu1000-rpmh.yaml       | 70 +++++++++++++
>  .../interconnect/qcom,qdu1000-rpmh.h          | 98 +++++++++++++++++++
>  2 files changed, 168 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qdu1000-rpmh.yaml
>  create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000-rpmh.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
