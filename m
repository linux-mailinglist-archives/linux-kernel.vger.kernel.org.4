Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4AF85E586A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiIVCNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiIVCNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED239C236
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 19:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663812826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=la998Fhh07Iapm6q9oJ6N9PKQNKvsYQdU7CIA3wD4kk=;
        b=BmIXEbtXzKaqTtLF2m7wm8aHfTBTkxsGIMUpmBKW3uebv+cuGJlXGoeYLBTFN2xp/rebGD
        Y9mbCDaPbd03oqN56jo2YdzDQF9XZZQ1wgNn5PUwnQUCPQdsNj6kjdgg6Aa0IInNmFvZp7
        3PGD3eypIBXRwH8Q3vNmDXUcH0UK6Gk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-655-MdOlDXeCNyqMlsFfMDMc9g-1; Wed, 21 Sep 2022 22:13:43 -0400
X-MC-Unique: MdOlDXeCNyqMlsFfMDMc9g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3E8F85A5A6;
        Thu, 22 Sep 2022 02:13:42 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F25382166B2C;
        Thu, 22 Sep 2022 02:13:30 +0000 (UTC)
Date:   Thu, 22 Sep 2022 10:13:25 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     ZiyangZhang <ZiyangZhang@linux.alibaba.com>
Cc:     axboe@kernel.dk, xiaoguang.wang@linux.alibaba.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH V4 6/8] ublk_drv: support UBLK_F_USER_RECOVERY_REISSUE
Message-ID: <YyvExQcnSFAqQHMY@T590>
References: <20220921095849.84988-1-ZiyangZhang@linux.alibaba.com>
 <20220921095849.84988-7-ZiyangZhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921095849.84988-7-ZiyangZhang@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 05:58:47PM +0800, ZiyangZhang wrote:
> UBLK_F_USER_RECOVERY_REISSUE implies that:
> With a dying ubq_daemon, ublk_drv let monitor_work requeues rq issued to
> userspace(ublksrv) before the ubq_daemon is dying.
> 
> UBLK_F_USER_RECOVERY_REISSUE is designed for backends which:
> (1) tolerate double-write since ublk_drv may issue the same rq
>     twice.
> (2) does not let frontend users get I/O error, such as read-only FS
>     and VM backend.
> 
> Signed-off-by: ZiyangZhang <ZiyangZhang@linux.alibaba.com>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

