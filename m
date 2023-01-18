Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90CD671C40
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjARMhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjARMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:35:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A88530D5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 03:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674043148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uwKNfVTLw4/VaiMr9TrdXa/SE+IC/gk6fvOEWlw5BJ0=;
        b=GtXUVCljpSiZWhlAycnfI6Ku9bDrpPfInWxWt99+NqDQRoCcCsyVf0IwVut6FhfOETUMVh
        vCmVwyjPgaA6Lh5T2jG1tZhWlnFHKn7GtcDnnrpOYE5l6x05tdsva2oES2TiOoc8HBFTZE
        Jb74nqmRzwMm2ZIMWrzlRx2+7u84T9w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-PI_GPxPsN12c-ZuC-KiyiQ-1; Wed, 18 Jan 2023 06:59:04 -0500
X-MC-Unique: PI_GPxPsN12c-ZuC-KiyiQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74182183B3CC;
        Wed, 18 Jan 2023 11:59:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 280C3492B00;
        Wed, 18 Jan 2023 11:59:04 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 30IBx3kC020549;
        Wed, 18 Jan 2023 06:59:03 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 30IBx2Lm020530;
        Wed, 18 Jan 2023 06:59:02 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 18 Jan 2023 06:59:02 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        lvc-patches@linuxtesting.org, linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] [PATCH] md: dm-ioctl: drop always-false condition
In-Reply-To: <c8c9df45-1d59-3195-7631-51b3a58148ee@omp.ru>
Message-ID: <alpine.LRH.2.21.2301180658250.13031@file01.intranet.prod.int.rdu2.redhat.com>
References: <c8c9df45-1d59-3195-7631-51b3a58148ee@omp.ru>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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



On Tue, 17 Jan 2023, Sergey Shtylyov wrote:

> The expression 'indata[3] > ULONG_MAX' always evaluates to false since
> indata[] is declared as an array of *unsigned long* elements and #define
> ULONG_MAX represents the max value of that exact type...
> 
> Note that gcc seems to be able to detect the dead code here and eliminate
> this check anyway...
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE static
> analysis tool.
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>

> ---
> This patch is atop of the 'for-next' branch of the device-mapper repo...
> 
>  drivers/md/dm-ioctl.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Index: linux-dm/drivers/md/dm-ioctl.c
> ===================================================================
> --- linux-dm.orig/drivers/md/dm-ioctl.c
> +++ linux-dm/drivers/md/dm-ioctl.c
> @@ -1073,8 +1073,7 @@ static int dev_set_geometry(struct file
>  		goto out;
>  	}
>  
> -	if (indata[0] > 65535 || indata[1] > 255 ||
> -	    indata[2] > 255 || indata[3] > ULONG_MAX) {
> +	if (indata[0] > 65535 || indata[1] > 255 || indata[2] > 255) {
>  		DMERR("Geometry exceeds range limits.");
>  		goto out;
>  	}
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
> 

