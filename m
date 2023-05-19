Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7A7709CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjESQyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjESQyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:54:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D2B1B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F04961830
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35165C433D2;
        Fri, 19 May 2023 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684515268;
        bh=qdeg6xLN2YhYdTB45PajbhDh1y+9dPsOk3q/dOApKts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pb+zb/Wc7lZKEdsb3bxCF8wDchu4CHbIF99eGFk1tinaBwFQ/K6hH1gVfGKeXjQKW
         nehfvCN35KQhgZVjrvedCCZIOpFhzHERyrhr5nwPegwv0zPlqxup0xdARWT+dFHvAB
         2PTtNmtGaZKCzB1f/90w0r+DoeLvE+d2ISU0ETtnZqnS1b+AMKdUEIUxeyV8UlD15i
         VGQHGTD/r+uySn9Dc1hsIrXe37MeZKYKDv5Q0zLPkDMK5OGjcVPSA83SvAGNCsEMFC
         A4C8/07EKafZhOzxDEHx9awy+D1v5IAxbb8CAXT/vQtHzSzIIIixhviuMitcqKSt+G
         IaXiHWc/sSGrw==
Date:   Fri, 19 May 2023 18:54:25 +0200
From:   Simon Horman <horms@kernel.org>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Add missing documentation for structure fields
Message-ID: <ZGepwedHtG62XFXP@kernel.org>
References: <20230510-virtio-kdoc-v2-1-1c5a20eb4cfe@kernel.org>
 <y6kgnwu35oci7y5hx2htfobglrecjhxgpnqmtjetv52xk7hlsc@gwvfoojunl4x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y6kgnwu35oci7y5hx2htfobglrecjhxgpnqmtjetv52xk7hlsc@gwvfoojunl4x>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:54:49AM +0200, Stefano Garzarella wrote:
> On Thu, May 11, 2023 at 04:46:22PM +0200, Simon Horman wrote:
> > Add missing documentation for the vqs_list_lock field of struct virtio_device,
> > and the validate field of struct virtio_driver.
> > 
> > ./scripts/kernel-doc says:
> > 
> > .../virtio.h:131: warning: Function parameter or member 'vqs_list_lock' not described in 'virtio_device'
> > .../virtio.h:192: warning: Function parameter or member 'validate' not described in 'virtio_driver'
> > 2 warnings as Errors
> > 
> > No functional changes intended.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> > Changes in v2:
> > - As suggested by Michael S. Tsirkin
> >  + @validate is not called on probe
> >  + @validate does validates config space
> >  + embarrassingly, validate was misspelt
> > - Link to v1: https://lore.kernel.org/r/20230510-virtio-kdoc-v1-1-d2b1824a9a2b@kernel.org
> > ---
> > include/linux/virtio.h | 2 ++
> > 1 file changed, 2 insertions(+)
> 
> I left some minor comments, anyway this version LGTM:
> 
> Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks, and sorry for the delay.

> > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > index b93238db94e3..3abe8e9c8090 100644
> > --- a/include/linux/virtio.h
> > +++ b/include/linux/virtio.h
> > @@ -103,6 +103,7 @@ int virtqueue_resize(struct virtqueue *vq, u32 num,
> >  * @config_enabled: configuration change reporting enabled
> >  * @config_change_pending: configuration change reported while disabled
> >  * @config_lock: protects configuration change reporting
> > + * @vqs_list_lock: protects @vqs.
> 
> Maybe we can now remove `/* Protects VQs list access */`

Yes, I think so.

> >  * @dev: underlying device.
> >  * @id: the device type identification (used to match it with a driver).
> >  * @config: the configuration ops for this device.
> > @@ -160,6 +161,7 @@ size_t virtio_max_dma_size(const struct virtio_device *vdev);
> >  * @feature_table_size: number of entries in the feature table array.
> >  * @feature_table_legacy: same as feature_table but when working in legacy mode.
> >  * @feature_table_size_legacy: number of entries in feature table legacy array.
> > + * @validate: the function to call to validate features and config space
> 
> Maybe we can add ". Returns 0 or -errno."

Sure, I'll plan to include this in v3.

 * @validate: the function to call to validate features and config space.
 *            Returns 0 or -errno.

...
