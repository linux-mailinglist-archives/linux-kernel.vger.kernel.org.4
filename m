Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B30645F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiLGQ5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLGQ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:57:04 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE1A62E8F;
        Wed,  7 Dec 2022 08:57:04 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1447c7aa004so13843631fac.11;
        Wed, 07 Dec 2022 08:57:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjsoTXGri8JLvJW2T8GIZAWKirugVS34hV+s8paAZjM=;
        b=B95HHd9RFVh0YWSFXqw1o7LpQmjiI5/V10JgeDz0NdFru4Lm8pnjCR649fOo/Hw/63
         om/7vGEtkqJceLGwILoU3ZhROi7rRdoUCKnTdKK4iQSZf0Ze7RBE2HFSbS1rk9VRwvNz
         gUIeiN6zbGwp8JT4M40R+v2X6KPThUqQM4WdJSjIl1sXa0u0kLlyr8gFMPiEb8z41a+k
         2VCmijcAihW+ftq7ctgcTnN5IRN0oWliFjbU2JCEzKtCw5BHfCl9WwkzwTuGG5OWff4W
         KMmCNMXcc/1ko86zk4pT8TzN/0t0Tpx+wuuKTevxEtPc3X/M853ci5tRFoT930jSlmgA
         W/qQ==
X-Gm-Message-State: ANoB5pny8xeV48FssdNaZJqSbB5pUMmN5TXwpS3xZZ21LAAYE4re8bF6
        pyJlPzxAhbFnlMn2W2jh1CVeZkay5Q==
X-Google-Smtp-Source: AA0mqf7VORNFgWUjiYSUyWALvb0Vfyh3rcM9Jxf+M/TQedidfiv9ZxymKnscFUHhOk0EfWqVdzqw4g==
X-Received: by 2002:a05:6870:e99f:b0:142:d085:c1cc with SMTP id r31-20020a056870e99f00b00142d085c1ccmr44003737oao.29.1670432223084;
        Wed, 07 Dec 2022 08:57:03 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n25-20020a9d6f19000000b00660e833baddsm10495609otq.29.2022.12.07.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 08:57:02 -0800 (PST)
Received: (nullmailer pid 2401862 invoked by uid 1000);
        Wed, 07 Dec 2022 16:57:02 -0000
Date:   Wed, 7 Dec 2022 10:57:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: sort entries alphabetically
Message-ID: <20221207165702.GA2396480-robh@kernel.org>
References: <20221202110536.22230-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221202110536.22230-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:05:36PM +0100, Krzysztof Kozlowski wrote:
> Sort entries alphabetically.  This was a semi manual job with help of:
> 
>   cat Documentation/devicetree/bindings/vendor-prefixes.yaml | grep '":' > old
>   cat old | sort > new
>   diff -ubB old new
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Patch rebased on next-20221201 therefore might not apply cleanly to
> Rob's tree. Probably should be taken after the 6.2-rc1.

Indeed. I'll pick this up with the other treewide cleanups planned for 
the merge window.

Rob
