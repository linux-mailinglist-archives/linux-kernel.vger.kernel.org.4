Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E68A6E4A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDQNqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjDQNq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58E710E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681739142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQIbr1IdRvX8ZwbP47xI9cpUC59Ke3qChHXmW4g760E=;
        b=OML4J20bV5gh2emyeOBPWTTH2QZS8iLp+HOt4ifnDnuUIfY9Ev6PqFRHMrFgT8+BFO3KvJ
        LKjqzsL29/nh1mITx5RoQ5xBeQS1tbR3e2WwsIXDWtgVX0k0fAHWQfyfxNu8h2kuOCkXUl
        L37rMLdayFpsW+SJOVLUBfPJuoImg/M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-W7l8ec26OjKUm6Br76yOCQ-1; Mon, 17 Apr 2023 09:45:41 -0400
X-MC-Unique: W7l8ec26OjKUm6Br76yOCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB3D538173C0;
        Mon, 17 Apr 2023 13:45:40 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 812C2C158BB;
        Mon, 17 Apr 2023 13:45:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <e8bc6158-86b2-18e5-efea-c165e2a3f196@kernel.dk>
References: <e8bc6158-86b2-18e5-efea-c165e2a3f196@kernel.dk> <20230413182542.1133335-1-broonie@kernel.org> <0c6b661c-f7ff-cf12-b7f0-00b6b2f1317b@amd.com> <3c4b9025-2667-ca8c-7427-502068b8168e@amd.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Ayush Jain <ayush.jain3@amd.com>,
        broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Santosh.Shukla@amd.com, Kalpana.Shetty@amd.com,
        Narasimhan V <Narasimhan.V@amd.com>, sfr@canb.auug.org.au
Subject: Re: linux-next: Tree for Apr 13
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1551343.1681739138.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 17 Apr 2023 14:45:38 +0100
Message-ID: <1551344.1681739138@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem might be summed up by the following snippet:

	openat(AT_FDCWD, "/dev/loop0", O_RDONLY) =3D 3
	newfstatat(3, "", {st_mode=3DS_IFBLK|0660, st_rdev=3Dmakedev(0x7, 0), ...=
}, AT_EMPTY_PATH) =3D 0
	splice(3, NULL, 1, NULL, 1048576, 0)    =3D 0

David

