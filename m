Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35BBD6DA0EB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjDFTTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239634AbjDFTTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:19:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE5A26B3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:19:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w4so38392859plg.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680808752; x=1683400752;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeH6FINvXMYcp3IeM6dg3TgK/rL10t3h+RFF5o1RXSQ=;
        b=EvHd608s97okKwHDkFDthIAXFo0gW/FY9RFDQSxqFyTOSuKwUuGmGip8/koVdzNwge
         wH2IgzO0IJ6lqYZI8I49FI2/TkiseKMP5xJubIloanGTu/QRf7UlBNZGdit0Bg13Hi7+
         3X58uA3KBZPcdyvFp97HoH40jl4eTdOCjLe+ldGTdUqDJihNCzi5mz8fvVajmDi7HQ3y
         2PjI/eFuC907sYu1B//UA+wd542S/76gd1ap0jvmAbX7xIQJHnP760iJ7JecLnvOp7yt
         41PHodTDa7zOp8pnvrFR5DklF81D1yq4ZbFcxqux7h2T/PQem7emER6SljmP+IY8f9Lr
         F45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680808752; x=1683400752;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeH6FINvXMYcp3IeM6dg3TgK/rL10t3h+RFF5o1RXSQ=;
        b=qc9Ho/F+w1qcGciLqV44AXeJNLD9R495niw0wOCgXSab4jVEcLTQkhtbsxntvPFEn5
         Ak8XfHtvKOU+sFw5LHE/nkv5YoDXj1YMkBVJI8AIfM/1tZ7IGs2oSGZRLGF7EHbFm2kJ
         p2KJZkB0AzqQj1Iq7rj3UKr3dRyc6gMxUNtQLBEDTJmCe4ts1s/tlCEBLN7bBXgkEoYW
         B+d/lhalo7DmAenpwjb8JMULLFOSPNIwrBYPJQK7PaUOFbkAywuEcjeWBEowN24zLNNB
         C0zw3OPVSfI2262ROeUjKG0nsMy/SLQ8SHe82vvkxZvDfvg1B5TNZYPNuAyzac3bfaEB
         Y53w==
X-Gm-Message-State: AAQBX9fJ+7A1nB0/TRh4b03QpBMmrlr0wIfn4o0JNtXP8DvrF/Sgje9I
        hau5eaqyckPDgqcM74qCYVA=
X-Google-Smtp-Source: AKy350ZQ+Ms0j1RA4eL+brm2jFzNh3cafmfbNS1/y+YiXE/QKCkIOo/mXMkj3efwee2tvHGbUyWHNw==
X-Received: by 2002:a05:6a20:6d90:b0:e4:9931:cb7 with SMTP id gl16-20020a056a206d9000b000e499310cb7mr448914pzb.41.1680808751667;
        Thu, 06 Apr 2023 12:19:11 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id n23-20020aa79057000000b005e032bb1c34sm1716727pfo.24.2023.04.06.12.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 12:19:11 -0700 (PDT)
Message-ID: <806934f5-2992-6085-ab75-909e11e7a95c@gmail.com>
Date:   Fri, 7 Apr 2023 04:19:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/5] extcon: Make the allocation and freeing to be
 private calls
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20230405152745.24959-1-andriy.shevchenko@linux.intel.com>
 <20230405152745.24959-2-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230405152745.24959-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 4. 6. 00:27, Andy Shevchenko wrote:
> The extcon_dev_allocate() and extcon_dev_free() are not used
> outside of the extcon framework. Moreover, the struct extcon_dev
> can't be filled outside of the framework either after allocation.
> The registration part, for instance, requires a parent device to
> be set and that's done in the devm_extcon_dev_allocate() wrapper.
> 
> Taking the above into account, sumply move the mentioned APIs to
> the private headers.
> 
> Alternatively, the pointer to the parent device can be added to
> the extcon_dev_allocate(), but since there are no users and magnitude
> of the change it makes a little sense to go this way.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The role of extcon_dev_allocate is not that supporting to touch
the internal data of struct extcon_dev. Some driver needs
the removing sequence between extcon device and their used resource
like irq/opp/regulator or others.

When they need some sequence of resource freeing, it should be supported.
I think that there is no benefit to move into driver/extcon. It might
limit the various use-case of extcon_dev_allocate.


> ---
>  drivers/extcon/extcon.h         | 4 ++++
>  include/linux/extcon-provider.h | 9 ---------
>  2 files changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.h b/drivers/extcon/extcon.h
> index 15616446140d..49e4ed9f6450 100644
> --- a/drivers/extcon/extcon.h
> +++ b/drivers/extcon/extcon.h
> @@ -63,4 +63,8 @@ struct extcon_dev {
>  	struct device_attribute *d_attrs_muex;
>  };
>  
> +/* Following APIs allocate/free the memory of the extcon device. */
> +struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
> +void extcon_dev_free(struct extcon_dev *edev);
> +
>  #endif /* __LINUX_EXTCON_INTERNAL_H__ */
> diff --git a/include/linux/extcon-provider.h b/include/linux/extcon-provider.h
> index fa70945f4e6b..db474ae3c711 100644
> --- a/include/linux/extcon-provider.h
> +++ b/include/linux/extcon-provider.h
> @@ -25,8 +25,6 @@ void devm_extcon_dev_unregister(struct device *dev,
>  				struct extcon_dev *edev);
>  
>  /* Following APIs allocate/free the memory of the extcon device. */
> -struct extcon_dev *extcon_dev_allocate(const unsigned int *cable);
> -void extcon_dev_free(struct extcon_dev *edev);
>  struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
>  				const unsigned int *cable);
>  void devm_extcon_dev_free(struct device *dev, struct extcon_dev *edev);
> @@ -78,13 +76,6 @@ static inline int devm_extcon_dev_register(struct device *dev,
>  static inline void devm_extcon_dev_unregister(struct device *dev,
>  				struct extcon_dev *edev) { }
>  
> -static inline struct extcon_dev *extcon_dev_allocate(const unsigned int *cable)
> -{
> -	return ERR_PTR(-ENOSYS);
> -}
> -
> -static inline void extcon_dev_free(struct extcon_dev *edev) { }
> -
>  static inline struct extcon_dev *devm_extcon_dev_allocate(struct device *dev,
>  				const unsigned int *cable)
>  {

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

