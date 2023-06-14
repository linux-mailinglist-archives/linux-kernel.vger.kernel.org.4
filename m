Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4672F8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbjFNJR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243952AbjFNJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:17:42 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1700D1FF5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:17:41 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f98276f89cso139001cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686734260; x=1689326260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NmiRBAcZ9cvxOKeXFRkYv+ik5tUe/PARU9gZbEaPiU=;
        b=LYUQ3HqCYY/8TiB3Z6yqF2jVftbgewi2HgiI06akooT//gxAb3nyPrrpf3yB6UOQKb
         82QwZeiHTj8mlH4qmJwzexlj9Rn/pKp37S/+4qXHxKun61AlIKxmSIzoyZ7HQdBYyn1Q
         6wKz9A9rJejJTem+bwubkAGocVI9MxMmrCP3BkwTFaJkH3XSUqCcFEY3HziBgfKaC+TD
         Xk8zS86HkDprZ0XiVevGL136O4vbre0Ks6uCPMlr5W+Ep/Xh/LiHmU0NOQKC4GpWQ5uB
         n5xgMJeZZjKM7SG1or7ONVz+myczJjYZvnBEHtqXgd+29LnN/16RwqL3aA0Xe02KWlNZ
         eyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686734260; x=1689326260;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NmiRBAcZ9cvxOKeXFRkYv+ik5tUe/PARU9gZbEaPiU=;
        b=Bfbu1JK+RCfKYwQrEeu4YwGav+j1DcCfRyCL4nrMvmt6wqX+qdv3D4Oq2hIcdRCyxE
         ClxUhdpMyET0bsbDRtMyFUvqyhFMRbDojRYoHIUTjseB6sPxa3ulniB+Uy6102gE9hy7
         R2+vkJNwV/3/CT47JOfemE+BCQ+9W8XXtDA782hRfapp3k6t9X1HcHyMe8Z5r8kZGR1k
         KFmYbdooncnAttWjGq70GiTjGUvZL2aK+fJIxVZBjxJ1a0HOEyfQaxZMiwvbt5Opvhyv
         JIBDeE6KQRMYLB70x3ia6iZrVHprmCjg97g5pDoCJX6DklEnVsyYQEHwYSovlXYtwOeS
         Zp2Q==
X-Gm-Message-State: AC+VfDw4nNdXL5k3HKwdhGH8E+uFmZZVsFURxcxXi7wdAf+UBWVpRu4/
        EUXRliiqluqOGh2n1K4RgST+7bmdW7qgi6uIhofqRg==
X-Google-Smtp-Source: ACHHUZ6qFqzCM8Btqgf8/fKUnENgzMgD7o0VcXeVee1SYR7Rsd46p+9kfWjn+ika7JL8ur8cwhxssPXqimpWLOMcgv0=
X-Received: by 2002:a05:622a:188f:b0:3f9:56c:1129 with SMTP id
 v15-20020a05622a188f00b003f9056c1129mr130965qtc.5.1686734259904; Wed, 14 Jun
 2023 02:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230606120854.4170244-1-mshavit@google.com> <20230606120854.4170244-15-mshavit@google.com>
 <ZH9oQMmI8CezMCnx@nvidia.com> <CAKHBV25eDNXEu+6GWDJqpw1h5N-Jq-GPzf81kNH1dyw3Z=KsZA@mail.gmail.com>
 <ZIBxPd1/JCAle6yP@nvidia.com>
In-Reply-To: <ZIBxPd1/JCAle6yP@nvidia.com>
From:   Michael Shavit <mshavit@google.com>
Date:   Wed, 14 Jun 2023 17:17:03 +0800
Message-ID: <CAKHBV25K4BCewMdp3HcRtaX1iNhVpxL_6dMwp1_fmcQ5RWpKBQ@mail.gmail.com>
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

On Wed, Jun 7, 2023 at 1:09=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Tue, Jun 06, 2023 at 08:07:50PM +0800, Michael Shavit wrote:
> > SVA may attach a CD to masters that have different upstream SMMU
> > devices. The arm_smmu_domain structure can only be attached to a single
> > upstream SMMU device however.
>
> Isn't that pretty much because we don't support replicating
> invalidations to each of the different SMMU instances?

Looked into this some more, and supporting attach to multiple devices
is still very hard:
1. When an arm_smmu_domain is first attached to a master, it
initializes an io_pgtable_cfg object whose properties depend on the
master's upstream SMMU device. This io_pgtable_cfg is then used to
allocate an io_pgtable object, and the arm_smmu_ctx_desc's TTBR field
points to that io_pgtable's TTBR (and ditto for the vttbr on stage 2
domains). So then arm_smmu_domain needs to be split into two,
arm_smmu_domain and arm_smmu_device_domain with the latter containing
a per-SMMU device io_pgtable, arm_smmu_ctx_desc and arm_smmu_s2_cfg.
Each iommu_domain_ops operation now needs to loop over each
arm_smmu_device_domain.
2. Some of the iommu_domain fields also depend on the per-SMMU
io_pgtable_cfg; specifically pgsize_bitmap and geometry.aperture_end.
These need to be restricted as the domain is attached to more devices.
3. Attaching a domain to a new SMMU device must be prohibited after
any call to map_pages or if iommu_domain.pgsize_bitmap and
iommu-domain.geometry.aperture_end have been consumed by any system.
The first is something the arm-smmu-v3.c driver could feasibly enforce
on its own, the second requires changes to the iommu framework.

The arm-smmu-v3-sva.c implementation avoids all these problems because it
doesn't need to allocate an io_pgtable; the shared arm_smmu_ctx_desc's
TTBR is set to the MM's TTBR. One possible solution would be to make
the changes proposed in 1., but only allowing SVA domains to attach to
multiple devices:
1. Domain functions only accessed by arm-smmu-v3.c (such as
arm_smmu_iova_to_phys) can assume there's a single
arm_smmu_device_domain per arm_smmu_domain.
2. Domain functions also accessed by arm-smmu-v3-sva.c (such as
invalidations commands) must iterate over all arm_smmu_device_domains.

> On Wed, Jun 7, 2023 at 8:00=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
> I think splitting it into a series to re-organize the way ste/cd stuff
> works is a nice contained topic.

Should I explicitly resend this patch series as a v3 cutting off
patches 14 and onwards?
