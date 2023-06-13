Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29B872E430
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 15:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbjFMNeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 09:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242553AbjFMNd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 09:33:58 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BCBE5;
        Tue, 13 Jun 2023 06:33:57 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-77ac2eb07a3so221461139f.2;
        Tue, 13 Jun 2023 06:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686663236; x=1689255236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVMF0cNkOvWOotSiCVqWjAUYo2pClvF2wLwm2zYOVjQ=;
        b=Dx7RV1suQsxbD6ol5j32WwQTVz3aUe/fB8o0liMZTcpBn1uX52/C2EJHohs/ZU0fYV
         oa2F8UiQ0U0TuHGkVzvYfWsALTrDH4+aqHHjWR1pVksQOD4269YoER9bznyPnz5M5Xfb
         61SWV+2thDXUgczy/XgPoAY6IlKDQVswkAQYiCdielzbN80JFKPDzJ5bYJrNgkTuRKYJ
         rZ9DtT5dGRudBBzEHXLMzGvb/UJxOBw8L4KPoba2t1GNqfU1lOPIFV/NzQYMF+rF8gpf
         FPDbbKQyG4WomTkGklF6kZ9cGAwhRaIK80RTuegY25x6nxjJJNDsvIPz8CgZHHdxXU8v
         TLWg==
X-Gm-Message-State: AC+VfDwd2SKvTYv8FgZmhA78ZYLhYxXJNfEiVivHkAScTB/EirVLjhVK
        xFDTi3m2DvnN+7/fclWJUHuns5H4DA==
X-Google-Smtp-Source: ACHHUZ49q1Oh89Wc+426zGavzltcBtj6qS6mPvOOgEpcvRcr08SDV8e1ae7C3q137hDz1vfIgIb1Kw==
X-Received: by 2002:a05:6602:1d6:b0:774:8d9f:e3e2 with SMTP id w22-20020a05660201d600b007748d9fe3e2mr9832851iot.17.1686663236369;
        Tue, 13 Jun 2023 06:33:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g21-20020a02b715000000b00422bf19bccdsm892919jam.121.2023.06.13.06.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 06:33:55 -0700 (PDT)
Received: (nullmailer pid 1766960 invoked by uid 1000);
        Tue, 13 Jun 2023 13:33:54 -0000
Date:   Tue, 13 Jun 2023 07:33:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, devicetree-spec@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: reserved-memory: Add
 alloc-{bottom-up,top-down}
Message-ID: <20230613133354.GA1750589-robh@kernel.org>
References: <20230510-dt-resv-bottom-up-v1-0-3bf68873dbed@gerhold.net>
 <20230510-dt-resv-bottom-up-v1-1-3bf68873dbed@gerhold.net>
 <20230608140256.GA2478894-robh@kernel.org>
 <ZILt0X0uyIyUdxqH@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZILt0X0uyIyUdxqH@gerhold.net>
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

On Fri, Jun 09, 2023 at 11:16:01AM +0200, Stephan Gerhold wrote:
> Hi Rob,
> 
> Thanks for your suggestions!
> 
> On Thu, Jun 08, 2023 at 08:02:56AM -0600, Rob Herring wrote:
> > On Mon, May 15, 2023 at 12:12:16PM +0200, Stephan Gerhold wrote:
> > > Right now the allocation behavior for dynamic reserved memory is
> > > implementation-defined. On Linux it is dependent on the architecture.
> > > This is usually fine if the address is completely arbitrary.
> > > 
> > > However, when using "alloc-ranges" it is helpful to allow controlling
> > > this. That way you can make sure that the reservations are placed next
> > > to other (static) allocations to keep the free memory contiguous if
> > > possible.
> > 
> > That should already be possible with all the information you 
> > already have. IOW, you are looking at all the region and "alloc-ranges" 
> > addresses to decide top-down or bottom-up. Why can't the kernel do that.
> > 
> 
> Would you accept a patch implementing such a behavior?

Yes.
 
> There are obviously infinitely complicated algorithms possible for the
> allocation. A fairly simple one would be to check if the "alloc-ranges"
> overlap or are adjacent to an already existing reservation, i.e.
> 
>   1. If the "alloc-range" starts at the end or inside an existing
>      reservation, use bottom-up.
>   2. If the "alloc-range" ends at the start or inside an existing
>      reservation, use top-down.
>   3. If both or none is the case, keep current (implementation-defined)
>      behavior.
> 
> For reference, here are some examples how it behaves. |...| is the
> unallocated memory, RRR existing allocations, and each RRR--- line
> below a requested alloc-range (and where it was allocated):
> 
> Bottom-up (rule 1):
>   |.....RRRR................RRRRRRRRR...........|
>             RRR----
>          ---RRR-------
> 
> Top-down (rule 2):
>   |.....RRRR................RRRRRRRRR...........|
>                      ----RRR
>                 ---------RRR------
> 
> Otherwise rule 3 just behaves as currently where either bottom-up
> or top-down is used depending on the implementation/architecture:
>   |.....RRRR................RRRRRRRRR...........|
>                -----RRR
>      or        RRR-----
>           ---------------RRR----
>      or   --RRR-----------------
> 
> There are plenty of edge cases where it doesn't produce the optimal
> result, but it just results in exactly the same behavior as currently
> so it's not any worse (with rule 3):
> 
>   |.....RRRR................RRRRRRRRR...........|
>                           -----------RRR-----
>                  or       ----------------RRR
>                      ---------------------RRR  (no way to handle this
>                  or  RRR---------------------   with top-down/bottom-up)
> 
> > Alternatively, if you really care about the allocation locations, don't 
> > use dynamic regions.
> > 
> 
> Yes, this is the option used at the moment. As outlined in detail in the
> examples of RFC PATCH 4/5 and 5/5 I would like a solution inbetween. The
> exact address doesn't matter but the way (direction) the region is
> filled should preferably stay the same.
> 
> > > 
> > > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > > ---
> > >  .../bindings/reserved-memory/reserved-memory.yaml  | 39 ++++++++++++++++++++++
> > >  1 file changed, 39 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> > > index c680e397cfd2..56f4bc6137e7 100644
> > > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> > > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
> > > @@ -52,6 +52,18 @@ properties:
> > >        Address and Length pairs. Specifies regions of memory that are
> > >        acceptable to allocate from.
> > >  
> > > +  alloc-bottom-up:
> > > +    type: boolean
> > > +    description: >
> > > +      Specifies that the memory region should be preferably allocated
> > > +      at the lowest available address within the "alloc-ranges" region.
> > > +
> > > +  alloc-top-down:
> > > +    type: boolean
> > > +    description: >
> > > +      Specifies that the memory region should be preferably allocated
> > > +      at the highest available address within the "alloc-ranges" region.
> > 
> > What happens when both are set?
> > 
> 
> They are not meant to be both set. I should have added an if statement
> for this, sorry about that.

Ideally, you define the properties in a way to avoid that situation 
rather than relying on schema checks. For example, a single property 
with values defined for top-down and bottom-up.

Rob
