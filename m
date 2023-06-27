Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B599C73FD83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjF0ONc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjF0ONa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:13:30 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE56E74;
        Tue, 27 Jun 2023 07:13:29 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-345b231322fso5962595ab.2;
        Tue, 27 Jun 2023 07:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687875208; x=1690467208;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+34dOqwiPYr04E0G4Xm/yOYM4qu798aPWQjNtLw1CjI=;
        b=kRxOfX+Tz1dw+6ggsX1elYaytaNNzpnjd2Cwtzzxl7S+9GKgFDSchmWgZo53Wyk48W
         NUZ2ONQygFeJ6Xwlk1+By80R6dLrm0Ci/1gQOmM334xWzsJZjrpPzM2weC1bu/edysQ+
         FVxGR6orgyRQZ7vqdp+7YoqssidNUOVyKyWQGBi4EaVjig1u8LrbS7wQQWCId/cWlERN
         e09R8P6zaZWakgVDBgYzEZnHmdodb+qQv8GXkU51XTYKra/7xkBuZrSoYi2QdggciZId
         BhvEl4vUS0JWCLwpA4fuhk1Wu2It4H2m3CTbRs7tHkTPLm1qZse29AmLICHfAxQm8cKP
         cOoA==
X-Gm-Message-State: AC+VfDx6shN+Ydly0aic4bkbeNnXtT924oVSAv3o+boZCAzglI86YXgV
        kWhPEEf2GCgkzPFHuC6ZdikMFfy0kg==
X-Google-Smtp-Source: ACHHUZ4wRY2cU/zuyjuVAsmGPISWFZVleu8/CVMKM4HfKZ24n0tENdP0Afc+q+NMVSthuvPOYuL/gw==
X-Received: by 2002:a92:d350:0:b0:345:c2ab:2394 with SMTP id a16-20020a92d350000000b00345c2ab2394mr542941ilh.15.1687875208646;
        Tue, 27 Jun 2023 07:13:28 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id t9-20020a92c909000000b00345b53bdea4sm695274ilp.37.2023.06.27.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 07:13:27 -0700 (PDT)
Received: (nullmailer pid 1834159 invoked by uid 1000);
        Tue, 27 Jun 2023 14:13:25 -0000
Date:   Tue, 27 Jun 2023 08:13:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-scsi@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Iskren Chernev <me@iskren.info>,
        Avri Altman <avri.altman@wdc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v5 3/5] dt-bindings: ufs: qcom: Add ICE to sm8450 example
Message-ID: <168787520491.1834121.2564277926008455539.robh@kernel.org>
References: <20221209-dt-binding-ufs-v5-0-c9a58c0a53f5@fairphone.com>
 <20221209-dt-binding-ufs-v5-3-c9a58c0a53f5@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209-dt-binding-ufs-v5-3-c9a58c0a53f5@fairphone.com>
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


On Tue, 27 Jun 2023 10:28:03 +0200, Luca Weiss wrote:
> SM8450 actually supports ICE (Inline Crypto Engine) so adjust the
> example to match.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

