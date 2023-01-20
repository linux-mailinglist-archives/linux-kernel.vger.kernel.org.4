Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D83676053
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 23:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjATWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 17:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjATWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 17:43:43 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C7D63E12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:43:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l41-20020a05600c1d2900b003daf986faaeso4706265wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtLMDQAX/YK9HtOu1Z9v06OwTqR1lRLgNqC7/vxACsc=;
        b=T46csed2Nhq9XwzM3we2Jfb2clZKTRKljlMtsvqPHw5Q0zsHe4do7qhAdqwZEuXTrp
         jxi38P1OdcslMWdVMSihR0Rjkih0taAwWwuvfTXprBimserYz9pgbFvbROLn2Cr+Fhe7
         3ADg73dAwXJXliaSv/FIDeQvmdm4tH3hUiv0St7h5sA8n8KliYrjgCUkNe7uUHLBqBG1
         Dyl22AVts5DQFd6d/yaAJ78VZqkaELwzZW/EKZFBBBmrXWb9exTD1HUpQ6zDShi4iNrf
         G3OI+1vfoc8+oLeoeexjSs0deW62ZamACHSAbALnsWnLUW3p0+8ZKVQLKoW0SN7JB5Qd
         xEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtLMDQAX/YK9HtOu1Z9v06OwTqR1lRLgNqC7/vxACsc=;
        b=whcgM1wrhU+JWCTgMlt3w2IQkNrjgbrF9EaXgHZeQWDq7UEvr5zRWTDP9kM9wmiN/Q
         4xOwBCZpSinzU25+/e+zi0u8s+fcBzjUMb8IoYrwSONjX7HyuVWXt56vSiFQaCFY5Hgo
         bTLtDbMOpgxoGTc+IsIhYTLsCvj4atcBi1rWad+eY49i54+ieZWOtgkOvCmGrZP2Hy07
         63+P87xpA5AwHE0uV7glRN9Oxvft7Va/tSG77g+WsQiX/sMxell3FLGaYUiCPfpsEx19
         Yk+4c9QqwI0lC6gkbsNN2FL88rGMw17jL/L6McL6ZzTwb7IwmZvkwsv0TMHPGqi8T00F
         GNgQ==
X-Gm-Message-State: AFqh2kpN1K6cagkIVF+DMQPHm6xl0Xt77TaBCVD4jjunTVWdgHpUf4L2
        Cl556ukph2cnr0NXuiVtZD/rzg==
X-Google-Smtp-Source: AMrXdXu80icGL8ey6l0/W9ZOqaGxphD9S86JFy5cjw7ZTIc3Qm4Jfm4RRFZtslY9rOhdvK9FsUkg1A==
X-Received: by 2002:a1c:4c0a:0:b0:3db:210:6a24 with SMTP id z10-20020a1c4c0a000000b003db02106a24mr15188096wmf.8.1674254620497;
        Fri, 20 Jan 2023 14:43:40 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m2-20020a05600c4f4200b003db0ad636d1sm3953996wmq.28.2023.01.20.14.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 14:43:40 -0800 (PST)
Message-ID: <999011db-32c0-9f75-ca63-09f0e51c5df1@linaro.org>
Date:   Fri, 20 Jan 2023 23:43:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 1/2] driver core: class: Clear private pointer on
 registration failures
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <5905717.lOV4Wx5bFT@kreacher> <4463268.LvFx2qVVIh@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4463268.LvFx2qVVIh@kreacher>
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

On 20/01/2023 20:46, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Clear the class private pointer if __class_register() fails for it, so
> as to allow its users to verify that the class is usable by checking
> the value of that pointer.
> 
> For consistency, clear that pointer before freeing the object pointed
> to by it in class_release().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

