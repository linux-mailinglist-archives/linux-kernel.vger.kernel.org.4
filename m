Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273387316B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343879AbjFOLcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343847AbjFOLb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:31:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE72695
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686828672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/XZCNt/QvdEXWrMsWxLzKd1tiPDtWpqCSu6u7Jtfw0=;
        b=VKNOt+pm+R5gS8sg+hnWbP9NgMOW/CbnjY1AIYUTbnsOETmwxwjsmWLZZcKfVnyeg2uy6u
        0SyCb4r2jWxTzT4QvxyvpcOrvyPfqfC/3ZHtZ0wQNg9GQex28Zl53G9KeoOh8vaErbqS+3
        V7F7STqW6JRlcUGgOEjNQLqTOhYdxOg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-120-mw6PUxiEPKCWYbYzKeOZpw-1; Thu, 15 Jun 2023 07:31:09 -0400
X-MC-Unique: mw6PUxiEPKCWYbYzKeOZpw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E0453C01C1B;
        Thu, 15 Jun 2023 11:31:09 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6F71492C1B;
        Thu, 15 Jun 2023 11:31:08 +0000 (UTC)
Date:   Thu, 15 Jun 2023 12:31:08 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     dev@aaront.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        zhuyifei1999@gmail.com
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230615113108.GN7636@redhat.com>
References: <20230614112625.GN7912@redhat.com>
 <20230615110429.2839058-1-zhuyifei@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615110429.2839058-1-zhuyifei@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:04:29AM +0000, YiFei Zhu wrote:
> see if you can send a alt-sysrq-w to show stacks of
> blocked tasks.

I guess this is a virtual console thing?  I have to boot this hundreds
of times with a serial console to even get to the bug, so it's tricky.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html

