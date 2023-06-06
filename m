Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E8D724B82
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238308AbjFFSgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjFFSgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:36:45 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8663010F1
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 11:36:44 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f9b7de94e7so35641cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 11:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686076603; x=1688668603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A56IwHY5+byjNKAjh+uwXHK8afHF+U37XZljvsbVqKs=;
        b=LD+ckuYjLtWV1YRQOg3PLufZlPloFGyMumfiFUHPb4PBL1WCTqVPAQMQ+xscCKGRWG
         jvhqH0VitY0Hw5VHu9dgxZoKwmZ8ua2KENbtrMLxUu2H3CcyIukos1btHsetvY1toFnw
         v4L2FSosY5QfRfgdxLSSMU3LWMS+zcASQ2xoXi4EK+kt1Tji1vPehXZ+yJD9FmZhJwJG
         po9U+HA9pve1AhbZs1C0GpsZUILNLZOQTKefnxEQJf6uWS9MxJn4D9EFGT9T2+0vo1n+
         fa1h2u/0OLMS633XRELsU4a8vauYWjLENRT9Fg6HQmpbt2STJsTy6vpKFe8CXamlTnP/
         mUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686076603; x=1688668603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A56IwHY5+byjNKAjh+uwXHK8afHF+U37XZljvsbVqKs=;
        b=S+PE3+C2BxkIe+DCFvAn8V/ZgwEdhL7HLLvCf7Fz1BktI3kY3moSp0I15d1ILXbsQP
         2eQ4VzWdHuHCxNhKptEw/iePAfxty9cNZ9swFDaEbBPGqaWfflMkUhLSWkEjokKidp06
         ffWVm2/VONEmDu8Z+pMWYAR+OIbw+m8J60sDV52uGdPSQZv5hu2o/rm6iJ2jjtWLbdF4
         i42bqrke5CVMtuREFONLCBkrGac7klKYj3nEHHCg2SMnzhSDHDDrMwlQPDpAQp3kI0pq
         Se6Qx9ksX8JOcPCDNpiP0Yp2HL896f09rFVsNr7O4a/9CYKuLbQmkgkZjwQyMIaxid+x
         6V7w==
X-Gm-Message-State: AC+VfDxFF82cVahdvJmUV2+fJsVexU2Tb9DIsLXpmOPwtLcZ8z8EfIGs
        EKVe5n7T3JPSPwMJFXlL/R996ja3n2jkRANoVxOi8A==
X-Google-Smtp-Source: ACHHUZ5NDwRXuNiM755ldBiztJFRxN0R1USqy0SysmBtk902kWPW7QxwDPIR+i1U/wbViR3XHPzaCyE576EXCgNdH0k=
X-Received: by 2002:a05:622a:144e:b0:3f4:f0fd:fe7e with SMTP id
 v14-20020a05622a144e00b003f4f0fdfe7emr13637qtx.3.1686076603516; Tue, 06 Jun
 2023 11:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com> <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com>
In-Reply-To: <ZH9oQMmI8CezMCnx@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 7 Jun 2023 00:06:07 +0530
Message-ID: <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
Subject: Re: [PATCH v2 14/18] iommu/arm-smmu-v3: Support domains with shared CDs
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 10:39=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, Jun 06, 2023 at 08:07:50PM +0800, Michael Shavit wrote:
> > SVA may attach a CD to masters that have different upstream SMMU
> > devices. The arm_smmu_domain structure can only be attached to a single
> > upstream SMMU device however.
>
> Isn't that pretty much because we don't support replicating
> invalidations to each of the different SMMU instances?
....
> I would expect different SMMU devices to be handled by allowing single
> domains to be attached to a list of masters where the masters can all
> be from different instances.

Oh you're right! When I first looked at this, arm_smmu_domain still
held an arm_smmu_s1_cfg which depends on the SMMU device. But
attaching a single (stage 1) arm_smmu_domain to multiple SMMUs looks
much more tractable after the first half of this patch series. We can
add a handle to the smmu device in the new arm_smmu_attached_domain
struct for this purpose.

> What we definately shouldn't do is try to have different SVA
> iommu_domain's pointing at the same ASID. That is again making SVA
> special, which we are trying to get away from :)

Fwiw, this change is preserving the status-quo in that regard;
arm-smmu-v3-sva.c is already doing this. But yes, I agree that
resolving the limitation is a better long term solution... and
something I can try to look at further.

> You might try to stop your series here and get the first batch of
> patches done. This latter bit seems to be a seperate topic?

The main motivation for this part of the series is to reduce
inconsistencies with the smmu_domain->attached_domains list and
arm-smmu-v3 functions that rely on that list. Specifically to reach
the last patch in the series: "iommu/arm-smmu-v3-sva: Remove
atc_inv_domain_ssid".

Splitting this part into a follow-up patch series would definitely be
easier and helpful if you're all ok with it :) .
