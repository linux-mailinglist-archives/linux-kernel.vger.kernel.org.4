Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA09732540
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240648AbjFPC1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFPC1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:27:46 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDC270F;
        Thu, 15 Jun 2023 19:27:45 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666a63f7907so349574b3a.2;
        Thu, 15 Jun 2023 19:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686882465; x=1689474465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lrm4RXCLtawSCTt2xEoMjdXS2vTA8X2w0nWYSNzEbCU=;
        b=Dh4SZj1BYzVhuC3v8F6tkuMbrYJ663MLo1gleJvGvFPvSItZVMquu9TZJxbJgs2d2s
         ufL0bD/rkhSaxSy9DaPROSkSKoe9D3zkYrfpkxHwPwA7DkLQEGu7TOECfG9K5rCUzOi0
         fIGmCVhwR+Y5Y4V2+yhgvAwqq6deSzjMr2+UJE2Zdnm4ogMcPqNs+zBFAizONru/WryO
         4Prm/57qma8ZkjeOD9guxz/Ag3pthT5SACK6q2jr6/DSULP/L+Mhr5FqiEaUKvKdBGED
         HK1ubyQMYoQSa1rTlGBpUsS4b7VuJEKlI3ZRPgaIHp7QRF43XIoUF3I1KwLjUHP1GVZV
         ni1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686882465; x=1689474465;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lrm4RXCLtawSCTt2xEoMjdXS2vTA8X2w0nWYSNzEbCU=;
        b=gBlWGdSNcx+VWmqBMbt/yOA19wFdVmlTxnVAYUUKxryKcC3yvhRPAY8bgXBZ95ljX5
         PRhlWeOg3W9o8G+Wt+86rurKyXKktf3Ywbpyd+030rtKM7QsrLVr+6L2xsb670Yc6Ngm
         Po9O0InVuwZUQjYFmBZUROmBvTbArJIhvMX1h30k0+UUJLTmowKnRGBIqUomU9IDaBu/
         rlIoygHRQuJH7H45VKVDN2aAD5p3bJ0K5bncttpibU1UuQg+kmu9ncWrhqquDqLNVRdd
         q007iDJ4wGJvzYOKxqDvnUi0Aa9r0C0bNcx0pOcyk2mIryQbsi3EI4pYyHb1BevXptQu
         ITmA==
X-Gm-Message-State: AC+VfDxlwsTfGnMU5Kg0kwAK377+5sUXgDuxf6Ke/4j690NiJHJ0TnYc
        rWcLBFUnrhWRiVxMxN1FJLc=
X-Google-Smtp-Source: ACHHUZ6KkhQj9St2fy/bZ0hKx7EtifQHGV6A4pYwLeNzUNrUXxeI5zanpcady3g+4UPEKkQ0M2d6WA==
X-Received: by 2002:a05:6a00:244a:b0:666:8cbb:6e02 with SMTP id d10-20020a056a00244a00b006668cbb6e02mr895703pfj.8.1686882464752;
        Thu, 15 Jun 2023 19:27:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p3-20020a62ab03000000b00646e7d2b5a7sm1943024pff.112.2023.06.15.19.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 19:27:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3c3fbecd-caf9-c432-0890-93cceade98c1@roeck-us.net>
Date:   Thu, 15 Jun 2023 19:27:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: usb: typec: tcpm: fix cc role at port reset
Content-Language: en-US
To:     Frank Wang <frank.wang@rock-chips.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        sebastian.reichel@collabora.com, heiko@sntech.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, huangtao@rock-chips.com,
        william.wu@rock-chips.com, jianwei.zheng@rock-chips.com,
        yubing.zhang@rock-chips.com, wmc@rock-chips.com
References: <20230616022001.25819-1-frank.wang@rock-chips.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230616022001.25819-1-frank.wang@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 19:20, Frank Wang wrote:
> In the current implementation, the tcpm set CC1/CC2 role to open when
> it do port reset would cause the VBUS removed by the Type-C partner.
> 
> This sets CC1/CC2 according to the default state of port to fix it.
> 
> Comments are suggested by Guenter Roeck.
> 

I have no idea (recollection) of what I suggested here :-(

Guenter

> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3c6b0c8e2d3ae..9f6aaa3e70ca8 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4885,7 +4885,8 @@ static void run_state_machine(struct tcpm_port *port)
>   		break;
>   	case PORT_RESET:
>   		tcpm_reset_port(port);
> -		tcpm_set_cc(port, TYPEC_CC_OPEN);
> +		tcpm_set_cc(port, tcpm_default_state(port) == SNK_UNATTACHED ?
> +			    TYPEC_CC_RD : tcpm_rp_cc(port));
>   		tcpm_set_state(port, PORT_RESET_WAIT_OFF,
>   			       PD_T_ERROR_RECOVERY);
>   		break;

