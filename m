Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9CA5EF70B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbiI2OAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiI2OAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 10:00:33 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01FCEEEB5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:00:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q17so1631954lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 07:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=X4udh+F/jTTPAawHj+leYFUcEjOK0Up2+V5M2hR8VXE=;
        b=VjCYChWjn6iy+G3yVQ6tZ5L5GrU7JMx6AFQ+ZIwJs9EqJdAQec1TweUcsCGbcL5zbN
         IcYXCI9pbWIaq3GI3J98z7m8bU6Eg24TmmlRaBm3jWe2XdtHETo1oLcp8UAHlG2Ff7jY
         0nNtDetj7dDIdFNbbL1Pu7gFgvUcjrHf5auaM7kzTnxn8WGUuCdjAUPu9CQEBbD5QQLl
         EC91SUJqW/acBbe94NQt+/gD5IiMV6nwTx1Q+Hrr0rHdVRS9waYT7ZMQsRfHsPZwE92B
         fq+roLKRMKkFs0p5Dp6D3rH9Pql0spk3ObhDvl+0pHJMAOKdEN2L63cgu49/aN6W/BR7
         iThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=X4udh+F/jTTPAawHj+leYFUcEjOK0Up2+V5M2hR8VXE=;
        b=chPniWMsUZ+mQm+T/KoYGYktkOJk8jWfpEMGyKcv7OtHbybok1W4GWgvKHQU43dcMq
         p5vBum1odBv2HDUYEQ+dhDGf8wUp2HTuMP9aLvdzph4hLbNmvCm3TBU0GjEZP9Py9rx+
         MS4LyDZBjB+vdxeXIuoEomDVxNsPdEc9aaMy5D2ozfcRPtESlwPhvYoaos/3hxovbvvl
         QiaJKAeHTw3MDz95gxUD/8NVLiEjpJzEUcuxkg3daLDOEvVeWQPqfDfd3Tq9ksCEC4Uv
         30Yp2/Z0cN+8W+lb6Dx/04oGGgLUMc6Wk1fnARl93AdFGBjsZWt7/0Lsz7bLSshm/0i8
         sPhw==
X-Gm-Message-State: ACrzQf3wNshvfuazp+yXx+XNmcv4M+lwbrsAzeUMZEQSLycfiNoiysPE
        xHRPRxsVfzPn0qnTDkqVu2jvgw==
X-Google-Smtp-Source: AMsMyM7aoCdu9WHwG285Neg6d4thYouvRN6KfDb/QxWK+gc0PVmrUK/EJD+sPkftZalwKRWmRkCIdA==
X-Received: by 2002:a2e:9cf:0:b0:26c:3973:ec1f with SMTP id 198-20020a2e09cf000000b0026c3973ec1fmr1321095ljj.322.1664460028783;
        Thu, 29 Sep 2022 07:00:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id dt18-20020a0565122a9200b0049c86ca95bfsm794048lfb.52.2022.09.29.07.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 07:00:27 -0700 (PDT)
Message-ID: <88035bdd-3aeb-640e-c001-8823013e5929@linaro.org>
Date:   Thu, 29 Sep 2022 16:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] ASoC: wcd-mbhc-v2: Revert "ASoC: wcd-mbhc-v2: use
 pm_runtime_resume_and_get()"
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        stable@vger.kernel.org
References: <20220929131528.217502-1-krzysztof.kozlowski@linaro.org>
 <YzWgescSJMKzYTAo@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YzWgescSJMKzYTAo@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 15:41, Mark Brown wrote:
> On Thu, Sep 29, 2022 at 03:15:28PM +0200, Krzysztof Kozlowski wrote:
> 
>> Cc: <stable@vger.kernel.org>
>> Fixes: ddea4bbf287b ("ASoC: wcd-mbhc-v2: use pm_runtime_resume_and_get()")
> 
> That commit isn't in a released kernel.

Oh, indeed, thanks. I'll send a v2 without it.

Best regards,
Krzysztof

