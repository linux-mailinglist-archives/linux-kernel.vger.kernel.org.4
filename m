Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A0D6399D3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 10:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiK0JoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 04:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiK0Jn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 04:43:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA38712086
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 01:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669542182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hCGeRJaJ4BT+MNAi9nuSQuHFDu4OGy2+H1qbzpSUDAE=;
        b=at9UWplqR2zHYq2eeDxjc6JXj+X+vXRQkhRFtse5zLHhOhsC1HJOrxo4kX/7YVQCX7Bq9r
        PDrOISrAGLpd49snYEZS4KnTgxlVqeUqh408ccHLs08BvgWANj7hX+EfjgbIvEY/OMkin5
        fxR/wXbIQGdPrW8Kbw7DaBPe0r97AOg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-ReqQPmC-Pf6YqMl_chEeIQ-1; Sun, 27 Nov 2022 04:42:56 -0500
X-MC-Unique: ReqQPmC-Pf6YqMl_chEeIQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A20B885A588;
        Sun, 27 Nov 2022 09:42:55 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD8FE111F3B6;
        Sun, 27 Nov 2022 09:42:46 +0000 (UTC)
Date:   Sun, 27 Nov 2022 17:42:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     John Garry <john.g.garry@oracle.com>, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: Why is MEGASAS_SAS_QD set to 256?
Message-ID: <Y4MxEcF+DWCAgxGJ@T590>
References: <1c4d66ca-fe1a-3d1a-d7f9-4981d2fc9eb1@huaweicloud.com>
 <e11cdb17-053c-390c-9c48-36790eb70cc5@oracle.com>
 <2b89210a-222c-a919-ab5b-c76830308f92@huaweicloud.com>
 <Y4F3XG3lMCCKlLAr@T590>
 <aef69f3b-a8db-f34c-4a52-49ba9020f6cf@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aef69f3b-a8db-f34c-4a52-49ba9020f6cf@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 02:08:02PM +0800, Yu Kuai wrote:
> Hi, Ming
> 
> 在 2022/11/26 10:18, Ming Lei 写道:
> > 
> > If you want aggressive merge on sequential IO workload, the queue depth need
> > to be a bit less, then more requests can be staggered into scheduler queue,
> > and merge chance is increased.
> 
> But if nr_requests >= queue_depth, it seems to me elevator will have no
> effect, no request can be merged or sorted by scheduler, right?

Yeah.

If nr_requests <= queue_depth, every request can be queued to
driver/device, so requests won't be merged by scheduler.

But plug merge still works if IOs are submitted as batch.

> > 
> > If you want good perf on random IO perf, the queue depth needs to
> > be deep enough to have enough parallelism for saturating SSD internal.
> > 
> > But we don't recognize sequential/random IO pattern, and usually fixed
> > queue depth is used.
> 
> Is it possible to use none elevator and set large queue_depth if nvme is
> used in this case?

Yeah, if the storage is SSD, usually none with bigger queue_depth should
help, and usually 256 should be enough to saturate one single SSD for
one well implemented driver.


Thanks
Ming

