Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E873A340
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjFVOkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjFVOk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:40:29 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241771FE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:40:10 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77e2c42de06so252870539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444809; x=1690036809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tKPUnBe2iKBsE43I+EUg2QZni65SsN6yl7vOoJSOSc=;
        b=P3PKh9GV0MkcheqpYW5aNhAgfzZScR0fpavUNyPSWixAVlhNT4r57AtzjHcsXkmKEs
         vM87A3yfoFPejliSxsJd+GHc1ONLedTX8EuQ3l+Abxok/9Onm29seB3O6eup6qXliFGe
         pTKf/vcPsKNkAbwRdSK/MBPT2mvwqZkQ8k2E9j/Y6o6miDZEVOHmL+30QWDaN5pGmvz/
         1r1wSrEalnQuR4NtqDca6HIUtTogIrtdVrqxl1/JCFdPOIPkxfaNG3OhlMKY+11LB0hZ
         xK6tjHkckbxjpj5E/1Yhh5l0qO2uYLGV8tGeE6NZH+6RHi69dD/IBpLL82p29HCXmSK8
         xQDQ==
X-Gm-Message-State: AC+VfDzdIH38wbjWMc3IQZeNZa4LVvLoXocHA0HfLPHpuVJh59t3i5Px
        nxfwEK8gnh2jTTN4TAe1Lg==
X-Google-Smtp-Source: ACHHUZ5dI3Eznhe3M1Npx4fJO7q6fQcJiKn1+GnPwf2QY7dkuYPAWtxlW/3xfTU5P+eZmrEd5kyGOw==
X-Received: by 2002:a92:d945:0:b0:33b:ca8:fdaa with SMTP id l5-20020a92d945000000b0033b0ca8fdaamr16434122ilq.6.1687444809277;
        Thu, 22 Jun 2023 07:40:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y12-20020a02ce8c000000b0041ac54cbc60sm2111291jaq.56.2023.06.22.07.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:40:08 -0700 (PDT)
Received: (nullmailer pid 1669715 invoked by uid 1000);
        Thu, 22 Jun 2023 14:40:07 -0000
Date:   Thu, 22 Jun 2023 08:40:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] dt-bindings: qcom: Document new msm8916-samsung
 devices
Message-ID: <20230622144007.GA1662197-robh@kernel.org>
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
 <20230622000254.48260-1-linmengbo0689@protonmail.com>
 <e66f1431-a4fd-07f8-6d34-5f6a358a361a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66f1431-a4fd-07f8-6d34-5f6a358a361a@kernel.org>
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

On Thu, Jun 22, 2023 at 10:31:24AM +0200, Krzysztof Kozlowski wrote:
> On 22/06/2023 02:03, Lin, Meng-Bo wrote:
> > Document the new following device tree bindings used in their
> > device trees:
> > 
> > - samsung,fortuna3g
> > - samsung,fortunaltezt
> > - samsung,gprimeltecan
> > - samsung,grandprimelte
> > - samsung,heatqlte
> > - samsung,rossa
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> You missed at least DT list (maybe more), so this won't be tested by our
> tools. Performing review on untested code might be a waste of time, thus
> I will skip this patch entirely till you follow the process allowing the
> patch to be tested.
> 
> Please kindly resend and include all necessary To/Cc entries.
> 
> You just ignored maintainers entirely... It's not even about testing but
> no one would apply it.

Something strange going on with this one as it still made it to the DT 
patchwork, so it did go to the DT list. Must have been Bcc'ed.

The patches are also quoted-printable encoded which shouldn't be used.

Rob
