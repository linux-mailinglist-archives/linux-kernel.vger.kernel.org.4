Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA56B6B1106
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjCHSar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCHSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:30:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A3894F54
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678300198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XiaSU/H2qBb8kKJcJ41fFSj3Fx0hsgTrrlqBMpV8vb8=;
        b=hjbgMnnKzuNfrAQqP3Hosnln01SJb+Uj0N3XW24MY5/XNH7EuY+tt8kW2x6DFyNZ4ZaKh7
        FNhzBUpZ7x6b47akG4Vx1pg4pJIWIcWofypOvixDjw5YFm3DsG0k2L3tIQDFTN5pR/5P9b
        x8gu6bTzY3r36YQI2cDTLqaMvNnC5jI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-XTMTl4pkMRGIFdvvUei7ew-1; Wed, 08 Mar 2023 13:29:54 -0500
X-MC-Unique: XTMTl4pkMRGIFdvvUei7ew-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88DA82803611;
        Wed,  8 Mar 2023 18:29:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.15])
        by smtp.corp.redhat.com (Postfix) with SMTP id 79A9F492C3E;
        Wed,  8 Mar 2023 18:29:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  8 Mar 2023 19:29:47 +0100 (CET)
Date:   Wed, 8 Mar 2023 19:29:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     David Vernet <void@manifault.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, kernel-team@meta.com,
        torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tasks: Extract rcu_users out of union
Message-ID: <20230308182907.GA16406@redhat.com>
References: <20230215233033.889644-1-void@manifault.com>
 <20230216080459.GA5200@redhat.com>
 <Y+54c0YvXcMIFva4@maniforge>
 <20230217102521.GA27682@redhat.com>
 <Y/zWPoCjQ6gLSNGU@maniforge>
 <20230307171913.GA4387@maniforge>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307171913.GA4387@maniforge>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07, David Vernet wrote:
>
> Sending a friendly ping on this now that the merge window has closed and
> things have settled down a bit.

Well, I can't help to merge this change, I lost my account on
kernel.org years ago.

Perhaps you need to resend this patch? FWIW, feel free to add

Acked-by: Oleg Nesterov <oleg@redhat.com>

