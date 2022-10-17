Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1CF600603
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 06:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJQE2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 00:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJQE2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 00:28:08 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E34CA28;
        Sun, 16 Oct 2022 21:28:07 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id f37so15666746lfv.8;
        Sun, 16 Oct 2022 21:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Fwt36RikcbsAb9G5IUBOEhKHyL8xS32oZmvLgDP+5Q=;
        b=OoDtW9p7CDbcvByI/t/f81CxHGvwqSCXCl1kz/AV3+DswiIs0hDBCS4sNSIKvscShp
         h+dn+fk2eKzVz3B2U9bT3hLW4KqvHeTETfwRqyp8JBqcocjyWnEvQZ+DzrKatQs2vQzS
         nEcQAzTGTy0GOX1mFleJ9+84cu5ekuqvSb52U4/lYYeflNmIMbbuQ8m8XDW0gtmcjyF1
         ycC1IVg+v2WVSc8JkGG0C4z2o06VkZG9hb3eXnM8slG03z2cLE4Ag1cUisLXBJ0YgGpp
         0aNvzpThB9mOq0PXKcG/lIYrcrEsXDNuhS22CD9X6XdJI3XKvE6e8eyRuFXLFbTt2I7M
         6fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Fwt36RikcbsAb9G5IUBOEhKHyL8xS32oZmvLgDP+5Q=;
        b=DBqWiNG3N99HtYwipD7BPNCnNYN9GzBd7dGtPMasVhve0edHLtiDiBsq2DY+ym3s1F
         miW8gPvE0quQ7mnSZeNK4N6qOodqy6sXG+ijQiV5ropAFThreaEzgRtvmNJeUuqoMsqb
         gx6lHsrG2iw2E1O17XKYoswvodeJTYR/dRK/+Z8n9uup8OeoqUBofL2BtZi3OMjZu/xL
         a+OIEgFTbQkgEfYQMUBkyYucAO2CrbQfewc7IVv5KS+9Z0BaySCRG7gLZBLfA4C4r4Of
         5TF/Bv5w1MCYdzBp4pobH0eDGEQmjMEFR9hejvPWWI9C/OK+GWmfyKWW8++vWOqz016w
         7ZEw==
X-Gm-Message-State: ACrzQf35cMBuvodsk5rrxN4WPyjMIleWhSyO9GmZ96PhkLahg7L6JLmj
        dmMajFpGqmUto/iM0iyBrK5Myoch/Uo=
X-Google-Smtp-Source: AMsMyM7xr+rrDsOYkmtxi/QypYGQ2Q4kGzi68Sz4W7Gj6spZiAMaQ0HCKpwR3q1qFirP5Icvki1aYA==
X-Received: by 2002:a05:6512:1193:b0:4a2:70b6:3191 with SMTP id g19-20020a056512119300b004a270b63191mr3077827lfr.563.1665980885805;
        Sun, 16 Oct 2022 21:28:05 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::4? (dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::4])
        by smtp.gmail.com with ESMTPSA id y10-20020a056512044a00b004946c3cf53fsm1272530lfk.59.2022.10.16.21.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 21:28:04 -0700 (PDT)
Message-ID: <7f532450-2818-e0fc-7686-9daeb29777a4@gmail.com>
Date:   Mon, 17 Oct 2022 07:28:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 08/14] iio: bmg160_core: Simplify using
 devm_regulator_*get_enable()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Xiang wangx <wangxiang@cdjrlc.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1660934107.git.mazziesaccount@gmail.com>
 <3fd11489356b1c73a3d7b4bd9dec7e12c9fe8788.1660934107.git.mazziesaccount@gmail.com>
 <20221016170808.341aa08b@jic23-huawei>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20221016170808.341aa08b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 19:08, Jonathan Cameron wrote:
> On Fri, 19 Aug 2022 22:19:31 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> Use devm_regulator_bulk_get_enable() instead of open coded bulk-get,
>> bulk-enable, add-action-to-disable-at-detach - pattern.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Applied with tweaks:
> - patch title includes gyro:
> - ordering as Andy suggested
> - spaces after { and before }

Thanks Jonathan for saving me from respin the series :) Much apprecited!

Yours
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

