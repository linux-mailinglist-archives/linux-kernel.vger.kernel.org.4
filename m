Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC76A8FA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCCDFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCCDFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:05:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C774E7
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677812702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HEC+EQ2fcEJpPVWrVXT2FWHbUmj+Ri2fHzAWmmTFFEQ=;
        b=G6ggth8C1HB+mdRwwiij7/tCafXCRuG2i2+9eZDYOXhWm2WlgGM8zB6az25dROwud/Vjto
        6Z2V41Nag1G+cBkJMjQPrcIomL4MbfKVWP4RbdAgXTewd08fVhVyPXPX3Ne2GdLzNLtt/4
        2mR4Q6IDSsyYejwGiCAvj964g7Ax87k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-403-3YiycohuNJSCqW18LIoOVg-1; Thu, 02 Mar 2023 22:04:59 -0500
X-MC-Unique: 3YiycohuNJSCqW18LIoOVg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C55641869B6D;
        Fri,  3 Mar 2023 03:04:58 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7A5E492C14;
        Fri,  3 Mar 2023 03:04:58 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id 7C173C042A; Thu,  2 Mar 2023 22:04:58 -0500 (EST)
Date:   Thu, 2 Mar 2023 22:04:58 -0500
From:   Aristeu Rozanski <aris@redhat.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Error reports at boot time in Ampere Altra machines since
 c733ebb7c
Message-ID: <20230303030458.czktr3vscumyqevw@redhat.com>
References: <20230302201732.pwnhg46mum6st2bv@redhat.com>
 <865ybizqfi.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865ybizqfi.wl-maz@kernel.org>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 11:25:37PM +0000, Marc Zyngier wrote:
> It says "Hardware Error". In my book, that's pretty bad. Do you see
> this on more than a single machine?

At least two of these machines in our lab. While looking up
e8ed898d-df16-43cc-8ecc-54f060ef157f I found another report but this one
with a lot more of the same errors:

https://github.com/nodejs/build/issues/2894#issuecomment-1129229236

-- 
Aristeu

