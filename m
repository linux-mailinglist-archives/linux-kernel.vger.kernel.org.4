Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06B4736F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjFTOuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjFTOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:50:12 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBDC173B;
        Tue, 20 Jun 2023 07:50:10 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-777a4c8e8f4so252896539f.3;
        Tue, 20 Jun 2023 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272610; x=1689864610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skNC7wGMKQOXF6+biUK6xM5jOg9O1b/Uor/uSAeQg/c=;
        b=JXEl5aU6+GUExHVLdRGnjq41jk3zcFSbQhgvc1uMRYheQCMJukpYA5Kr3ezQVtPxdS
         2pI0mIQv1+jBP2+WgxyCrMsBItZRnF+Fz8KJw3ip0/X3bVAiIfdHrAGvOYhuYccB17CK
         zxev1nMpiB8CkzMXuqTJ1QMmyPR5raqWvA+H7WusiwRENeeG64CoG0alglmYdwwL1lRd
         BS9ENWI/ZM+jolm7om4IGTSuI9PCo0cptMRB2mKqJaVjEdCGU1RS3gJ03PBvW1syBkN9
         DQ6EsvTmkGzDCqwGgUm9bnN0Tj2xj91tdxV0l15mFEgPgGL3DnuPJiAkkBxOjBA85lo9
         4DOA==
X-Gm-Message-State: AC+VfDxiA5vv3+f2e5tJLIsr16BgKsUJbKYYJ0ymgJQ0qeyJeIqwkTI9
        spHAXW8Fzuinnwh7cQcTuQ==
X-Google-Smtp-Source: ACHHUZ4dWy9kfXsS0mzHJJEVJTPbSBU385oc5mwoA8J3jBAESMYYpIoq2vu9yBpvRMfmNgTxYCz0CQ==
X-Received: by 2002:a5d:955a:0:b0:76c:4db8:c1ea with SMTP id a26-20020a5d955a000000b0076c4db8c1eamr13019634ios.10.1687272609689;
        Tue, 20 Jun 2023 07:50:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l6-20020a056602276600b0077e40979b41sm705500ioe.45.2023.06.20.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:50:09 -0700 (PDT)
Received: (nullmailer pid 3575608 invoked by uid 1000);
        Tue, 20 Jun 2023 14:50:07 -0000
Date:   Tue, 20 Jun 2023 08:50:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: dvfs: drop unneeded quotes
Message-ID: <168727260712.3575548.11905935350852290454.robh@kernel.org>
References: <20230609140742.65018-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140742.65018-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 09 Jun 2023 16:07:42 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/dvfs/performance-domain.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

