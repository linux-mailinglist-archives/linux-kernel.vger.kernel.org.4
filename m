Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C502467AB41
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbjAYH6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbjAYH6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:58:53 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FA545BF2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:58:51 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so630520wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jC6pU+sGbtpoB7ethShoVXn+Chr0YG8N/LtDw3sEIK0=;
        b=Lfvx+d6cL/XnfSt7+z4Ob5aulUk0jxtb56S0J4kri453gt+pmKjnTQlmYSEeC+1Qxv
         +Y0qb+1KqO7YMETgUHSjAh02IDtT0PzDeEDWEefvDvE7jXvrBqw7wqDPs31YJROI4kbd
         f2j3AUMXIoENJ7cyjZ0Rg11tMkUIOkUgEhIev4KCj/mo4iCJLzR4ZJqlMzBvUqU6Nih3
         b6zdRMlty83RFfXyiDrFmZ9ehtWQ7HV7jfNrHZaciYHTnKJ3OvFm+b+N9otCmpqjIVLy
         r/Xao64KM7miZvRWr/vvB0j1uDb7Eohbkg8s/lO0oeZwNqIdXQ7vNTDPtjVyeeoO2MCr
         KqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jC6pU+sGbtpoB7ethShoVXn+Chr0YG8N/LtDw3sEIK0=;
        b=fxNJatfuupR9fOTusrKzEiBERXGqsyZl6Do6oG18BJ/6h84nyY3U9o8ApVw4y71YRW
         hf3OFNj54A67TUcIvGuvjOWnDVFuaiPCflUGCXaiUElKK3tbqkmtXTJsCFKsFEZfC2aW
         Ka17eKEy4SzTeTarVsSlBMXEInUD1u0UATJs4SrOfTotgk8SMw99IdSrImXBSxd9BVNf
         jMELRglkdahWe9vvOrpa/z7TTKID5bR/Yz/4OBXSISI5G51mvRCDejDWyeOxw3PhfRyu
         dB+pIAgxyzB7kb1le+QTdVtmpKM5R39wa3Gz1RyeV88wacYT0Velxgf+6hY4NPZPNCID
         Vxzg==
X-Gm-Message-State: AFqh2ko10mVKXt7Ab46gwepsghIhF3nVzoZVvZt2iBv/T/RusqsxFw2v
        MN7jfIxiX0Ee7G+Zp3mbxJ9img==
X-Google-Smtp-Source: AMrXdXuDMs4P5amijj2D20nKFk7M/g6g2ayWIBrOteD8b+TEV46COKKWFpqjcchSxNEGAmR2v+HcVw==
X-Received: by 2002:a05:600c:3d14:b0:3da:f793:fff6 with SMTP id bh20-20020a05600c3d1400b003daf793fff6mr30419532wmb.16.1674633530203;
        Tue, 24 Jan 2023 23:58:50 -0800 (PST)
Received: from ?IPV6:2a04:cec0:11f9:b9e5:f1e5:d9fa:43ee:3db9? ([2a04:cec0:11f9:b9e5:f1e5:d9fa:43ee:3db9])
        by smtp.gmail.com with ESMTPSA id g23-20020a05600c4c9700b003d358beab9dsm975568wmp.47.2023.01.24.23.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:58:49 -0800 (PST)
Message-ID: <f4f33c59-73d2-4e82-fc07-adc21b22384a@smile.fr>
Date:   Wed, 25 Jan 2023 08:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 0/3] Documentation: kprobetrace: Improve readability
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        bagasdotme@gmail.com
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230121225304.1711635-1-yoann.congal@smile.fr>
 <20230122083138.300ab49e15c7b3de13f0f121@kernel.org>
 <20230123103341.56f42e72@gandalf.local.home> <87v8kvfv8e.fsf@meer.lwn.net>
From:   Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <87v8kvfv8e.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/24/23 23:01, Jonathan Corbet wrote:
> Steven Rostedt <rostedt@goodmis.org> writes:
> 
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>>
>> Jon, care to take this series through your tree?
> 
> Done, thanks.


Thank you for ack'ing, reviewing and merging :)

Regards,
-- 
Yoann Congal
Smile ECS - Tech Expert
