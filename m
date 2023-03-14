Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558086B9B45
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjCNQYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCNQXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F425E3C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678810899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SFNS/FHWxqMs+6UMj50orr+Ml0OypRyi1WpXmT75DtA=;
        b=ExxmE5mTAA1hXHdVJTaa0tgH102feaxnoXP+Rn6FOhc2P5sLpH0u6jW7BBWNbYecjDyi9w
        43ikHp3J78xFHWsuicxMCEjgqXskKqk1Zq0gZEbRkHAF4FeZzfEG0a+/j7LII7LiXP7+Hg
        eYb3VNdaaz5obIiSOa+sxcc+cbkVxeM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672--JZqQdF3NZ-3Uwl8PYjrGw-1; Tue, 14 Mar 2023 12:21:36 -0400
X-MC-Unique: -JZqQdF3NZ-3Uwl8PYjrGw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 998F73C218AC;
        Tue, 14 Mar 2023 16:21:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF111C15A0B;
        Tue, 14 Mar 2023 16:21:34 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230221170804.3267242-1-sshedi@vmware.com>
References: <20230221170804.3267242-1-sshedi@vmware.com>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sshedi@vmware.com
Subject: Re: [ PATCH v4 1/6] sign-file: refactor argument parsing logic
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3755242.1678810894.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 16:21:34 +0000
Message-ID: <3755243.1678810894@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shreenidhi Shedi <yesshedi@gmail.com> wrote:

> +		{"privkey", required_argument, 0, 'p'},

Please don't change the flag assignment - you can add new ones, but don't
change the existing.  This program is used by a lot of scripts.

David

