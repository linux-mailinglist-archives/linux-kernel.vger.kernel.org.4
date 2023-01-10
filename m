Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A5666374B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237873AbjAJCZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbjAJCZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653513E34
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 18:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673317487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odciY+9+EikNajE585hIA5zUDol7M/v4VgDdpw0aLYY=;
        b=HVSSokT6hc5dGk+Q8ZOFuThkHGtZr+8Jgt31PDdATUG6CNI78ekzXh1BppySQE37RrL52Y
        gEjVy8u5Dhz9RIqLOxssFNjMGl08YDZaw2S6cC9Kp9zvntK4EjjXjGVt5KYSWaVpmUWsCD
        7VxmkQ3HS0v7BOoy2dSGBRSNb0WIH2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-RNpvsEVsPr-9Y50zhF9Krg-1; Mon, 09 Jan 2023 21:24:44 -0500
X-MC-Unique: RNpvsEVsPr-9Y50zhF9Krg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AEE2811E9C;
        Tue, 10 Jan 2023 02:24:43 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0C1A175AD;
        Tue, 10 Jan 2023 02:24:42 +0000 (UTC)
Date:   Tue, 10 Jan 2023 10:24:39 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH] Revert "x86/apic/x2apic: Implement IPI shorthands
 support"
Message-ID: <Y7zMZ8nCNtSt09kV@fedora>
References: <Y6FJgh3fOYoF0wSV@MiWiFi-R3L-srv>
 <87k01vjrnt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k01vjrnt.ffs@tglx>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/23 at 10:59pm, Thomas Gleixner wrote:
> On Tue, Dec 20 2022 at 13:34, Baoquan He wrote:
> > This reverts commit 43931d350f30c6cd8c2f498d54ef7d65750abc92.
> >
> > On kvm guest with 4 cpus deployed, when adding 'nr_cpus=2' to normal
> > kernel's cmdline, and triggering crash to jump to kdump kernel, kdump
> > kernel will stably hang. Reverting commit 43931d350f30 ("x86/apic/x2apic:
> > Implement IPI shorthands support") can fix it.
> 
> Is there any output on the early console or hangs it silently?
> 
> If the latter, can you attach GDB to the guest and figure out where it
> is stuck?

No any output on the ealry console. I will try gdb debugging. Thanks.

