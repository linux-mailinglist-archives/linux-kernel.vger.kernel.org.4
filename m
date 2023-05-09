Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07496FCC5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 19:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjEIRIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 13:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjEIRHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 13:07:49 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184965FF6;
        Tue,  9 May 2023 10:05:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-52c6f8ba7e3so5733699a12.3;
        Tue, 09 May 2023 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683651924; x=1686243924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=amE40pGjkHaZY1kl3ojQhTIMDPt7Dk1yxIzG7+bYcrA=;
        b=EuMMChqFf167ZSiRxfbyUgRbSW0Gl+e/+JR5pN9GyR4V/SvQyfc2RLcY+BZZr+QsBT
         vBBiuZlht9tErwMdHx3rDCunUGjzROiVdktnHT4SuW9mg5lPYUtRIiJif3jr48W0QYwZ
         0avQyg4ZXORF/3ZM0uusErsSbeacKSZlZERdDEQ3bu2yp1xX/HGCULAtqHXuzMZYkkQ0
         QKIua2N6lN+XCyS77rxc/zk1R1t/Rx5n97a+o0cT1BU7wsnMZt0P1Hue8WnR6qyddDGX
         77Mwu8LYATkwTyeGgyQDeEQAEeHim4NLlM+FLZAiHERahs7K3xlh0eFLyoucJjF/xFvX
         xBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683651924; x=1686243924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=amE40pGjkHaZY1kl3ojQhTIMDPt7Dk1yxIzG7+bYcrA=;
        b=FzsLsOynZShR/nxBzdgH1TitW9r7hvjVE0ae5cjhWL7L12alejaj1+m1Wnk5IkwZpV
         nYt/aTsLEaOS7JwQwBV3qjlIrxx43979n72VlnbZp8SrYngLqBtEohxx/zLnBtaENS3a
         83/Uf58lZMyc7MuF4qrDQzLIePnxIjRw09hBxw7dZHePu4uTwju5RbQK0HWR7r3hCtY3
         sLgd5RTUBy2xHcabJJYSOTZD1kQixho+zb13cHaVhiQh+TvcieRUZjsMvSLCetWNMjPs
         3X0zugNV9kd/mh2iZL9uWaWpJRWgjw+hJ9VajZI5hXV/1ar/RWjEo3GG6ZQe9LHWYEeQ
         KTOw==
X-Gm-Message-State: AC+VfDzNe6N6TmFfhsQ+2CAJqqUxqE5FgcGiaGGxoTDlJp4l1k6JHUJ7
        fIFFVUVMZETJmlkGDo1zuo9Rb1fpziiwMq081IM=
X-Google-Smtp-Source: ACHHUZ4D1jFjztMuQrAVOVCq1/uk1yxKVf2VKX74E0qpqL8JRbtWGioMuJnzKNgemeDUWc/uD2CgcYpRPpXXHh8Q9QI=
X-Received: by 2002:a17:90a:a784:b0:250:27ad:e1a6 with SMTP id
 f4-20020a17090aa78400b0025027ade1a6mr15002406pjq.31.1683651924346; Tue, 09
 May 2023 10:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230509030701.507375024@linuxfoundation.org>
In-Reply-To: <20230509030701.507375024@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 9 May 2023 10:05:13 -0700
Message-ID: <CAJq+SaBywHUnZUjJHqw0MgAGvTTc7rWUfh-7f4GXZxiZ9VEJ4A@mail.gmail.com>
Subject: Re: [PATCH 6.2 000/662] 6.2.15-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.2.15 release.
> There are 662 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.15-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
