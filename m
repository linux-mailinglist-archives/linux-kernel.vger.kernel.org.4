Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0415873FF63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjF0POO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjF0POM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:14:12 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA45C26B3;
        Tue, 27 Jun 2023 08:14:10 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-785ccf19489so10756939f.3;
        Tue, 27 Jun 2023 08:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878850; x=1690470850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6Dxr1qrQ+dD7ODCxvLBG8Sk4TfJL34ijnHxpCzhHGA=;
        b=WLkL4jcTklw8Fz3tNZnnmv3SIniP1w8//Ak4fXyOYviKUjapG+tnz8A++7uo/pIZ4N
         TtQm/eN+aFmECRNlvZC62+vBBj+/Vq5WWZrR9rb5tX6UrRJd4fTj4oFZBpdmt4KHKKQ1
         3LGFe3W093Yayhhll0eYnvQp0BA6KEtgMKlGHryJl2wy5HhB9DXv/B7OxQv9DwFVOH5g
         CLnkkhHDeX/ZsqvEuRt/zuxvWHdzlJbH/RUqbKdC4hDHGJhutV5nGJ8bB6i3lELRFlz1
         ZJ5ILOcxzQ4VH7QzHLhc+ahel68xI/kIiyaWEZdfAQiFl3sbXO9BvOwEuCWMsSKErnB2
         NDJg==
X-Gm-Message-State: AC+VfDzyjMq+K2Tf5C6o3LFn2Hi9TMMYvLX5KctIk44VHSUI05uYHnB4
        xzoTAZo+TSzH2KIEhbxP8g==
X-Google-Smtp-Source: ACHHUZ7PC3wuDrYXpV6ivJj09BHOErKMVoROQny4zV4bhGuli6zRMNhs4YwTOs7ErMfy18wdNkciOw==
X-Received: by 2002:a92:cb07:0:b0:340:5928:e048 with SMTP id s7-20020a92cb07000000b003405928e048mr27005727ilo.11.1687878850054;
        Tue, 27 Jun 2023 08:14:10 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y15-20020a92090f000000b003422ef44e6asm2726591ilg.6.2023.06.27.08.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:14:09 -0700 (PDT)
Received: (nullmailer pid 1929024 invoked by uid 1000);
        Tue, 27 Jun 2023 15:14:07 -0000
Date:   Tue, 27 Jun 2023 09:14:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Luca Weiss <luca.weiss@fairphone.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] scsi: dt-bindings: ufs: qcom: Fix warning for sdm845
 by adding reg-names
Message-ID: <20230627151407.GA1918927-robh@kernel.org>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-6-abel.vesa@linaro.org>
 <cd84b8c6-fac7-ecef-26be-792a1b04a102@linaro.org>
 <CTK1AI4TVYRZ.F77OZB62YYC0@otso>
 <20230623211746.GA1128583-robh@kernel.org>
 <f1ff2c32-df2a-e349-1227-e5a93fe37c92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1ff2c32-df2a-e349-1227-e5a93fe37c92@linaro.org>
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

On Sat, Jun 24, 2023 at 09:49:12AM +0200, Krzysztof Kozlowski wrote:
> On 23/06/2023 23:17, Rob Herring wrote:
> >> With my private mailbox I just have a different folder for patches that
> >> have been sent which I archive once they're applied, but with work GMail
> >> I don't see how I can easily replicate this since it's also not grouping
> >> threads properly.
> > 
> > Yeah, GMail sucks for that. I use 'lei' to get all my patches and 
> > replies to them (though its caching will miss replies). Then I delete 
> > them from the mbox when they are applied or otherwise finished. lei 
> > updates won't re-add them to the mbox.
> 
> That's interesting approach. What's your lei search query for getting
> your patches? "f:rob" would get all your threads you participated in.

This is what I have:

        q = (dfn:drivers OR dfn:sound OR dfn:tools OR dfn:kernel OR \
         dfn:arch OR dfn:Documentation OR dfn:include OR dfn:scripts) AND \
         f:robh@kernel.org AND rt:3.month.ago..

Really, I'd like a 'is a patch' flag or 'dfn:*' or 'dfn:/' here, but I 
didn't convince the lei maintainer such a thing is needed. Sigh.

Also, you have to disable lei's caching with the --remote-fudge-time 
option because it will miss replies to the matching query. Also reported 
and not fixed...

Rob
