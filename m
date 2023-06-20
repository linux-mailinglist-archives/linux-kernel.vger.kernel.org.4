Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C1737219
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjFTQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbjFTQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:50:32 -0400
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33451726;
        Tue, 20 Jun 2023 09:50:31 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3416b5df9b3so24759085ab.3;
        Tue, 20 Jun 2023 09:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279831; x=1689871831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3J+twO/vjQM/qWkeIhcjjpl1ciXpaPP0MAnGxmiVji8=;
        b=f3HFScl/wxXBMJuWdyyi+4CoJoucPCDPf16feLtNyj8cwdgNRUP2TDlb522nrn64hZ
         Cl6HliuBOONmhTLqdx1pbJeigrd9D05xfhUob4hC7BGkK3FLC9f0YFTYPNpwY7P3+nRS
         JGdmmvRrJboq2NLisf9f+aLUMaGcEVVBZxtTTvL4LyW4QD+LMeld7vU7DG+xNlnGHB2z
         5f8zTiVbuWrZhA4sjBb7FBhST+EP+RmvlXZv3LHFYnTuXfNNT+O2UMR/jDtG7uXEzTdJ
         TLdG7ZAlaCGQ4j93BKgR+Y3mvTmwj338e+aq7WBq1xv0wA3pHT4VjUdMQoqNv6TZyZ+u
         p4VQ==
X-Gm-Message-State: AC+VfDzP+8f4weyCfEM7jSAGfLAqtyOsWdl9MagEA52po53uP6xYW0IB
        6RlemfQX8JywmyxDKNqvgBTlZFimZA==
X-Google-Smtp-Source: ACHHUZ7kWXURanD12QIIx+0GBD7ocA/PUqlmXY+3EM7bAaEKXip+6jUcuL1koF4S5eHi+04b0fdzHA==
X-Received: by 2002:a92:de08:0:b0:342:28f1:75ae with SMTP id x8-20020a92de08000000b0034228f175aemr9154292ilm.12.1687279830895;
        Tue, 20 Jun 2023 09:50:30 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id r27-20020a056638101b00b0041627abe120sm543091jab.160.2023.06.20.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:50:30 -0700 (PDT)
Received: (nullmailer pid 3806154 invoked by uid 1000);
        Tue, 20 Jun 2023 16:50:28 -0000
Date:   Tue, 20 Jun 2023 10:50:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     jaswinder.singh@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ilias.apalodimas@linaro.org,
        masahisa.kojima@linaro.org
Subject: Re: [PATCH] dt-bindings: arm: socionext: add bindings for the
 Synquacer platform
Message-ID: <20230620165028.GA3805350-robh@kernel.org>
References: <20230616035813.255062-1-jaswinder.singh@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616035813.255062-1-jaswinder.singh@linaro.org>
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

On Thu, Jun 15, 2023 at 10:58:13PM -0500, jaswinder.singh@linaro.org wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> Socionext's DeveloperBox is based on the SC2A11B SoC (Synquacer).
> Specify bindings for the platform and boards based on that.
> 
> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
> ---
>  .../bindings/arm/socionext/synquacer.yaml     | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/socionext/synquacer.yaml

Should I pick this up or Socionext maintainers will?
