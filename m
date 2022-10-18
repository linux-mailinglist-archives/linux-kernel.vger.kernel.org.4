Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9982A6022DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiJRDq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiJRDqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:46:05 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BD02BD8;
        Mon, 17 Oct 2022 20:46:04 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id k6so13552000vsp.0;
        Mon, 17 Oct 2022 20:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gd09phphTcEXggHzCnon6RDCULniijuv9GAHZJRpo90=;
        b=doJ2fDCB0QuXATfFMnsF7Z6oEsqsQw+ostomkG2z8kutk7hSh21gf8f0UfHkb+/Njz
         THG1jafgs7Krga0vcE6RBJ+0ILqebCb6t5Db7tIh9Y1MjJ6cQP/DSNkK7Y18isevS2ly
         IlCxJFVHSiWAtnQTXeiDbnzu9rfAO+w2+WD5AUhIj6+HuierGPUUFD0IYkVijxGDDQkv
         Rj9sNzuJ3yIuS+ATy/pbfdTLOhEn3N/HVu4i15OjFDd49Cc75YyE5Cgm1X8eEL29sQzU
         2Jl5AlYlgbeHBnp0JPUkaiV+BAfS/Q/udW4389hkMSR+f726D0OiRKdcHXYjfx8N6zeb
         xNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gd09phphTcEXggHzCnon6RDCULniijuv9GAHZJRpo90=;
        b=oO93G9HVjUvbRXGu/ksEYF3zYsRrEgZSbsmsbq3RAWKil+Qc+hrzRnPU1WiC3VuXH+
         sOor+nySRyKdEFQPogHQ+QFJxMLBRZj96HftpGoIIB/eBguzL0IHctUUoq2Ut7xGEDmw
         99sq93bxNP4bwpgRex3piH2lLzYTdlqF878Rlq1lu3KiK57y6WyFiAJhE4aq0TXLtMYB
         FTxVPikv5KL8xLlY0H//KigmGMYhwa0Oi2OB9WeB3jtX0vnKMTqrFUfQAYRSk6rDWxKu
         WKWo9EtK7gLfuqq+sjRN8Zpa7xtannUipMmpJ1KunHlX6zSrN7fpZzP9dSGwfHz42N5E
         xzNg==
X-Gm-Message-State: ACrzQf1q7XnpFMXdhr3SHPY/dnAZPg8iYUy77Sg6YjxP12PxM91WUaYM
        t8lVG9OOVXDEnGWDNBkRFf2LeS/4qNyzm7PrcPY=
X-Google-Smtp-Source: AMsMyM6DFOJ1o4dqI3lPhSrvb0C9QbshgqCX/dXlKDww3++cOrPdN7iB5c2xxd0n1slyE2YUzXecnxKsr5xOHEDl/K4=
X-Received: by 2002:a05:6102:22d6:b0:3a7:c599:e02c with SMTP id
 a22-20020a05610222d600b003a7c599e02cmr339484vsh.61.1666064763730; Mon, 17 Oct
 2022 20:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221018143814.34815e82@canb.auug.org.au>
In-Reply-To: <20221018143814.34815e82@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 17 Oct 2022 22:45:52 -0500
Message-ID: <CAH2r5mtXBgc7jyceq2qKoR=4+Jk-h7_Ztu2_kL-vuLK2EFVKUw@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed

On Mon, Oct 17, 2022 at 10:38 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commit
>
>   1b028682528c ("cifs: set rc to -ENOENT if we can not get a dentry for the cached dir")
>
> is missing a Signed-off-by from its committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
