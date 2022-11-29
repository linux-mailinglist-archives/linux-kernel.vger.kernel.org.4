Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A0363C64D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiK2RSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiK2RSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:18:31 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42285CD3C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:18:30 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id n205so15964695oib.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wK6JqpkMMBjX29Mgv1VqifDJI9zcBpWFVZwUZAn/37g=;
        b=M7bu+kzxvY/F+Cfsl96L+ioNgiGXCpfg6O2TpeTT/gOS7VA04aEiEUCCxONueRGvD4
         I9Vnt3uaX+hNewFX53fxFwex+EfUMNmMHfOakBM0jYOOeKlxbJZQ+F7ex0RrjOB68Cvp
         b7yF5enCLkyCU89t5VCubEggyZmmVEKr/wPxz1srqjYfaWwlVbEqZfc0L7fV/I9X7hKx
         Olt8goXpZXQafVIMLdAsWqNEdPpPokU0Y7QQ3wHg5v8ThdjYpQYYhO26SrVeqIjEUSba
         Go49+It+PLcwEJFTJ8lRouJ/duMU6lVYihIJFXnvUC/qGSu21P9pgVomiM6DYmzNrflf
         uiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wK6JqpkMMBjX29Mgv1VqifDJI9zcBpWFVZwUZAn/37g=;
        b=NOHkg41ZUj9QGECD3nfgtTlw6D6DWpDxKlywgP1tl4HjTHjVZx+mwbMpiOKQbY+jvM
         OiaaWw+ptxsSFoxo2jxaaieH+1rtmmhyvU1i/Zlevud8t2ItKkYX53Ackzc3rs/vVeq3
         3JsIfim5seBPyT79wmnL7+ktI/tB/GN4mcJfXkz/Ks3Qm5tP5DojIC2T+1kqoav6mTbt
         ftkgTl4PEFBogwE+Xg5Q6ludsHPnP7vBhNQBmdvXS1H/VKwdoXwgr1VIS/OuKL/9uLRk
         qq/gaFToDKZyvUP8Pe8ZaH5Hp0Zp7qRFQKPBPyHMlnhIU3z0xXehIHQGMAg4A5xMNZFn
         fe9w==
X-Gm-Message-State: ANoB5pmanbrpwkbuIfSbIiiS1feE21a2b+JZiXFCMZ4I+cXWHao9DPG/
        6t6h4Q8cU8hm+JWtTiEVnpuunRWZPVxkGDB1zgZQv7fqFJIi5g==
X-Google-Smtp-Source: AA0mqf4JdBG2TLakle0NcijYqlUiqjqejBlnJP/G+QgcMZZW/KtutXvghewrfEqoFah4XpMah+ovbO+8AM09rrVZk7A=
X-Received: by 2002:a54:4492:0:b0:35a:eee1:66f6 with SMTP id
 v18-20020a544492000000b0035aeee166f6mr20233880oiv.279.1669742309464; Tue, 29
 Nov 2022 09:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20221104230040.2346862-1-dionnaglaze@google.com>
 <20221104230040.2346862-5-dionnaglaze@google.com> <b332c967-cbe5-891a-3d15-f9fbb514d8e6@amd.com>
 <CAAH4kHY-zq_WrZK1-Jne8LURwY5K_6orK3NuZbVn9u+gwQdN=w@mail.gmail.com> <CAAH4kHaq+vNRkQRA9WX_V+R_hoXn3SKcRfJcyd2ddJqQ8ZzmkQ@mail.gmail.com>
In-Reply-To: <CAAH4kHaq+vNRkQRA9WX_V+R_hoXn3SKcRfJcyd2ddJqQ8ZzmkQ@mail.gmail.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Tue, 29 Nov 2022 09:18:17 -0800
Message-ID: <CAAH4kHbptSSCyPERr+3VejaJrBnsc1QKYLwTVPS=SYkNq-YTMw@mail.gmail.com>
Subject: Re: [PATCH v8 4/4] virt: sev-guest: interpret VMM errors from guest request
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Liam Merwick <liam.merwick@oracle.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Haowen Bai <baihaowen@meizu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Confirming with Borislov, since you've queued "[PATCH V4] virt: sev:
Prevent IV reuse in SNP guest driver" for inclusion, have you also
queued this patch series? The IV reuse patch without this patch series
will cause host throttling to render the guest unable to use
sev-guest.

-- 
-Dionna Glaze, PhD (she/her)
