Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15AA5F723A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiJGAYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJGAX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:23:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A1FFF8D6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:23:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 282D6B821E3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 00:23:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C89C433D6;
        Fri,  7 Oct 2022 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665102235;
        bh=wNxxAaNgmv1Yy2qhYYPm61z1GMJgbu+XBvZGxaEoE4U=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=kVleMf6zL6f1pwxe3/B2+3DcPTeU3X6a/wIGPDmirHr2H5djKLv8hAP3MT3r/KeNf
         7Iu7krEgUK6RMUuh3oPWvGrQoXgT2rnlUWnpQAmGvFOxkLRwSVN/czsbTqpoRF0O8Z
         EhEIImTKy/roVmqFiE6fJZ3RGfNgwaNLXYa5++bk1MZjcXL6OwB6vcyL9bgQ9OR1pb
         jikOOGFNJiMQPE/gzN5LBfzAc3yW4s/F6xrNdBGknOVcyIGL7sELIUIkqRrD2ePMEO
         21i9P/Q+7ae1hDCMjXB6nym3qwmuxGJYwmp8gX7d/2w0uCx0MaycdEKFVKwMoN3klc
         qldIYJvaWDb5g==
Date:   Thu, 6 Oct 2022 17:23:52 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
cc:     Juergen Gross <jgross@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 2/3] xen/virtio: use dom0 as default backend for
 CONFIG_XEN_VIRTIO_FORCE_GRANT
In-Reply-To: <36b69e76-a26e-f7e5-998a-8345034cec20@epam.com>
Message-ID: <alpine.DEB.2.22.394.2210061723410.3690179@ubuntu-linux-20-04-desktop>
References: <20221006071500.15689-1-jgross@suse.com> <20221006071500.15689-3-jgross@suse.com> <36b69e76-a26e-f7e5-998a-8345034cec20@epam.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022, Oleksandr Tyshchenko wrote:
> On 06.10.22 10:14, Juergen Gross wrote:
> 
> Hello Juergen
> 
> > With CONFIG_XEN_VIRTIO_FORCE_GRANT set the default backend domid to 0,
> > enabling to use xen_grant_dma_ops for those devices.
> >
> > Signed-off-by: Juergen Gross <jgross@suse.com>
> > ---
> >   drivers/xen/grant-dma-ops.c | 3 +++
> >   1 file changed, 3 insertions(+)
> 
> 
> Reviewed-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> > diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
> > index f29759d5301f..a00112235877 100644
> > --- a/drivers/xen/grant-dma-ops.c
> > +++ b/drivers/xen/grant-dma-ops.c
> > @@ -349,6 +349,9 @@ void xen_grant_setup_dma_ops(struct device *dev)
> >   	if (dev->of_node) {
> >   		if (xen_dt_grant_setup_dma_ops(dev, data))
> >   			goto err;
> > +	} else if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT)) {
> > +		dev_info(dev, "Using dom0 as backend\n");
> > +		data->backend_domid = 0;
> >   	} else {
> >   		/* XXX ACPI device unsupported for now */
> >   		goto err;
> 
> -- 
> Regards,
> 
> Oleksandr Tyshchenko
> 
