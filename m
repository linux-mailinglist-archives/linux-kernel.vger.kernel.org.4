Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D8C7297AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbjFILBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjFILAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:00:43 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA64210D
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:00:39 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f6283d0d84so2009290e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686308437; x=1688900437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KaxH2G08x0WAm5ZDxnuF7caGceTezG6e/vkGlzD414s=;
        b=a3neumajdkAyMb15L63ptOnt1mlLv3WhJc3hGuRd43eDHSpnHN7hU2RIv0M1JY/p/I
         tEbpVocNiCe6k8jaSsf1aDaysgtMqa+M2swPgrE//HcWFKAJfU0t96gNzkNtORJttPJz
         HeThlJ9N78kjskmvyC6bFm6+7pPd3h0gbZXrJe9y8GW+lypUSecMdzLMTvgP25UtcnpG
         XVTsam2/9pI/TE1nyngC8l8cdhzBhHHR296SaD4i/UFsepVfjOYT/889AKV6mn4aKA6l
         X7EOdzOyn0JF3LfiueCz62cm0SOaqJXdwUjMWDjWzYSN/1i9QeqCFkePI4IARbxcap9r
         G2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686308437; x=1688900437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaxH2G08x0WAm5ZDxnuF7caGceTezG6e/vkGlzD414s=;
        b=KzD1J1vJ9/+nyqEDwahKZBm7xe8pTG++l4zdxCVI3mkUO0WjjXew/x/LvsNVuO4GvE
         cFn3fYypiW5XqN4AC0olXygWfoEjvOwsTIW2G84KB2mzGqJMbkzALoaVISo2b5jqu0WX
         vlYBB6JWqtpYw/7SeNxAJQOjJ1dbnsZUPrn17+Z1spMao0GJQBEpVMLHqVMoFkor+nYg
         +0EhH7EJi1K8Y0pJ+NsIhqSQW9FmPYlT1Z9QFv7ViWzJo9Sb01qcj9dy8GqFEScNx0YB
         TzcxwYnCFh4J9rgw51TjmSb15pY+YWVAiKATHo6h778w8+rTUPLXzkbYrYyOi6m1H6+A
         fcgg==
X-Gm-Message-State: AC+VfDya0RuO7OpWOELTUw5/H+7plI0Zew1C5aemMdIvTJnnQqKOl0pW
        Au91K7M60eFkj/fR4o2Reus=
X-Google-Smtp-Source: ACHHUZ6DlFnc7GqAChxOFVlJtig9rh5wYWfjNZBo3GpULaOnlCfBwn/wSKWoW/bX0T3GHOnukt1LhQ==
X-Received: by 2002:a05:6512:32ba:b0:4f3:b07e:7eb8 with SMTP id q26-20020a05651232ba00b004f3b07e7eb8mr661403lfe.29.1686308437165;
        Fri, 09 Jun 2023 04:00:37 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f8:1500::1? (dc78bmyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::1])
        by smtp.gmail.com with ESMTPSA id r16-20020ac24d10000000b004ec84d24818sm513424lfi.282.2023.06.09.04.00.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 04:00:36 -0700 (PDT)
Message-ID: <58edb40c-05de-a355-20f9-2636d00169ad@gmail.com>
Date:   Fri, 9 Jun 2023 14:00:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] regulator: Use bitfield values for range selectors
Content-Language: en-US, en-GB
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230608075651.3214540-1-wenst@chromium.org>
 <c9947378-419b-cd35-73fe-aa1564340d2b@gmail.com>
 <e78127b2-4c00-4fcd-b829-7a9d465ad2e9@sirena.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <e78127b2-4c00-4fcd-b829-7a9d465ad2e9@sirena.org.uk>
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

On 6/9/23 13:53, Mark Brown wrote:
> On Fri, Jun 09, 2023 at 01:45:15PM +0300, Matti Vaittinen wrote:
> 
>> For the helpers.c and bd718x7
>> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> There's a v2: https://lore.kernel.org/r/20230609075032.2804554-1-wenst@chromium.org

Right, thanks! I replied to a wrong mail!

I'll send the tag to the correct version.


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

