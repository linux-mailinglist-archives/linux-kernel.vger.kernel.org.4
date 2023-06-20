Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0947573724B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjFTRHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjFTRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:07:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B6E1737;
        Tue, 20 Jun 2023 10:07:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666ed230c81so3383785b3a.0;
        Tue, 20 Jun 2023 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687280865; x=1689872865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h08iZ67gSYZQc3WCT8YBnzAa6Qcv3ozAhy/u+AkpJl8=;
        b=aOLxKrRJZ6WW14Ax0HKLHn54/1c6uWdrXdefvepkOK0xoz/JTrZDBbRljmHSwTLSBw
         zHGlywKoPM4SIxVbSGGJNbtl8G/OvreLfwNNuuFZ1q0fbnuk/gyQ6TiSu1bFtfb1IeKL
         yYEE3D6b/2yb6l9AlISZ+4YntQG5Bk8AMLEVSp91zxbm+HS6P5skRZafpbGZ+Pbveqh0
         VGF4dU7Vv5qQJYWBEVRytlCMKHXc8C8Q8S2w3d5gKXt3UqBS6rEXCWmoBqj8o5bsN/vO
         muW+/PN0+yVsHf7ilvlX/SFIOA4NscamDAGyxw5hvGpbypXYAl7S4NIzm5IrbHrfevBZ
         8iQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280865; x=1689872865;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h08iZ67gSYZQc3WCT8YBnzAa6Qcv3ozAhy/u+AkpJl8=;
        b=Z/3FtYWRVuPy9kazgZJasq2RvEZPeqmmghrS+7mxPpHeDoha+dEfaZarIhuhEZlQ+W
         C7F+zXv6Y6zH9BU8XlNTt+IfcBX58VubQnqWX5V2eMjnx/u2WbCtjggjxE6fARfVfu7O
         wAFsIEDi003Ey+NFPDDoFrmwaSfSu1wKbPwbK4Q9MQbAJoJyJeeky7cngVimYdFAcVtc
         EZXZF03l+LCC/knj9LL1BKPv0aZz4kdn+cI/t2RlNI+DLZCx9eg+L5O77APcdZd8BGRR
         J0aOxtN6L5zUEbsloIFFq0v2urD0SC9pQj5YoOx1vDuh8Ytna9Xuhx/MINWU+ZpclJlC
         kLoQ==
X-Gm-Message-State: AC+VfDyIwMAS8qPH/V8KEJ1MdMG/xJbEqcN8arcs64a/Kxd26Y6o0swN
        9Y+n8a/V08yAxmznn4EbBRdGJDmNNSGLlkF5rYnWPL6SngM=
X-Google-Smtp-Source: ACHHUZ7PXhFpQVAdDnBMoRfKtjpDycGr/zZFDAHuCis0e436e5+1iHqYJokh1WnOt8pTNcrTQkBWJoGQ7jWS48B4zHY=
X-Received: by 2002:a05:6a00:3984:b0:658:f86f:b18e with SMTP id
 fi4-20020a056a00398400b00658f86fb18emr16174784pfb.22.1687280865287; Tue, 20
 Jun 2023 10:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230619102141.541044823@linuxfoundation.org>
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 20 Jun 2023 10:07:34 -0700
Message-ID: <CAJq+SaAHfmy=mhXBeo5zWQGTY8Sf_5Puhhr5BKs-mRCDP0WVFA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/107] 5.15.118-rc1 review
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

> This is the start of the stable review cycle for the 5.15.118 release.
> There are 107 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.118-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
