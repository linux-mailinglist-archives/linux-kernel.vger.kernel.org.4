Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6BB663763
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 03:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjAJCdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 21:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAJCdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 21:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846551839D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 18:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673317976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l94HaeBEBiFD5ilSjwcw6DDx5RLDQlnkVXrKy/YYH8k=;
        b=DsuSJQUlMksNHCDxPzgG9WcaVn98J4OjZnjdxnVi5vL7wjGY4y6zw/opXet0BPmrhJDjUt
        Ko5ffxbHQy41enavTK66fvbSDGBZyze4/qGs6Tt7p3tHx4KcgqUSDEv2WolP7dx6HOuUD+
        cKqk82JMxcSzXfilITJaGjJEO/z9XpE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-tXc1h2RJOnCvWpTl6LAxOg-1; Mon, 09 Jan 2023 21:32:55 -0500
X-MC-Unique: tXc1h2RJOnCvWpTl6LAxOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A42F33804062;
        Tue, 10 Jan 2023 02:32:54 +0000 (UTC)
Received: from localhost (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CBCFF2166B26;
        Tue, 10 Jan 2023 02:32:53 +0000 (UTC)
Date:   Tue, 10 Jan 2023 10:32:49 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>, akpm@linux-foundation.org
Cc:     Philipp Rudo <prudo@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Petr Tesarik <petr@tesarici.cz>, kexec@lists.infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@kernel.org>
Subject: Re: [PATCH v6 0/3] kexec: Add new parameter to limit the access to
 kexec
Message-ID: <Y7zOUdQdbV+c+6P2@fedora>
References: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114-disable-kexec-reset-v6-0-6a8531a09b9a@chromium.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/23 at 03:38pm, Ricardo Ribalda wrote:
> Add two parameter to specify how many times a kexec kernel can be loaded.
> 
> These parameter allow hardening the system.
> 
> While we are at it, fix a documentation issue and refactor some code.

The whole series looks good to me, thx.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> To: Jonathan Corbet <corbet@lwn.net>
> To: Eric Biederman <ebiederm@xmission.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kexec@lists.infradead.org
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ross Zwisler <zwisler@kernel.org>
> To: Philipp Rudo <prudo@redhat.com>
> To: Guilherme G. Piccoli <gpiccoli@igalia.com>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Petr Tesarik <petr@tesarici.cz>
> Cc: Baoquan He <bhe@redhat.com>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> 
> ---
> Changes in v6:
> - Fix kexec type on kexec_file
> - Match the length of the table borders to the sections underline (Thanks Bagas!)
> - Fix typo on kexec_load_limit_reboot (Thanks Petr!)
> - Improve commit message (Thanks Baoquan!)
> - Link to v5: https://lore.kernel.org/r/20221114-disable-kexec-reset-v5-0-1bd37caf3c75@chromium.org
> 
> Changes in v5:
> - Remove maxlen from ctl_table. Thanks Steven!
> - Link to v4: https://lore.kernel.org/r/20221114-disable-kexec-reset-v4-0-ab809c8d988c@chromium.org
> 
> Changes in v4 (Thanks Steven!):
> - Uses sysctl instead or module_parameters
> - Pass image type instead of boolean to permitted
> - Fix typo on flag handling
> - Return -EINVAL for values that does not change the current value.
> - Link to v3: https://lore.kernel.org/r/20221114-disable-kexec-reset-v3-0-4ef4e929adf6@chromium.org
> 
> Changes in v3:
> - s/paramter/parameter/ Thanks Ghilherme!
> - s/permited/permitted/ Thanks Joel!
> - Link to v2: https://lore.kernel.org/r/20221114-disable-kexec-reset-v2-0-c498313c1bb5@chromium.org
> 
> Changes in v2:
> - Instead of kexec_reboot_disabled, add two new counters (Thanks Philipp!)
> - Link to v1: https://lore.kernel.org/r/20221114-disable-kexec-reset-v1-0-fb51d20cf871@chromium.org
> 
> ---
> Ricardo Ribalda (3):
>       Documentation: sysctl: Correct kexec_load_disabled
>       kexec: Factor out kexec_load_permitted
>       kexec: Introduce sysctl parameters kexec_load_limit_*
> 
>  Documentation/admin-guide/sysctl/kernel.rst | 25 +++++++-
>  include/linux/kexec.h                       |  3 +-
>  kernel/kexec.c                              |  4 +-
>  kernel/kexec_core.c                         | 94 ++++++++++++++++++++++++++++-
>  kernel/kexec_file.c                         | 11 ++--
>  5 files changed, 127 insertions(+), 10 deletions(-)
> ---
> base-commit: 479174d402bcf60789106eedc4def3957c060bad
> change-id: 20221114-disable-kexec-reset-19b7e117338f
> 
> Best regards,
> -- 
> Ricardo Ribalda <ribalda@chromium.org>
> 

