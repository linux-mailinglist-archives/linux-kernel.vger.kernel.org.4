Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02EAB7091D8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjESImT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjESImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:42:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C9E58
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:42:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30626f4d74aso1980360f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684485733; x=1687077733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qj6uQgN1+vxh9RZBPkG03bBIocorGgNPBI/qslQJ5s8=;
        b=FsxZ051YRylQq/5B4oscm9IUNqPtK0o/St+buTVwQzm+nnIlhcPRbnZ1EhwwSjOrou
         NJ6/UnPeWArc04donPKQJt8JAALcSxZQ9eMU6jRp7vGkprLOzzmYOiIUoiOO6bFCZRKu
         H0Xk88MYGfXQ5xTUff7hxGT/rdRJWs3B2T69dCV6ofeiPsoJLhdPcKlHz8rppCTgrCfu
         Hy62FW1esfpeZHB8C/zVX16sKZ1FB9BaEpvNZGNs0GVJzRp/b/QDZWQ39AC4fdK3t0ZP
         kf2D8uUC5WeW0YsVlOXpBHXYN1zmvxf5xVh46RtqZDzTkhLIF8Sl4rJ0xGL5sfn5L43C
         LBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684485733; x=1687077733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qj6uQgN1+vxh9RZBPkG03bBIocorGgNPBI/qslQJ5s8=;
        b=Oqown4XGJdgz9W02PqF+tT6eMZZQwheHNYtekchJ7PlbuFsMGRUTTW1cefmUVrLJ1V
         cWM5Y4Mvt4QX9fR6QVbtz98L1teRPDsmPMdF2KzeknEoqzTRK3pM42kV36fNjDeQktL3
         QicR8nhrXBlLjK+hT5D8JcXvHXyt1X0B6BN1LGS6vpcvBsp85H7PnFSWeGJnL613j95u
         EpvoDUAIe1/bFF0F7EmgSLmhuPpEW1BsG/fdqq5q14nSgJt1AGucrMpNRzH91wx2LhfH
         cud+ZpAyHaRbe3Bs+ti2Ldu6kW1LFjukB48WnZLXMrGS2yehp/+fUU5u2/1jaEoaix4I
         OwKw==
X-Gm-Message-State: AC+VfDxuhnt2nrx3fFVPbt6L6yZmaRsaVOdqOhEKUpPKtylM+v+3y4GV
        7zaH/yJeo7hB6moEmbyItzt+vg==
X-Google-Smtp-Source: ACHHUZ4pYqnT+QNSgIw7tLCyKnqAJpSKnRj3817DB9WLtNNuVND7AG9ya5U08W4gvbQi0+CNP9XOMg==
X-Received: by 2002:adf:e64d:0:b0:307:979f:736e with SMTP id b13-20020adfe64d000000b00307979f736emr1344667wrn.55.1684485733660;
        Fri, 19 May 2023 01:42:13 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id x15-20020adfec0f000000b002cea9d931e6sm4624731wrn.78.2023.05.19.01.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 01:42:13 -0700 (PDT)
Message-ID: <50c285e2-2212-45c9-e62c-1b3804ec2cec@linaro.org>
Date:   Fri, 19 May 2023 09:42:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] MAINTAINERS: remove broken entries in QUALCOMM TYPEC PORT
 MANAGER DRIVER
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230519041307.32322-1-lukas.bulwahn@gmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230519041307.32322-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 05:13, Lukas Bulwahn wrote:
> Commit a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> adds the section QUALCOMM TYPEC PORT MANAGER DRIVER in MAINTAINERS with
> two file entries for header files in include/dt-bindings/usb/typec/.
> 
> However, these files are not added to the repository with this commit or
> any commit in the related patch series. Probably, these file entries are
> just needless leftover after the work went through some refactoring.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Remove the two file entries for non-existent header files.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Bryan, please ack.
> 
> Greg, please pick this minor cleanup patch on your usb-next tree.
> 
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3182992769aa..a987ed462d64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17559,8 +17559,6 @@ L:	linux-usb@vger.kernel.org
>   S:	Maintained
>   F:	Documentation/devicetree/bindings/usb/qcom,pmic-*.yaml
>   F:	drivers/usb/typec/tcpm/qcom/
> -F:	include/dt-bindings/usb/typec/qcom,pmic-pdphy.h
> -F:	include/dt-bindings/usb/typec/qcom,pmic-typec.h
>   
>   QUALCOMM VENUS VIDEO ACCELERATOR DRIVER
>   M:	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>

Oops

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
