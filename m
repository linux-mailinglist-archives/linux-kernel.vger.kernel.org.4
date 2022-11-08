Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93F62101F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiKHMRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbiKHMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:17:26 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725E729C84
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:17:25 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j12so14014696plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GPBwlCnaRzpGXtG/LFrZj3940KhkGa8TifjWi+E9sjk=;
        b=v0q9FyjQWUO79ZSOvqbbQE1MM/k6W/uFmQdd/8txQLmopVW578DvpwhDCxDRO7iarn
         rQrgc0p7V0rRBvoQavgZEhAUjISCnnAFn/WS02Ba4CSFCrSJdPTb8ppckkSGhJb+0VLK
         lVBbXuJgADrcBIqKwsSKww6kgglNHpxXISLkHKFmC20FjpmDW5GucTiM2JDynzGZxBkP
         xAhL/ykpRXosLZDZD3Y55O35+5rTmG/KTGM5f+3/n1Y+Sz2JgbFaoZ/vKMHkNwRDzHrX
         OhXiLACK+cAzCAuLYrTu61YFxIrwWleJV6x8ovg80TURTmoYNNmuRND9p1Eu1fN7WPWX
         DU7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPBwlCnaRzpGXtG/LFrZj3940KhkGa8TifjWi+E9sjk=;
        b=JOPtKqJ9Yc5iibCtoqG+KQ2oXAoFrLta4MnNU5+JNwLc3K8TBKeMlcJCQvuX8v9mZH
         JAfJi65CFHzF5IlgVjPwhWSU+fXh8RgC/d6CikwVY1zcidmgCiBuGmPw7cbdp5XO0aVS
         q47ICpFVB+JxHwFItQYqX4GdrM1TSk9Xax28IzODv3oamXF++DagX1GMGHF3VRu1eDrw
         vkpZD2v7bdHZc0cZOBsW/gVU71+LmK3TrPTc/e+aNe6p6iqoettmD/MF9N/tjy6YWeOZ
         36NdEIWBmx+uBZVHJfBsuLerm3wV9E8TUtaCpaobOOJPBxjum96eXjuOS1hZWhZ58FhD
         k5QQ==
X-Gm-Message-State: ACrzQf2QkS2G7YCJgHE5I//oRToNyWI3MQgO6kopb28o0t7OESCdXr/3
        Kvp7/ZtNeswG4WhH6BGGtyy/NGhTPYGl
X-Google-Smtp-Source: AMsMyM4Id0s61/8FGRatsxuqkroG+/gT4oaAzG5R6Qmy/cXgH2NN62Weju9wZAkjmDJ0SHJLCxBNIA==
X-Received: by 2002:a17:902:8e84:b0:178:57e4:805b with SMTP id bg4-20020a1709028e8400b0017857e4805bmr55823734plb.144.1667909844774;
        Tue, 08 Nov 2022 04:17:24 -0800 (PST)
Received: from thinkpad ([117.207.25.46])
        by smtp.gmail.com with ESMTPSA id g12-20020a17090a714c00b0020a7d076bfesm5961701pjs.2.2022.11.08.04.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 04:17:23 -0800 (PST)
Date:   Tue, 8 Nov 2022 17:47:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Om Prakash Singh <omp@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI: pci-epf-test: Register notifier if only
 core_init_notifier is enabled
Message-ID: <20221108121718.GB29115@thinkpad>
References: <0faa0138-ae2b-42e0-d378-665527f0b660@socionext.com>
 <20221102230902.GA6576@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102230902.GA6576@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 06:09:02PM -0500, Bjorn Helgaas wrote:
> On Tue, Nov 01, 2022 at 06:31:07PM +0900, Kunihiko Hayashi wrote:
> > Hi Bjorn,
> > 
> > On 2022/10/29 2:06, Bjorn Helgaas wrote:
> > > On Thu, Aug 25, 2022 at 06:01:01PM +0900, Kunihiko Hayashi wrote:
> > > > Need to register pci_epf_test_notifier function event if only
> > > > core_init_notifier is enabled.
> > > > 
> > > > Fixes: 5e50ee27d4a5 ("PCI: pci-epf-test: Add support to defer core
> > > initialization")
> > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > Acked-by: Om Prakash Singh <omp@nvidia.com>
> > > > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > > > ---
> > > >   drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > This patch is a part of series "PCI: endpoint: Fix core_init_notifier
> > > feature".
> > > > The rest of the patches have been withdrawn.
> > > > 
> > > > Changes since v2:
> > > > - Add Acked-by lines
> > > > 
> > > > Changes since v1:
> > > > - Add Acked-by lines
> > > > 
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > index 36b1801a061b..55283d2379a6 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > @@ -979,7 +979,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> > > >   	if (ret)
> > > >   		epf_test->dma_supported = false;
> > > > -	if (linkup_notifier) {
> > > > +	if (linkup_notifier || core_init_notifier) {
> > > >   		epf->nb.notifier_call = pci_epf_test_notifier;
> > > >   		pci_epc_register_notifier(epc, &epf->nb);
> > > 
> > > Why does pci_epc_register_notifier() even exist?  It's not used at all
> > > except for this test code.
> > > 
> > > It would be better if infrastructure like this were connected with
> > > some user of it.
> >
> > This call was added by the commit 5779dd0a7dbd
> > ("PCI: endpoint: Use notification chain mechanism to notify EPC events to EPF").
> > 
> > I haven't followed the discussion, however, this commit say: "This
> > will also enable to add more events (in addition to linkup) in the
> > future."
> 
> 5779dd0a7dbd was 2.5 years ago.  It was probably a mistake to merge it
> then.  Usually we add infrastructure when we have a user for it,
> either in the very same patch or at least in a subsequent patch of the
> series.  
> 
> But Lorenzo has already merged this, so I guess this is moot.
> 
> He probably wouldn't object to a second patch that removes the fixed
> infrastructure if nobody uses it.  We can easily resurrect it if a
> need arises, and if that happens, we'll be glad that it has been
> fixed!
> 

I'm planning to submit a new EPF driver that makes use of this infrastructure
(although the callback mechanism).

Thanks,
Mani

> Bjorn

-- 
மணிவண்ணன் சதாசிவம்
