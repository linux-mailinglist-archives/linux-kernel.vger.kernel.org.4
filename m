Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4BA613268
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 10:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiJaJTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 05:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJaJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 05:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FF6D132
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 02:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667207891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aLHvMkuWIJwngK3NBqM0wFdXKT6mSNzSHXzmL6Bj96E=;
        b=jHoythdixBeE7SJnfMzijK3/1HtTsuQDV9H6caMtYtbc51PqpjDMMNSBSGOkflT9KyeuZr
        LcAYVyS6jCOr5tAW2hYwKrnC2Zfjbnm30eW/Bh43rHCS01j3c9kDL7Sx0A9oSg/rD55W/O
        K2WTqEECV5ntYNdBYEXBh0yox70BSFk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-OGUxiIqqPTmXZzuAWZ_2pQ-1; Mon, 31 Oct 2022 05:18:04 -0400
X-MC-Unique: OGUxiIqqPTmXZzuAWZ_2pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33625882828;
        Mon, 31 Oct 2022 09:18:03 +0000 (UTC)
Received: from localhost (ovpn-12-152.pek2.redhat.com [10.72.12.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 600E31121320;
        Mon, 31 Oct 2022 09:18:02 +0000 (UTC)
Date:   Mon, 31 Oct 2022 17:17:58 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        bagasdotme@gmail.com, kexec@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, crash-utility@redhat.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org, yixun.lan@gmail.com
Subject: Re: [PATCH V5 0/2] Support VMCOREINFO export for RISCV64
Message-ID: <Y1+SxuC8qFWQStSe@MiWiFi-R3L-srv>
References: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026144208.373504-1-xianting.tian@linux.alibaba.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 at 10:42pm, Xianting Tian wrote:
> As disscussed in below patch set, the patch of 'describe VMCOREINFO export in Documentation'
> need to update according to Bagas's comments. 
> https://lore.kernel.org/linux-riscv/22AAF52E-8CC8-4D11-99CB-88DE4D113444@kernel.org/
> 
> As others patches in above patch set already applied, so this patch set only contains below two
> patches.
> 
> ------
> Changes:
>    Fix commit message in patch 2: use "Document these RISCV64 exports above" instead of
>    "This patch just add the description of VMCOREINFO export for RISCV64."
> V1 -> V2:
>    Remove unnecessary overline above header text in patch 2.
> V2 -> V3:
>    Fix commit message in patch 1,2; 
>    Use 'space' instead of 'region' for vmemmap description in patch 2.
> V3 -> V4:
>    Remove unnecessary kernel space export:
>    KASAN_SHADOW_START ~ KASAN_SHADOW_END,
>    ADDRESS_SPACE_END
> V4 -> V5:
>    Remove IS_ENABLED() judgement for KERNEL_LINK_ADDR in patch 1.

This series looks good to me, thanks.

Acked-by: Baoquan He <bhe@redhat.com>

