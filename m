Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2586247DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiKJRDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiKJRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:03:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7092E9E4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668099748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oLqZ/8EEIHT45ui0RenFRFjR0vVGG5QYmadzBNdtDks=;
        b=CLjvdkiUT8BZZ06m+LsRqjLor6CXUj/TsGvcgGNmvY+2DP14utTKRGQDTaS/Iq25d4P5/k
        fdZzPjN1GkCzr/yUK5MlFYVTfLOe1fNCsLl1Zfo1bb+zCv7QrWr7+TYDG4MYTqSjxXxVmr
        i+GkUIgjPR1sOSjXXC1owrHKHa6K4zw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-b9NSMlpuM7up6uwjgiCsFg-1; Thu, 10 Nov 2022 12:02:25 -0500
X-MC-Unique: b9NSMlpuM7up6uwjgiCsFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AAEF8001B8;
        Thu, 10 Nov 2022 17:02:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB9662024CC6;
        Thu, 10 Nov 2022 17:02:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <166809951250.3381741.3113541135557341907.stgit@warthog.procyon.org.uk>
References: <166809951250.3381741.3113541135557341907.stgit@warthog.procyon.org.uk>
To:     willy@infradead.org
Cc:     dhowells@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Make some folio function arguments const
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3383015.1668099744.1@warthog.procyon.org.uk>
Date:   Thu, 10 Nov 2022 17:02:24 +0000
Message-ID: <3383016.1668099744@warthog.procyon.org.uk>
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

David Howells <dhowells@redhat.com> wrote:

> Mark the folio* argument to some of the folio accessor functions as a const
> pointer.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Actually, disregard this please - it needs some work to make it compile again.

David

