Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656E6728805
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbjFHTRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236575AbjFHTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:17:44 -0400
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102F630F5;
        Thu,  8 Jun 2023 12:17:10 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-33b36a9fdf8so4457425ab.2;
        Thu, 08 Jun 2023 12:17:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251740; x=1688843740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnuCWlLeGXkXzjrAZSc98CK+vugpSfbrMYt9DNWRMOE=;
        b=KWWwofw7I7hN6vxsSJNE5BV7JsqiVfW7yp5yNb/aS95YcVDWRZVLN2FH6KYnd1Ug0Y
         0f7jRVhhHY6C80/+7sOm4Fwz+bYb+Urzq2maRWcWB2hydlQ3CahYZeSpAqeRdQht+hSC
         HYZ1WBLmiHHl9/bIQknUVjGu4+QaAmCviqnGRINYPijtI4/lxLplBZEKDLqXY5glIsi8
         10lktI5ROPoo7ihu7WA7ZNAKdAJdWwMcrDZH/d3olNRKXE61BCuCMEO+cpSytRQ0diB3
         XcZF3Mhf6mduSCrsOx46wQPaaRz0sOR0Jxe7W9pz/JN0qZEx6Fksx98CAcw9tYIiRI3T
         LtmA==
X-Gm-Message-State: AC+VfDyFf3DwuKIpVSCRVG7eVw3lx7fONoQA4TqHC5qdKuDLstP7iQWI
        hSm5k9YUhctRTZQShi8CEQ==
X-Google-Smtp-Source: ACHHUZ6vUrRrwwLFM+Hb3/loXcNPujVf20GEn/2hSQYhDLxez4ApnNr9gWsyMTIlALZzM/ichJLIqA==
X-Received: by 2002:a92:90c:0:b0:33b:ea2:fe6c with SMTP id y12-20020a92090c000000b0033b0ea2fe6cmr10362873ilg.24.1686251740495;
        Thu, 08 Jun 2023 12:15:40 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id e5-20020a02caa5000000b0040908cbbc5asm464387jap.68.2023.06.08.12.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 12:15:39 -0700 (PDT)
Received: (nullmailer pid 3254644 invoked by uid 1000);
        Thu, 08 Jun 2023 19:15:37 -0000
Date:   Thu, 8 Jun 2023 13:15:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>, palmer@dabbelt.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
        linux-riscv@lists.infradead.org, qemu-riscv@nongnu.org,
        u-boot@lists.denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230608191537.GA3233857-robh@kernel.org>
References: <20230518-thermos-sanitary-cf3fbc777ea1@wendy>
 <20230518-4050231ca8dbe93c08cf9c9a@orel>
 <CAAhSdy07Mg_JBF+4ucGFiWdBKh-Ass5G_aUWqBqTnDSFp7S=0A@mail.gmail.com>
 <20230518-hammock-doornail-478e8ea8e6a7@wendy>
 <f7c20090-220c-2805-86ba-b174a89f65b3@seco.com>
 <20230518-monkhood-dispersal-6749b1228b0d@spud>
 <20230530-duller-reset-a34ae111f207@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530-duller-reset-a34ae111f207@wendy>
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

On Tue, May 30, 2023 at 03:12:12PM +0100, Conor Dooley wrote:
> On Thu, May 18, 2023 at 10:42:34PM +0100, Conor Dooley wrote:
> > On Thu, May 18, 2023 at 02:30:53PM -0400, Sean Anderson wrote:
> 
> > > 
> > > Why not just have something like
> > > 
> > > mycpu {
> > > 	...
> > > 	riscv,isa {
> > > 		i;
> > > 		m;
> > > 		a;
> > > 		zicsr;
> > > 		...

I prefer property names be globally unique. The tools are geared towards 
that too. That's largely a symptom of having 0 type information in the 
DT.

For example if you had an extension called 'reg', it would be a problem.

> > > 	};
> > > };
> >
> > Naming of the node aside (perhaps that could be riscv,isa-extensions)
> > there's not something hitting me immediately as to why that is a no-no.
> > If the size is a concern, this would certainly be more efficient & not
> > like the probing would be anything other than trivial more difficult
> > what I have in my proposal.
> 
> Having started messing around with this, one of the main advantages, to
> me, of this approach is proper validation.
> cpus.yaml has additionalProperties: true in it, which would have had to
> be sorted out, or worked around, but creating a child-node with the
> properties in it allows setting additionalProperties: false.

That's an issue on my radar to fix. I started that for the Arm cpus.yaml 
a while back. Sadly it involves adding all the misc properties vendors 
added. It's not a lot, but still better to get in front of that for 
Risc-V.

> > Rob's AFK at the moment, and I was hoping that he would take a look at
> > the idea, so I won't respin til he is back, but I'll give this a go in
> > the interim.
> 
> Mechanically, the conversion of the patch isn't difficult, but I'll still
> wait for Rob to come back before sending a v2. But that v2 will more
> than likely implement your suggestion.

I haven't read the whole thread, but the initial proposal looks okay to 
me.

Another way you could do this is a list of strings:

riscv,isa-ext = "i", "m", "zicsr";

I think we have a helper to test is a string in the list.

Rob
