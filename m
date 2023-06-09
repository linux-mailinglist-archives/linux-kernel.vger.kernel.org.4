Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACF7297B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbjFILDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239205AbjFILCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:02:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 957F71FDC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:02:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4effb818c37so2052431e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686308567; x=1688900567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uf9IlnNboHNw68KxEZiobWWHHkMEEH02B4vLkNnCDuI=;
        b=QTHGncz0AMMxIWO+o/VLHhOxaKw1LM5zQIyh36sAgmHehobJMV+0I3QNd89OocTWVm
         IIxquhCIO68etEv4cFZvRp5R1sH5xu/dVRlhPsbdpl5bdy31jb291LlbppXgn60gVhFV
         sWJnbCojxAvQMdr2lutQQpsC2dR/Gd/8dCByNatU17ZH+pzryIcjily5tHU+KOTnqvqW
         7KB3PFjLd53YODoCcPg+wY2EjBq8vssKBJtiPCNCXP3crJhyr4KStNR/ShYtzhdmNplv
         dp8BZjcZOycGWvfyMc6Bal275FzIffYMr9aXx/Z05sW8aL7OK58vFynY+1c7HH22JOZG
         WrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308567; x=1688900567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uf9IlnNboHNw68KxEZiobWWHHkMEEH02B4vLkNnCDuI=;
        b=OmdJmMxQ71seO3frkYRuM40ZDun6YQEEjZvbMRaEqOfK3EHTDmKEej/zz08RMHzsqo
         aZRUiQmyA7d5mqqQWhOll6dsSreTWuDjT6oW0GcgXW18NpMfbORv6BUPg1JIoSqh03d7
         DswtxmqqFPE3dyfnNviZ0XNphdHKrQCcHvIvq+NyYYFBJNe7Gw7F6+hufPrLo9mVMJA8
         U9ur1I4uIeKyXTveRS4JJLummZiMQ0NUiSpWcaS/aqTWnuiln80UHfyr9T5xp4AfSz6Z
         kkghyhzjUWKFBjtgoBYV0mb7bhvl9q+b1LypLmiFGKN1veMct4ZYW3q7YBOeuKb2e6Oy
         lsEw==
X-Gm-Message-State: AC+VfDzkY0gusbM9kNCD6ZoqsddBXJFGzJIhckzl3LtKVrydXverDWyf
        bCsSXdlX3vvXC+kdFLwNHBs=
X-Google-Smtp-Source: ACHHUZ61YMaPK4rDUyGsa95+60Q37n/0fH4tZsmHWDRI7c3Iw+h66t+XkICf2vG7dzMQMxwsZShOrg==
X-Received: by 2002:a2e:7c01:0:b0:2b1:bb66:7b54 with SMTP id x1-20020a2e7c01000000b002b1bb667b54mr870620ljc.47.1686308566716;
        Fri, 09 Jun 2023 04:02:46 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id j15-20020a2e800f000000b002ab017899e8sm346499ljg.39.2023.06.09.04.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:02:46 -0700 (PDT)
Message-ID: <f40e9e7f-d655-be0d-3cdf-71c02614266f@gmail.com>
Date:   Fri, 9 Jun 2023 14:02:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] regulator: Use bitfield values for range selectors
Content-Language: en-US, en-GB
To:     Chen-Yu Tsai <wenst@chromium.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230609075032.2804554-1-wenst@chromium.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230609075032.2804554-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 10:50, Chen-Yu Tsai wrote:
> Right now the regulator helpers expect raw register values for the range
> selectors. This is different from the voltage selectors, which are
> normalized as bitfield values. This leads to a bit of confusion. Also,
> raw values are harder to copy from datasheets or match up with them,
> as datasheets will typically have bitfield values.
> 
> Make the helpers expect bitfield values, and convert existing users.
> Include bitops.h explicitly for ffs(), and reorder the header include
> statements. While at it, also replace module.h with export.h, since the
> only use is EXPORT_SYMBOL_GPL.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
For the helpers.c and bd718x7
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Please ignore my tag in v1. I accidentally replied to wrong mail, the 
tag was meant for v2. Thanks for the heads-up Mark.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

