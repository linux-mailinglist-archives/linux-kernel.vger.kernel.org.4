Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD88628B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237158AbiKNV3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKNV3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:29:52 -0500
X-Greylist: delayed 1405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 13:29:50 PST
Received: from outbound-ip19b.ess.barracuda.com (outbound-ip19b.ess.barracuda.com [209.222.82.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D850618E11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:29:50 -0800 (PST)
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72]) by mx-outbound41-171.us-east-2c.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Mon, 14 Nov 2022 21:29:49 +0000
Received: by mail-qv1-f72.google.com with SMTP id z18-20020a0cfed2000000b004bc28af6f7dso9218313qvs.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 13:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sHhq7GAcH+SGAD2OAT/4GIJITY8Agpvr4ItX6H4dnTw=;
        b=RkaNIlr9V5SN6THND5V/unQ4uGo4Ewoz2wIKKh+ktKuyCJdNnVVPtPduHX2TXf/r3W
         OxV+lLwPYO0X+XWeGLEZ6I3mH7aPIjXo9AyxulJrwHbamWpmay+eU+B7rLJIkFYiYEve
         ZSWF624bLS8OJ48owc55yns0psiZ8lOP/YruCDfdNvvg3D8QY6oVkL1IExlvhbOlkznZ
         70h0LGGBw0M6fJwlBKvJBOWnCQ96ztSV3OtQ8cAlSDsTG8P61hJ3Vb9xDWv1jOHzZ2UN
         JGIYpXsf69ITyp1HII4ksPVOAJVtMCt1wwGkjVTLta2BW12VcOuX5HHW4NiFp/Q7g3/W
         fcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHhq7GAcH+SGAD2OAT/4GIJITY8Agpvr4ItX6H4dnTw=;
        b=TIEZZ8tkkNn7DUAVj/DbDBCngSHXj5wclWy64lbZ1CJFIC2H6mj8rkq5u6rTs0PpmZ
         9Y+35kWYmR6UJnZOuO/s+h0R/6YhzwoQKJ4N8E8GxfNIflDaZWPMiBU0EXnbVnnvZfY5
         2dAdm8552uhOwl1t7V8jIK3Drfs7LaCAaifNA4wg7IL97La2sB56aDAaEStHkA54h8qb
         FbfvBtDb0SjWQbsNgqNecFW2gShGUiD+lB0PUyYjilVhhWqF33XjkzBvBmuxcBI0fbax
         bdAbGBu/iBfn5eJH4OQhlEhANOjaqXTS4dqdf00PfovA/kL8OoPN8QWRVwHgA7vr2lh4
         JtOQ==
X-Gm-Message-State: ANoB5pnulWFGnyEi+mckUozA45yk6f2T/ZM6TzXGvEwlRlpnx6Elb5hj
        fVrwQC/ocgd9zjjcr6s39rU0l+ndXT3Vz0y8L9bM3IbWnyc+uNs0Ex+mUPIE4mCBfjtdSbMInQo
        Tsa7xPsJa2wWCPx6owTjE372hFV21AduzZnCMKQtu5dOikKXaYNuYHXjIy6Iy+h2PPxUwxZMX
X-Received: by 2002:a17:902:b18e:b0:187:2790:9bc2 with SMTP id s14-20020a170902b18e00b0018727909bc2mr1045584plr.61.1668460006277;
        Mon, 14 Nov 2022 13:06:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5hR1jUSh6vO+NzVXJRDYcadYdn4lJl0ydhNhJqjQVtk/DjBGaS18IFlwxJN0Asr3csyDUI7pdHlDadYCNkliw=
X-Received: by 2002:a17:902:b18e:b0:187:2790:9bc2 with SMTP id
 s14-20020a170902b18e00b0018727909bc2mr1045562plr.61.1668460006054; Mon, 14
 Nov 2022 13:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20221114124442.530286937@linuxfoundation.org>
In-Reply-To: <20221114124442.530286937@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Mon, 14 Nov 2022 16:06:34 -0500
Message-ID: <CA+pv=HMHfNO-v2jRMrzHKx7VWzg9khjPxp6pNh0DPDsnF_O55w@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/95] 5.10.155-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, rwarsow@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-SWM-External: yes
X-SWM-IntToExt-Scanning: swmout (swm-pri11-itoemail0-scan.leviathan.sladewatkins.net)
X-SWM-Sent-by: swmPRISMgateway (swm-prismgateway-pri02-mail8-scan.leviathan.sladewatkins.net)
X-SWM-Antivirus-Version: 1.1.0
X-SWM-ite-Primary-Server: swm-pri12-item.leviathan.sladewatkins.net
X-BESS-ID: 1668461389-110667-25855-6573-1
X-BESS-VER: 2019.1_20221114.2026
X-BESS-Apparent-Source-IP: 209.85.219.72
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.244150 [from 
        cloudscan13-119.us-east-2a.ess.aws.cudaops.com]
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS162129 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 7:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.10.155 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 16 Nov 2022 12:44:21 +0000.
> Anything received after that time might be too late.


5.10.155-rc1 compiled and booted on my x86_64 test system. No errors
or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
-srw
