Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A136D33DB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 22:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDAUkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 16:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAUkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 16:40:06 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E292703B
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 13:40:01 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so15880165wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 13:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680381600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=54WZlKFOH7z5ow1TMELZBNq0Ok+OKChGqnAavsTIt50=;
        b=Zi6RFMmsqxCOCubKiabzmroMnsnSzzswgQogx2DJo7nlLLcHzNFfMrQddlDKYNaMMR
         yXrp55GZvc/XtcGNMVmYP/GCiTroSWzEhO+IHGFbz8hYP7MtBK/r+7Tgnq5UKC3Dyr0b
         yDlTqS7Yn2qu6zn5MUIi38OHjc+vjL3DLRs1XDoOu4koZ9hHgIbUHV6PaYHWkYwqgmE8
         z37ad18320vLGNnWT3G9cyrTp1zxRkDz7Zk6T2sc0ChlugqjtKV1NFAHB4d+ByC1FrGp
         fgwB7za1HTwoMHJ7abtg8Y8OwaRbXhqg4KxHnRjx8Z7ztY0WU7hmGC53nS4du9cIEEVL
         2fRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680381600;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=54WZlKFOH7z5ow1TMELZBNq0Ok+OKChGqnAavsTIt50=;
        b=AAaGepeF+iSPZMSn1RqLmGqWYd+Z24QfVpZ38ixeIEnOZIF/xbv5TcCu6D2rl/cvUX
         WeXYi5C7xOO5cqDwJ5Qt0wUkXtUtCP6N7bQbDSeLjEK7YOzAJV8NCLm5PuG1bIw4dbxI
         eEF43T1x/9tRHN8BR2RWXF5QUesSTGnfDayWLEm6xXC7pu6MlpIscq7knE4z5X2qjz9r
         Atd4dNaB2pk8DU/4qzUG2R3gjWa37icIJykMCk8EafVznI2unidY4uYfnX8pMOGgbPK+
         Mum7Tq+y97jZkIWttD6z0UWaOQJ6B/XP8wvgQCNDXFS5j7IHUEkvV/FyhfuZ7s172dS/
         3IJA==
X-Gm-Message-State: AAQBX9fV5pKLk1k3RN0y7emFtvXZftZ/v/u4yo9nDvkyW0DwivMX/Vjv
        mhwMoutQhcgYMOpjxv3QCuBcoQ==
X-Google-Smtp-Source: AKy350agutLAusoP7ESlN2zNEl/9Hx3qYZ9lnD2QfxKiwZHrGUaPAddBOpSu0Jn/T9RctFKUwc2U6A==
X-Received: by 2002:a1c:f207:0:b0:3f0:4f83:22f4 with SMTP id s7-20020a1cf207000000b003f04f8322f4mr83242wmc.20.1680381599641;
        Sat, 01 Apr 2023 13:39:59 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:b36a:1186:309c:1f9a? ([2a05:6e02:1041:c10:b36a:1186:309c:1f9a])
        by smtp.googlemail.com with ESMTPSA id m9-20020a7bcb89000000b003ed4f6c6234sm7078132wmi.23.2023.04.01.13.39.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 13:39:59 -0700 (PDT)
Message-ID: <93922fdb-331a-15bb-514a-2015e65ee4c3@linaro.org>
Date:   Sat, 1 Apr 2023 22:39:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] thermal: amlogic: Use dev_err_probe()
Content-Language: en-US
To:     ye.xingchen@zte.com.cn, glaroque@baylibre.com
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <202303241020110014476@zte.com.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <202303241020110014476@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2023 03:20, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

