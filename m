Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43585BA771
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 09:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIPH1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiIPH1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:27:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A691E1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663313237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Of9F6D0XG0kz29dHaaaRnZmMTmIQ7SApcigqeqNHsck=;
        b=eq1q5yzfohmGurTA8i11/bhzVfvX4eem7BpygXiVfP+GNuunw9+sErLjjstijcpNUfOoL8
        rXsr5pxAkbWeVDN8qtpzfMf1NxM+U2zTvBxR1ki/yxlQf3/A+1eFx96BWkxx0WbZFrkkRZ
        yVgAA4Pqjlm7F1AgPd7urnGbnCNL9DU=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-578-hr4xlMfeN9ikimccRsnUCQ-1; Fri, 16 Sep 2022 03:27:15 -0400
X-MC-Unique: hr4xlMfeN9ikimccRsnUCQ-1
Received: by mail-vk1-f197.google.com with SMTP id h194-20020a1f9ecb000000b003a29cd56380so2883884vke.15
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 00:27:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Of9F6D0XG0kz29dHaaaRnZmMTmIQ7SApcigqeqNHsck=;
        b=kF90crtweqISPjdzSWMGwC6+8+2S8QlbknmDPyCsmEH/w2hVQayIFqYDyAvkcLQwGC
         K8fILp4/yx/XNT+U3Odm8KGEx+2QYejyjV7eBU/6OsAQpEUgEEuOjhSp2JXzG3I8587o
         ow2yu3F+NOrhpnnpM65f9kf67hvUpjZzfKnb98FsjlZabHy3rC2VxFunGY5Z/TViiOIa
         fXaYY1atPO/4i5a0kA3EOizpWlnsUfs26O12F5iB/2zlKAsKWOb2k079aOeFKevH41dJ
         uOHgKpzzatYT29QD0Rtmc10jVApMXPXAzeVpynz//6S/UugWkDoexIAp0ao44QJ/xV6W
         nGzA==
X-Gm-Message-State: ACrzQf2TRKdrTdhfYbusVrbAuVx+z6zCx/EQKcgovo6WZ6pxC6Q70Hyp
        Au0o/nzi8VxLE5GmYaZRHbCxsp5odji4XAKR8f3p6R5S0VqgemApamIVzs5Zkg2H9HMTCCAVvPv
        1tEqzR6xIFF+6g53oxsAP3Mw3KnXanR62Ugx/1AxB
X-Received: by 2002:a67:ec82:0:b0:388:fefa:2467 with SMTP id h2-20020a67ec82000000b00388fefa2467mr1503175vsp.67.1663313235240;
        Fri, 16 Sep 2022 00:27:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5xMrLs26c52lN9gK3YyGVQL3n3xVFjzBpm2yGpQ+A9J0bntdHsO2kin0KVBZ7r4qv5ElrakEPqWpP0T6Y1Md0=
X-Received: by 2002:a67:ec82:0:b0:388:fefa:2467 with SMTP id
 h2-20020a67ec82000000b00388fefa2467mr1503172vsp.67.1663313235031; Fri, 16 Sep
 2022 00:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220912161140.34281-1-mlombard@redhat.com> <YyMe8LvKxc5juCfr@hyeyoo>
In-Reply-To: <YyMe8LvKxc5juCfr@hyeyoo>
From:   Maurizio Lombardi <mlombard@redhat.com>
Date:   Fri, 16 Sep 2022 09:27:04 +0200
Message-ID: <CAFL455kQaTb=6NFUbDdpP051nc2=LwpJxAOFicdAeoFjDXvgMQ@mail.gmail.com>
Subject: Re: [PATCH V2] mm: slub: fix flush_cpu_slab()/__free_slab()
 invocations in task context.
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C4=8Dt 15. 9. 2022 v 14:48 odes=C3=ADlatel Hyeonggon Yoo <42.hyeyoo@gmail.=
com> napsal:
> No objection about this patch,
> but it seems create_workqueue is deprecated?

You're right, the documentation says that create_workqueue() is deprecated,
too bad there is not a comment in the source code.
Thanks for reporting this.

I will wait for the maintainers to review this one and eventually I
will submit a V3.

Maurizio



>
>
> --
> Thanks,
> Hyeonggon
>

