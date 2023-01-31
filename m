Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51111682D87
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjAaNPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjAaNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:15:15 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06F61968E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:15:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so14152255wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1l1C1QoOBbN/O2rldGTzUvhpgO7w1nK8eIYom++tGNQ=;
        b=cW49nxKugLsAjaxCdj8GGNGclu8Bm3//fzksB/z8oGDBrOjLH+H0PLhzjSF69Nj+Vz
         xWHnqorRHdGskWOQV97qFLLZzuADCPVkMoFUwxQdpyRRW5c5rQd+MwUMjfrIBqXRHy+V
         sSWgo7XjyVauSd9OtnPofRkgBAgURz/cJ7i6z0mkq5VPCYf6cgzuSY8RjoOcbTJ1q9Ds
         vmG8rTdieGUn7e7ZxZaoPtmxr73jUa71XRDvfjxKJQYfcnKBmIceOyt+R9xyqsKBtgK5
         f9BjV+YUADLdOc5Xg9w31YJbr7HeudtUftFMMmwYQZfXyFsLFRuYtoMqVIY4hMru80yY
         evsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1l1C1QoOBbN/O2rldGTzUvhpgO7w1nK8eIYom++tGNQ=;
        b=Trf0F2ttToe7MlLuaumZvxihYCR035Hs8VTOgMsZj1rNpwpeuoL9VFD61oXmctAoSE
         mVy2ggG5mjWjSqhLnrQH+F/G8Fz/2AG9MwBbQn4hXjtPtn/OnLBbOQrnrY5udzvQd67M
         fZ08xtaxqqTmWzV9tm8u8CsgFAp6IUrIosCCkanPTNXjsukMyVCIVpvencBUhmXqBFZT
         s1JKen4Xf7umdh+Qu70f6RbSAWZpGY5y1fo1QG/GBdIOYDj9JC4exy9ju6DGNiBH7pwd
         BVYLeLOmUTrcqYQ7VhZh+fiQ3s5c+Rrbz1FTUfz2SqmaXmLCvpsq9gcKxxBdzEXO9F4A
         Nrpg==
X-Gm-Message-State: AO0yUKURLDcpDbdqYe5E2Lsh1Ji8E22Gl07bnICjvk3xmMpJgVBJFG7L
        JmUtC86WDK+bHNsbcrMztUQeLQ==
X-Google-Smtp-Source: AK7set9zPCp4WfWxSitGl+AlAs04Hc4gL3diB7Y8saIo5VMYf06/YuAsIjWWE6G+zaBz8mzToMvlNA==
X-Received: by 2002:a05:6000:69b:b0:2bf:df72:fdfa with SMTP id bo27-20020a056000069b00b002bfdf72fdfamr3250223wrb.40.1675170900303;
        Tue, 31 Jan 2023 05:15:00 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e4-20020adfef04000000b002bded7da2b8sm14722781wro.102.2023.01.31.05.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:14:59 -0800 (PST)
Message-ID: <c82c6308-2b32-fe19-e40b-5853544e1c9d@linaro.org>
Date:   Tue, 31 Jan 2023 14:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] thermal: Drop spaces before TABs
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cda2b9ee52a49fa3904d209097754cd757728a4f.1675160668.git.geert+renesas@glider.be>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <cda2b9ee52a49fa3904d209097754cd757728a4f.1675160668.git.geert+renesas@glider.be>
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

On 31/01/2023 11:26, Geert Uytterhoeven wrote:
> There is never a need to have a space before a TAB, but they hurt the
> eyes of vim users.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

