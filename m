Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AEB6C36F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCUQ2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCUQ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:28:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E9435B0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:28:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eh3so61937949edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679416116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRUXMjw1yqtizFMO9hhf0y6intRqN77LQ8iMEXFSQeU=;
        b=IVfOxzk8m1QldR3hACl0mrlKEk/3Mpgb19D3F14wwyGcDk89LmFr8cuGJREN/viaRy
         Z2z1xAeEALG5HOZkNqX9P/arLTn0gqJ7OIjVOkbU24b2SgFm4aY8VZo3cTXPt+EC4ymP
         sWKwg6sLlpkuqpqSos4LLaGG6Ua4IV8O/ip+Qisdjw9xzbW7CsOx5on5C8MoGcFmjKnW
         cDMB8eZxwtUw7dgXVaQEuk4xQiO9A2GOyRWQiaPDKuxkaKBK7mCTWlwj1AoqZYbixqv1
         qCrwijAhes24rXjbU0Z7eDNYMQCm+dqyTxRrzFdlVj1VHV+jlNQpmGftzv4K38C9n0jb
         Y/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679416116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRUXMjw1yqtizFMO9hhf0y6intRqN77LQ8iMEXFSQeU=;
        b=akeHPgjdoQUTKZhIngO4tvBMU/pq8uI5cr/tANDBZFr2huapEonqoe7GHld/lxR3s8
         lzQduPee0yOAc6h1LxhP0j6NgF54RURQpI5xMQkGJuS/7PtNZQhbSaij6/FhxOhLYbRF
         SMPfXrtYfonIdABK5Q0/v6EcVRKnxTF6B5e1/TT71Rf+FcikkWTY7IahpUT9BzW1Mn0g
         urxuPJrZSrjRM9K3LeGuhjc4i6NajvvKYL5gKuCOhsG1/LCio8N5TipJEH5sXM2+o3N+
         7jyhFRVxXT9PdWOBg+oNT0mImMFDqeVCKNZAKYy1MDa4rh0eI6/L8HJ6poJw+cV0xLww
         DGNA==
X-Gm-Message-State: AO0yUKUs/kXGWAT3TZZOOgsIXFklahBwngZhCuxwCZpYI3Bv+gcd3Ntz
        cAKj8uAYe1VP4weblNgla0jrsn1giTwJfK2g
X-Google-Smtp-Source: AK7set9J9hxl4uXIJrgVRbkzC7YMBJZZcmmKgSQPLvjIZ1YSEcv9LYFHdmAhpM3rIq9prmlmfnFaDw==
X-Received: by 2002:a05:6402:38a:b0:4fc:d277:a6d5 with SMTP id o10-20020a056402038a00b004fcd277a6d5mr3838658edv.19.1679416115750;
        Tue, 21 Mar 2023 09:28:35 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id x23-20020a50d617000000b004fa268da13esm6623696edi.56.2023.03.21.09.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:28:35 -0700 (PDT)
Date:   Tue, 21 Mar 2023 21:28:32 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fix line ending with '('
Message-ID: <ZBnbMEJS6q+NWNiT@khadija-virtual-machine>
References: <ZBhNOkQbG4ygNF98@khadija-virtual-machine>
 <ZBnZD5alylOgjhYd@khadija-virtual-machine>
 <ZBnZ+xM0+59Lmvhi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnZ+xM0+59Lmvhi@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 05:23:23PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 21, 2023 at 09:19:27PM +0500, Khadija Kamran wrote:
> 
> <snip>
> 
> > Hey Outreachy Mentors,
> > 
> > Kindly take a look at this patch and let me know if I should wait for
> > the response on this patch or submit another patch.
> 
> Less than 1 day later?
> 
> Please relax and always keep working on new things, don't let my
> response time be the gateway for you doing work, otherwise you are not
> going to get very much done at all.
> 
> You normally have to wait about 2 weeks to get a patch reviewed,
> sometimes I go much faster, sometimes slower.  Either way, it's
> uncertian...
> 
> thanks,
> 
> greg k-h

Okay understood.

Really sorry about this message.

Regards,
Khadija

