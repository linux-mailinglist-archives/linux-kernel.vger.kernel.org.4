Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CAB5FF370
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbiJNSH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJNSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:07:22 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532201D4631;
        Fri, 14 Oct 2022 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665770835;
        bh=qt6OErHWsTDKZrWmkypB7PH5kVLGo0E85ODKBQDxDhw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EuPkDVSc+wMkb23sZ0qt2uponSkCVabrPXK1rJGb/ZMo2pxCWwZAUjXytuZbzrEfS
         QosL5e9DJ2FkzfRB4P5zQx22YNJv+l+DVPDS+MiE/zgj4GMPMQx2WImyPrnLnAOIOj
         fRw1mWE+iyXtZHxM0qKNMNDNtI7y73KVFDE7VBMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.188.185]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6sn7-1pDIRo2NZv-018KNL; Fri, 14
 Oct 2022 20:07:15 +0200
Message-ID: <4cfd944b-2558-0b74-b976-e8b7b175428c@gmx.de>
Date:   Fri, 14 Oct 2022 20:07:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] parisc: Fix spelling mistake "mis-match" -> "mismatch"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-parisc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221013221915.128286-1-colin.i.king@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20221013221915.128286-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SsI7+OOhrckqJ9s71RET+UmBVYmcBfG3BxtNPAnpEaaLLltYf/q
 W76QW46tGg7oyNbFqDCU9YH4ckpIuwWLipXzrCQPWXljqpsuA3HnZIR696Oe0KmLauJwehM
 pKzkxXhOkWFzc7BDm2BIxtuOr6565cIXP4Lwy3lYfxjx/a3GL5ec/1NSClYCfAmiyqBaq4S
 VKQHdNQGpBqpURzgs7XTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:36OZDcg+JL8=:D1m7yYw0u5tlw4bVmNjOz5
 TRYljKp7WktP8mwyDJB5sbiehN54ckfgCqfjOT+wg0bTPfoSTWfE6o9Y8REPrZhOSxTAGRcyP
 dM6Tq/eRE068MzDAJsADFzCcYkw+0WJ7CfCDI7qfoCbQKBCuSidlrM/7FOHkPc/Jbh7e1PFyD
 GvrPwgqcU42F6IOEeFd0ppe3RzBP39NV2oAeSVe8VQHtF68jTd5ytJujAWaA8OtDyFuRCiWyd
 A3M35SyIezb+VtjbhhC0tQU35sqhBTaSrWa8Kkcw6klNhr5erB97X9exOHwbvsfFEjF98bRuZ
 i8eh4x0+/NGkR8KC39QSp/sDVo5NHYKerTqpi4b/oWWtenn1V7y7ViBBIiL3Z1GcWXgr8l365
 mqft/1X4qbg7K1iDwqxqwtCCl2owixVMeAROCwpQTUHnoKwdkJYbqnn9anYxgPUgDViqT5ovx
 X71xceSJGzn2ums8uNVtr/hu8vkzBNhfnVjtUbg7ohiLt/v1R3XZNSve39xQWGDTjEL0uAyTJ
 S8pVAWdRPSw4d+fLHvF5Ye5wXUpOz8tjyqA/48yLxu/NkeCKshAuUUY7QZ4kjXuSv0WSMNNU9
 h4mq7RrSA14RY2YtvVCt3cUCT4tIXcPNBG/4YCqHUu4zwdKlzPrdLjHyVyXMC/R44BG1p9one
 zIE0o0jHf1oF5TSOByNsk41pmyV6K9MLsvnFeGz+BUbJuuaDEWd9heaNhxfSFnJD73JXShMjI
 orMZNTOH6yLirdVcM55kb4QPMw9kXkdkr52JsLGLeBAyRKCUBD4OXUEhaU6gs/Xi/88NwjQeJ
 fxWv7GH3T0GbK/vWjcaZTdP+VbrqPdDy8JqZb7XHaoRCuACK5KWiabCH1rRahIaNWvbj/Fija
 IOoiRHS7+exrhnCBsHrrNH2QjWmZKGCj/Gmbz87V/z9+jq2MwlN5Am1bJy7UZjymsCEbc9AwF
 mOj53JJMTqxfoWGGNryq+NqkJ16gVlAH43kd0Y6Z9wwBfAyNKT3ZkwOW+/VuiNLMVcxvkbxU7
 HFjUM7QbfVv/G2igUTByTaBvX0/cGSCTOj9xV19g7MRACCZDev/Q19QbzMwTlUa7bHyqYV6P7
 dg3kcvc3i0IIdoTnmpNDyb+B+EP9s4HhmtUJT47WVfawAAswl9oVz/4CHvwREF651MY63q0E7
 rjuA/yifsFXq5W8/CA4F3imC8mo4jPoazlPeN2ol827+6v6/BJfdbchvE6HdsxuYE0sKrNhz+
 Dj2i9FX+RnHcTBFm/n1AQ9GRTCYaCTKeSnx9UBkEr/JM4s4feRej/buMHxO43VwlprU0pGA0V
 lDXH+OMbO6rUAIawBDQ3xLCQSi4MwseeAeJlZWFECNRlatGBLTMugtYflA0cw9TiTzx5Okx6Z
 G+EVbFlyvldcIpIv5aDRqVcu4lOQe1kjbuPL72ad5TwxIXXLuRsGW6Me70zZcqqRpndjJe/3B
 A7f3xR35zEnH7k2SaZJYgl8ChE1QEL63ipulZQD44EwYhJZ5C0Au1k3JRaW+ufLaIjft/Nqxe
 AeFhs/SiXgq3wnyoWe4JTLHAxjRpPBH1x9Pm4266O06di
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 00:19, Colin Ian King wrote:
> There are several spelling mistakes in kernel error messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

applied to parisc tree.

Thanks!
Helge

> ---
>   drivers/parisc/eisa_enumerator.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/parisc/eisa_enumerator.c b/drivers/parisc/eisa_enum=
erator.c
> index f54a6f450391..f0cb31198a8f 100644
> --- a/drivers/parisc/eisa_enumerator.c
> +++ b/drivers/parisc/eisa_enumerator.c
> @@ -393,7 +393,7 @@ static int parse_slot_config(int slot,
>   		}
>
>   		if (p0 + function_len < pos) {
> -			printk(KERN_ERR "eisa_enumerator: function %d length mis-match "
> +			printk(KERN_ERR "eisa_enumerator: function %d length mismatch "
>   			       "got %d, expected %d\n",
>   			       num_func, pos-p0, function_len);
>   			res=3D-1;
> @@ -407,13 +407,13 @@ static int parse_slot_config(int slot,
>   	}
>
>   	if (pos !=3D es->config_data_length) {
> -		printk(KERN_ERR "eisa_enumerator: config data length mis-match got %d=
, expected %d\n",
> +		printk(KERN_ERR "eisa_enumerator: config data length mismatch got %d,=
 expected %d\n",
>   			pos, es->config_data_length);
>   		res=3D-1;
>   	}
>
>   	if (num_func !=3D es->num_functions) {
> -		printk(KERN_ERR "eisa_enumerator: number of functions mis-match got %=
d, expected %d\n",
> +		printk(KERN_ERR "eisa_enumerator: number of functions mismatch got %d=
, expected %d\n",
>   			num_func, es->num_functions);
>   		res=3D-2;
>   	}
> @@ -451,7 +451,7 @@ static int init_slot(int slot, struct eeprom_eisa_sl=
ot_info *es)
>   		}
>   		if (es->eisa_slot_id !=3D id) {
>   			print_eisa_id(id_string, id);
> -			printk(KERN_ERR "EISA slot %d id mis-match: got %s",
> +			printk(KERN_ERR "EISA slot %d id mismatch: got %s",
>   			       slot, id_string);
>
>   			print_eisa_id(id_string, es->eisa_slot_id);

