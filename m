Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA596F073B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbjD0OXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbjD0OXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:23:02 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69535BBF;
        Thu, 27 Apr 2023 07:22:37 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6a5e905e15aso3124971a34.1;
        Thu, 27 Apr 2023 07:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682605342; x=1685197342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gLDwWMtMBMb7y/jrCbWtT0/Hn7uUjkpKAJY/4sZ7Bs=;
        b=PgeyRR4N6e45+vwoG+gVglfHXc8nb7hLAGJbZYq+d9hFMmS/JQ4ypRIeOr/I865NRT
         WUto93XZy20ApJh0aECwQLwkJ2mLzlamHItK3B8rpNhQEBuLaYk7ty7Qs/tYvNjM4Dtj
         aqIoO2iJTeMDKVytNSwoX28gWBS4t8zTXTEcCW3ekamOX4gMg494pX6qS+AGG7/SN6U3
         XKlXmXYCunNaHtD0yxyDQtIfbdnzA2zQ76ekQOqLoEY6ujwHfvkR9h9j0apCQy3kIaVq
         4F5R2DjgKUEP3+NoaCuSTwIXpcDcAJ1EaFzFEgsmvIrcvvpJB52+GmJoQlGbkL5J4kvl
         wZqQ==
X-Gm-Message-State: AC+VfDwZ7fS7VyCL3umgQifsh7oRfzw6RAS1x77KXpCgtSgL/b8qB11e
        +kmE2DzJznOK7szVi9ISTg==
X-Google-Smtp-Source: ACHHUZ4BWEVnqnsdAsGY7E1vQ9qbP2prNMAfDqV6P5Yn5brYFtyS3A8u18GVW90OuUhA4zsAyR4Z+A==
X-Received: by 2002:a05:6830:1614:b0:6a6:2d87:e2ec with SMTP id g20-20020a056830161400b006a62d87e2ecmr888782otr.14.1682605342417;
        Thu, 27 Apr 2023 07:22:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f12-20020a9d6c0c000000b006a44338c8efsm6790490otq.44.2023.04.27.07.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:22:22 -0700 (PDT)
Received: (nullmailer pid 2990071 invoked by uid 1000);
        Thu, 27 Apr 2023 14:22:21 -0000
Date:   Thu, 27 Apr 2023 09:22:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        andersson@kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1 2/6] dt-bindings: phy: qcom,usb-snps-femto-v2: Add
 bindings for SA8775P
Message-ID: <168260534009.2990013.16903959800829842763.robh@kernel.org>
References: <20230421133922.8520-1-quic_shazhuss@quicinc.com>
 <20230421133922.8520-3-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421133922.8520-3-quic_shazhuss@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Apr 2023 19:09:17 +0530, Shazad Hussain wrote:
> Document the compatible string for USB phy found in Qualcomm SA8775P SoC
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---
>  .../devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

