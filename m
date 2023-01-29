Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1A67FDCF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjA2JTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbjA2JS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:18:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C732196A4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674983891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sViF6ZInPKPte2yWe3+h3SfJB20AgbA8M0P2IzSOqVA=;
        b=XUCvjNSM1Mo2b7V5W0JszVbutrRhSbL4Od7oB8lkmySKDmK0NDfV5HhKVRPxIZi2hQPHnX
        qHAKmQy7dvtj0+GAyw2rTiQdNlQKgxyL7drhEp6rAdjWbJ/fAvtv7Me7mww8cySsTwpNW0
        Qp8Op31aRW3CqhKxvxGO2twwVE8DHxw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-uknB_wOVMNeX_9Y0badVIQ-1; Sun, 29 Jan 2023 04:18:07 -0500
X-MC-Unique: uknB_wOVMNeX_9Y0badVIQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FB983806649;
        Sun, 29 Jan 2023 09:18:07 +0000 (UTC)
Received: from T590 (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8C52026D4B;
        Sun, 29 Jan 2023 09:18:02 +0000 (UTC)
Date:   Sun, 29 Jan 2023 17:17:56 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Zhong Jinghua <zhongjinghua@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH-next v3] blk-mq: cleanup unused methods:
 blk_mq_hw_sysfs_store
Message-ID: <Y9Y5xDuUU28axCs5@T590>
References: <20230128030419.2780298-1-zhongjinghua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128030419.2780298-1-zhongjinghua@huawei.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:04:19AM +0800, Zhong Jinghua wrote:
> We found that the blk_mq_hw_sysfs_store interface has no place to use.
> The object default_hw_ctx_attrs using blk_mq_hw_sysfs_ops only uses
> the show method and does not use the store method.
> 
> Since this patch:
> 4a46f05ebf99 ("blk-mq: move hctx and ctx counters from sysfs to debugfs")
> moved the store method to debugfs, the store method is not used anymore.
> 
> So let me do some tiny work to clean up unused code.
> 
> Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

