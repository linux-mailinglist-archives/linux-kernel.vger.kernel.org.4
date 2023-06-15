Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45D87318EB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbjFOMYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbjFOMYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:24:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B7E3A9B
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686831714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYEtR6Ta+AFtEBh75sLC3RO2svtF0qXz9FJ2urYLUrw=;
        b=HUlUQo9CeCw++lxIM5+1B0NyxDkftkpLyDY4N8ug5UY4QNpKKsTH+Vf0339YGnqYslLSLp
        WFOPU0+Dwafxq1T3xP7eT2ZA/ykItGf1vGz8/X9XlQtaWQZ95j0MG3RqHhqhacZYcSwY19
        +P91nHMH2kMT4zsSKmigzlSYlUeE53s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-217-nohnvbOANIuyM_8O6okfxg-1; Thu, 15 Jun 2023 08:21:48 -0400
X-MC-Unique: nohnvbOANIuyM_8O6okfxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB3F6101A58E;
        Thu, 15 Jun 2023 12:21:47 +0000 (UTC)
Received: from localhost (unknown [10.39.192.206])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83CB61131F;
        Thu, 15 Jun 2023 12:21:47 +0000 (UTC)
Date:   Thu, 15 Jun 2023 13:21:46 +0100
From:   "Richard W.M. Jones" <rjones@redhat.com>
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     dev@aaront.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
        zhuyifei1999@gmail.com
Subject: Re: printk.time causes rare kernel boot hangs
Message-ID: <20230615122146.GF10301@redhat.com>
References: <20230614112625.GN7912@redhat.com>
 <20230615110429.2839058-1-zhuyifei@google.com>
 <20230615113108.GN7636@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615113108.GN7636@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Never mind, I've tested the fix here, problem solved!

https://lore.kernel.org/all/87jzypq6gq.ffs@tglx/T/#m860cc015534899c7fcd12dc184c96441027f602b

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

