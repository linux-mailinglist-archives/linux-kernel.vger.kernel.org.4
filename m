Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24A9726923
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbjFGSrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjFGSrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:47:18 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC06C1993
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:47:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5149429c944so2215767a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686163633; x=1688755633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Saw/wcMjaTOKj6+ur5l5dkvFtuu3joPFGhVbSYzUS6E=;
        b=F7gUsU3UCaoBKO4nx1qLKGM7+Ocjx9dx3nGX0xJMlc4Crg44LrkCvBkYaXGY1yBU3R
         WpBTKSxYqsXrqYXeMAB4wl73gQiwW7ZF8fZlwDg9eZqe9SWVTmrnNajgXS+R1qPw3dRM
         1pcgCXwwnmpQm/N/v34Ek5g9yfWJqLJtKbxhx9iAeGgck34XX93M5vx9H50KlcQzA3RQ
         10AX2aPETkoIRlobjgMVIuDQ/Ee9mh8RM51LaXM9KH8/mShDTQYWHgMsk3rRUg/jQijE
         QQEKPF2soAW0u2bhDwf+uR6EQd+vm80hgFYJ7OqI2DH5kDfbyZFXGpjuT2GSZfz/6k+D
         OsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163633; x=1688755633;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Saw/wcMjaTOKj6+ur5l5dkvFtuu3joPFGhVbSYzUS6E=;
        b=fznuopBsLE4GSPsTDt5TROfi//0AbTZAzKnEUDBLuZfuEuXZXkK7ujulFeaUEoPqMn
         QrM0dSahEHInMp0DXluKmXCVulh/SuKZ3KZoKKgOI8trEYy9OQXQKMmI3GFYgwlsTdR7
         sYzgdNxZYMUFvCkrrVAZhkx7CYbvEh2Om7E/6zDeYqMEJXRO81+GT9r2v9F+6xrHOOqt
         b4ucVcIIPKfo79c4mReVV0IYMaQurZ2ejnt4sX6jzzsgTJzj5v+2jYQpzRE6uuqzYQKH
         HI0hBGpwTkqHcle6VlaaGhdtC9UzSfvzs4P4Gcrbvkp6UJvnYCVIrCrE7cBavGle6t5Y
         5ZJw==
X-Gm-Message-State: AC+VfDyVwLehSPiHeJlqsapy+8zNyjbdIL/UxFKExaeLb9Vg88ek7NVP
        UJNtpXuncqGt973PDSpCIGgO3w==
X-Google-Smtp-Source: ACHHUZ68Bq5KQbazm15stdQM7ZkuSGXrYI4b4MEPFpdT7BOx0AbduzT0oBcsh38Y1oz5wjhGG0tKgw==
X-Received: by 2002:a17:906:9753:b0:974:86a7:d3a3 with SMTP id o19-20020a170906975300b0097486a7d3a3mr6597724ejy.13.1686163633165;
        Wed, 07 Jun 2023 11:47:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id hb19-20020a170906b89300b009737b8d47b6sm7052264ejb.203.2023.06.07.11.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:47:12 -0700 (PDT)
Message-ID: <bdf49a17-bb4c-a00d-0239-ed5d0eef470d@linaro.org>
Date:   Wed, 7 Jun 2023 20:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND PATCH v1 2/2] misc: fastrpc: detect privileged processes
 based on group ID
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org
References: <1686155407-20054-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686155407-20054-3-git-send-email-quic_ekangupt@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1686155407-20054-3-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 18:30, Ekansh Gupta wrote:
> Get the information on privileged group IDs during rpmsg probing based
> on DT property. Check if the process requesting an offload to remote
> subsystem is privileged by comparing it's group ID with privileged
> group ID. Initialization process attributes are updated for a
> privileged process which is sent to remote process for resource
> management.
> 



> +
>  static const struct file_operations fastrpc_fops = {
>  	.open = fastrpc_device_open,
>  	.release = fastrpc_device_release,
> @@ -2277,6 +2396,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> +	err = fastrpc_init_privileged_gids(rdev, "qcom,fastrpc-gids", &data->gidlist);
> +	if (err)
> +		dev_err(rdev, "Privileged gids init failed.\n");
> +

What about error paths? No need for cleanup?

Best regards,
Krzysztof

