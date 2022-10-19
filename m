Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3F3604736
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJSNer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiJSNeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:34:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F91781CE;
        Wed, 19 Oct 2022 06:23:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so6269pjl.0;
        Wed, 19 Oct 2022 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02HMc5IuJLVgVwifqtF7lVyS4XBTNP1Rrj2XsXGDS2U=;
        b=UpspIVIXlFFSX8J5UAn/cqAQwRAgnbzjY3FhC7fiaajPMIK49IW+Oc6CM7t0MN1Tuj
         ZP+uH0eEOgwQmp5Y5AShlzuAU0fMUk4n+C6f6Sga+VGoXiOvOd/sXrgbNfU3BEVx1R15
         2fampG235xBRpQq3vNwof8eoCIvK9NaGvrFEc7oFKFXNY0QOuyFGSNa8tm15nRK2dTaP
         txrzoQGT81l/3a+L6y26K5RUIaiUeZrarEdCN2Ie27A0egIhWMv8qK9qwPEQSSRtzUbj
         4lrMfxuVxi2I8RU5LOTm8ei6OG7uLNfnT8GvWE3pa7OI6oY8U51FTv9Kt7xlFRSGk8PM
         cWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02HMc5IuJLVgVwifqtF7lVyS4XBTNP1Rrj2XsXGDS2U=;
        b=HdtMqItaSkALXYayqPsYP0AvZCFHGe68+k7t/zzWVADaS58qr6yym2xk7NxkajPSQI
         88ItlFjQwZpxDviADSVOZrEuSdNf933cKGuEyuRwYZsJjfUxo43g3S2iMzdu8SSxwPHR
         p7woyiA3KmSd3WpRZwTv13I5HT3j+Awvm+5lL0SldTb4Vi5ARu1up9zvCf+y+tzWh7Kl
         3e46HenM7CJSCVZg4+aXseKGlO3cyp1q0G3PVqtlpYXw70sBOrykELWGI5A3DsRCj3Rf
         /6u8Ks7/dLHOwU5F9F8nwRieEIMRnOIYp0bSx2SOqX3lKFnyqL9RhnI/gv4Q65Dr4Jaf
         BEQw==
X-Gm-Message-State: ACrzQf39iRafVoTAA2Noyjc2whvnOVBbMWxdUAfuulwopFb0htykX/Lz
        MPUxzSdCx2NVOcQm4I+ll3w=
X-Google-Smtp-Source: AMsMyM51LIc9x8VknUpeaDLAHqK0/L1+2c3a7yy3BWTqy4hOoALnSvTXVNWetB3LWNzJwyGM/KrdxA==
X-Received: by 2002:a17:903:245:b0:178:e0ba:e507 with SMTP id j5-20020a170903024500b00178e0bae507mr8614236plh.115.1666185668244;
        Wed, 19 Oct 2022 06:21:08 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id i3-20020aa796e3000000b005625ef68eecsm11282861pfq.31.2022.10.19.06.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 06:21:07 -0700 (PDT)
Message-ID: <3005030d-ab99-200f-aee3-c7ee74b55506@gmail.com>
Date:   Wed, 19 Oct 2022 06:21:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: linux-next: Tree for May 17 (drivers/nvme/host/fc.o)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org
References: <20220517194118.2caa01b8@canb.auug.org.au>
 <5958ccea-d89c-8b1a-15d3-19d8cacd141d@infradead.org>
 <20220518045704.GA30131@lst.de>
 <e2f636e1-33ff-3d9f-a793-960f239d0bc2@infradead.org>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <e2f636e1-33ff-3d9f-a793-960f239d0bc2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/2022 10:21 PM, Randy Dunlap wrote:
> 
> 
> On 5/17/22 21:57, Christoph Hellwig wrote:
>> The patch that adds nvme_fc_io_getuuid need something like this
>> folded in:
>>
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index a11c69e681180..3c778bb0c2944 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -1911,7 +1911,9 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>>   	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
>>   	struct request *rq = op->rq;
>>   
>> -	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
>> +	if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
>> +		return NULL;
>> +	return blkcg_get_fc_appid(rq->bio);
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
>>   
> 
> Thanks. You can add
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> to the patch.
> 

looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

