Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CA9701D76
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjENMl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjENMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:41:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0AD171A
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:41:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f4ec041fc3so22506805e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684068084; x=1686660084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cynUrOqdkWITH+5SSziuXYTSPapfq2lw8vhoI55n8Xo=;
        b=J5GzqF1QT0T7YOO0bd27+68MuQ/9HbiQmzKGgSrtzcna9dWqD5//yCDwtHZZlhsV3W
         zIUgsGdhIo4aoKmt8456jKo+VwRYv9BVKI/Z2KEnIeBICtX6pXw99ftRMR1kJFObTi+E
         JjPyyDha2SQrgd78YyMxfOfhkIWs4XQfekRrosuiQ6nYiw6PVWk1UHVfnvGAAj2HIgGG
         arihh5MjWVohb9RnPMxytD5kDBr6IW12+HWC2bR0NMys4P0o9hGDykFPnH4ZJsSL5Sc+
         tVi939CyvTSjbuY30Cu1fxj/UzOWd5gPfrIXyQDHTy8C4RJ6lCwKTNx3zmi3a2Buybyp
         o6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684068084; x=1686660084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cynUrOqdkWITH+5SSziuXYTSPapfq2lw8vhoI55n8Xo=;
        b=LvMspiC/dInXjdOKVNrYMByd3NQ1xKGxY/kbWCp2gmXzrqzDENqle6Zjo9wrlm5uMU
         rXgLNgaXjLL0vXg7vnbw907wtubfsOtV3+xtnJANeTBuvHlwj9bXH+e7aopcTzq+KuK5
         h/DF5F0189Vi75r+SIVj8W2yHMkEs6XAjr7DYrpYZOMNsz0qGC9bhk6IeXMQ4hzYRphe
         ZphrHpwFunsX8DdOfEIxbDbcw+a7dLgQnOnPSKWJiIFShsaGSQG11x9fqScRTL8XMH/9
         dADfLw0fS0co4M1Xn9bf+auuYJ35zRNN6eDcW/P+SYZBoUdE+UH/bzTerxEKBM8eUlQG
         EESA==
X-Gm-Message-State: AC+VfDzFzMPtixZ5KKpoF3HPKppjxyr+l7DQ/ZDNC5hIr/JDyiELhjsP
        6c25U0rXD/N49rJ+QPfPvddgnA==
X-Google-Smtp-Source: ACHHUZ5v2c/Lw+UdKikQE0IAnGR2AyU+5LcRlbP33uYNDyiIM3X4STlCRE4ltv3M4pafF+VlU6Disg==
X-Received: by 2002:a1c:6a0d:0:b0:3f4:23d4:e48 with SMTP id f13-20020a1c6a0d000000b003f423d40e48mr16977737wmc.23.1684068083830;
        Sun, 14 May 2023 05:41:23 -0700 (PDT)
Received: from [192.168.0.15] (cpc76484-cwma10-2-0-cust274.7-3.cable.virginm.net. [82.31.201.19])
        by smtp.gmail.com with ESMTPSA id i7-20020a05600c290700b003f4ecf1fcbcsm9693192wmd.22.2023.05.14.05.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 May 2023 05:41:23 -0700 (PDT)
Message-ID: <552345c5-b1e9-41f6-f275-b6eeeb51df25@linaro.org>
Date:   Sun, 14 May 2023 12:41:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use
 PROBE_FORCE_SYNCHRONOUS"
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230324063357.1.Ifdf3625a3c5c9467bd87bfcdf726c884ad220a35@changeid>
 <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <CAMi1Hd1avQDcDQf137m2auz2znov4XL8YGrLZsw5edb-NtRJRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/05/2023 18:08, Amit Pundir wrote:
> On Fri, 24 Mar 2023 at 19:05, Douglas Anderson <dianders@chromium.org> wrote:
>>
>> This reverts commit 58973046c1bf ("regulator: qcom-rpmh: Use
>> PROBE_FORCE_SYNCHRONOUS"). Further digging into the problems that
>> prompted the us to switch to synchronous probe showed that the root
>> cause was a missing "rootwait" in the kernel command line
>> arguments. Let's reinstate asynchronous probe.
> 
> Hi, the asynchronous probe is broken on Dragonboard 845c (SDM845)
> running AOSP (Android Open Source Project) with v6.4-rc1
> https://bugs.linaro.org/show_bug.cgi?id=5975.
> Can we please go back to synchronous probe.
> 
> AOSP do not make use of rootwait, IIRC, but it is added by the
> bootloader anyway. And the device fails to boot AOSP regardless of
> "rootwait" bootarg being present or not.

Could you try applying this diff to enable some log spam and let me know
what you get? I'm keen to try and figure this one out. My mail client
might crunch this a bit so I have pasted it here too
https://p.calebs.dev/ab74b7@raw

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index f93544f6d796..67859f1bdb28 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -653,11 +653,23 @@ int rpmh_rsc_send_data(struct rsc_drv *drv, const
struct tcs_request *msg)

        spin_lock_irqsave(&drv->lock, flags);

+       dev_info(drv->dev, "%s: %p tcs->type=%d state=%d, "
+               "wait_for_compl=%d, num_cmds=%d\n",
+               __func__, msg, tcs->type, msg->state,
+               msg->wait_for_compl, msg->num_cmds);
+       for (int i = 0; i < msg->num_cmds; i++)
+               dev_info(drv->dev, "%s: %p cmd[%d] "
+                       "addr=0x%x data=0x%x\n", __func__,
+                       msg, i, msg->cmds[i].addr, msg->cmds[i].data);
+
        /* Wait forever for a free tcs. It better be there eventually! */
        wait_event_lock_irq(drv->tcs_wait,
                            (tcs_id = claim_tcs_for_req(drv, tcs, msg))
>= 0,
                            drv->lock);

+       dev_info(drv->dev, "%s: %px GOT TCS! %d\n",
+               __func__, msg, tcs_id);
+
        tcs->req[tcs_id - tcs->offset] = msg;
        set_bit(tcs_id, drv->tcs_in_use);
        if (msg->state == RPMH_ACTIVE_ONLY_STATE && tcs->type !=
ACTIVE_TCS) {

> 
> FWIW I do not see this regression on RB5 (QRB5165/SM8250) running the
> same set of AOSP images.
> 
> Regards,
> Amit Pundir
> 
> 
> 
> 
>>
>> Fixes: 58973046c1bf ("regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS")
>> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> ---
>>
>>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
>> index 903032b2875f..4826d60e5d95 100644
>> --- a/drivers/regulator/qcom-rpmh-regulator.c
>> +++ b/drivers/regulator/qcom-rpmh-regulator.c
>> @@ -1462,7 +1462,7 @@ MODULE_DEVICE_TABLE(of, rpmh_regulator_match_table);
>>  static struct platform_driver rpmh_regulator_driver = {
>>         .driver = {
>>                 .name = "qcom-rpmh-regulator",
>> -               .probe_type = PROBE_FORCE_SYNCHRONOUS,
>> +               .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>>                 .of_match_table = of_match_ptr(rpmh_regulator_match_table),
>>         },
>>         .probe = rpmh_regulator_probe,
>> --
>> 2.40.0.348.gf938b09366-goog
>>

-- 
Kind Regards,
Caleb (they/them)
