Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9376D472B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232978AbjDCORr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbjDCORp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:17:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B7B2BEF5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:17:44 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id kq3so28107882plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680531464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JgJZk44zL8lne7M+hgXc/XiROqMmGQUdX4VZoJ00DF0=;
        b=YzFggkuCxl4srkZVAxYsVpnsEWUudg6Fh1jAU541QQqQsMVkEMQx+I2GBf0qRldhbl
         cbSQGhcInrSv3JQ8BDKFWrdiXekXGVh6JQ5f6cAlQ9jCEeQ764LarZYiABhml/5OFKlx
         1QRowLv6WO0InklqXt/xt2wTAA6LGNK/nxuTLPNblU2k8ECNMTZ9HhKMGtkzLtJTPfO+
         oR/3PjwEPFi7BpNNskbrmu/C7AN45ZriwGNAMWUyOe6m6Xqzk9YEEyn7BeCTOPyNaj8l
         OXqsm4gusw5/q3wFO9/Y7D+MO6AcYNI1fDM2l2LSR0dYF61ZVZYf26YsF0s0wLtLKmB9
         ccYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680531464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JgJZk44zL8lne7M+hgXc/XiROqMmGQUdX4VZoJ00DF0=;
        b=6jSS1HdCfplYF3KO7ngLiijnNeqgKFPjUyLQEegcWbMutv3L2DXSDzUQi6s7QjlaKw
         cHx0ZGdkFkVG5Oj4IhOt15ZU1Qye5CIqtanP0DlOHdQe0UaOOkfMXlDfbKU5xeuzljbh
         Ojh5NMWxoqZg/wG7HzlcGd5tH7Y8TjAhDE+cNNDwWmm4y1EjZI0wguptZ2d8IUb26Xju
         tJq6vcOwGND1tBlnRPub7YuhfmOPrG/N8v84O/odkoJYKOdqyVWiAHaLpMbbFXWsIr6N
         MJQaS8s2NXnK8iwKwbBaasPnLFz0unHkLM72ofL5umSABL+8QowFwnI2HtsfC9116yhe
         lA9w==
X-Gm-Message-State: AAQBX9ceI7ku/izrzftsJVdy58isfJ8G2CH0oV0oyTXG2v9nabq2Q5Ro
        S1l6egVbcAIV3pnajG8tXes=
X-Google-Smtp-Source: AKy350bIC31k52FGD/bINsL+hy/go7Y5mBma0D5S6vyRnNSeY78wXe5uWstjjEntHzE0kMsV1VT2RQ==
X-Received: by 2002:a17:903:6c4:b0:19e:61cc:6793 with SMTP id kj4-20020a17090306c400b0019e61cc6793mr33172609plb.48.1680531464249;
        Mon, 03 Apr 2023 07:17:44 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902ed0100b0019ab3308554sm6695023pld.85.2023.04.03.07.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:17:43 -0700 (PDT)
Message-ID: <496784d9-0e17-1be5-f33b-3fefa5c4ede4@gmail.com>
Date:   Mon, 3 Apr 2023 23:17:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 10/14] extcon: use dev_of_node(dev) instead of
 dev->of_node
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-11-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-11-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 22. 23:40, Andy Shevchenko wrote:
> The dev_of_node function should be preferred.
> In the result we may drop unneeded NULL check
> of the pointer to the device object.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index 5cadbfc151e6..32e96cb49067 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1429,21 +1429,17 @@ struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
>   */
>  struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
>  {
> -	struct device_node *node;
> +	struct device_node *node, *np = dev_of_node(dev);
>  	struct extcon_dev *edev;
>  
> -	if (!dev)
> -		return ERR_PTR(-EINVAL);
> -
> -	if (!dev->of_node) {
> +	if (!np) {
>  		dev_dbg(dev, "device does not have a device node entry\n");
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> -	node = of_parse_phandle(dev->of_node, "extcon", index);
> +	node = of_parse_phandle(np, "extcon", index);
>  	if (!node) {
> -		dev_dbg(dev, "failed to get phandle in %pOF node\n",
> -			dev->of_node);
> +		dev_dbg(dev, "failed to get phandle in %pOF node\n", np);
>  		return ERR_PTR(-ENODEV);
>  	}
>  

Applied it with the following patch title.
Just use capital letter at the beginning char of title

- extcon: Use dev_of_node(dev) instead of dev->of_node

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

