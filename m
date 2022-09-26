Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437A95E9D94
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234799AbiIZJ2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbiIZJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:27:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F17945F5A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:26:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id w8so9823850lft.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SAs267zzkbZc8WXFYLr/NLR/iCCUVjG9YIqyHkZX/Zk=;
        b=hhXgOHUdjqAAlSP04nrr2Wx7nQlNPh0efaR4V44EV2KFGJpduR/nACiFSOI+4Rzttb
         jpF1ltjDuIKOQg5YtQlR1YLiQJp3utaBj3diZ0Tskw491stWiVmsQCX85nFHnqx6NEt3
         dWMcIiSG04Yt49LN97N7TPXLJ996LwLWEK2zcP7Btfnvx3u8jdNsZaUVC7IbO3D9ktHF
         yOXDUKPoORPLqeEw0TShlX1VVjNfRxmRykS1nR4+A+XRuGAD7mI+WcKGZtauVagig63Y
         l6vGBHAQ4P0Z72SinKjZrGLOgBjHOZeUqXaXghCx5ek+MnhsGrKnexBJjv5dyZhzUogn
         0/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SAs267zzkbZc8WXFYLr/NLR/iCCUVjG9YIqyHkZX/Zk=;
        b=gIr7KZ3v2rUK5cSW8Hvpg2wRi0MWCaXCRsn4gUa4jldzWlAjtEp292yit2SGGkZJ/r
         cjI+zb2Lsr4cpI1+BlA/ZNiBK27cSKB6qMnUEJBJtqi599JCU1JcutinK8Mr+p7z59pE
         tyord75cFPQz+wVkv0WgiPcSrXb4OH+BKrn/5oIZXqs6akuMZZHTmToNEWPNDpjkZNJv
         4DuzvC0T2tm6waItns2Ru7Hbgl/uiSXmVu+Wq2r97rMyrz+sAsNDoNvGulOd5pC8IpOV
         sK0eCGaYxu2fGIUL8qEWoCXk+8vq2djNEhu0U/F3MyKJRH1ukxAjtbIog/HX9PXOlI/C
         zkCQ==
X-Gm-Message-State: ACrzQf17eJro43zaTmAN4YkrN9molnt2zOPlxlCyYqHPXEBrbR6DyYdd
        todoYA26YFGTskXw5tblfsZ52Q==
X-Google-Smtp-Source: AMsMyM6TM4H2oxAb/1+bR6Nlgblj7yh+5ZedUKvDNsHUMQz23Pc6t8DMhBXAdsbtgOiL/yb97Z16bQ==
X-Received: by 2002:a19:f80d:0:b0:49b:29a8:db54 with SMTP id a13-20020a19f80d000000b0049b29a8db54mr8185541lff.178.1664184364894;
        Mon, 26 Sep 2022 02:26:04 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s11-20020a056512214b00b0049944ab6895sm2469978lfr.260.2022.09.26.02.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 02:26:04 -0700 (PDT)
Message-ID: <55ffb305-950f-f482-5033-1d4ab1bc7eac@linaro.org>
Date:   Mon, 26 Sep 2022 11:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/4] memory: tegra: Use DEFINE_SHOW_ATTRIBUTE to simplify
 code
Content-Language: en-US
To:     Liu Shixin <liushixin2@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20220922143344.3252585-1-liushixin2@huawei.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922143344.3252585-1-liushixin2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2022 16:33, Liu Shixin wrote:
> Use DEFINE_SHOW_ATTRIBUTE helper macro to simplify the code.
> No functional change.
> 
> Liu Shixin (4):
>   memory: tegra20-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra30-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra210-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
>   memory: tegra186-emc: use DEFINE_SHOW_ATTRIBUTE to simplify code
> 

Any review from nVidia-interested folks? :)

Best regards,
Krzysztof

