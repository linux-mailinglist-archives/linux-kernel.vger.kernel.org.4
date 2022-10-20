Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3585A606C27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJTXoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJTXo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:44:29 -0400
X-Greylist: delayed 356 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 20 Oct 2022 16:44:25 PDT
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53178BC2B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:44:23 -0700 (PDT)
Received: from localhost (004.mia.mailroute.net [127.0.0.1])
        by 004.mia.mailroute.net (Postfix) with ESMTP id 4Mtkhk3MSGzHpk3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:44:22 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([199.89.3.7])
        by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id V_ZDC_paeMSG for <linux-kernel@vger.kernel.org>;
        Thu, 20 Oct 2022 23:44:20 +0000 (UTC)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 004.mia.mailroute.net (Postfix) with ESMTPS id 4Mtkhh2gRpzHpYr
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 23:44:20 +0000 (UTC)
Received: by mail-pl1-f198.google.com with SMTP id c12-20020a170903234c00b0017f695bf8f0so490502plh.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YX1dOQSRsve78QezUb/eXdj5VKCyEMPTdvcMB3RYrOQ=;
        b=WbIhvWU8CfHx8GVDZGCjoiNp8HwXpcmXBtrDYeXkgwCxun52M4sXTAU7fvjDWmQIDa
         m14lf2Dkr9vaxUNBrV1dEzQyAjrofbS6nbkuPY5HluitUiRVsA2qCA63DDZQAz1pnhcb
         9iZhdMitQh2kG5RWefsNKLOf+SolbgeiSnXrS0C/is8Ow+7OT2IKl2kPTbFABWHB3Zj8
         m4OfxPhnXDMPtRJCcRHwL0c7694ItA0+ePqTw9SoCgg9RHlgnrw58FPqMZL0VrC+5tMf
         ssP3zJa8OvnvQndg9B9LLvvpYWX/dCw8asU4LC2qxWe+v8RTas2J7rREyzqEQLYiMJ7C
         rJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YX1dOQSRsve78QezUb/eXdj5VKCyEMPTdvcMB3RYrOQ=;
        b=re/54aNUaDk+kWzeXnjzioNNdq0hM0M1+EoPxTS7FlmirbOH8j1YpBUSR6Xq6oC/Yo
         uA1hP+Tbobqkw6E6nZBILQIa6ppLl2MT5p/4wKF8h5f0+J+j/yFJRMNEliEnbQqsJv5r
         1zZt//wcek+7obfJ9bhpbHvmBDgOayfSwRzaJadQIXxzhtQiX+dFBJj6xzYL5VfzCz0W
         T6wudEfZPWRPP01/peNhI0AWYm5EOkoGYN+wbDydytlxJXLR8DL08rawEDAa+KSK4ZDN
         8RMYjW3kMSNDGOVYX7nlwrXiihFIEWbvSbOLLij0GMYxbmAAUChdKW0mbQgUanqyx4IA
         UuJA==
X-Gm-Message-State: ACrzQf1Icuvs+p40JB7yjZe/8VjzAvFNImkQ7Cvj+SGXaqH67aKZGVF/
        ZFBUtHOGOAkm+STxYczslDHk3kdIMbxnbN2MeVH2kJrQpeAoMDpglRypGBERxl9qVH7mMq9mkqH
        O7J6LI0RxtumKNXG/zTVqACEO15HwbE9GDFBYFbwOJCjcY5ICrWPYsKY=
X-Received: by 2002:a63:df03:0:b0:462:cfa2:2871 with SMTP id u3-20020a63df03000000b00462cfa22871mr13685278pgg.225.1666309459071;
        Thu, 20 Oct 2022 16:44:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM75NxUHYbQaS3LgwG5b/WXaDO1a4BYysaF3eePJ2McKsaOhV8OIsrv2zZdZ2WzF6btIac6cwDHaWtY7Ngc0h+A=
X-Received: by 2002:a63:df03:0:b0:462:cfa2:2871 with SMTP id
 u3-20020a63df03000000b00462cfa22871mr13685264pgg.225.1666309458800; Thu, 20
 Oct 2022 16:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020135545.586-1-nicememory@gmail.com> <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
 <02b72b86-7240-5530-477a-c8bdcfd35ef5@gmail.com>
In-Reply-To: <02b72b86-7240-5530-477a-c8bdcfd35ef5@gmail.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Thu, 20 Oct 2022 19:44:07 -0400
Message-ID: <CA+pv=HO36vMH6Uqu412MF+Hmu-+57QeapGt6k+QDDxr-AsbJkw@mail.gmail.com>
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        Jintao Yin <nicememory@gmail.com>, hsinyi@chromium.org,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, regressions@leemhuis.info,
        regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend due to formatting issue, thanks gmail.]

On Thu, Oct 20, 2022 at 7:23 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Ah! I was about to test his third fixup patch. I prefer to go
> with your fix instead (as the formal patch).

+1, agreed.

-srw
