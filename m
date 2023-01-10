Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8E664174
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbjAJNPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbjAJNPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:20 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531A158315
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:15:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id z5so10641021wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vOKLV0L/rUMNuhw4HJl2mVChrRCC1KIi40pAfe+sGyI=;
        b=H3pJGg9tgvES7PQKDaXPryN9CSbYSn5HIe2ElfoyPqu1/9lBQYp2u+P5tXBE4Crg1f
         +4Jn9/5MuEYqkpXKLtYiATPi4fg33gOCDL9U88rQ/E3H7mh+G2nUkLd5H9TM8pprCivY
         Wh5SSI9YAZqV+FvMujurLWzA94BOHs1+5O1nG+MS+ROJHAf2T+BtY59AswZi/ndcuWuc
         ovj7C2ciWKrx75X+Bekx+1XHeNaUgWtRMy3iSqx05Q8h3wZkJxbAoHT5EP27JliMVkSO
         1c4p9yz+P/JL4Xpt3kk4WK3zydlH7EDBaitBCmMx4vblJvcrXHVpmCWQ1BBwB0BMN4mi
         2V5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vOKLV0L/rUMNuhw4HJl2mVChrRCC1KIi40pAfe+sGyI=;
        b=ZHBIS+qFq90NFkwC9+6cr5SQF12tAlDJSNEoTDVyRNDj0QurtTiHw7kT4hINC+AF0N
         0bNpMc4Sva5nZTLmtOmWBE20yhYmKUWcx2uMJkkVfxfPvzqnZkC/j+YQrvRDeqjz2Pyi
         bcFIEhTbtbC9SPgDa1aLAZnbS7+SYx3KpEPsYcB0KGoyhrw4va4lRJ6VR4Wf0MmpHH9C
         RNjZRJnFzoY/Ndrzd4SYXAVPxbe6KmW8FVsCXWWZxtvkzGTNSPF0GFmTPgZbCZCp5VCp
         sK6Knc9impcdJjbPad9HTeIVhuAZ05GWYjydKr6Lf7QjEGYAq/U05HqldYbUyW0nE08v
         76AQ==
X-Gm-Message-State: AFqh2krNOPw+E1I/E9/QcXKcmKbpVFm9VOWGzu8byDbuQkOVEnpwCzHP
        c6b3XjGe2tKcvWERLwKpHQQpcQ==
X-Google-Smtp-Source: AMrXdXs6XTGkkUTyIUOVn7MpsVRoKLGf1JtfFs6zf8gl8ajAfnJudhARkVA/Py6c5QVFics52QXXuQ==
X-Received: by 2002:a05:6000:719:b0:2a4:bff5:6e79 with SMTP id bs25-20020a056000071900b002a4bff56e79mr14889328wrb.67.1673356516655;
        Tue, 10 Jan 2023 05:15:16 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id s7-20020a1cf207000000b003d98438a43asm14176420wmc.34.2023.01.10.05.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:15:16 -0800 (PST)
Message-ID: <7fdb8902-965a-03c4-2f9c-fb60d562d735@linaro.org>
Date:   Tue, 10 Jan 2023 14:15:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal/drivers/qcom: Remove duplicate set next trip
 point interrupt code
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     dmitry.baryshkov@linaro.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230110103420.2430518-1-daniel.lezcano@kernel.org>
 <CAJZ5v0hFrevTR4KkO0VDB8YQC60cgDkDKQT3kdQAk-VoOJoZhg@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hFrevTR4KkO0VDB8YQC60cgDkDKQT3kdQAk-VoOJoZhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 14:01, Rafael J. Wysocki wrote:
> On Tue, Jan 10, 2023 at 11:34 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> The tsens driver reprogram the next trip points in the irq
>> handler. This function then call thermal_zone_device_update().
>>
>> However, thermal_zone_device_update() calls thermal_zone_set_trips()
>> and from there it calls the backend 'set_trips' ops. This one in turn
>> reprogram the next trip points (low/high).
>>
>> Consequently, the code setting the next trip points interrupt in the
>> interrupt handle is not needed and could be removed.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> 
> I'm wondering what you wanted to say through these S-o-b tags.
> 
> I don't think you have to sign off your own patch again.

Yes, I changed a configuration in my git tree, something I have to fix. 
That has to be considered as duplicate SoB

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

