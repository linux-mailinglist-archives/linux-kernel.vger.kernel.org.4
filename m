Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC286E74FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjDSI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjDSI0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:26:34 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E119A7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:26:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id dx24so35512682ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681892791; x=1684484791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cn8sw9IP8LiVn6+N6W0wmYqLVqWZIVaQNaxL7vP2/hY=;
        b=J1i/i0FgqzTKm7G0QiddqXo6Ri5/9n1aNp1jCQ+jZKrMagLa0Gj1HtFV59bes7i9VZ
         G83lDzwDi1A7HpHxF9kROzaxgYHN4dpfF7ztMXna/pdwIWRcllZsMJ8HYqtNKKKZJKpS
         w93rgHqH8IiKjWMa6duvs2JsAQt+9hggM7KR71VvR8Ok1eSji6GuvbLGqVCWXje1Y9ac
         chpMvoL89Gt5HCkKOmUXrRuU56SOJ6EN7LZLFhFzz1pA7FDcE39zLeUlyCsBWVW5/6IZ
         bLZoNM7V01Ok6swveYYyirxGp7XnNm+VNvdRETMimsnBRZeBROBjE/RckkLuZrK98KWk
         Jtsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892791; x=1684484791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn8sw9IP8LiVn6+N6W0wmYqLVqWZIVaQNaxL7vP2/hY=;
        b=L5n7A8q9BpUDAjgvenfSCrAtr1QTJVO51O8zdD5zILNskWHbPEqRH5FpwExfFHIOFz
         vGjn0LOFjvwegZ5KMAh1SVen/3hXYYeiGhF8C1VPHlXIUc8CrF5RUWdfItAqxp6u8oEy
         groVehCk3jabKiB5GpWh42ZrDuF5Nqyg+236opoKP0GcvbXAg7eQ1tOK+EDWu0g8eEwL
         E7kUDk+PbIx7tFoWJ+tUtkr4XKFLUL+TT9zWO9zzwT/tUEnkZbQHjYRwkMkgs6IFhVy/
         lBLtx5tw8/+t6jdy7fpa+DJQqUmyhlpwF38wSyDPMPZeMMPFrO9bAmEf+k88CNR0Xfyf
         IcvQ==
X-Gm-Message-State: AAQBX9fpMW6Cof31kqcvBi0kyYg5H6cRyMGL1VFg95AkYBDBz1MnJF0P
        I0VbvSHLNBe6spbYtiYX4XUv4A==
X-Google-Smtp-Source: AKy350bRJ1WkIkaKqBC4j+0kdeEKhVCv+zX5drbWouRUp1ZA6qztn4VVUu2MljyPUD/o+nvd8267LQ==
X-Received: by 2002:a17:907:75ca:b0:94f:680d:3437 with SMTP id jl10-20020a17090775ca00b0094f680d3437mr9858125ejc.17.1681892791421;
        Wed, 19 Apr 2023 01:26:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id rp26-20020a170906d97a00b0094f3132cb86sm5681596ejb.40.2023.04.19.01.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:26:31 -0700 (PDT)
Message-ID: <3aeac99f-aef3-ee22-f307-3871b141dc7b@linaro.org>
Date:   Wed, 19 Apr 2023 10:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] net: nfc: nci: fix for UBSAN: shift-out-of-bounds in
 nci_activate_target
Content-Language: en-US
To:     Anup Sharma <anupnewsmail@gmail.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linma@zju.edu.cn, dvyukov@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <ZD9A5Krm+ZoFEFWZ@yoga>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZD9A5Krm+ZoFEFWZ@yoga>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/04/2023 03:16, Anup Sharma wrote:
> syzbot found  UBSAN: shift-out-of-bounds in nci_activate_target [1],
> when nci_target->supported_protocols is bigger than UNIT_MAX,

UINT_MAX?

> where supported_protocols is unsigned 32-bit interger type.

integer?

> 
> 32 is the maximum allowed for supported_protocols. Added a check
> for it. 
> 
> [1] UBSAN: shift-out-of-bounds in net/nfc/nci/core.c:912:45
> shift exponent 4294967071 is too large for 32-bit type 'int'
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x221/0x5a0 lib/ubsan.c:387
>  nci_activate_target.cold+0x1a/0x1f net/nfc/nci/core.c:912
>  nfc_activate_target+0x1f8/0x4c0 net/nfc/core.c:420
>  nfc_genl_activate_target+0x1f3/0x290 net/nfc/netlink.c:900
>  genl_family_rcv_msg_doit.isra.0+0x1e6/0x2d0 net/netlink/genetlink.c:968
>  genl_family_rcv_msg net/netlink/genetlink.c:1048 [inline]
> 
> Reported-by: syzbot+0839b78e119aae1fec78@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=19cf2724120ef8c51c8d2566df0cc34617188433
> 
> Signed-off-by: anupsharma <anupnewsmail@gmail.com>
> ---
>  net/nfc/nci/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index fff755dde30d..e9d968bd1cd9 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -908,6 +908,11 @@ static int nci_activate_target(struct nfc_dev *nfc_dev,
>  		pr_err("unable to find the selected target\n");
>  		return -EINVAL;
>  	}
> +	
> +	if (nci_target->supported_protocols >= 32) {

I don't think it makes any sense. How do you protect from UBSAN reported
shift? Why supported_protocols cannot be 33? You are not shifting the
supported_protocols...

> +		pr_err("Too many supported protocol by the device\n");
> +		return -EINVAL;

I am pretty sure that you broke now NFC. Test the patches first and
share your test scenario.

> +	}
>  
>  	if (!(nci_target->supported_protocols & (1 << protocol))) {



Best regards,
Krzysztof

