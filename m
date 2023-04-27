Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CA16F0815
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243972AbjD0PSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 11:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243404AbjD0PSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 11:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872844233
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682608644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r+17+KTOOVGjge09dstY847TPVDvwXA1kCLuEc8Dqts=;
        b=cXih+nWhFH/I25Qf0Q6qdx6ROs7pL1zH/o3ut89wWZRoJb7+z8l7RHU2nvjql/6b7cSO3Z
        ZqUDb8vgsV7M5455V6AdpJL9LffZSnKaFRZLHfKA9hCUDyon3W7mamcqS8Bn5pp7Bl2lkH
        k/uHFE6FjNu4xMZn28dYNeS0SkTtqTY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-74-eDukie4rOsKb8xEVznIMOQ-1; Thu, 27 Apr 2023 11:17:16 -0400
X-MC-Unique: eDukie4rOsKb8xEVznIMOQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EE551C3A074;
        Thu, 27 Apr 2023 15:17:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 52231492C3E;
        Thu, 27 Apr 2023 15:17:03 +0000 (UTC)
Date:   Thu, 27 Apr 2023 10:17:01 -0500
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] nbd: s/handle/cookie/
Message-ID: <7xvuavcyhqfygrp3ak3iw5jiatbp3fcrhx6teeyqcrrjhdtjn4@ordpaqvft67k>
References: <20230410180611.1051618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410180611.1051618-1-eblake@redhat.com>
User-Agent: NeoMutt/20230407
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

On Mon, Apr 10, 2023 at 01:06:07PM -0500, Eric Blake wrote:
> v2 was here: https://lkml.org/lkml/2023/3/17/1107
> since then:
> - squash patch 2/5 and 3/5 into 3/4 [Ming]
> - add Josef's R-b
> - tweak commit messages to match commits in userspace NBD (code itself
>   is unchanged, modulo the patch squash)
> 
> Eric Blake (4):
>   uapi nbd: improve doc links to userspace spec
>   uapi nbd: add cookie alias to handle
>   block nbd: use req.cookie instead of req.handle
>   docs nbd: userspace NBD now favors github over sourceforge
> 
>  Documentation/admin-guide/blockdev/nbd.rst |  2 +-
>  drivers/block/nbd.c                        |  6 +++---
>  include/uapi/linux/nbd.h                   | 25 +++++++++++++++++-----
>  3 files changed, 24 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d
> -- 
> 2.39.2
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org

