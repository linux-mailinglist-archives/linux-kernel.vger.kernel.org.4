Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487576ED792
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbjDXWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjDXWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:10:08 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E658A7A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:09:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5067736607fso8664552a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 15:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1682374180; x=1684966180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3vo8hN0NTp+VghdOI9Hp/duwMShqFPxn5hXcMLBGsY=;
        b=f/SoEqea+rKQnXN8NytAsBZMxcCI6/CT+J6ZLDswvldOXjq0ybDsR/RUTRbw+D9iaZ
         sHWpeRscqR553t1QCg7W1zIZaZs5caI+lKbWQL4bew2yDtN9VqcmUI8f2tViSCNDkWMV
         d6wFAvqP16lyOK4cIKfBotdWxQEoY9u6gAEdYy4kTWC8Ay/jQ/pg0nObvvomKTWtJJTM
         yj8tX5B8yKIMA3UNkF8wi8Uvj0zteSJ73GAJrtxFYslXXgbvRZJmo7GBb/ECRChT00n3
         46i6HKPajRSWbfHycCJZLGxliYthi7lY1+jIc3NALBE4JGG84hvOj9xzJ0QWBTCjMV8x
         Xjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374180; x=1684966180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3vo8hN0NTp+VghdOI9Hp/duwMShqFPxn5hXcMLBGsY=;
        b=a3zq9lM312lNKxKajqXtYgvXfZpXx9sjfj8W3ZGNo/QoV6xInSttjgMqmnXwinTp3D
         KF/9BWDgGNKfLngnirSccUCOZCLPaWcZJ5L1UabKdDUzIFZXrG7ZR0E+Ye9MxRvLCgP1
         aA4uZbdyktoca+QGPvdrl9RLfZFHl0TwIidCNig8kymhJlxK/np9uLKiRKAwGtjcMgYr
         BT4gt/QPVoM2AxBwYvoOiWyGS2dh2t4vdiD2FlNFdHsrvYB+xxIT5NssOZqS9af4T27R
         7GTvz/RHWrgBN8BKjYgTXk2JmGU61NKrD4Rb8cYUKKR5ZxxEfS9jqA/F+YgcnLhsYYc9
         nEyA==
X-Gm-Message-State: AAQBX9f7A6TKt+wEwajUVr2tlYZxZnjWSyKifR75Dw1X9e0/4S3d9B7z
        yQ1BfYkJDkZ1FYUiYv5C6dOJuKPlPtnorfmpyBzIPQ==
X-Google-Smtp-Source: AKy350YPqje98LYBmLx3j66DAjxMN04ofbuTdqe5UqlpewYae4MIHJ0w5uaLjc3d84grCTPIOX8t0pXtqAjaFZBsgP8=
X-Received: by 2002:a05:6402:48:b0:509:dd75:7a0d with SMTP id
 f8-20020a056402004800b00509dd757a0dmr4220399edu.30.1682374179521; Mon, 24 Apr
 2023 15:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230424131133.829259077@linuxfoundation.org>
In-Reply-To: <20230424131133.829259077@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 25 Apr 2023 07:09:28 +0900
Message-ID: <CAKL4bV5N_9HVm6h-=c8wD7gomekk3WsWirbUdKixRc2_oPrY6g@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/98] 6.1.26-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, Apr 24, 2023 at 10:25=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.26 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.26-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.26-rc1 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
