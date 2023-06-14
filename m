Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7038A730777
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjFNSl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjFNSky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:40:54 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB732137;
        Wed, 14 Jun 2023 11:40:51 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-777a78739ccso385800539f.3;
        Wed, 14 Jun 2023 11:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686768051; x=1689360051;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9bkX1K24HhQtKumvGXLdDfYBuEzGgLYupOfZPyAl6Y=;
        b=KuAsC7O2HanOH2kOAWp8ySa2VPeZzB8L8Qhhy1OkP5hihGclMilqCEqSr3xuIKGZda
         b/ra30iqzdsLBepzqUtl+p2WUP6QIZ5ZfFOBbTpsQqaoW7tAKcJlThuNkJ77+jEXXEmf
         K4YMBwhHXBpm7lIbrDZ+lPqkSQp5+NgQ2GO1eDK857mL7+8xNJ8LEUVGtdRND8TNbAef
         F//rZEMUF9ISM+yMY7pCjUwgvUzyrg2kRC5VxITKbx4Cgq9Fq+nUHaRn8+aChLOvlLFB
         V3ShVvDBlVycgZKsmBRsZwlTqSGsImqhyGrD2GtJGP3tXgNT+muoAr94MuhI83tanzt+
         81gw==
X-Gm-Message-State: AC+VfDymdriyRCk9XY59WSNrTKS1evpS+Os0ly+NF0S8DKw1An/z1c1i
        rzqx02C1IPruG6//gU5vBg==
X-Google-Smtp-Source: ACHHUZ79MrwRGKHIQnJ8LRcxJbjX5Yql+A6VplX9d0CEwLBnl2HrKPc91lQln9L3TOQdVAQZJrtVAQ==
X-Received: by 2002:a5e:db07:0:b0:777:8e86:7636 with SMTP id q7-20020a5edb07000000b007778e867636mr15939318iop.15.1686768050943;
        Wed, 14 Jun 2023 11:40:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g14-20020a02b70e000000b00418ae2206b1sm5236807jam.107.2023.06.14.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 11:40:50 -0700 (PDT)
Received: (nullmailer pid 2524554 invoked by uid 1000);
        Wed, 14 Jun 2023 18:40:48 -0000
Date:   Wed, 14 Jun 2023 12:40:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        Wolfgang Grandegger <wg@grandegger.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: can: m_can: change from additional-
 to unevaluatedProperties
Message-ID: <168676804750.2524488.14056388147398744360.robh@kernel.org>
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
 <20230614123222.4167460-5-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230614123222.4167460-5-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 14:32:18 +0200, Leonard Göhrs wrote:
> This allows the usage of properties like termination-gpios and
> termination-ohms, which are specified in can-controller.yaml
> but were previously not usable due to additionalProperties: false.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> Suggested-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

