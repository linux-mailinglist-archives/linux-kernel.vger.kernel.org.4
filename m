Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF8460AE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 17:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiJXPJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 11:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiJXPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 11:08:48 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC43F52467
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:45:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id w10so245551qvr.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 06:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2+QOBJHHWEkUuBFr42Se70cWpXSG2GrMADo027oyw4=;
        b=twiVT3I/Xp04E/nPPYGkJL++4wpd7f6aO/XY14XrZuBQ6+liUVkxms0B0/ObKwxqVn
         ERYmgFExovKJTPtyoaKI9kGxUsSFk4yD/FrGV+dV8YLsKS/A+thiltu6Fk0k/HD3jmbe
         JH5F6e0vtSgQlFy0R5LeUlFKefZQOJ587B6fg/C7XagE5NZvLqMx1zplA84lLze6smOZ
         sN+FmFwyxo2UNpmwh+z3Km+i6e1n8kFSb2URVFpo4mSyCpqsqBC8WKDrsSAhS5vI/eez
         bf10JGgdBpC8Z697JNWXtQSWHbF7O0/UVJeddnrC6wp1igPhBkXHDjRp4YKG4jePeoEj
         WMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2+QOBJHHWEkUuBFr42Se70cWpXSG2GrMADo027oyw4=;
        b=zr3IVX2gJAm9N28+shyt1Djk0X/HAgSguZI21eCbQTw+D45iaz9h5MoSywlahO0l18
         cMZtq1Kz6Q6CeMv4bZjtMrXocvp29qXHGtBDogAUOIhIDVtOhxOBWgaezIxCIV8sIjln
         eyNfVzcnMcKicONc4mdfRXGF1DBB7xEwV62Gf+F3e/zJdAlZjNg9jr3wxhyi5WeLqo3I
         0UiVg35PJaSSd2zL8xYgutBynjA5SFJYws5wXJ+qmdvT6eC+eVkXVja50xtxmYmLmWEe
         rYDIreHeHxkpl0XWD9+LsuqFzdWejHGHlRnew998nrIaxYfoMIVQ8VDXy31unJh3t6t5
         eLvg==
X-Gm-Message-State: ACrzQf0LPBW83Y3NPe427gTWv077/I02T/nVT7Hwqd+crWirqPs4muFn
        j2xeyqIalRpCrW9E3H9mj2zHeQqNER26Ew==
X-Google-Smtp-Source: AMsMyM65K/QiQBmdOnqFxK02DN1KcRfzxU7Rx1KWoB8ExgLy5o+iiTxWE0tO74yK/1cqrwLKTai3Xg==
X-Received: by 2002:a05:6214:518c:b0:4b1:88f8:b6a4 with SMTP id kl12-20020a056214518c00b004b188f8b6a4mr27713895qvb.0.1666615224453;
        Mon, 24 Oct 2022 05:40:24 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id cf17-20020a05622a401100b0039c7b9522ecsm12839772qtb.35.2022.10.24.05.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:40:23 -0700 (PDT)
Message-ID: <1264967e-cf78-d7c0-c361-6013cb0ea238@linaro.org>
Date:   Mon, 24 Oct 2022 08:40:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 15/21] cpufreq: remove s3c24xx drivers
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-15-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-15-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> All s3c24xx platforms were removed, so these five drivers are all
> obsolete now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

