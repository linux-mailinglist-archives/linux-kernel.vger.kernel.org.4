Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E046BD8B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCPTQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjCPTQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:16:34 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312C872020
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:16:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cy23so11651227edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678994191;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/wDWtFCM7WcRQcdZ/hsAREK7bWOLl6e/ZYZcmTu9kY=;
        b=IbhDwe/+Pk8t2zx5e2xUger4Co7HNiCBwQ9eWAA5Oi/QXGYGiXKsNYIKwGmP+Jkpa/
         7YQhL7J2euxNH84t9Xlcf3r8eTQaLsftCDfBA5RRjSaznLEqUPE+lJJ+OKh0FEhgTlMc
         vcP9Loh7OeWURRHkvP4nSqhbAIMFnUa0zCVeSHUr/uxvm7n95MbYpVEjiOWp0QSPj2g0
         621zIesyuaeEEbqiJ+NAuGzO4cxUOi/vfTMgUTZhA5/lplZrQfOHTjry3mMETd3lUFyi
         jO20RHub+IYMCoL+bM/htpur1qK22YCP3GTJ/OID7TMsomM8XiD+Lm/KP1ouSIqdQ46N
         m7/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678994191;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/wDWtFCM7WcRQcdZ/hsAREK7bWOLl6e/ZYZcmTu9kY=;
        b=yn/M7W9Gz+AV5uzFen1kETRoNvqzQUVSAOWWyoq8S6fDobJx6a2EGyusM6P2b73xTk
         hT2JG5PGE+5KcAQQymyKhMEcyYSTRdXu0FHl3pUJW5udwmV7CTpKuX1asvrtTPXqBjQ5
         fLfotZ9b0/ItOQItfLCRbiS8hoC0Qv2+uPDyPr8ds20Sg2gg2SD3fp2CHmO5VFx0R6jK
         Co4ZjYpW9so3v3KocMd6bXSQq2UuO4JvSdtJ/nezAUvKMs2LCTVZv494m0T0I1UsUwJk
         m2j0VBTZhlnc22vKrVqg2L/H2VHQIOzkf6sBVWfkUjMyDxLicHrPpzKryectDW3abq4i
         MDow==
X-Gm-Message-State: AO0yUKWY3FHsYgxcreDDes2qWDU4y+vqz5+wTYoPuQ0wY8mtENFH7pPM
        DoKKKVLKaJ+KIZZjUrXD98c=
X-Google-Smtp-Source: AK7set9sU3F6kgpGUDoNVIyPCTEtbDfMWvBBxDekfNVTsfy16mWBxpaCLu2I8xtzVPpWB9Z5kqMewA==
X-Received: by 2002:a17:907:a60b:b0:92f:cf87:578d with SMTP id vt11-20020a170907a60b00b0092fcf87578dmr5417045ejc.75.1678994191537;
        Thu, 16 Mar 2023 12:16:31 -0700 (PDT)
Received: from archlinux (p200300e73722c9367ab74af7b32c2ca8.dip0.t-ipconnect.de. [2003:e7:3722:c936:7ab7:4af7:b32c:2ca8])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709061c8a00b0092bd1a7f5fdsm10169ejh.57.2023.03.16.12.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 12:16:31 -0700 (PDT)
Date:   Thu, 16 Mar 2023 20:16:29 +0100
From:   Nils Hartmann <nils1hartmann@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Using MAP_SHARE_VALIDATE in mmap without fd
Message-ID: <20230316191629.2pet2mq5bpxl3z4p@archlinux>
Reply-To: 20230310171617.wqnqs42l2viwjsz5@archlinux
References: <20230310171617.wqnqs42l2viwjsz5@archlinux>
 <e6b72d88-3011-c284-f53a-71431065b991@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b72d88-3011-c284-f53a-71431065b991@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 04:28:21PM +0100, David Hildenbrand wrote:
> On 10.03.23 18:16, Nils Hartmann wrote:
> > Hey,
> > When used without a file pointer, EINVAL is returned. Is there a reason for this?
>
> You mean, using it with shared anonymous memory? (MAP_SHARED|MAP_ANON)
> I assume you mean "file descriptor" not "file pointer".

Yup thats what I meant.

> The only reason MAP_SHARED_VALIDATE was introduced was due to MAP_SYNC, only
> required for DAX. DAX does not apply to shared anonymous memory.

Yeah I heard about it being introduced with MAP_SYNC.
But since the manpage from mmap specifically says:
'MAP_SHARED_VALIDATE provides the same behaviour as MAP_SHARED',
I didn't think it would make a difference

> I guess nobody cared/cares.
> Question is if we want to update the implementation (there has to be a good
> reason IMHO) or simply update the man page, stating that MAP_SHARED_VALIDATE
> is not supported for MAP_ANON.

The only reason I can come up with, is naming consistency.
But it's really a non-issue und updating the man page is definitly
the saner option.

> --
> Thanks,
>
> David / dhildenb
>

Best Regards,

Nils
