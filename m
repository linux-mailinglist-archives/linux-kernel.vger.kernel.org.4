Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4F6DF7C8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjDLNz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDLNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:55:27 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995F8106;
        Wed, 12 Apr 2023 06:55:23 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id ec6so1019231oib.8;
        Wed, 12 Apr 2023 06:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307723; x=1683899723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqL7X4+EJrGtGtNS3rKAzHWSwh1aMiX2aKtEdeGVs4c=;
        b=KKI7c4jOMG8mOq2CrwZj4SCusFUxLT2PQWzgHtyb7nLTyfA5hbYyHHH3+lGLNQlV+8
         Yku0JEVCGkRT0TMDIhgOsHkvpaPHhCl8KHvadkvwSYMw0M6mj4/37OwMZwViEOJKnOkc
         VkEDeLzdsY5A43n7usUV1XmghAnjBx7tnrAf8cqmqPhwK4w5v4MIBTmQ1TXp/c7peAHy
         bQgJCgcJ7M3ho1GtCHkAgA/vb6CIHs3afTTI8bqANKyNgYAMlT9KgwBPCyBBG93mQYCh
         xbbyXClfq5HsLidg4QaTZUtAGc6Va/sGmuLV8OH8hbh7rOHrf8dvesYt00yeZh6O6UhQ
         ey5A==
X-Gm-Message-State: AAQBX9deihivE4tjyljKNlZLLj6EtNX9p2GKSxzDWpWpUFl2+PwIymGf
        onMipDIcTxdlz4HVgPk7hA==
X-Google-Smtp-Source: AKy350bNThrMnjQw8e+apoSf+oXZXTPecnCRU/DA1smWGccLMV/ckiI5HGb704PFtg7OfRqAvZt5sA==
X-Received: by 2002:a05:6808:2b0c:b0:386:a88f:780c with SMTP id fe12-20020a0568082b0c00b00386a88f780cmr7406065oib.4.1681307722845;
        Wed, 12 Apr 2023 06:55:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o184-20020acabec1000000b0038998fa6c2bsm6754530oif.33.2023.04.12.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:55:22 -0700 (PDT)
Received: (nullmailer pid 2230118 invoked by uid 1000);
        Wed, 12 Apr 2023 13:55:21 -0000
Date:   Wed, 12 Apr 2023 08:55:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        James Tai =?utf-8?B?W+aItOW/l+WzsF0=?= <james.tai@realtek.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: realtek: Add Realtek Pym
 Particles EVB
Message-ID: <20230412135521.GA2228687-robh@kernel.org>
References: <cc3c64023eb847ed86554971de2dbf39@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc3c64023eb847ed86554971de2dbf39@realtek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 07:18:49AM +0000, CY_Huang[黃鉦晏] wrote:
> Define a compatible string for Realtek RTD1319 Pym Particles eval board.
> 
> Signed-off-by: cy.huang <cy.huang@realtek.com>

checkpatch.pl complains that the author and Sob names don't match.
