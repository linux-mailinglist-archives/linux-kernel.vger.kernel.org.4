Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8355FE8BF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 08:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbiJNGPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 02:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJNGPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 02:15:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7696D180279
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 23:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665728144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5OvGf4hXubBI7CFS1x0hSqfuSG/M0J2H+cdEuLNTaNI=;
        b=CkAqvaIn7ORtovVup83uiritgUQcUq30ZJxjWgCN86nGT881Iu+wLeJIvpWHLp/kBNreVf
        dX2nM6r/6vx695LLvurFcIO2SVOAEG5oR1wCaJ0IIAgNPI7hb19JrjuQAF4Hmsx1GDfS/Y
        L/cDAvTchXqr35PmzwzOry+CFcGArG4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-6Cq_2fvaOxeCW_pvg53lMQ-1; Fri, 14 Oct 2022 02:15:40 -0400
X-MC-Unique: 6Cq_2fvaOxeCW_pvg53lMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0770E101E9B2;
        Fri, 14 Oct 2022 06:15:40 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D7A2E4C36D8;
        Fri, 14 Oct 2022 06:15:38 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
        <Y0gLyLbdOCetX5LN@sirena.org.uk> <Y0gteD0QYVlYxSZh@zx2c4.com>
        <Y0g8HEYHZYHGdwlf@sirena.org.uk> <Y0g+wTTJmlaFVLzr@zx2c4.com>
        <Y0hH5NelZ03yfQuU@sirena.org.uk>
        <87o7ufwovp.fsf@oldenburg.str.redhat.com>
        <Y0hz3u8ZNO2yFU2f@sirena.org.uk>
Date:   Fri, 14 Oct 2022 08:15:36 +0200
In-Reply-To: <Y0hz3u8ZNO2yFU2f@sirena.org.uk> (Mark Brown's message of "Thu,
        13 Oct 2022 21:23:58 +0100")
Message-ID: <87o7uforqv.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown:

>> The enterprise distributions have toolchain modules or toolsets that you
>> can install, all nicely integrated.  You'd probably consider those
>> versions too new. 8-/   I expect it's mostly an education issue, raising
>> awareness of what's available from vendors.   (glibc versions are a
>> different matter, but I don't think dropping support for historic
>> versions on build hosts is on the table, so that should be relevant.)
>
> Yeah, I found the ones for SLES easily enough but not the ones for RHEL
> or Ubuntu.  Perfectly prepared to believe they're there though, it does
> seem like sometihng users might want.

For what it's worth, it's devtoolset-11-gcc or gcc-toolset-11-gcc,
depending on the OS version.  The =E2=80=9C11=E2=80=9D is the GCC version, =
new versions
become available in the fall, about half a year after the upstream
release.  Old versions remain installable (even in parallel), but drop
out of official support fairly quickly (at least compared to our usual
support timelines).

Thanks,
Florian

