Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B5A736F1C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjFTOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjFTOtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:49:52 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A4B1716;
        Tue, 20 Jun 2023 07:49:50 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-341e400c2b3so25604575ab.0;
        Tue, 20 Jun 2023 07:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687272590; x=1689864590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNeUCHjGHh7bJE/7uofbP2PYTnvjxgnzc+IxbdCcyLw=;
        b=c77h1bJnEkU4XJArcY2jXPb1K114SFStI2BiJ5LaCQJ3Q/1saAxtRjshfz4RO6QpJD
         Wel+QF3WfN2Hj8UHNbK5lQgZk3rd2SdxI6Wv5kKNPM7xFowyMwa7+s1GJA+pRFnjcH3/
         aQfsKqceo7i6qSSKwTL7ybVaMDd6yURpymbb201QKVQjkceOs75nD8qeNacWVTHQr2qo
         JLHG9dSTWK2yHK5E3mfB/UMuDKJgc+N9jGNxKll/WAl5S0Zc2JONhF4Tfhd+IQqZVyJ7
         BGTvktMi1XTQ6VL0zEeb6KguT+72BFxXdamqg8WweedT/bHDKH4+M0l7LNoyZ57IPIdN
         AMZg==
X-Gm-Message-State: AC+VfDzp+hYIiETDMOoNpzmbblXMWFZ5lHVwE/IFNX9GBdHhL6YZp59i
        tzOpb9z0y9rwmzCGEXO2Vlrn5yz+FQ==
X-Google-Smtp-Source: ACHHUZ4S0zb0vXjrS2u+bCfs/vcRgVGNiN0e/Kh7jZi1YbPslVXuzlbDqDmk45ovZnLm7SYsrai4bA==
X-Received: by 2002:a92:cc0f:0:b0:342:1954:6c0c with SMTP id s15-20020a92cc0f000000b0034219546c0cmr11215974ilp.11.1687272589756;
        Tue, 20 Jun 2023 07:49:49 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id a2-20020a029f82000000b004265fff893asm659101jam.179.2023.06.20.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:49:49 -0700 (PDT)
Received: (nullmailer pid 3575014 invoked by uid 1000);
        Tue, 20 Jun 2023 14:49:47 -0000
Date:   Tue, 20 Jun 2023 08:49:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpu: drop unneeded quotes
Message-ID: <168727258711.3574956.16756717526607386996.robh@kernel.org>
References: <20230609140738.64958-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140738.64958-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 09 Jun 2023 16:07:38 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 2 +-
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

