Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1EE724081
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 13:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbjFFLJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 07:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbjFFLIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 07:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895041715
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 04:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686049605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O9d5bP1gQuJXoEA6pUWt9ORuENs1rGV35zFDv1yXe84=;
        b=ForNn+qq2tqGr2a6+9nSt5fIYxwwpNkueshTPv/yCN+K0zt4lICevJzIl+ewHV0Tj1EYA/
        1poUk3PkyJnOmHUUkX05JWAhAjGsL6z9yc2yciMlHYKvxKabiSsahpgJhL9tkaPPDXHZYe
        fwb94+MbOLvmeqbJX+HcZzDfi69GntM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-yCGlh9owPYug3WKAQVddAw-1; Tue, 06 Jun 2023 07:06:44 -0400
X-MC-Unique: yCGlh9owPYug3WKAQVddAw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1F8385A5BB;
        Tue,  6 Jun 2023 11:06:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.222])
        by smtp.corp.redhat.com (Postfix) with SMTP id 850517AE4;
        Tue,  6 Jun 2023 11:06:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  6 Jun 2023 13:06:21 +0200 (CEST)
Date:   Tue, 6 Jun 2023 13:06:19 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH REPOST 1/2] signal: Add proper comment about the
 preempt-disable in ptrace_stop().
Message-ID: <20230606110618.GB7542@redhat.com>
References: <20230606085524.2049961-1-bigeasy@linutronix.de>
 <20230606085524.2049961-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606085524.2049961-2-bigeasy@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On 06/06, Sebastian Andrzej Siewior wrote:
>
> Commit 53da1d9456fe7 ("fix ptrace slowness") added a preempt-disable section
> between read_unlock() and the following schedule() invocation without
> explaining why it is needed.
>
> Replace the comment with an explanation why this is needed. Clarify that
> it is needed for correctness but for performance reasons.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Oleg Nesterov <oleg@redhat.com>

