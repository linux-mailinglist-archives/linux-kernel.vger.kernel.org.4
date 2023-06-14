Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57B72F2A8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239881AbjFNCor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbjFNCom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF21BD4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686710634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o+b6C0pGnulriL9wuvGLa83HoZJEKl0zPaxRa1umUfk=;
        b=KQqeN4g8SPkXUOXG7o21QjIaXueRJtgsgry+SEIKc+JuAi298au9T5PIjv3dRbmYqgFfXU
        yLl8zXM5aFksAsceXBr/TQ4Ffn5BM69c3OX/xLQB7XPdZmDApXLGW+QuAWHv3+uVYW3RF4
        ubgTbgABO3GPv1Q3ociFFI8iAoKOG1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-8CZY8mInPO-aWdWctstLNQ-1; Tue, 13 Jun 2023 22:43:50 -0400
X-MC-Unique: 8CZY8mInPO-aWdWctstLNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3002811E78;
        Wed, 14 Jun 2023 02:43:49 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8C72C1603B;
        Wed, 14 Jun 2023 02:43:49 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id 499054043A65; Wed, 14 Jun 2023 03:42:28 +0100 (BST)
Date:   Wed, 14 Jun 2023 03:42:28 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     baomingtong001@208suo.com
Cc:     agk <agk@redhat.com>, snitzer <snitzer@kernel.org>,
        dm-devel <dm-devel@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm: remove unneeded variable
Message-ID: <20230614024228.GA63706@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: baomingtong001@208suo.com, agk <agk@redhat.com>,
        snitzer <snitzer@kernel.org>, dm-devel <dm-devel@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <202306141008237478337@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202306141008237478337@208suo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:10:33AM +0800, baomingtong001@208suo.com wrote:
> fix the following coccicheck warning:
> drivers/md/dm-snap-persistent.c:909:14-16: Unneeded variable: "sz".
 
> - unsigned int sz = 0;
 
> - return sz;
> + return 0;
 
Did the patched code compile OK for you?

The semantics of the DMEMIT macro are perhaps a tad unexpected.

Alasdair

