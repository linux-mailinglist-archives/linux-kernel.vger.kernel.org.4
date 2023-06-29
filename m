Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A86741D49
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 02:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjF2Ajx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 20:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF2Ajr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 20:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457CB10FD
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 17:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687999135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OrLmNB2GGh31uhER3PTvDlbj/IyEOeXGRijja43l2Mw=;
        b=NSkh7Uv3GRNZOg/Z7BJ6T4U7BkY5iH7iziX3zI8EWsYRtyPIfNPwawXBwMh/VMB4YIZvsx
        IBekc1SRWVuZt5sh1F8o1zFMMeP9p6UECqwSN1PLGaT0DKvRDswMaRpMGpzprHyH6U1cWt
        qHpr3xlwkugowt4fU1onz3crw21+Sxg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-627-7BICcNw7Pw6gz7OW3-gGsA-1; Wed, 28 Jun 2023 20:38:49 -0400
X-MC-Unique: 7BICcNw7Pw6gz7OW3-gGsA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7918E3C01C20;
        Thu, 29 Jun 2023 00:38:48 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A527E2166B26;
        Thu, 29 Jun 2023 00:38:41 +0000 (UTC)
Date:   Thu, 29 Jun 2023 08:38:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Andreas Hindborg <nmi@metaspace.dk>,
        Hans Holmberg <Hans.Holmberg@wdc.com>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH v4 1/4] ublk: change ublk IO command defines to enum
Message-ID: <ZJzSjFbzzNxppH7p@ovpn-8-18.pek2.redhat.com>
References: <20230628190649.11233-1-nmi@metaspace.dk>
 <20230628190649.11233-2-nmi@metaspace.dk>
 <d23bf48c-5bc9-aab6-4ca2-ebbb24a0878e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23bf48c-5bc9-aab6-4ca2-ebbb24a0878e@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:47:47AM +0900, Damien Le Moal wrote:
> On 6/29/23 04:06, Andreas Hindborg wrote:
> > From: Andreas Hindborg <a.hindborg@samsung.com>
> > 
> > This change is in preparation for zoned storage support.
> > 
> > Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> > ---
> >  include/uapi/linux/ublk_cmd.h | 23 +++++++++++++++++------
> >  1 file changed, 17 insertions(+), 6 deletions(-)
> > 
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > index 4b8558db90e1..471b3b983045 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -229,12 +229,23 @@ struct ublksrv_ctrl_dev_info {
> >  	__u64   reserved2;
> >  };
> >  
> > -#define		UBLK_IO_OP_READ		0
> > -#define		UBLK_IO_OP_WRITE		1
> > -#define		UBLK_IO_OP_FLUSH		2
> > -#define		UBLK_IO_OP_DISCARD	3
> > -#define		UBLK_IO_OP_WRITE_SAME	4
> > -#define		UBLK_IO_OP_WRITE_ZEROES	5
> > +enum ublk_op {
> > +	UBLK_IO_OP_READ = 0,
> > +	UBLK_IO_OP_WRITE = 1,
> > +	UBLK_IO_OP_FLUSH = 2,
> > +	UBLK_IO_OP_DISCARD = 3,
> > +	UBLK_IO_OP_WRITE_SAME = 4,
> > +	UBLK_IO_OP_WRITE_ZEROES = 5,
> > +	UBLK_IO_OP_ZONE_OPEN = 10,
> > +	UBLK_IO_OP_ZONE_CLOSE = 11,
> > +	UBLK_IO_OP_ZONE_FINISH = 12,
> > +	UBLK_IO_OP_ZONE_APPEND = 13,
> > +	UBLK_IO_OP_ZONE_RESET = 15,
> > +	__UBLK_IO_OP_DRV_IN_START = 32,
> > +	__UBLK_IO_OP_DRV_IN_END = 96,
> > +	__UBLK_IO_OP_DRV_OUT_START = __UBLK_IO_OP_DRV_IN_END,
> > +	__UBLK_IO_OP_DRV_OUT_END = 160,
> > +};
> 
> This patch does not do what the title says. You are also introducing the zone
> operations, and the very obscure __UBLK_IO_OP_DRV_XXX operations without an
> explanation. Also, why the "__" prefix for these ? I do not see the point...

It should be to reserve space for ublk passthrough OP.

> Given that this is a uapi, a comment to explain the less obvious commands would
> be nice.
> 
> So I think the change to an enum for the existing ops can be done either in
> patch 2 or as a separate patch and the introduction of the zone operations done
> in patch 3 or as a separate patch.

Also it might break userspace by changing to enum from macro for existed
definition, cause userspace may check something by '#ifdef UBLK_IO_OP_*',
so probably it is better to keep these OPs as enum, or at least keep
existed definition as macro.

Thanks,
Ming

