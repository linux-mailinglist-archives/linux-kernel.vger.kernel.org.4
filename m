Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE46C398E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjCUSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjCUSul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:50:41 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB5A26A1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:50:21 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id o14so7391668ioa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1679424621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xDr70Nnl1VATn+QsQLIB3bXV6I1lenwh+WDqNDOsA0Q=;
        b=DcTJTnyhiYLJeNioUDLmuSVg6UoVRxbbe5ZSgac+myOX2cLkzG9RbvRC5CNDWpB6uf
         v83+q2Ltq1PlTNMTJ2tbM2GtMfQdEJF/z1MDcE00HTKDACl9T2hI05OTuPXTwc4EhkSE
         btWd7/Cy/Vms+sGLosNbqH9xybP/DNMVyyGs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424621;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xDr70Nnl1VATn+QsQLIB3bXV6I1lenwh+WDqNDOsA0Q=;
        b=sibw02xQiWz7/URvankSQsGWxrgna9G22udiWDhqEJjWpXoDrgBJn5qv/O5cLwcJo9
         A2AtqHZpJ+eIGGrOGniyMAju2eN+h3B9zPcTaGqDq13XvCcYF/dVfnsYwb7G4UjBfapp
         t4UtBYslZqzOTDc4VI4/2xjiD5+4dD5YdR0yb0u+KymeH/RnhwJjNjOmKtkE29gQy9jn
         Oe4bK1KZm6NIVZPeMUQXsApSEDNScQDwp7fLdKtMhB94yZ8zECVBnSqINl6zJ0xznx/E
         6tIt+v3J7W5tcDHpVsdKiWZqp77Zq2bW8JD7wd/VQSl2pnNJFqVtQH6Y3VvysQOpF865
         G62A==
X-Gm-Message-State: AO0yUKXUDk/mN1lXvCEc1Jr+KqyxJjmhVfwIT+k8gJnP2T8sm39RG8Kt
        o3zFS2VB5bICMttX6HYEWolrWHSc2ujVULJXI8g=
X-Google-Smtp-Source: AK7set/4kVSlvtI2ppfTio176h7OTJNhkCUm3QA9gCe292hvJ6C5sdw+51ybOK5/SJkFjQYInjN53Q==
X-Received: by 2002:a5e:de46:0:b0:752:ee32:322d with SMTP id e6-20020a5ede46000000b00752ee32322dmr2315828ioq.18.1679424620929;
        Tue, 21 Mar 2023 11:50:20 -0700 (PDT)
Received: from [172.22.22.4] ([98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id c25-20020a5d8b59000000b0071664d0a4d7sm3875903iot.49.2023.03.21.11.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 11:50:20 -0700 (PDT)
Message-ID: <2e869677-2693-6419-ea25-f0cc2efcf3dd@ieee.org>
Date:   Tue, 21 Mar 2023 13:50:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] staging: greybus: use inline function for macros
Content-Language: en-US
To:     Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Julia Lawall <julia.lawall@inria.fr>
References: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
From:   Alex Elder <elder@ieee.org>
In-Reply-To: <20230321183456.10385-1-eng.mennamahmoud.mm@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 1:34 PM, Menna Mahmoud wrote:
> Convert `to_gbphy_dev` and `to_gbphy_driver` macros into a
> static inline function.
> 
> It is not great to have macros that use the `container_of` macro,
> because from looking at the definition one cannot tell what type
> it applies to.
> 
> One can get the same benefit from an efficiency point of view
> by making an inline function.
> 
> Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>

I'm sorry if this conflicts with what others have said.

But the use of a macro (with a container_of() right-hand
side) to get at the structure containing a field pointer
is a widely-used idiom throughout the kernel.

What you propose achieves the same result but I would
lean toward keeping it as a macro, mainly because it
is so common.

					-Alex
> ---
> changes in v2:
> 	-send patch as a single patch.
> 	-edit the name of struct object.
> 	-edit commit message.
> ---
>   drivers/staging/greybus/gbphy.h | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/greybus/gbphy.h b/drivers/staging/greybus/gbphy.h
> index d4a225b76338..e7ba232bada1 100644
> --- a/drivers/staging/greybus/gbphy.h
> +++ b/drivers/staging/greybus/gbphy.h
> @@ -15,7 +15,10 @@ struct gbphy_device {
>   	struct list_head list;
>   	struct device dev;
>   };
> -#define to_gbphy_dev(d) container_of(d, struct gbphy_device, dev)
> +static inline struct gbphy_device *to_gbphy_dev(const struct device *_dev)
> +{
> +	return container_of(_dev, struct gbphy_device, dev);
> +}
>   
>   static inline void *gb_gbphy_get_data(struct gbphy_device *gdev)
>   {
> @@ -43,7 +46,10 @@ struct gbphy_driver {
>   
>   	struct device_driver driver;
>   };
> -#define to_gbphy_driver(d) container_of(d, struct gbphy_driver, driver)
> +static inline struct gbphy_driver *to_gbphy_driver(struct device_driver *drv)
> +{
> +	return container_of(drv, struct gbphy_driver, driver);
> +}
>   
>   int gb_gbphy_register_driver(struct gbphy_driver *driver,
>   			     struct module *owner, const char *mod_name);

