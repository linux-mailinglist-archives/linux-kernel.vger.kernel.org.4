Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388BA6D46E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjDCOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjDCOPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:15:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C404EF4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:14:59 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id r7-20020a17090b050700b002404be7920aso28642715pjz.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680531299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOT7gHoRFPuvocHIp4c9gnzq9W/CXIWnAUXdAPq4PzA=;
        b=Pl4YFCMsfoY4pWCKmCGkqgMlm1F7cFCxqMsNwKhQqNXSnB9GNrHTyEIXQFTLMKmKj2
         XR3+BD90NqUge9PG828rXW7U5hybj3a3ds2Ta6baNnjSPR3m/sYocvcpkjdPSXTZ3zFy
         07TQdRpPB1RMC0rYse2yOIahHF7OvDMz3RdzxuXBT1bPJJmtj+YatopZWIVsfsKeEX0U
         +uizdH319DcSJQbtSNVLpSAD6BsSJzn3doGBKPhWRwqBvs2dhtjjS8nsHxP+xJVrnRsy
         Y7XPD4FHKMgtXfmgYsYBCvwyY/u4aK5hm6RQrRknyWHV/SHmBMAiNPOczOfWAbJyQwoZ
         oF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680531299;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOT7gHoRFPuvocHIp4c9gnzq9W/CXIWnAUXdAPq4PzA=;
        b=UvelK+77Y+Hlc45aLDqLfivjVR0KLEvZxm5O6XpIE2olMGIR8r+Llqni533u3ap0PN
         vZKz+boBhwpkqUgLp2qNemrwQcNTKKnQLUEfxNF1shOHpcHgnSqT6iN/H3shHUZHop4R
         12SGKeIDievSE6veccYmT1TUwQ81jVllbK9/fX5HXZ+FMO78CRf9udOx62tXDnqqnBUq
         1qZAYEYiB9GqmvkxqfU70W3iphh1SoNxertcapHW3KhaK+JaTaLKsMFINxwz1pREWIvp
         ezUwxQ9dGBVM9ghTdqHBKUiqyEp5JludprUrI1cnkcb7sAFMbkYjIP3FRg+URLGy0vUo
         +KcQ==
X-Gm-Message-State: AAQBX9eKnv+/ebxdFl5nTV/Kdm8BKINTh7NaxbKgjUTIpQZuTKrDRTU/
        ELOOdrZkuH91uLY1/VdbCqU=
X-Google-Smtp-Source: AKy350aSiPBouf54YKPFY2W56HFBDrktHv/o/RASAAlW9AFMkvWUpK0Z0yDYUnG2VQz0LUcx+U9BOw==
X-Received: by 2002:a17:902:e810:b0:1a1:a531:460e with SMTP id u16-20020a170902e81000b001a1a531460emr43515602plg.63.1680531299331;
        Mon, 03 Apr 2023 07:14:59 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id o4-20020a1709026b0400b0019e31e5f7f9sm6667588plk.71.2023.04.03.07.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 07:14:58 -0700 (PDT)
Message-ID: <98dff2ac-c7f7-1e26-06a6-82be72ace2bf@gmail.com>
Date:   Mon, 3 Apr 2023 23:14:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 09/14] extcon: Use device_match_of_node() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <20230322144005.40368-10-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230322144005.40368-10-andriy.shevchenko@linux.intel.com>
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
> Instead of open coding, use device_match_of_node() helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index a63e7eef02fd..5cadbfc151e6 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1411,7 +1411,7 @@ struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
>  
>  	mutex_lock(&extcon_dev_list_lock);
>  	list_for_each_entry(edev, &extcon_dev_list, entry)
> -		if (edev->dev.parent && edev->dev.parent->of_node == node)
> +		if (edev->dev.parent && device_match_of_node(edev->dev.parent, node))
>  			goto out;
>  	edev = ERR_PTR(-EPROBE_DEFER);
>  out:

Applied it.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

