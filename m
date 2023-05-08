Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621636FB0A0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbjEHMwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjEHMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:51:57 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626EE1A110
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:51:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bceaf07b8so8539228a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 05:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1683550315; x=1686142315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yFivrtig9OalB2jQkNmqkqk5bNHkWlvaRKlvji8EAhM=;
        b=jUNUAuQ8lqy2X4B5qryu0zGlFNNkgTQeSpmvwVdIc1290XSGbsy8n1Rbx0um+wwkap
         V6vnQLrqEKql8a+cZKN50aEMj5Vh8+UhKjtCfRFvFRVsGUc8eg+Dh/zZWROt1XzE26Gd
         qydb1wJrN6ohz1bA4iAZLJXFg6UCSU3Do4Ya+gaDCRS3E35/eteRxO5rWCpyKvKxDWJR
         6Fq3gno/8DSlqoiZALVWS3oWEthH0THlAx5OfYLoNzNHoTh/vwUewyelLMooTq8TlLk1
         0aKufMCb33d2URm9b8dykcStXthn2DV3Kl4ZQ3/9yeifD3DP5UGthO0qX3Qz5DMx9qKL
         taPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683550315; x=1686142315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yFivrtig9OalB2jQkNmqkqk5bNHkWlvaRKlvji8EAhM=;
        b=PJVkZjMkmahv2pyXH/ztiV6FwBZ+aN68ajCgch4dKNPjTGyTnEpTbioCzBFp63Ldme
         3usT3PqFdkPAJwEMd3YAF6/ehjMnqf2HIZ+JaB7z5SmidKvlbKZi5916vD7s+2bDl15n
         gk2SmYsKy6rqS/SqTKk+IXLrrwmWnkefNzqK44BsYz32hyMuwvdF54647UW/QsREiEUR
         v+roN4zjXCH+4RoLhlJ4W701s8BffT5l7ylrYKVs1FczGupCk72w8XaR+OuCPltqm4Zo
         ADkYcKx8fRnmEqfHTLTbHK7z0T4FOBbpnkoz5yffrP1wf3umuOG2xLipijVRdRLGDpXt
         /Yww==
X-Gm-Message-State: AC+VfDyjv6/blQOIGLj2NO/+WqLHf/HcUqE2jO55fGoMc1jnFGG85BnA
        /t2Y4WefZBwjaEbJgPpSPpZyLz1dfrxRMFmZOR4UITCFeS9dq6AqknQgd1K5
X-Google-Smtp-Source: ACHHUZ7U/+wY/Vx6PFEt6WoITv7yJSSsKVa65gZ1L/PI1Bk8WFvhVMO5mg+66YWV8epPOITeYa8yUpVlYT6WyahnmLc=
X-Received: by 2002:a17:906:58d5:b0:969:9fd0:7cee with SMTP id
 e21-20020a17090658d500b009699fd07ceemr234143ejs.10.1683550314783; Mon, 08 May
 2023 05:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230508094421.513073170@linuxfoundation.org>
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Mon, 8 May 2023 21:51:43 +0900
Message-ID: <CAKL4bV6QaUA-Psd3dpdBL7QKxg+QwCF3LwYdYVfM-qDKqZFYPw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/611] 6.1.28-rc1 review
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

On Mon, May 8, 2023 at 6:50=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.28-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.28-rc1 tested.

x86_64

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P, arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
