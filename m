Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E802F605716
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJTF7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiJTF7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:59:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB7D1B2BBD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:59:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id e18so28321488edj.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yTeWtLc9iuDGFKFl9h7/VcDmaMI9wa+7Pbxnp/ORjl8=;
        b=JAuBCAVsFVOEIzlPbzy0vu38g44tEL83lti6tKpbc93b7aYSEkE5UZ1b+HuAJefMCu
         o50SoZAvCyXTe7/I2ss7BH9FWIKqEcPvBcjnqP+5S8Q5ILB+narxBQ03eryc/nDQeav7
         3HdOr9M7W/nGjTlndKXY1momaZvUkvDst5o4ZH1I9ygDl8YpM7liUqPaK7adwd8M10Wx
         NwQ/J736XbuefugZqPMsLlYtcWkUdetAh26CsQoCEgy2HAdUpPBoaVGJbdMdx1Tr1Uz3
         jD9Y2diqtiWpt36lBMbRTaFj4z312ES2/geHgfulA5G3K+N7GXkm4GO7Yx+Y4ZKfjEEA
         yasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yTeWtLc9iuDGFKFl9h7/VcDmaMI9wa+7Pbxnp/ORjl8=;
        b=YuM+ydUjqVYRb49rdP5jxi4wQbK+C7gj2Bm/qrijMNj74ojil6Vt+FhcPyKZJmo5yM
         APJwSzubYqlqjL7+OsMuaXW96SruETwR2SgP58s7mGCfMgUa80q4gtVnuhVG/ZMvSuof
         8g9mB9oT/HPyh3Wm24C7c5AQj0HpXvSCm7iqEHxZJt8BWGlaIdVXde9uLMHB2/sRoxWR
         bJM4jWdtj712Ssr4J8XGycZvRGJxlAsPjHzqeJbcByPAnxZzOxhlhw0SRngeGsDXm7ty
         5GtUVUf6IQ5qoxTfGHwCCicWoXQGbHWPpiMSw6PrOHTFn3EBJI4o9v3yjRA0KtBNMp5r
         A00A==
X-Gm-Message-State: ACrzQf3xS3rwy30atu3JgNsIhvlEVliGLGSGIN2uu4NaLB9ycK9zgnXl
        j2R5weKI8nXJfM3wI4Cvg9Y=
X-Google-Smtp-Source: AMsMyM67D46OvwHEI6Wq29SnNnoQgIzSxnhbTpOutN+fPKo+6OpCGefoic2psE4DdbBdgIKqoil4kw==
X-Received: by 2002:aa7:c956:0:b0:43b:206d:c283 with SMTP id h22-20020aa7c956000000b0043b206dc283mr10691464edt.381.1666245543360;
        Wed, 19 Oct 2022 22:59:03 -0700 (PDT)
Received: from [192.168.0.100] (ip5f5abb58.dynamic.kabel-deutschland.de. [95.90.187.88])
        by smtp.gmail.com with ESMTPSA id l17-20020a1709063d3100b0073cf6ec3276sm9744027ejf.207.2022.10.19.22.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 22:59:02 -0700 (PDT)
Message-ID: <56f4cf2c-bc9f-e6a3-d7a0-7f293465166e@gmail.com>
Date:   Thu, 20 Oct 2022 07:59:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/3] staging: rtl8723bs: fix white space warnings
To:     Emily Peri <eperi1024@gmail.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     gregkh@linuxfoundation.org, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1666230736.git.eperi1024@gmail.com>
 <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
 <7025b8d8-e23a-0148-75b5-a06c18c6dbcb@linux.microsoft.com>
 <Y1DXNYai6M6niWXQ@marshmallow>
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <Y1DXNYai6M6niWXQ@marshmallow>
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

On 10/20/22 07:05, Emily Peri wrote:
>>>   
>>>   		*pold_state = networktype;
>>>   
>>> @@ -367,7 +368,7 @@ u8 rtw_set_802_11_disassociate(struct adapter *padapter)
>>>   
>>>   u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_ssid *pssid, int ssid_max_num)
>>>   {
>>> -	struct	mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
>>> +	struct	mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>>>   	u8 res = true;
>>>   
>>>   	if (!padapter) {
>>
>> Regards,
>>
>> ~Praveen.
> 
> Now that I think about-- in this last edit I removed a space to appease
> checkpatch, but maybe I actually should have removed the tab?

Hi Emily,

you are right, just use spaces.

struct mlme_priv *pmlmepriv = &padapter->mlmepriv;

thanks,
Michael
