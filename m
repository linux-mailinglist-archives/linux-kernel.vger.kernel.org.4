Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1370968C6FD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjBFTpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjBFTpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:45:12 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F12855B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:45:11 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso9757369wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APDyx3z4IV3rW3QxZlA7mfU0mjO7Ox32BtkbuWjdnhQ=;
        b=BA9E+Wxq5Z1bboYNGKdE7TzAScXqwKruYCCehgI70/13ingHOhZ6Y5lGoiIW56O4oD
         iPyb2vXEu6NdFnIsOqjcMM+aTduZbnWf9PLpnpM6swoMBvfb8WtbdsuCBWcMA67TrDDq
         Eg2djz5q+d9V14je6D2HYO8GqM6bxlcDxePdjqAk9G4NrYZ4wgFRJ8/Nav7JHwNxaABP
         42QiftW1N6IgjvDmEqAWK2U/CB9OYPN0KhibLpI+IylVivMMA4ymm8RHisqUCezi9lMz
         J6BlkASoQUWyqBX+Q15WD5ygF0797iMyOHWin84BkroAw5L0qb6NZp+uIG7DXIZ8uBVd
         Mp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APDyx3z4IV3rW3QxZlA7mfU0mjO7Ox32BtkbuWjdnhQ=;
        b=22EaTLyz2O0IS+4/oyTElRIEkj/nuybgdOfVLq3SNvfcZrCUb4gJwUE8O8wZmGS3CZ
         U6fhnlWrToMRen4bs3B1tamp3Ib9mrDTQ4ukWmT/gBIDpAiiSOWuOVHzpGYFjBYx+VJp
         wLAHGF7fwLjXPkUtTxOaEc3UBeesvogdq7nzM96mP/+JoME5FTSIrb0OBT9rdHpAVNDF
         dSKLEgrkt+vtsQZ89CNB+U7ynEr0iyu5QtJTWvYCs0gIKYMik7d4l0O5RTWIjQxbcqhN
         PT6i7pwgk4q69o3KvBJD/k5RsB41ckbLwxYiUnJwdYPgJLQZogfZPaKHq/Uh6NoT8g5n
         wT2Q==
X-Gm-Message-State: AO0yUKVGdnzDPTRFGeIReqTbi46T2mKkW4yfBeCkutno4e0DVyPEXk4d
        Cv5+ZOOup5G9k1NO5bC9XfK2kg==
X-Google-Smtp-Source: AK7set8XgVcldAJlafsoSXSh5Q33TEccODw28mHgBONK8/sMpsHldbDSv7P8EojCeImLsUHJJWeYsQ==
X-Received: by 2002:a05:600c:43ca:b0:3d9:a145:4d1a with SMTP id f10-20020a05600c43ca00b003d9a1454d1amr764913wmn.34.1675712710077;
        Mon, 06 Feb 2023 11:45:10 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id ip20-20020a05600ca69400b003dd19baf45asm11232511wmb.40.2023.02.06.11.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 11:45:09 -0800 (PST)
Date:   Mon, 6 Feb 2023 19:45:05 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, robin.murphy@arm.com, will@kernel.org,
        joro@8bytes.org, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Enable PCI ATS in passthrough mode as
 well
Message-ID: <Y+FYwbWgOaWyHySj@myrica>
References: <20230202124053.848792-1-gankulkarni@os.amperecomputing.com>
 <Y9z3UG+wEBn4i3G2@myrica>
 <3a681b82-d840-6ef1-40dd-358f34c8be9c@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a681b82-d840-6ef1-40dd-358f34c8be9c@os.amperecomputing.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 10:50:00PM +0530, Ganapatrao Kulkarni wrote:
> 
> 
> On 03-02-2023 05:30 pm, Jean-Philippe Brucker wrote:
> > On Thu, Feb 02, 2023 at 04:40:53AM -0800, Ganapatrao Kulkarni wrote:
> > > The current smmu-v3 driver does not enable PCI ATS for physical functions
> > > of ATS capable End Points when booted in smmu bypass mode
> > > (iommu.passthrough=1). This will not allow virtual functions to enable
> > > ATS(even though EP supports it) while they are attached to a VM using
> > > VFIO driver.
> > > 
> > > This patch adds changes to enable ATS support for physical functions
> > > in passthrough/bypass mode as well.
> > [...]
> > > @@ -2453,8 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
> > >   	master->domain = smmu_domain;
> > > -	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
> > > -		master->ats_enabled = arm_smmu_ats_supported(master);
> > > +	master->ats_enabled = arm_smmu_ats_supported(master);
> > 
> > I should have added a comment for this. Only found the reason in an old
> > cover letter [1]:
> > 
> > "When no translation stages are enabled (0b100), ATS Translation Requests
> > (and Translated traffic, if SMMU_CR0.ATSCHK == 1) are denied as though
> > EATS == 0b00; the actual value of the EATS field is IGNORED. Such a
> > Translation Request causes F_BAD_ATS_TREQ and Translated traffic causes
> > F_TRANSL_FORBIDDEN."
> > 
> > (See 3.9.1.1 "Responses to ATS Translation Requests and Translated
> > transactions" and 5.2 "Stream Table Entry")
> > 
> > So I don't think we can enable ATS for bypass domains :/ The PF needs to
> > be in translated mode in that case.
> 
> Are you intending to say smmu-v3 driver/spec will not support ATS to a VF,
> if it's PF is in bypass?

What I meant was that if, in order to enable the VF ATS capability, the
PCIe device requires to first enable the PF ATS capability, then given
that the SMMU does not allow enabling ATS for streams in bypass, we need
to enable translation on both PF and VF SMMU configurations.

But reading the PCIe spec, it looks like the capabilities are not
necessarily tied together:

 "The ATS Capabilities in VFs and their associated PFs are permitted to be
 enabled independently." 10.5.1 ATS Extended Capability

That wording doesn't indicate that all implementations must allow enabling
the caps independently, only that they are allowed to do so. If a device
provides independent capabilities, then I don't think you need to enable
ATS in the PF.

Then the ATS Control Register seems to contradict this with the STU field:

 "For VFs, this field must be hardwired to Zero. The associated PF's value
 applies." 10.5.1.3 ATS Control Register (Offset 06h)

So pci_enable_ats() requires that pdev->ats_stu is set in order to enable
ATS on the VF:

        /*
         * Note that enabling ATS on a VF fails unless it's already enabled
         * with the same STU on the PF.
         */
        ...
        if (dev->is_virtfn) {
                pdev = pci_physfn(dev);
                if (pdev->ats_stu != ps)
                        return -EINVAL;

But I suspect it's done this way only because it's easier to implement.
The spec doesn't require the PF ATS capability to be enabled, it just says
that the PF's STU value counts as the VF's one. It looks like we're
allowed to enable ATS on the VF without enabling it on the PF, right?
If you rework the PCI driver to only write the PF's STU without enabling
the capability, then you could enable it in the VF.

Thanks,
Jean

> 
> > 
> > I can send a patch adding the comment next cycle.
> 
> I am more keen to know, how we enable ATS to a VF of ATS capable EP when
> it's PF is in bypass?
> or it is mandatory to have a PF also translated? then that should be
> captured somewhere in documentation.
> 
> 
> > 
> > Thanks,
> > Jean
> > 
> > [1] https://lore.kernel.org/linux-iommu/20190409165245.26500-1-jean-philippe.brucker@arm.com/
> > 
> 
> Thanks,
> Ganapat
