Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BEA6B2F23
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCIUym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 15:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCIUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:54:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC39BF0C74;
        Thu,  9 Mar 2023 12:54:35 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id r18so3201634wrx.1;
        Thu, 09 Mar 2023 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678395274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKRPP95UCERqYSKZRLrnrthOnUbdU21OYLfdjhCLwlk=;
        b=VwwYCNnyZSgzjedTU/AgKPiXR8fyZenx+unao+pjaJcbx89QJF09d66EqcpyAPSvZy
         FolJuNRo+WmFTGd4LhLHdU/pgEzU+UcIy9sZTxyWwMqV+usOuy4IANfJZBpTGnbd1l8H
         4IhYuYE9H+3v4QmjYBAHAKFleSfwozKNT7bmwnKVmjMzoUygDfT4GGwg0rsb0vBAcsdL
         B2/Ft3cqsxY7D8QmifGs7ayV6wqDE5z54nEhPqmOdOSXMFfiVgtjyhHuL8CixKFPg/wA
         wy5sCuuhvLJrDvy2bmYQP51nfqwncRrsR5+Dqbexl+dkJUpd/GqD0cTuAXp25Ov/uhF/
         7NYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678395274;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKRPP95UCERqYSKZRLrnrthOnUbdU21OYLfdjhCLwlk=;
        b=SL0WgOU8jqcor4GkvBbgFy0dPu1B/91oK530vaoXTz0QtornP/DgnH+NDWJY1CeUqs
         EH0RTVQRpWICwgcM3hUipy+6Goy76zIvlrSftWwlObrdTdnEmQDT+eVwDK9rq3/4cCSc
         YX6sLGzeqVbcXYWYkO/Yk69TXDjvwODB25XQno6FStOvapWhwyM3EuUbYjHpB/bwRCDn
         25L64XDdFRYHWDLlH7WApozNrXc5eAYul7mxT8Xxr/PFT/NLzENQg0xSORbllzvtehZw
         9CQaKPwCDgcJBOz1VJpx43cbAnPvs15NMNOs7PS3K91LrhcPNWpzc2drzcjNCulUzgvf
         qiow==
X-Gm-Message-State: AO0yUKWNgGcDhz5qZ2vN0+gpwd+X8a3kL7B9sefou5flulm6yEZ5R0Gr
        UN/T6By/MJw4hXK/dGmnKyk25ekxoSzUZg==
X-Google-Smtp-Source: AK7set+0yuPxMlqsjjyXCoz+LnA1CWfnzzV3jjN/tSizAxt2JCo7b/ARnFaKknS8I2OR5+PXhkg2ZA==
X-Received: by 2002:adf:decf:0:b0:2c7:3d5:9faa with SMTP id i15-20020adfdecf000000b002c703d59faamr14238624wrn.11.1678395274053;
        Thu, 09 Mar 2023 12:54:34 -0800 (PST)
Received: from [10.23.0.3] ([194.126.177.54])
        by smtp.gmail.com with ESMTPSA id p1-20020a056000018100b002c54c9bd71fsm317981wrx.93.2023.03.09.12.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 12:54:33 -0800 (PST)
Message-ID: <57dd6b7f-6f30-9fc5-0cbc-7d28a2f65f6a@gmail.com>
Date:   Thu, 9 Mar 2023 21:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 2/4] firmware: Add support for Qualcomm Secure
 Execution Environment SCM interface
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230305022119.1331495-1-luzmaximilian@gmail.com>
 <20230305022119.1331495-3-luzmaximilian@gmail.com>
 <84e6cfd8-ee4b-a5f4-5249-d87df9909246@linaro.org>
 <fa9cfc41-1d6c-1003-e6d9-6a1545487177@gmail.com>
 <98f20683-bb1d-47c2-18ca-f3de61c9a91f@linaro.org>
From:   Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <98f20683-bb1d-47c2-18ca-f3de61c9a91f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/9/23 09:45, Dmitry Baryshkov wrote:
> On 08/03/2023 15:59, Maximilian Luz wrote:
>> On 3/7/23 16:32, Dmitry Baryshkov wrote:
>>> On 05/03/2023 04:21, Maximilian Luz wrote:

[...]

>>>> +int qseecom_scm_call(struct qseecom_device *qsee, const struct qcom_scm_desc *desc,
>>>> +             struct qseecom_scm_resp *res);
>>>> +
>>>> +
>>>> +/* -- Secure App interface. ------------------------------------------------- */
>>>> +
>>>> +#define QSEECOM_MAX_APP_NAME_SIZE            64
>>>> +
>>>> +int qseecom_app_get_id(struct qseecom_device *qsee, const char *app_name, u32 *app_id);
>>>> +int qseecom_app_send(struct qseecom_device *qsee, u32 app_id, struct qseecom_dma *req,
>>>> +             struct qseecom_dma *rsp);
>>>
>>> I think that only these calls should be made public / available to other modules. qseecom_scm_call also is an internal helper.
>>
>> So move all calls to qcom_scm and only make these two public? Or move only
>> qseecom_scm_call() to qcom_scm (which would require to make it public there,
>> however). Or how would you want this to look?
> 
> I think we can make it with just these calls being public. Or even with just the second one being public and available to other drivers. If the app_id is a part of qseecom_app_device, we can pass that device to the qseecom_app_send(). And qseecom_app_get_id() becomes a part of app registration.

Right, with the bus structure, we only really need qseecom_app_send().

I'm still a bit concerned about things maybe getting too complex for
qcom_scm with the blocking/re-entrant calls (and maybe other future
stuff), but I guess we can always try to break things up when/if we get
around to that.

I'll try to implement that and your other suggestions and see how that
goes. I think that should work quite well overall.

Thanks again for your review and comments.

Regards,
Max

