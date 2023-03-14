Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9106B9AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjCNQRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCNQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:17:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB64797FEF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678810551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LCofmY0Z2TSSkGRruGgKaZa32+IfX9KwJ1GZHQ8a3S4=;
        b=CQpnq/OuAuTb0YduLkxFo5j+zo8G+KSvehGikskhRPLk1TGwqqhpEYEv4VR7sUVxyXAaag
        SwNPVQJClSAEarIXwkn3F3zaHCcl67sYRZQ0laMHN3mvNC2nXjfmmS4F0jClnqtty+FZ0T
        g09NEubwlsU7MTm9B6qNtK0VhlVuyZI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-Dw4nOFehM76KDI_Cz718tQ-1; Tue, 14 Mar 2023 12:15:49 -0400
X-MC-Unique: Dw4nOFehM76KDI_Cz718tQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50F983C10EE6;
        Tue, 14 Mar 2023 16:15:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95B1D1121315;
        Tue, 14 Mar 2023 16:15:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230221170804.3267242-5-sshedi@vmware.com>
References: <20230221170804.3267242-5-sshedi@vmware.com> <20230221170804.3267242-1-sshedi@vmware.com>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        sshedi@vmware.com
Subject: Re: [ PATCH v4 5/6] sign-file: use const with a global string constant
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3754998.1678810546.1@warthog.procyon.org.uk>
Date:   Tue, 14 Mar 2023 16:15:46 +0000
Message-ID: <3754999.1678810546@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

> From: Shreenidhi Shedi <yesshedi@gmail.com>
> 
> Fix a space issue (cosmetic)
> Both reported by checkpatch.
> 
> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>

The commit message is at odds with the subject.  These should be separate
patches.

David

