Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059E16617E8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 19:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjAHSMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 13:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbjAHSMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 13:12:24 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D36BC5;
        Sun,  8 Jan 2023 10:12:15 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id o8so3846109ilo.1;
        Sun, 08 Jan 2023 10:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX14fWS4r2WLjwMZynaPJpioCPRRdQEkuCm2JEOBH9E=;
        b=C69npXRv+P31SevtJ0d+OtNDqK3/sL+rGVmRViiu4ihbK5fYah8MJk8Pds/l8EzAgs
         fB191K+wCEwSnxdw9wNdLgPe3Flu4Nfa8xms159mtuaF1ko5F9x5T3/WJcimjYU3EMf5
         bQ0yvI6uIQNEZp719pF+NAsWCA0Y/0L+/0NI8dc49CMN8mPdc8kK3nq3zze9aQZZdOli
         QCYTosqmnM+MgkyJVUW/dPtNn+8BWeKtzjBm84MsWWK1+gMAWxtrgu1xQpgnor71Dd83
         Pjy9DOti9MZztiQopL/1LfG8nKqxIajsSHyzhIEOquR041zbwPkyP/R1KedBZ3bvZSR+
         duDw==
X-Gm-Message-State: AFqh2kpGG8K6NylYZBbr/yuPt10WmWwKYnRYrs4JFwI1mKUVYksQ1/XM
        /iQTxoHujpECgwdH8bdjVQ==
X-Google-Smtp-Source: AMrXdXuhKSgOVXHDqYXmylCy1SIcxR4tYXYF9CrnA4rt94dPFYzyVPhjpLTM/Ugnm8hQmWZleK1Zaw==
X-Received: by 2002:a92:d846:0:b0:30c:63d5:a300 with SMTP id h6-20020a92d846000000b0030c63d5a300mr13653721ilq.21.1673201535148;
        Sun, 08 Jan 2023 10:12:15 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id z17-20020a027a51000000b0039e296bf18esm2130982jad.167.2023.01.08.10.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 10:12:14 -0800 (PST)
Received: (nullmailer pid 156294 invoked by uid 1000);
        Sun, 08 Jan 2023 18:12:12 -0000
Date:   Sun, 8 Jan 2023 12:12:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: phy: qcom,sc7180-qmp-usb3-dp-phy:
 correct SC7280 compatibles
Message-ID: <167320153134.156239.2836472885331360656.robh@kernel.org>
References: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115944.55425-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 25 Dec 2022 12:59:43 +0100, Krzysztof Kozlowski wrote:
> USB3 DP PHY on SC7280 is used with SM8250 fallback:
> 
>   sc7280-herobrine-evoker.dtb: phy-wrapper@88e9000: compatible: ['qcom,sc7280-qmp-usb3-dp-phy', 'qcom,sm8250-qmp-usb3-dp-phy'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../phy/qcom,sc7180-qmp-usb3-dp-phy.yaml        | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
