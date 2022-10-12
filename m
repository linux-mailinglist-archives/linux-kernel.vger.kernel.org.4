Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AB35FC6C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJLNyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJLNyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:54:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E5FDF5A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:54:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z3so23581804edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x2tUb5+aLG8nam33vfaV25MeR7P8G77Loo4qayZcNpU=;
        b=H2rbP2y7a33ArIHNNILZbA76NG2+X/SR3QOLjp7Zyib7xxe52pAgRd6xnQh+PLuQiZ
         vgUN32VfzlFDBwcTpV5VOPAdL2BQtYrmuDCKhUYGSnTkCTnUQLWsa9MiTsTmbVr2O0CJ
         9DMuG/ljOOgeV4fnznCEFL8ESQ3wEb73shvzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x2tUb5+aLG8nam33vfaV25MeR7P8G77Loo4qayZcNpU=;
        b=Q5eUOY0Ttf+KcAl/UUfQykkZo+aokX1Rr3q/sR4c7fog0vMqUDFvjiiBbAnlizznjO
         VZKBoU6yqKqmmwg/W1wj0sMMlsdIl6LLoLu5RPZ94buiwYfnUdkwBvclNsJVDEAxDMMu
         51tLb+tQ7RVgAbggvnI2atlAiQlYO4ALXFuVJ6lF7hO+O/VShDR06LyeTcmNOeNOU1po
         9N5+tA5dClKemQRhOxbZZxHEJysYvfNXnDX6zwodCeFSBJ5VeHPzgLVEX9sBZKrnCnj1
         WgyHQQ8RjmUvleSF/2Y9lKV9eMjefO+yb4FQo0gL+ky2v0wKJQHH9Ef/3P8bmrOvnw25
         fdJw==
X-Gm-Message-State: ACrzQf2eHNPXIz44G4gcVxNODrBttWZwPQsFp78wn1zYtQWnLKdn2jL0
        wr0CFVJBnttflPQhtT8tIZCnFuBQiA4bTWTSMwII8Q==
X-Google-Smtp-Source: AMsMyM5i9wtc4jHHAG4BKdvGzBQM+sSkdoTnwxvW8c+6VbI4dkGaNQjwflByW2NoDfRkkqVCzCj/z/zmf046zQSqTVk=
X-Received: by 2002:a05:6402:3215:b0:45c:97de:b438 with SMTP id
 g21-20020a056402321500b0045c97deb438mr5204382eda.7.1665582887439; Wed, 12 Oct
 2022 06:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220901074259.313062-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220901074259.313062-1-ye.xingchen@zte.com.cn>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 15:54:36 +0200
Message-ID: <CAJfpeguPHUmGDzT6VXC6SaQaAb3vLVT+xt4k31AqDiJuZ-oK0w@mail.gmail.com>
Subject: Re: [PATCH linux-next] fuse: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sept 2022 at 09:43, <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value fuse_dev_release() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thanks.

Miklos
