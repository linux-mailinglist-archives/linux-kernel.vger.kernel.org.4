Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DF06C38B4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCUR4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjCURzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:55:50 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213F45070F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:55:49 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso1964989pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled; t=1679421348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anmwm8yh/Vv8uX68Kbemfb9lejd4xrXhy7Hrxs7x/Xc=;
        b=p+5z7EVJQPLlOQLYbDplKK87mDndC8RzhIx2+st0XPbLsiD60EhRtLtfqfOMrMg+UX
         /6Fwj04we+rGkipUMwrnIhhNChD58Q+D0HcJUHND61pTEtL7rj9utgbbf8CfmF/HIZbF
         EDeRugM3ONkg2u9p7433FET+ZotZEyzDYdmf/hRf9jAOgoYDSNjm1bEYnHJI5BHOvQ1y
         PC2DH9oJ4lT9AG6rBH6ke+6Py0SlJmK5fXwyCpNspaE/JhcQP8CehRxKb7kOddg7f5om
         LTr1C2/zgoe8GetVf6eCS9oLMEcn6Qvb3IETEgBN+7KAKQUJf6eumactKjZ0GyKoighV
         JuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679421348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=anmwm8yh/Vv8uX68Kbemfb9lejd4xrXhy7Hrxs7x/Xc=;
        b=YWqoaNy4s+RgXF7d9xxKmNNGlumTntbap6SsMs//LTMPCcJ+BMtiKiLPvpOYJq7uk+
         WG+8qY3xgORYTjPUx3J7Ofb4HGRVDFppKrq4LpEJeZOcHLRcZB987ng9sVhcOZq5LH4t
         8JbBL3kU6j3wHhzOiGow2ZWwqR0cHPI5zOstAnBhExVsU6b9aI0V2ixj7QHUCTb42VDj
         v40n1Er5JMJMLCoLr9TIWGXzubPcM1ulWesb6SP0A7UwlV8OQ7gimQah0qAKK65Gh7Gc
         NXd7mF5oqF1lpHf10EPgt0lG2KCUKXuMAp+gBo8TNfAfAa6RWZzWoFHAxfjBMTYvzvWx
         nPBQ==
X-Gm-Message-State: AO0yUKXM6DkOOf41fy+IyY0/rCxCqnDygVRMVeEmN5MvSSAmqsoTas7I
        OCcoaSG/ck0VhF9ErK6ixAvYtUCpI3TZ4KTLE511CYTEfsY65UOrjPdwnnSVwHsV4WyH4yPuI8o
        7apkrjsafhwipTQiOBu1sX+KXq0VM9xLnjmY=
X-Google-Smtp-Source: AK7set+aSSNndRQzBA2NvrSAm3VcmzzTjttcwiReGOC8KcfvRLO1EcHhKyk4ELdF6t0E/8bB9RzPogDwF+CPhKhae0E=
X-Received: by 2002:a17:90b:190b:b0:23d:535f:59c7 with SMTP id
 mp11-20020a17090b190b00b0023d535f59c7mr221120pjb.7.1679421348502; Tue, 21 Mar
 2023 10:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230321080647.018123628@linuxfoundation.org>
In-Reply-To: <20230321080647.018123628@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Tue, 21 Mar 2023 13:55:37 -0400
Message-ID: <CA+pv=HOG7Ye9qvUTyYuCNYW=iEbmwEtGO9534EcPz4iUKTFMcg@mail.gmail.com>
Subject: Re: [PATCH 5.4 00/57] 5.4.238-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-SWM-Antispam: Scanned by pmxgwmtau.interior-mail.sladewatkinsmedia.com
X-SWM-TLS-Policy-Status: enforced
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 4:39=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.238 release.
> There are 57 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 23 Mar 2023 08:06:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.4.238-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.4.y
> and the diffstat can be found below.

Compiles and boots on my x86_64 test systems. No errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade
