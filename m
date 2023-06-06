Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9200F7246B9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbjFFOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238398AbjFFOrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:47:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412BE1715
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686062703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G80vYWB54fkROwB0ny7r616IevO9M7q/EEaVoIUzKyE=;
        b=WHUU3BBkxiBaUejUfkjdvqr9Y8bThkBWLa2YD7hV0G5wdkpDj5njOUmBd7O57LWKQ8wvys
        ZSlYLmIpnq75OmSDKM9rTlCQNoF4e/0T/a59sW7QfdH7HxiyaFQjv9nkaAc1dEdysIcwmp
        Cfe3S3tM14RE0yLFD93cbd6YTXDVHdA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-vykLroegM2O2u-3cuqWF8g-1; Tue, 06 Jun 2023 10:44:57 -0400
X-MC-Unique: vykLroegM2O2u-3cuqWF8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30FE78028B2;
        Tue,  6 Jun 2023 14:44:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26F837AE4;
        Tue,  6 Jun 2023 14:44:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CT5KNU3BZ71L.2S88IEDDT5AD9@suppilovahvero>
References: <CT5KNU3BZ71L.2S88IEDDT5AD9@suppilovahvero> <20230601190508.56610-1-franziska.naepelt@gmail.com> <20230602085902.59006-1-franziska.naepelt@gmail.com>
To:     "Jarkko Sakkinen" <jarkko@kernel.org>
Cc:     dhowells@redhat.com,
        "Franziska Naepelt" <franziska.naepelt@googlemail.com>,
        keyrings@vger.kernel.org, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org,
        "Franziska Naepelt" <franziska.naepelt@gmail.com>,
        "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH v2] certs/extract-cert: Fix checkpatch issues
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1977837.1686062695.1@warthog.procyon.org.uk>
Date:   Tue, 06 Jun 2023 15:44:55 +0100
Message-ID: <1977838.1686062695@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> wrote:

> Fixes tag?

That's not really necessary in this case.  It's not fixing any bugs so much as
keeping checkpatch happy, so there's not much point backporting the patches.

> IMHO should be split to separate commits with fixes tags for
> trackability sake.

I think a single patch is fine for what it's doing.  Let's not add a bunch of
individual one-liner keeping-checkpatch-happy patches.

David

