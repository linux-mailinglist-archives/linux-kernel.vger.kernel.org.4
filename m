Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413FD745A97
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGCKtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGCKtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:49:50 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD42CBE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:49:49 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb863edcb6so6878476e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 03:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688381388; x=1690973388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE8anQZA0UUcsbLHQj52+//ujwbzaDMOp1DBWtVrdpo=;
        b=JeborHy5WDq3qB5zPRZYisV2WCPUfUbhSFvsIZMts1fY05hVw994NA0eR2x5nSBXRS
         uUt+yevNDP8inDLK0qQLjMFiEsadtUmdQYwfefBtmM4oSKS8pjAUUBukwhXqAhAyVCBX
         SFYHqrNpxFDSsw0SIwFfYTUytjTnj0P7UK8Vd7cc9zpklQHiisvIzOAELiS0PFy0T0QK
         SRYkwDs8ztYfSXIk000hA6nYLXKrG6fZAloDdTBsvxNw+bGa6GvYCcN6IelwnxCleakT
         HzJ8is3cBr3ytoUzPy54X1Z2/P8LptjQGUqIz+Dh3yde1ApBharRPXPq4xgTE4jCpPQN
         UGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688381388; x=1690973388;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE8anQZA0UUcsbLHQj52+//ujwbzaDMOp1DBWtVrdpo=;
        b=lXm9h79b79jb8nWryNevH+IGBMbKjML1BbdqmjjSpqsK6pZKL1tFPXHig0oRBQi5Ot
         kt9H2jk8IOoA8zYRxmVptdfuAxAZBQFHXDG6VUBdWmV0AvnPPg8mcSoumlTMcrtYhZ+1
         VZ65vmCj5hJKR4KcHxCoPjqRFLyaX19No2/a02ADERXKqe8iROw/o5zUIVA1i0eHvnBZ
         wEdzWF6Z5ZffgA+afKcsQumVnv5Pm8LZGvDQF0jH8Ok7Y1Njn+oZ4MHjI2YPGWARsQZs
         BMOhRCGVeCF+BCn7szpDzgIR3X01vg2qfWsBwACOILVkLvHgbhNjSeqhyM4csS4+pJqf
         cX2g==
X-Gm-Message-State: ABy/qLYWE6rCHp19f4nHUzkc+n4pXtl9iY+2ghleoD4TjKSVr6V43M4s
        JUPvwaN6EoYzC60DXjeBAxM=
X-Google-Smtp-Source: APBJJlF1pohfhP/PPc56e28FwasXwh/w9hUdV+Nk2PIKDRqX0ThFJwfuGCxN6ceexOaw6WUPyz/5fg==
X-Received: by 2002:a05:6512:74f:b0:4f7:6b72:3323 with SMTP id c15-20020a056512074f00b004f76b723323mr5997302lfs.55.1688381387791;
        Mon, 03 Jul 2023 03:49:47 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d19-20020ac244d3000000b004f843872e08sm4462885lfm.143.2023.07.03.03.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 03:49:47 -0700 (PDT)
Message-ID: <0c374c1d-cf98-993b-67d6-555222a0a3cb@gmail.com>
Date:   Mon, 3 Jul 2023 13:49:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 11/13] regulator: implement
 mon_unsupported_reg_modes
Content-Language: en-US, en-GB
To:     Benjamin Bara <bbara93@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     support.opensource@diasemi.com,
        DLG-Adam.Ward.opensource@dm.renesas.com,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230419-dynamic-vmon-v4-0-4d3734e62ada@skidata.com>
 <20230419-dynamic-vmon-v4-11-4d3734e62ada@skidata.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230419-dynamic-vmon-v4-11-4d3734e62ada@skidata.com>
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

On 6/20/23 23:03, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The mon_unsupported_reg_modes property disables all dt-enabled monitors

How do you feel about
mon_disable_when/if/at_unsupported_mode (or unsupported_*_reg_mode)? Or 
is it again getting too long?

This is not a point I would like to stress though :) So,

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> when the mode of the regulator is changed to an "unsupported" one.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
>   drivers/regulator/core.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 74b9c12d38e9..ca768d0ddb1e 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -4816,8 +4816,21 @@ int regulator_set_mode(struct regulator *regulator, unsigned int mode)
>   	if (ret < 0)
>   		goto out;
>   
> +	if (mode & rdev->desc->mon_unsupported_reg_modes) {
> +		ret = monitors_disable(rdev, REGULATOR_MONITOR_ALL);
> +		if (ret)
> +			goto out;
> +	}
> +
>   	ret = rdev->desc->ops->set_mode(rdev, mode);
> +
>   out:
> +	/* if changing mode failed, ignore monitoring error. */
> +	if (ret)
> +		monitors_reenable(rdev, REGULATOR_MONITOR_ALL);
> +	else
> +		ret = monitors_reenable(rdev, REGULATOR_MONITOR_ALL);
> +
>   	regulator_unlock(rdev);
>   	return ret;
>   }
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

