Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69351607665
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiJULmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 07:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiJULmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 07:42:42 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45892625CF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:42:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f4-20020a9d0384000000b0066208c73094so1681517otf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5PwdDXVu5A11cVv6wJuG3gZctd4QRKpsxJeBckZ3fGo=;
        b=DE2jFHwTCLaJZKNXRFpcGV7F9oYrDcTgin68ddiLvmSVj7qsqTyMUi4RIbwW5Oe+if
         7Rr4jMKrJeV2vk7KsQXL0yyAopaHkuLwC0Km67MNC4pWxDq2BhmEKwxsCS5Hhbya01fP
         wzW8WS0Nj/oIKB+NnQFEPENeAym4Atjquli+3OdFHqEUCjxZm38DlfwzQqCnCt4hNK4a
         Jis9X5xOEn2GVKQ+dNTjBD7eQhEAu/nDy+bggd6+paAMX7wGt+FrV0Nl7c0mqvRxd8HT
         rInJCusJHTq0E9lO5WWRQBQlyIXFTCn09HTBcEQbXehVbXFSmkWg+dWi9WjXpgN7YJwz
         CnyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5PwdDXVu5A11cVv6wJuG3gZctd4QRKpsxJeBckZ3fGo=;
        b=gOABG8oH5uUyAb2A0DGdlcOcFif00Z0QBKhlKBa+5tlXI0vzqQ42YnxLqWVknJXBWh
         bg0o0+iaR4Gva61wPVpRm5FMHoTPsAMXidk3hmQqJVTYTbWIAy+KHue5rWdc2hXKvrTS
         6N9ETh+U7Wviz3RlFMtCJRwoKfYoqK+k5Hh9MVqqbb1ErSOuxXpm7litv/WGCHu4jAO8
         qUiDsHSwwkxz3eVfdg9iy4kcGiN5r1eHOm9X+vw0NnFNDehqqrvLfJOD/+P2udR2NwUT
         6xzViWat1/YZAd+cu4PyMNNmwzZA82FJ2LalhsWWi7IGWFQFqxegbUwz4sbQ5Z9+ipg3
         tMwg==
X-Gm-Message-State: ACrzQf0KQbcy4mg71mSc8LWJWQJZ/JwHmkxhh1OoQkutUGBaYfvvZkSv
        JkmSmCV1+jEfToy3w6qCB0gk6Y53DZqugnb1WMcsDhJcHAo=
X-Google-Smtp-Source: AMsMyM4MlL2lx2850kkZhBccJdvjF9LkaoDGMT+SR3ZXRJtr91+cINSTOEUZYpzEfNjB/7WXVfOGbX3ghN9Ri7GGsJw=
X-Received: by 2002:a05:6830:4115:b0:661:a2c4:3bcd with SMTP id
 w21-20020a056830411500b00661a2c43bcdmr10255936ott.368.1666352561091; Fri, 21
 Oct 2022 04:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20221017171118.1588820-1-sammler@google.com>
In-Reply-To: <20221017171118.1588820-1-sammler@google.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Fri, 21 Oct 2022 13:42:28 +0200
Message-ID: <CAM9Jb+ggq5L9XZZHhfA98XDO+P=8y-mT+ct0JFAtXRbsCuORsA@mail.gmail.com>
Subject: Re: [PATCH v1] virtio_pmem: populate numa information
To:     Michael Sammler <sammler@google.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Compute the numa information for a virtio_pmem device from the memory
> range of the device. Previously, the target_node was always 0 since
> the ndr_desc.target_node field was never explicitly set. The code for
> computing the numa node is taken from cxl_pmem_region_probe in
> drivers/cxl/pmem.c.
>
> Signed-off-by: Michael Sammler <sammler@google.com>
> ---
>  drivers/nvdimm/virtio_pmem.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
> index 20da455d2ef6..a92eb172f0e7 100644
> --- a/drivers/nvdimm/virtio_pmem.c
> +++ b/drivers/nvdimm/virtio_pmem.c
> @@ -32,7 +32,6 @@ static int init_vq(struct virtio_pmem *vpmem)
>  static int virtio_pmem_probe(struct virtio_device *vdev)
>  {
>         struct nd_region_desc ndr_desc = {};
> -       int nid = dev_to_node(&vdev->dev);
>         struct nd_region *nd_region;
>         struct virtio_pmem *vpmem;
>         struct resource res;
> @@ -79,7 +78,15 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
>         dev_set_drvdata(&vdev->dev, vpmem->nvdimm_bus);
>
>         ndr_desc.res = &res;
> -       ndr_desc.numa_node = nid;
> +
> +       ndr_desc.numa_node = memory_add_physaddr_to_nid(res.start);
> +       ndr_desc.target_node = phys_to_target_node(res.start);
> +       if (ndr_desc.target_node == NUMA_NO_NODE) {
> +               ndr_desc.target_node = ndr_desc.numa_node;
> +               dev_dbg(&vdev->dev, "changing target node from %d to %d",
> +                       NUMA_NO_NODE, ndr_desc.target_node);
> +       }

As this memory later gets hotplugged using "devm_memremap_pages". I don't
see if 'target_node' is used for fsdax case?

It seems to me "target_node" is used mainly for volatile range above
persistent memory ( e.g kmem driver?).

Thanks,
Pankaj

> +
>         ndr_desc.flush = async_pmem_flush;
>         ndr_desc.provider_data = vdev;
>         set_bit(ND_REGION_PAGEMAP, &ndr_desc.flags);
> --
