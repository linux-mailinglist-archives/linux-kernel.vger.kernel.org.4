Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DF600F38
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 14:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJQMcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 08:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbiJQMcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 08:32:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EFB4AD41
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:32:32 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y1so10947631pfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h0pxyt/EKUK/MG4h+DBekx3KlQE3mxmmFg/7fznhJTI=;
        b=SCgiftR9cblWOkQ3H14dm+Po7yBBMzZkgGcDfc2ct1IUJn4AG/PcN4+EoBcWuvW9RT
         v3wuTMwpMPePXxDhCCGzIxTRnj1y5rGaZm+stjLF+iMqVEGhaiWWg1w9urzqa3fRE5pA
         BjILXOXVc5wXPniPq1nmqlQhrJrR4lqDleBFBRR3yc2+onK0X7NWKC4M8I211Mm6DBSK
         zLQdgFiULDOrDRZ+gOg6SYK5/7/Woj0q6rx6D09ftCWoZr8HgWH+UkQsiTKeXIoBM6I1
         jaQudtyOQQBSZ5btGF525OGeHZODRC0Mtr+gvbeNV5m7kHRIituvzUy00qwpVfcwLVWm
         hfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h0pxyt/EKUK/MG4h+DBekx3KlQE3mxmmFg/7fznhJTI=;
        b=6dyoJqlUEBKOqXu2lqXJyqYYv0f1YRTttNXlTkO9dD/yaXcfmgqYrZy+PqfK8obSWf
         RRIXsr8bVbGKmDbcEf63blIF7Lp6V56srgBaTFnAdiOcXvUbPRig7ylogghJGI5ryqdz
         /zCKFxgeexApqw7M553rUxpKfkXvPybvHmKqGNdKgvXS0dK8a/uJMQ2xikTLommB9/kS
         6eUsdLSLuMkeW5qRZyWo3wcdUUWPAzC/BSM/D/y9+qyzV/2dKLMYwIUphj+y+iRGOIjN
         IgglzCU+Gs/RYJbWUWi+kGv/pcsJLnHJif9KtsaFupP7mX2KwHBrgK02Yd3wLNDQBvRK
         a+KA==
X-Gm-Message-State: ACrzQf2+Mc4uLy8Gu5cfBFHKERJlt8DOZONE55E2c0ylopITSNnva72f
        uL/qnCly8WN60Rp3df046Y+VK+FhpVg=
X-Google-Smtp-Source: AMsMyM7HvJdx8QOn/eqVnmfTh5eLzM0viEj9FSk4U73Tb+3l+3qqzfm0PTXZan08EYGbWLP/Rk5ahg==
X-Received: by 2002:a62:cf81:0:b0:566:e88d:5006 with SMTP id b123-20020a62cf81000000b00566e88d5006mr7380101pfg.86.1666009951931;
        Mon, 17 Oct 2022 05:32:31 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-13.three.co.id. [180.214.233.13])
        by smtp.gmail.com with ESMTPSA id r8-20020aa79628000000b0056699fcdf6bsm6158979pfg.84.2022.10.17.05.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 05:32:31 -0700 (PDT)
Message-ID: <a1d46bd2-9603-f89a-ec85-ebcd25db8882@gmail.com>
Date:   Mon, 17 Oct 2022 19:32:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info, mirsad.todorovac@alu.unizg.hr
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
 <2d1ca80c-1023-9821-f401-43cff34cca86@gmail.com>
 <c5980bcb-f345-ff2e-a29b-75e53a6b8708@gmail.com>
Content-Language: en-US
In-Reply-To: <c5980bcb-f345-ff2e-a29b-75e53a6b8708@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 16:45, Bagas Sanjaya wrote:
> On 10/16/22 19:21, Bagas Sanjaya wrote:
>>
>> No Verneed warnings so far. However, I need to test for a longer time
>> (a day) to check if any warnings are reported.
>>
> 
> The regression still occurs with this patch applied. Let's see if
> reverting the offending commit helps.
> 
Sorry for speaking late about my triggering cause.

As the background, on my Debian 11 computer, I have lxd snap installed.
I use lxd to channel my sysadmin side by spinning up containers and
installing server applications there (LAMP, email, DNS).

Back to triggering cause. I can trigger the regression when the network
connection drops (when Firefox shows connection problem page). Then
I run `lxd list` to list container instances and I get the Verneed
regression error.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

