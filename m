Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A448683A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 00:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjAaXli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 18:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAaXlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 18:41:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71191043D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:41:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso1689837wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 15:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWV5OYFF459oJ2/z7E35EGvnCYe7cAXusgq2bgmkB+A=;
        b=roZSeiWoky3dz3Z3NWXD0n1cvpB73ZRK94dppvaulHr+FiFgUdVcCP4crTJMGQaOgV
         Y30bc5qj4Iyd2poLJHYq8eYla6syx+6PBwGcqqf6galUq/yV5QHcqGPtj/I9SoL07g8y
         CW2zIvJPxdzTXpfaZ8Ub+5gUinWSwxciyRw0vrBV7xsLLNZT6f6ciBwQNCVxjzkD/4nt
         V5M7zXHK3arqZxI0gsLyZHEfcSkyePFiPMyCQq9bbVFh3+B/dOwMh92crcdIh8Chlffi
         fI35dyqe2M7K/MkDtw0DiP5lyzupDXFlWxHoNHD4j5Vsz1hch56hiVV1svwoHTtMs/fd
         SWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWV5OYFF459oJ2/z7E35EGvnCYe7cAXusgq2bgmkB+A=;
        b=mnLD15xLSjwSptYDwuauuh8K0RVEu3mBOek58o9+cUT857g0vYpcGAJkbnOu0q6TQX
         w8n8IgE94qYAK88UGVzpYqvbTQqm9N9tfGS95j6uSsjTZkgcAOneEjEhPWb44l6j+Nu8
         k7GNiENYQhyYAOgW0ZcPOFat1/qkzN1LnHlSBnHP3G6NqGigtEd7LIxF1pQY443Uqppv
         9tRHc5UGNEPX0l2hIBICITHzc+raMzYoNRz8qY5P70eiGP0Grv621pBXE0M7vjsOPa95
         YsAPV54JqgHjEDrFDujQ4qQ2XXAHzu8rDFePPh7zs7XefKBDqzlOoOBoF1SSNWPc7dSB
         I6Yw==
X-Gm-Message-State: AO0yUKXZByD+xYjJsapDQpiOM02Sc2MsNN2O0aJewbACarDz7fFelgSR
        1TMV/yzzxwpxKqPXW2AGX4d7yfLISwokc86t
X-Google-Smtp-Source: AK7set8+35nC8Kne8FwFBkJd/UCCcjwD+41FNvVpIO/4oAPoKIQtZHtrMPv9hGmyF/Rpb4bqd+sc7g==
X-Received: by 2002:a05:600c:cc9:b0:3dd:1bd6:3839 with SMTP id fk9-20020a05600c0cc900b003dd1bd63839mr26068wmb.24.1675208494048;
        Tue, 31 Jan 2023 15:41:34 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n17-20020a1c7211000000b003dc3f07c876sm14732150wmc.46.2023.01.31.15.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 15:41:33 -0800 (PST)
Message-ID: <68dde5cf-e02b-fc90-f331-091065f019a6@linaro.org>
Date:   Wed, 1 Feb 2023 00:41:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 8/8] thermal: intel: intel_pch: Refer to thermal zone
 name directly
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <837557782.0ifERbkFSE@kreacher>
 <03b7e4ae-04b6-42ca-cad0-7828797f7bf9@linaro.org>
 <CAJZ5v0hgAsh9FQBb_X+1sSqAwjt-E6rKYO8Y8ue_6GmjwLy-Qw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hgAsh9FQBb_X+1sSqAwjt-E6rKYO8Y8ue_6GmjwLy-Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 20:20, Rafael J. Wysocki wrote:
> On Tue, Jan 31, 2023 at 5:02 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 30/01/2023 20:07, Rafael J. Wysocki wrote:
>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>
>>> Make intel_pch_thermal_probe() use a const char pointer instead of
>>> a struct board_info one for accessing the thermal zone name.
>>>
>>> No intentional functional impact.
>>>
>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>> ---
>>>
>>> BTW, Srinivas, I'm wondering if user space would be terribly confused by
>>> changing this driver to use "Intel PCH" as the thermal zone name of all
>>> of the supported platforms?
>>>
>>> ---
>>>    drivers/thermal/intel/intel_pch_thermal.c |    6 +++---
>>>    1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> Index: linux-pm/drivers/thermal/intel/intel_pch_thermal.c
>>> ===================================================================
>>> --- linux-pm.orig/drivers/thermal/intel/intel_pch_thermal.c
>>> +++ linux-pm/drivers/thermal/intel/intel_pch_thermal.c
>>> @@ -175,7 +175,7 @@ static int intel_pch_thermal_probe(struc
>>>                                   const struct pci_device_id *id)
>>>    {
>>>        enum pch_board_ids board_id = id->driver_data;
>>> -     const struct board_info *bi = &board_info[board_id];
>>> +     const char *zone_name = board_info[board_id].name;
>>
>> Assuming you will change 'board_info[board_id].name' by
>> 'board_info[board_id]'
> 
> Hmm, why would that be required?

I meant board_names[board_id] (related to the change proposed in the 
patch replacement below)

>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 
> Anyway, though, I'm planning to use this replacement patch instead of
> the $subject one:
> 
> https://lore.kernel.org/linux-pm/12166249.O9o76ZdvQC@kreacher/

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

