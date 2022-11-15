Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26166299BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiKONK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbiKONKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:10:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDBB0B;
        Tue, 15 Nov 2022 05:10:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C52BDB80B31;
        Tue, 15 Nov 2022 13:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264C0C433C1;
        Tue, 15 Nov 2022 13:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668517810;
        bh=MlDA+oqYxJDdDaP/NGSE8qbeh4hc59e+oXYuN/jvZZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odgzcxE5CbJWLLJz0EfUa/KYbt1sClD3O22Bq1xqx02zzYgWXYr4kunEQWHLK/2ON
         RDaZ8TGixaV4OwllWGtFUuoGfNo6LwBiDqM/h3TzaYfN1x9Sk03qt3+zej+xT51JID
         JyyMI+0l7XkRSdyloS8QwAFCntkpOQ9mxE3ADZp+DyaA7FpTCrsMmNxFqBFxGM+GPi
         Fv4cPMRhVWLGn3UNV+Jso9qPWqzuSlF9LzvOCYAeZ0fEeKBY97Pjad2J+Uh8I4xPPR
         SvZRN4ewBCARtdE7e/m22iOa++FgpDSHP+WQPgAm+Ynz0HwknvXofOUK6ItAQDFyRD
         Xfysixmo6kflw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 919AF4034E; Tue, 15 Nov 2022 10:10:07 -0300 (-03)
Date:   Tue, 15 Nov 2022 10:10:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     Andreas Krebbel <krebbel@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] perf list: Add PMU pai_ext event description for IBM
 z16
Message-ID: <Y3OPr3oIwld5omGu@kernel.org>
References: <20221111135402.858623-1-tmricht@linux.ibm.com>
 <Y3JnjmxPX+m7G9HL@kernel.org>
 <c1f8de28-1948-85b1-cd85-5bbd301e22bc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1f8de28-1948-85b1-cd85-5bbd301e22bc@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 15, 2022 at 09:58:22AM +0100, Thomas Richter escreveu:
> On 11/14/22 17:06, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Nov 11, 2022 at 02:54:02PM +0100, Thomas Richter escreveu:
> >> Add the event description for the IBM z16 pai_ext PMU released with
> >> commit c432fefe8e62 ("s390/pai: Add support for PAI Extension 1 NNPA counters")

> >> The document SA22-7832-13 "z/Architecture Principles of Operation",
> >> published May, 2022, contains the description of the Processor
> >> Activity Instrumentation Facility and the NNPA counter set., See
> >> Pages 5-113 to 5-116.

> >> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>

> >> --- /dev/null
> >> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/pai_ext.json
> >> @@ -0,0 +1,198 @@
> >> +[
> >> +	{
> >> +		"Unit": "PAI-EXT",
> >> +		"EventCode": "6144",
> >> +		"EventName": "NNPA_ALL",
> >> +		"BriefDescription": "NNPA ALL",
> >> +		"PublicDescription": "Sum of all non zero NNPA counters"
> >> +	},

> > Since the Brief description mentions NNPA, shouldn't the Public
> > Description expand on this "NNPA" acronym?, something like:

> > Oops, can't expand on that since there isn't a link to that SA22-7832-13
> > document.

> > Googling for it...

> > https://www-40.ibm.com/servers/resourcelink/svc03100.nsf/pages/zResourceLinkUrl?OpenDocument&url=http://www.ibm.com/servers/resourcelink/lib03010.nsf/0/B9DE5F05A9D57819852571C500428F9A/$file/SA22-7832-13.pdf

> > Ok, requires registration.

> > I wonder what is the value of these descriptions then :-\

> > I miss Ingo jumping into these discussions :-)
 
> I added Andreas Krebbel to the discussion, he knows more than I on this counters.
 
> NNPA stands for Neural Networks Processing Assist. This is a new feature in 
> the IBM z16. Here is a quote from Document SG2489-51 IBM z16 (3931) Technical Guide:
 
> <START-OF-QUOTE>
>   "The new IBM z16 microprocessor chip, also called the IBM Telum processor, integrates a
>    new AI accelerator. This innovation brings incredible value to applications and workloads that
>    are running on IBM Z platform.
>    Customers can benefit from the integrated AI accelerator by adding AI operations that are
>    used to perform fraud prevention and fraud detection, customer behavior predictions, and
>    supply chain operations. All of these operations are done in real time and fully integrated in
>    transactional workloads. As a result, valuable insights are gained from their data instantly.
> 
>    ...
>    The AI accelerator is driven by the new Neural Networks Processing Assist (NNPA)
>    instruction.
>    NNPA is a new nonprivileged Complex Instruction Set Computer (CISC) memory-to-memory
>    instruction that operates on tensor objects that are in user program’s memory. AI functions
>    and macros are abstracted by NNPA."
> <END-OF-QUOTE>
> 
> This intension of this patch is to give a small hint on what these NNPA counters are
> supposed to count and operate on. A full explanation is given in the document
> SA22-7832-13 "z/Architecture Principles of Operation", Chapter 26, pp 26-1 to 26-115.
> 
> If you think this small description is not worth it, then we can drop the patch.

So perhaps:

+	{
+		"Unit": "PAI-EXT",
+		"EventCode": "6144",
+		"EventName": "NNPA_ALL",
+		"BriefDescription": "NNPA ALL",
+		"PublicDescription": "Sum of all non zero NNPA (Neural Networks Processing Assist) counters"
+	},

?

- Arnaldo
