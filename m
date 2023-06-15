Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFBC7318F2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbjFOM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbjFOM0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE894683
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686831845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T+Nj/03RKjyOtGJqZYdD9wRMQ6t8HUqaepzwpLqdvCI=;
        b=Ed1bl01aEs1yMR3X1K6owMYvT0N3cRd/52Y5JfY1uVCbuwoItEyXykIHFt9uEUrzFHIpaV
        vlK5DpZfBPtGzwRxtWyTQyOp3oeerIGUX0EsSEgecypC4gO4QW3p3dro9y2JPbRa0SziYE
        ZPi2hLwJBXIlDcJyTJPbkC7OOhJXibM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-E7fop2fNOvutFwHhSjIaLQ-1; Thu, 15 Jun 2023 08:24:01 -0400
X-MC-Unique: E7fop2fNOvutFwHhSjIaLQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77BEF185A792;
        Thu, 15 Jun 2023 12:23:58 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BEBB40C20F4;
        Thu, 15 Jun 2023 12:23:58 +0000 (UTC)
Date:   Thu, 15 Jun 2023 13:23:57 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     dev@aaront.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        zhuyifei1999@gmail.com
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230615122357.GO7912@redhat.com>
References: <20230614112625.GN7912@redhat.com>
 <20230615110429.2839058-1-zhuyifei@google.com>
 <20230615113108.GN7636@redhat.com>
 <20230615122146.GF10301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615122146.GF10301@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 01:21:46PM +0100, Richard W.M. Jones wrote:
> 
> Never mind, I've tested the fix here, problem solved!
> 

I mean:
https://lore.kernel.org/all/bead7acb-ed71-4a14-0094-f8e39323a3b5@grsecurity.net/T/#m3ba5981ed4d5b534fa53589e226d832639584826

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

