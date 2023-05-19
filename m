Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DED70A110
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjESUyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjESUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:54:44 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A80E43
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:41 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f684f20f77so24557501cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529680; x=1687121680;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nEDErbKnDGyXH+lfOvpQDyyAEEG2NpiC+5fpLiNmj9E=;
        b=LimJZkMRsJLWfeHb2nO6LTXjKeKZWqRYQueh0ON/UMzR84F6/CgY+SQYOeWL4E0XRE
         0HSb473/lL38cXrAKcFH7pmi7EuN5T9u7i4rc2ReTUIliGN8elBDkamdVGWQRdJxmmss
         +Z3stulSjeCIibUWxtlOEnbqQVEyXqzKEfvHcOm5NQvsEFtYJ8Bom+fnMJKuIzuryxb9
         6sJKrUHPGutOWb1Coae16vm/qxy3Q3CZe4koU3DusFoYFGqLmBETUyAV1PfXkBaipvXh
         yIz9bsEJswMFJ+vX9qdh/aSZQTBR3uNALhI8kCi/gWyLy/4oE3j5hf2DoW6kKACvjOvz
         J1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529680; x=1687121680;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEDErbKnDGyXH+lfOvpQDyyAEEG2NpiC+5fpLiNmj9E=;
        b=AecbgF6AiRL5oM7OT4RM5ms7WxPNxiNveu2324F9aaPLCuhZZBCLZZbj2EODST66ua
         N/xXXOU8TCzydUGg5PS9hFrfa6pXW6TQCkOCpVyxs/1H6Hx3iKKV/UFh8tWN43RDExpb
         kWzirpNcmAamgVfXbnVjv0GDS1A+bfRu+VPBueaCXXtFz3Qg0IOx9UfF18ghrm67WFxk
         mCaqVJ4E5maIcxku6Zm6tl97kjiWVS7V4KxUlMJFKLcUryg5X8F/AVcdl/C7ZZUPddxQ
         62VthVBZisarVgKlUNqrgPgENkrdpiB3qUxtbXNj5JCCMtuibcn0VeM+8TI9RkxINiND
         3IIg==
X-Gm-Message-State: AC+VfDwEJbCmZu4I9j5GVYNUFTx6J4B8h5CbQj3rtnEn7GYcx7QBZbjf
        q+eGP8TnEdpZZ6w9mhPJ0vSrj/9TqvqXwuy/mw==
X-Google-Smtp-Source: ACHHUZ4E46IxLqXiq+Du2QmCpt+yW5Xhph/A3cd+zEaUfFm7Kfu7a+6nDxmOyhNEWuHEJ2kGqkBTaQ==
X-Received: by 2002:ac8:5c54:0:b0:3f6:93fb:dbf3 with SMTP id j20-20020ac85c54000000b003f693fbdbf3mr5637977qtj.52.1684529680106;
        Fri, 19 May 2023 13:54:40 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id ge22-20020a05622a5c9600b003f521882bc1sm129715qtb.7.2023.05.19.13.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:39 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:39 -0400
Message-ID: <8df851e887b1bc67434a3fae877d7cd8.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 3/5] audit: convert DECLARE_WAITQUEUE to DEFINE_WAIT
References: <20230511052116.19452-4-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-4-eiichi.tsukata@nutanix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> As there is no need to use DECLARE_WAITQUEUE, use simpler DEFINE_WAIT.
> 
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This change looks reasonable, but it needs to be reworked to take into
consideration the comments in patch 2/5.

--
paul-moore.com
