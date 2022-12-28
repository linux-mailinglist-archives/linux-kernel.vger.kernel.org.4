Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AE3657380
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiL1HLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiL1HLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:11:10 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5149BE26
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:11:08 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id bk16so964090wrb.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoevkCqm0C5XWODDQxiTKlCd9+LFUjRXCitTr69DptE=;
        b=uquiVL9NoYOszkI6bFc7kKQ24G0gAWYpSyGFNLCpco3sci1FSm+lJmoz9FHastz+7W
         U7kNSmACNWFQfonyKWbOpBg3Tfy7gkWkPTsSwzb1fpgPujs01WTbcl5S/0dkPz+xVYkb
         9CG+UoORXOA9XBJLngiNVW1EOh9PdQoh7Y6KJ1xz83uDoTSkFF3fW/T5yEIr6w94vLg5
         B3O6pAlokeHugK/VYHd+1c0vNzRyUn9dv4x6oq4xT6sx7Z6O7eecFAPZ1kTWxtrhdAHg
         BPbDQEP8vMH86Z9BtSOySt/qyvLIT+ybMSKwepuzQnqfkvjuDOMp59YQkW/au/AAHqO4
         7a/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoevkCqm0C5XWODDQxiTKlCd9+LFUjRXCitTr69DptE=;
        b=MWePRRQk9YRJ+4KZOtV+xDKAfJC7lbMk58803JE0xaUxFQ+47+FX9wPB6XoIy3VXf7
         KdOF1Iwt7kAzUzihaOkrU74qizxzU7d5X0Nid/SyaW/FB0Y1FQfk2T+MubIkJRBfXJYq
         +Ia2NMh4hhQ0WV+4WXKDpyw6rzhrlH6ovN2673LAmeyNTnER7xVZ0kRdmCq7dE0JQJ9L
         nUvZMbwWI3mawxeIwClHC9PYj2oSCnbH2/uchdxm5D8OTuwmZcStwTRMAv4ASyOqwJlP
         IyDqbfH16P2H6IXhXJPgwtsFp5CTMg0kP9NaGqx+4WYBnR9XmjBTuWVLNeNfzAi5YhLf
         QWEg==
X-Gm-Message-State: AFqh2koZ2hPxu6thpML7yzQwq2ardkq8qWCmDmYuXjJuQHZydgE+v4j3
        LXjbT+m2jB9sYqMoZdsZJqoOUmouU/56/kLa
X-Google-Smtp-Source: AMrXdXvbxe80HMxQjahLobDGkaTAMYMLKpxTJYeUbPE4yE/3SpjMedOXnc0L41IobhefT19PF0eBjg==
X-Received: by 2002:adf:d4c7:0:b0:25d:6628:debc with SMTP id w7-20020adfd4c7000000b0025d6628debcmr15680346wrk.10.1672211466922;
        Tue, 27 Dec 2022 23:11:06 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id d12-20020a5d4f8c000000b002421a8f4fa6sm14107330wru.92.2022.12.27.23.11.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 23:11:06 -0800 (PST)
Message-ID: <0acebf30-59a1-c336-1a44-19a74b4f244f@linaro.org>
Date:   Wed, 28 Dec 2022 08:11:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] remoteproc: virtio: Fix warning on bindings by
 removing the of_match_table
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20221005081317.3411684-1-arnaud.pouliquen@foss.st.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221005081317.3411684-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 10:13, Arnaud Pouliquen wrote:
> The checkpatch tool complains that "virtio,rproc" is not documented.
> But it is not possible to probe the device "rproc-virtio" by declaring
> it in the device tree. So documenting it in the bindings does not make
> sense.

Perhaps reworded a bit as:

   "Since it is not possible to probe the device "rproc-virtio" by
   declaring it in the device tree, documenting it in the bindings
   does not make sense."

Otherwise:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> This commit solves the checkpatch warning by suppressing the useless
> of_match_table.
> 
> Suggested-by: Rob Herring <robh@kernel.org>
> Fixes: 1d7b61c06dc3 ("remoteproc: virtio: Create platform device for the remoteproc_virtio")
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> ---
> Updates vs previous revision:
> - replace the "of_platform.h" include by "platform_device.h",
> - replace "Fix-suggested-by" by "Suggested-by",
> - add Rob's Reviewed-by.
> ---
>   drivers/remoteproc/remoteproc_virtio.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)

