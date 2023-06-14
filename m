Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8492B7307A1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 20:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbjFNSvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFNSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 14:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D32189
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 11:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686768655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=axMrVVQzDHja0OSSs7S0JJ0IUYKrRx1shrn+O4sjLXc=;
        b=daht9AZAGQObfZh726C+GpHJexBbCstPtcD1Tw2Hy7U4mhN0Ga51A+bGyvtlqpoEy3QLB8
        unH7e6qXwXFCe4OOlE5sAL7hYBxQ40CKLUIvBKbRzX+xKXaq5Cl9XWhDzDhjcWoT79GCn4
        WiBOPJv8A7sP+qIMChqdXbVVpZsJjQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-VrVLjB9VOp6jkDGZm7MZhQ-1; Wed, 14 Jun 2023 14:50:06 -0400
X-MC-Unique: VrVLjB9VOp6jkDGZm7MZhQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 375E585A58A;
        Wed, 14 Jun 2023 18:50:05 +0000 (UTC)
Received: from agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (agk-cloud1.hosts.prod.upshift.rdu2.redhat.com [10.0.13.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21299492C1B;
        Wed, 14 Jun 2023 18:50:04 +0000 (UTC)
Received: by agk-cloud1.hosts.prod.upshift.rdu2.redhat.com (Postfix, from userid 3883)
        id 885E74043A65; Wed, 14 Jun 2023 19:48:41 +0100 (BST)
Date:   Wed, 14 Jun 2023 19:48:41 +0100
From:   Alasdair G Kergon <agk@redhat.com>
To:     baomingtong001@208suo.com
Cc:     Alasdair G Kergon <agk@redhat.com>, snitzer <snitzer@kernel.org>,
        dm-devel <dm-devel@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dm: remove unneeded variable
Message-ID: <20230614184841.GB63706@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
Mail-Followup-To: baomingtong001@208suo.com,
        Alasdair G Kergon <agk@redhat.com>, snitzer <snitzer@kernel.org>,
        dm-devel <dm-devel@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <202306141008237478337@208suo.com>
 <20230614024228.GA63706@agk-cloud1.hosts.prod.upshift.rdu2.redhat.com>
 <a78b787e3c45de04df95c80dfc2aa511@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a78b787e3c45de04df95c80dfc2aa511@208suo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 11:12:19AM +0800, baomingtong001@208suo.com wrote:
>    在 2023-06-14 10:42，Alasdair G Kergon 写道：
> >      Did the patched code compile OK for you?

>    Yes!
 
So what is the definition of DMEMIT that your compiler uses and why?

Alasdair

