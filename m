Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60551704A80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjEPK05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 06:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjEPK0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 06:26:18 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F23C30
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:25:54 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50bc2feb320so21271218a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1684232752; x=1686824752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcHjdDfyIIWSoYZsMKiovdJIzlCJDyDWihIY5HPNKSk=;
        b=09Uuq7KAj8zEHmVegWg7KtyLu6hRs5VQUBMzjtD7rQEkluf3IHiWxtpn0nm7y9MJta
         z9hy5NMSZ3bAUKf/1RXLDFaleBuyedybLh6AY6mzcGtnULaHa/4lNBeBLz1AIlKqRV+N
         5ccU+YbWLMxQNH56maTj5Emc7CzxtI1c8eiDTgM5++DWrCyCCXT/jpH9o4uQuSF4/V8j
         FmaxS5i9IW6CPu/QYbz9JhPDn6npgWG+R4hyKrpjDdbegI/cRugdoGNG4yM5W8aeGDHg
         evgLy9HQH63y2e5mWYkfGZCZH+yKlDPLuWqw6LfTXnNvkXrbY0/k2yZPN7qlpgN4G6Az
         9pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684232752; x=1686824752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcHjdDfyIIWSoYZsMKiovdJIzlCJDyDWihIY5HPNKSk=;
        b=XakmYYdcY6qcsrLTS+WcCd4Qas+ehHZGuiV3JHzqWg8kr1ZldNDWDPPJDnkVsOJLgh
         jadFvyn2hIuDDRo9JKr/u5KyyOoJZ7Ceg4Mb1v0CCafU9wVCeH9vMA8ndqIMqLXbe7DJ
         NrpYfboinHl5/rxvFU48liQP2iWnS8w5kM4xiYBbRpwSrlWWIVmFQ7MFXqCmejyYMwLN
         cnwRxnl4Mw6AuIVXhwtDh5baoMMeLe6CJmY3OHDDm5qt197OO3BWZqI9ewLjl5T9c9m+
         4mnftHF6NcI+iV9flUTjFPXrMqnUERZ5t5ZwUX02S73A7TyURpqv9iEZxXMfuFRBqS36
         wWrg==
X-Gm-Message-State: AC+VfDxcBNgF82omOhUOqwxL6NzNo2w1ozb+6TKKmaW6KXkF5hluUm9x
        eL1ij9KRlDVZrnKUpYJ0eGslgRGjLzn5vq6pnw7+ig==
X-Google-Smtp-Source: ACHHUZ4Py2BEwM/zYFqwdmvdALvRvslKgYDWCfid+TfFBoSRh8Jf+bEtGy/xN1Na8gpQaP9M+fvBNv3P3iCUQtSvbWs=
X-Received: by 2002:a17:907:168d:b0:969:f677:11b9 with SMTP id
 hc13-20020a170907168d00b00969f67711b9mr27788487ejc.54.1684232752473; Tue, 16
 May 2023 03:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230515161721.545370111@linuxfoundation.org>
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 16 May 2023 19:25:41 +0900
Message-ID: <CAKL4bV4bam5Aa5zhYPqZJE5Pjt4fGCn0SsisHD+pYdBH60ca0Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/239] 6.1.29-rc1 review
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, May 16, 2023 at 2:05=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.29-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.29-rc1 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
