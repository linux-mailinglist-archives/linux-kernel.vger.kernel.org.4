Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDE6E6B64
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjDRRtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbjDRRtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:49:08 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60113F8F;
        Tue, 18 Apr 2023 10:48:55 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6a5e7482961so435161a34.3;
        Tue, 18 Apr 2023 10:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681840135; x=1684432135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxuOKbWy6nwVEz1B7D6dnfPS1WaRUz+7RSvc1E9AOPk=;
        b=FG/CtGz29fxobGfGaPfnaOjPdJ4OBVUcq/yufrIBAHkk+FvcjwCjyrg6f2pw2205kB
         lvYO6NfAr8LuXoY386TfDS37qne0IYn1b7ER72XWDX3rYNWgytV/XD638RpMxijus/y4
         54Vzh8kMzDp57tmmcCzpypnYOoZff9a9ypQ6E8Bo3JYeoXGwmziTlu6QwqoVWF3OJPz2
         mFXJ3wINW7aD1lkcWBCyuhglQd8J4ns5bBsQ+QNXDQ5kBcT/ilFGAnV0+qEbApS9Cu9M
         7HNQJgMtNAsY6/ojPmnB/H+dCzqwT6stN2ag1ayNX2OXkHVLnU0J6/P+Ea8IGRj1IdXP
         VbQA==
X-Gm-Message-State: AAQBX9eU5/AFUcg3QBQdYH4SZyhMMN0/D1ABYWHbRFaz2cK62ptMgtqQ
        pu1kSHtF4HRu0RS83mdTIA==
X-Google-Smtp-Source: AKy350ahDfCNSmluZZsodC1+A/VIncaDdFt0XCzkVgkg8kDeq0HtyPRv+PbDTf5IaSjjB1PkoMXuIA==
X-Received: by 2002:a05:6830:1089:b0:6a4:3e49:9eb2 with SMTP id y9-20020a056830108900b006a43e499eb2mr1470791oto.19.1681840134988;
        Tue, 18 Apr 2023 10:48:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a9d4e8d000000b006a5ef5db2f6sm1744419otk.27.2023.04.18.10.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:48:54 -0700 (PDT)
Received: (nullmailer pid 2034951 invoked by uid 1000);
        Tue, 18 Apr 2023 17:48:53 -0000
Date:   Tue, 18 Apr 2023 12:48:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        patrice.chotard@foss.st.com
Subject: Re: [PATCH] dt-bindings: reset: remove stih415/stih416 reset
Message-ID: <168184013058.2034852.9193512075106531733.robh@kernel.org>
References: <20230416200442.61554-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416200442.61554-1-avolmat@me.com>
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


On Sun, 16 Apr 2023 22:04:41 +0200, Alain Volmat wrote:
> Remove the stih415 and stih416 reset dt-bindings since those
> two platforms are no more supported.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Patch previously sent via a serie: https://lore.kernel.org/all/20230209091659.1409-10-avolmat@me.com/
> 
>  include/dt-bindings/reset/stih415-resets.h | 28 ------------
>  include/dt-bindings/reset/stih416-resets.h | 52 ----------------------
>  2 files changed, 80 deletions(-)
>  delete mode 100644 include/dt-bindings/reset/stih415-resets.h
>  delete mode 100644 include/dt-bindings/reset/stih416-resets.h
> 

Applied, thanks!

