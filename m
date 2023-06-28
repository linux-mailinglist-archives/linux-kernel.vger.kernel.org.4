Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC08074175C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjF1RjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjF1Ri6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:38:58 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9AF2102;
        Wed, 28 Jun 2023 10:38:57 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a36b309524so466134b6e.3;
        Wed, 28 Jun 2023 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687973936; x=1690565936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cWldZ174xGCS2Gs9xZ7wHxkpqbJdzsS714AuaqaJcGc=;
        b=IncwhENVMCB+5fqBC/VlDxPnjb5MRamc7lX1hqFGcFsMVLGq9UVcRPJm1uaxIIhmpe
         PeUJou+xTHRkVJhK+5C1kvW+YkzWy1wc+EFz1ybEhKv1HKAVYFbjr827X6KC8WHy2UPD
         1ABWFfwpGtCnPIir00Qbev4cjF+6v3Oeejr28Ou8RC/7VstYwip0mQz3zijpbuDhML4G
         Vtutc/epw70sZ+aSkDRdHZ+6Y735/+Pfcl4/sPGatXCsqvLvV4JpHFvuS9eX7DGG4OIL
         PxQPmxMS2VDbFVhURt1wKrQjcqFUvCBUHtdmvS9BM5Nq7IwBwJ+pCEbNh2Pq5Cf9zoXd
         SgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973936; x=1690565936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cWldZ174xGCS2Gs9xZ7wHxkpqbJdzsS714AuaqaJcGc=;
        b=A0Jjf8lFtmcXuS3KhFfGNpWBoe7rwrHlSHuYFbxauzV2wC1yHxNeLhYfOOIjkXTG7k
         YoHSilpOv4PYLk56tc6lAmboMC6fjrc6DEoOEhe2uwuCiab9cGctOUtollK7wjnhHXev
         QJa4SKjFpI8F550TqW4iwSG3OCHILoJyDOLn1Sxf9gyolL+exnOddjrTQ13XrrYql6cF
         wvnE5j7fwMUaiwoVYcIDGMaVAZIqRuX2OzhqhJcqUDxUvAF96oza9ECf+Tj462qPKcKx
         6t0nxuaPNVJHqMypXztYgMJJEvN9ecR/DknbcABXfOTI6wa1e8j/HG7nB3xtITSZGCo9
         rxhQ==
X-Gm-Message-State: AC+VfDzyUvR2UQTnYoxiy8EhinrLzouoebyip2y9Mgc5S1c8ybW5eMpa
        o4F2CDfCHY2Mbv2pvoFIZNPSae0dZGxqjvr8lHhRJm9nQtk=
X-Google-Smtp-Source: ACHHUZ5zCwL8ebBj47RFOKQlNLdPZtnvNZoB0jdId69CdbJu3AgINjUedNvNDGCXntBxMZTaduocIChOfpEfwPFalQc=
X-Received: by 2002:a05:6808:2122:b0:3a2:ee9b:4232 with SMTP id
 r34-20020a056808212200b003a2ee9b4232mr5841254oiw.58.1687973936409; Wed, 28
 Jun 2023 10:38:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180746.943455203@linuxfoundation.org>
In-Reply-To: <20230626180746.943455203@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 28 Jun 2023 10:38:45 -0700
Message-ID: <CAJq+SaDMbKq6wvAP-qA9odEB6E2avudft=OvRFg4eMX1HexCWg@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/96] 5.15.119-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
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

> This is the start of the stable review cycle for the 5.15.119 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.119-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
