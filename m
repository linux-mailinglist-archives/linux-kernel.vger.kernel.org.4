Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F8060B891
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 21:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiJXTvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 15:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiJXTu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 15:50:29 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1471270225
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:16:28 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id y69so13931593ede.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ahDO7+rUj1KXOd/Qkfsy2Fp1z/mH76ebAnI74jzaPs4=;
        b=LnldIeh4COUB4K6NTLWMbN9T1BKIZhqJMCVV1Vr0XxNk35yxYSXurE22kT5qZJtSyV
         odbacRNIZXrLZFoFOLaICe8RzYYkMGtGsHRVchDvCCGb1Eg0LlK+wdK+jq48+fgYbUPG
         PN9277CKeKzt1NQKYZE3YYVgvAkO13SQrGOhDib+F/6r8DCGdkkwVrjugKnGfGMOKwGu
         tHedAd31ldjmSVIy0DdN+8MXjdjU0WbgfQnPyQZVJIHL81Yg77HitkSvMluVydeKZDfH
         8qGI6cQlGhbx+vSDMtxm05V1W7iRHr7S0V1Gj/WizMZVSLDVbwG3WbIy27gLreeUmtuy
         X2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ahDO7+rUj1KXOd/Qkfsy2Fp1z/mH76ebAnI74jzaPs4=;
        b=sTTSZX+BwCCUM5V2JMRh7qP2+foYp7JOtKFL2PAxKtrg8nQnav36qBA/U0RJeYBeut
         aYZo+RM5VeznmGz6SWtc65UoaJlL/qdo6SvZqWq8Rc7fm6m/xVvwDE0jhTuFrOBK4YHQ
         37p+LvwS6ISRDT2mBfVg0TRAENbFJW704EKjh+DYpdkgljXjPRm36O7M7loRrSESE9I2
         YDGfal+hq/2DjuCEUlEXJmkqTuPw2yWw4VcktZsDbWlpU6kpshXYuwgmaEVnArYPIWun
         DpFgQrGMK5gFn0RrNtKB/d5SjcBpt96o/oGzwgSY7L45CnVjMc9onF4MXP5xclv62mL7
         bEAQ==
X-Gm-Message-State: ACrzQf3XQNg8mRBL9KnyoqOL9dgQ60ckKfjsL+WfmUa1l2fNMc1H6+G4
        xuhdmf4rdbTLXGcSTCMsKek=
X-Google-Smtp-Source: AMsMyM7Mvxlj6NJz6pm21NqKYDWEZwgw+iQrvIy7iAf3DzniCXJ30NWJaERW7GbIg1ATHY77DsCWoQ==
X-Received: by 2002:a05:6402:298b:b0:44f:20a:2db2 with SMTP id eq11-20020a056402298b00b0044f020a2db2mr32005255edb.138.1666634980611;
        Mon, 24 Oct 2022 11:09:40 -0700 (PDT)
Received: from [192.168.1.104] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id q21-20020a17090676d500b007a6c25819f1sm199683ejn.145.2022.10.24.11.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:09:40 -0700 (PDT)
Message-ID: <64d0f316-3e72-877d-0f6b-3db1d67877ac@gmail.com>
Date:   Mon, 24 Oct 2022 20:09:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/6] staging: vt6655: a series of checkpatch fixes on
 the file: rxtx.c
Content-Language: en-US
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
References: <cover.1666605225.git.tanjubrunostar0@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1666605225.git.tanjubrunostar0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 12:01, Tanjuate Brunostar wrote:
> The fixes are similar, mostly long lines splitting. I had to make
> serveral patches to ease the work of inspectors
> 
> v2: fixed a compilation error found by the kernel test robot and
> recompiled the code
> 
> v3: tends out the error persisted in the second version. this version is
> a correction of that
> 
> v4: did some corrections as recommended by Greg KH
> 
> Tanjuate Brunostar (6):
>    staging: vt6655: fix lines ending in a '('
>    staging: vt6655: refactor long lines of code in s_uGetRTSCTSDuration
>    staging: vt6655: refactor long lines of code in s_uFillDataHead
>    staging: vt6655: refactor long lines of code in s_vGenerateTxParamete
>    staging: vt6655: refactor long lines of code in the rest of the file
>    staging: vt6655: refactor code to avoid a line ending in '('
> 
>   drivers/staging/vt6655/rxtx.c | 542 ++++++++++++++++++++--------------
>   1 file changed, 324 insertions(+), 218 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
