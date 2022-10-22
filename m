Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D96460903C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 00:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiJVWIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJVWIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 18:08:07 -0400
Received: from 001.mia.mailroute.net (001.mia.mailroute.net [199.89.3.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2797ABA25B
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:08:05 -0700 (PDT)
Received: from localhost (001.mia.mailroute.net [127.0.0.1])
        by 001.mia.mailroute.net (Postfix) with ESMTP id 4MvwSh24HMz2KY8s
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 22:08:04 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 001.mia.mailroute.net ([199.89.3.4])
        by localhost (001.mia [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id yDSn1wUTWyzK for <linux-kernel@vger.kernel.org>;
        Sat, 22 Oct 2022 22:08:02 +0000 (UTC)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 001.mia.mailroute.net (Postfix) with ESMTPS id 4MvwSf0QPcz2KY43
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 22:07:56 +0000 (UTC)
Received: by mail-pf1-f198.google.com with SMTP id s2-20020aa78282000000b00561ba8f77b4so3058034pfm.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKOc1pnOZSy/A6AqcGy95JxvjU+o1yN6NNR2BOFs1Zo=;
        b=Ddn4gtaMO0m1ZwWqhlz0Rtd5LhZKlNPW54fuiAwB/497j4X9LlG1DaCePl87Y5yecB
         oyHdgXacYbHvrpub6hLpwyVkpLGb6HJ0o9s4zAEjhP27Tq81vwLcjW2Pq/utPQnIoi4k
         ehp75CRydk+XTKFDqXdjw5WcUYDSdMlWD0z5Gc2ezMC8u2/dcOCmtYt32hioHcKEovKD
         eHOCT9o2gIgAoWJBvqo1SIIGXSfQjYbCyhHl+Ni6e1Rf0Pp1vlcvyCov7JelZCV6zAVh
         yI9KfpDJmVS4oilzEAFNEhL5yrv13kKGgH6vGg8IUqGACA5ywOF4DAxauwXVN1sRmfCm
         W86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKOc1pnOZSy/A6AqcGy95JxvjU+o1yN6NNR2BOFs1Zo=;
        b=1BYxN9Ta1ZEURgmamZ8g1Ueeg1RGkL5OJZj3rGUZ7I5mU3PgxE5U3fM0beDij/Xe2V
         pq2Hm1mKn2iyrD++E73SQdHw/iDhb1qWSBrqPgg3cDwsIMKgOypBimPXtOm7LPq0yM9P
         nvtquH4L5tXPLVm/pufoa/VR+We+fNicOiVK2wLZbeLzHj8d+vsHkiPWuMdICPlpBp8W
         UGHwEUlD4aleq+L1DvYVweFrx7n5zKzvifo0WlkBigeV8CNyShIdb19bW7N255y+L7pN
         KcKPd2ZOLcRZkn2CxEW0arcupSH5CvnPc7uB+vODGJUPgZDrH6QxdtrZvAmnOudPJ7rb
         hDfg==
X-Gm-Message-State: ACrzQf3UKdkAfB0hWgC2rRPig8Ds+TZKt/Gi13aExWrNE6xlSMh+9pEB
        vxCEHVWB5KaVgQtjBEv5XiX8fD4XHs9GtzjFeKVCF/J6/GedGK4z88SzRCkpV2wWfT9rCdFsG43
        ws6GH+kZ5F7t7cLcH3bFPietF1nCRvU9OkaMbT46HZTxPl2kK9Fnb8Ds=
X-Received: by 2002:a63:df03:0:b0:462:cfa2:2871 with SMTP id u3-20020a63df03000000b00462cfa22871mr21741829pgg.225.1666476475623;
        Sat, 22 Oct 2022 15:07:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6GgtRePVqD5kO9HgjG7bDQl1h0aZN+6HYi4tc4P4UpH0evs+zPFDxS8vFNhXekMvhc21jfPRN5IREv/rjV8/s=
X-Received: by 2002:a63:df03:0:b0:462:cfa2:2871 with SMTP id
 u3-20020a63df03000000b00462cfa22871mr21741813pgg.225.1666476475357; Sat, 22
 Oct 2022 15:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221022072415.034382448@linuxfoundation.org>
In-Reply-To: <20221022072415.034382448@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sat, 22 Oct 2022 18:07:44 -0400
Message-ID: <CA+pv=HPGuq_OyXLtwHPznw5pMMXGTu=SxDtyFE2+4vXfJ=-HUw@mail.gmail.com>
Subject: Re: [PATCH 5.19 000/717] 5.19.17-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 3:35 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.19.17 release.
> There are 717 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Note, this will be the LAST 5.19.y kernel to be released.  Please move
> to the 6.0.y kernel branch at this point in time, as after this is
> released, this branch will be end-of-life.
>
> Responses should be made by Mon, 24 Oct 2022 07:19:57 +0000.
> Anything received after that time might be too late.

5.19.17-rc1 compiled and booted on my x86_64 test system. No errors or
regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,

-srw
