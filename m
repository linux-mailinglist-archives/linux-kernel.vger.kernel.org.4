Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF41169F791
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjBVPUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbjBVPUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195AE2C655
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677079160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=isqIy/bXUb3OOqTfDyrkAO0a/woxtyDYAXPuRMpTHPI=;
        b=RpTIu5SiXmIdm2OPfBrgSv/IPBaieOgWhxi13dhVkzNopXav8v9geXer5vaMUYnavlHM3k
        2ba8Q35G6uUOozZoBaaow3yB5CC2LLNglgbZsOx88+3HBsNIpvxeWz5gKdxLvLz32vI4ct
        sJCnCLBAXfP+N3k/Yn0q/ht158dMPE0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49--8WR4ZVTPZun_hccVb_prQ-1; Wed, 22 Feb 2023 10:19:16 -0500
X-MC-Unique: -8WR4ZVTPZun_hccVb_prQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D2DDB101A52E;
        Wed, 22 Feb 2023 15:19:15 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.75])
        by smtp.corp.redhat.com (Postfix) with SMTP id CCCE52026D4B;
        Wed, 22 Feb 2023 15:19:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 22 Feb 2023 16:19:10 +0100 (CET)
Date:   Wed, 22 Feb 2023 16:19:09 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v5] posix-timers: Prefer delivery of signals to the
 current thread
Message-ID: <20230222151908.GA20057@redhat.com>
References: <20230126154118.2393850-1-dvyukov@google.com>
 <20230220144347.267585-1-dvyukov@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220144347.267585-1-dvyukov@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20, Dmitry Vyukov wrote:
>
>  kernel/signal.c                               | 23 +++++-
>  tools/testing/selftests/timers/posix_timers.c | 73 +++++++++++++++++++
>  2 files changed, 93 insertions(+), 3 deletions(-)

For the change in kernel/signal.c

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

