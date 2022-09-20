Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4C5BE096
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiITIqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiITIps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:45:48 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F16454
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:45:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n12so3041425wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=7sTQyK1rwCsb942/R+/uEJKJqgm35TdHOkR/e6Qsq5k=;
        b=pYrXQHeDZyg+iFLPp2Ley57gVQjwsCkopd5fG97xP7zZpHXeuPPYDHIRTibmSlcZFZ
         0VtTnrpW7l/9adWhHrEm/NS+LasZdJ6+6cazF+n7acefuls+qCn5i6q6K6OtEJk9PG10
         O/p+rQZxaA7I8yGvIlLX+PyWma5NYcrOAb9u45qZrobjLA0HWXKBwuUXNGAgEbyu7sJ7
         t0IqkJGaUteJDZFZ7PS+mdJlfLFjvSVBJ3nlGfb5x2Lf4FnKtqP+OcQv5exf9z0PAPnp
         bvmPTo/uB5ThiN8U6tbtmR4YlGxdqr+TLmWnimD+yhK/3lyEPotjYhtoc/odeLy8hYUf
         iwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=7sTQyK1rwCsb942/R+/uEJKJqgm35TdHOkR/e6Qsq5k=;
        b=zVkGOUKkLhADLBrHNbkHoDLcmbW3AKMIcH5oh0g3QvY1recGIZ8wASAQxTcA3apASK
         dnOKopOj3aGgNDaZLpV0mVhEEO5xcHGKiPYG63M5HAjgLZUEcXPIp4jyvF0+EHoB0hhR
         NQFT0EcP0er86Wr4ghmQ4L27LfhUyhsuHROVdB+BTGoL49Yane9ee2epU5eCuu6TUNSJ
         mIBckAee/J3X4QOe9+QNnHaAuKndIdpiMkebv6XoTcJfgY3rVbeluLnJ4d/9R4MLQwug
         GQzSYePy609bmNY04qd0LbYTK9NNhYg70oORe3lN6XHnc1xQ5er+CDYS0jZ4fzHCkaRq
         Mcrg==
X-Gm-Message-State: ACrzQf02gq/sBrexFXhy1oByNHQqODH1QhYxNR/22gO32mzeIMD6OxmO
        oPa743FqMIjl0EyKBqc7cYiYSg==
X-Google-Smtp-Source: AMsMyM798er1BHO93Z4qMl0gWbe3B6jrQXYQeLyCe52d4x4iorkEh5RfijexCYU8KQ2pyKtJ40MXEw==
X-Received: by 2002:a5d:6609:0:b0:22a:3965:d5ad with SMTP id n9-20020a5d6609000000b0022a3965d5admr13433047wru.62.1663663524783;
        Tue, 20 Sep 2022 01:45:24 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bx23-20020a5d5b17000000b0022ac12fff29sm1030179wrb.65.2022.09.20.01.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:45:24 -0700 (PDT)
Message-ID: <f55faad2-737d-2ff5-1f68-14a41b1dd500@linaro.org>
Date:   Tue, 20 Sep 2022 10:45:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] clocksource: sysctr: add nxp,no-divider property
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, tglx@linutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
References: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220902111207.2902493-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2022 13:12, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Legacy design used in i.MX8M* has a internal divider, but new design
> used in i.MX9* not has that divider. So add a property to indicate
> the divider exists or not.
> 
> I thought to extend the binding such as nxp,imx93-sysctr-timer, and
> update driver to support i.MX93, then no need to add nxp,no-divider.
> But this means we need to extend the binding again when add new SoC,
> saying imx9[x].
> 
> Not very sure which is better, so just post the NXP downstream way.
> 

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
