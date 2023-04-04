Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB36D61BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbjDDM6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbjDDM62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:58:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00915D8
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680613060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+3Mz6sXDjvHd9OJUM6QYLit5VPzzJNt9TrWpGfLNl88=;
        b=e9gFFRcLESEvbEX3bVh8QT/W4oR18IZ244hYdebM1m4cc5JJFoME9Y05fWN8WxWc2CdkEy
        XvBPY6SfmE/EvzlET8pEDULS9QKKqJm27Ogb0kboT+qNduJmEwjqRL4m8h/hBK+HkaQvpe
        WAj5lAvxMzZOsaWF0/Hxf67zKU50lvs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-bpOvHZMTPu-SYEiJeevy7g-1; Tue, 04 Apr 2023 08:57:34 -0400
X-MC-Unique: bpOvHZMTPu-SYEiJeevy7g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6353A811E7C;
        Tue,  4 Apr 2023 12:57:34 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54E6A492C13;
        Tue,  4 Apr 2023 12:57:34 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 18051C04BC; Tue,  4 Apr 2023 08:57:34 -0400 (EDT)
Date:   Tue, 4 Apr 2023 08:57:34 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        "D. Scott Phillips" <scott@os.amperecomputing.com>
Subject: Re: Error reports at boot time in Ampere Altra machines since
 c733ebb7c
Message-ID: <20230404125734.rrub6r3lq6dmuhmu@redhat.com>
References: <20230302201732.pwnhg46mum6st2bv@redhat.com>
 <865ybizqfi.wl-maz@kernel.org>
 <ZAJMwLMNizPMPzS3@fedora>
 <87mt4th9zq.wl-maz@kernel.org>
 <ZAJXQUY2nSiGMCX8@fedora>
 <20230403162620.26t37wpmyohnuzoo@redhat.com>
 <ZCtmMie5skEIc0Tt@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCtmMie5skEIc0Tt@fedora>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darren,

On Mon, Apr 03, 2023 at 04:50:10PM -0700, Darren Hart wrote:
> Thanks for the patience. Yes. These error messages are benign as the error is
> managed by hardware and has no adverse effects to software other than the severe
> looking messages. A firmware fix will address the issue so the messages are no
> longer printed.

thanks!

-- 
Aristeu

