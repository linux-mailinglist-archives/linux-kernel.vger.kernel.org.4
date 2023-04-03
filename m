Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB046D4DA9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjDCQ1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjDCQ1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6EA212A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680539184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u5Wl/rAGr3UB8Azut2HzGqWLEE5zD9Z8IIRpmvpKtAM=;
        b=D6lK6I8rnyGeId/K/maMFRPsKIBrkbz7XNeVuQ/ydZK5u4Icngzo+gwdFgiyfV9R9F60zS
        ZugTj97brXb/t+VBhZve/MP91FlstfLDpFntCyxvr0rTBs6viPmLoVNvZdANpn5K14VkEO
        zu3cEedUqF2UgT/jMLYYPfT88GM6qSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-tEkfvgnIPfCSmR1t8OPiJA-1; Mon, 03 Apr 2023 12:26:21 -0400
X-MC-Unique: tEkfvgnIPfCSmR1t8OPiJA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AE2C85A588;
        Mon,  3 Apr 2023 16:26:21 +0000 (UTC)
Received: from napanee.usersys.redhat.com (unknown [10.2.16.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 36A33400F4F;
        Mon,  3 Apr 2023 16:26:21 +0000 (UTC)
Received: by napanee.usersys.redhat.com (Postfix, from userid 1000)
        id E8286C04FC; Mon,  3 Apr 2023 12:26:20 -0400 (EDT)
Date:   Mon, 3 Apr 2023 12:26:20 -0400
From:   Aristeu Rozanski <aris@redhat.com>
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        "D. Scott Phillips" <scott@os.amperecomputing.com>
Subject: Re: Error reports at boot time in Ampere Altra machines since
 c733ebb7c
Message-ID: <20230403162620.26t37wpmyohnuzoo@redhat.com>
References: <20230302201732.pwnhg46mum6st2bv@redhat.com>
 <865ybizqfi.wl-maz@kernel.org>
 <ZAJMwLMNizPMPzS3@fedora>
 <87mt4th9zq.wl-maz@kernel.org>
 <ZAJXQUY2nSiGMCX8@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAJXQUY2nSiGMCX8@fedora>
User-Agent: NeoMutt/20220429
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

On Fri, Mar 03, 2023 at 12:23:29PM -0800, Darren Hart wrote:
> Thanks for the detail Marc, let me see what I can learn and will follow up.

any updates on this?

Thanks

-- 
Aristeu

