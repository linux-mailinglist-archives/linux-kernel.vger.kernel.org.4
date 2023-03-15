Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A36BBF83
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjCOV6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjCOV62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:58:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3310E6232B;
        Wed, 15 Mar 2023 14:58:27 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id s7so3530214ilv.12;
        Wed, 15 Mar 2023 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678917506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=egyhGDt+hlqX/Z0LgBGD0IU2L4ojDg9iZKbAvFb0XXA=;
        b=BTbGGU5rUrP/fJWymUjjpoKoTUG0Cwn7TlACvuypQAgNlHvmxviexrpOdlC9EPNE/z
         o3a8wB934/eanv3D7KWPaxpK+IvgAnfY7V3tbjNI0/kGZAIRZRKeqowPILxa7+zmzelJ
         kHxjt6cSxYL8p17/jpwz1/BkJtQHRTnyFXBrZ/2xn75mJFNpzXQ2gThfy6yL/fyI8rRo
         wKkN2zmD4/LuEdYb9y+PLPS1AZ6/V+/QZDmjXWnmiuit6fRcuTH28IeiAJz6/QOKnpKL
         KZG0d9MmNaCP4hD7oGKY0AVdMiR359M67DIPsPa19utmwPlcDw2m6tPZVuXo8qry5Lj9
         0PDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678917506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=egyhGDt+hlqX/Z0LgBGD0IU2L4ojDg9iZKbAvFb0XXA=;
        b=j8aAjUBhMi3Ktd+hShIFi7hxUjhOPi/m24fW1mapJwiVQRleP1jc1EBEhT1LGG6SI/
         m531umKujg1St+hKEDsYeykzX95ant6FVA3749/RQquB59pN9e1GattYpO0OSrU+Q5Jx
         iqBml6TGKhog3mBPOIpacZnB7sTZEZVFtyYPX02o1i6bWTvN5SnYe9obzYPF4RbmsAZh
         VF/FiXdfOfFneBXfQpWY7zLLXOGMawmxKjd5tFENtT3LxuA8aGjGq14cG0pc10cKKuua
         hnJE6h+jph1aChJX5H+ZDXSIc9bBYvdDZFyfX/9p01L+piN5p2Cmvmt3b8f7T4BMkDky
         Tn+Q==
X-Gm-Message-State: AO0yUKVV1feHe6u4CMXuQxkbU3FzopNU2akhRyht2ckXmL+sUB40srTT
        HjWSi+6UVeunFH/m2YILP/F/yZMh+6c=
X-Google-Smtp-Source: AK7set/TOld09oomPcPWCwggPJMzRNFT7G2Y7AL62OGq/4nnFIZohB0DfhGNa1Jh13k1MRtsqogLdQ==
X-Received: by 2002:a92:d98a:0:b0:322:ffb2:db80 with SMTP id r10-20020a92d98a000000b00322ffb2db80mr5341802iln.6.1678917506436;
        Wed, 15 Mar 2023 14:58:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c21-20020a02a615000000b0040618ad53aesm882936jam.31.2023.03.15.14.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 14:58:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <19097c39-9703-6b7f-6cc4-8a157b00f368@roeck-us.net>
Date:   Wed, 15 Mar 2023 14:58:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] hwmon: (nct6775) update ASUS WMI monitoring list
 A520/B360/B460/B550...
Content-Language: en-US
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, mischief@offblast.org,
        de99like@mennucci.debian.net, holger.kiehl@dwd.de
References: <20230315210135.2155-1-pauk.denis@gmail.com>
 <20230315210135.2155-2-pauk.denis@gmail.com>
 <20230315233054.5ac21db0@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230315233054.5ac21db0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 14:30, Denis Pauk wrote:
> On Wed, 15 Mar 2023 23:01:35 +0200
> Denis Pauk <pauk.denis@gmail.com> wrote:
> 
> Tested-by: Holger Kiehl <holger.kiehl@dwd.de>
> 
> Pro A520M-C II/CSM is also tested by Holger Kiehl
> https://patchwork.kernel.org/project/linux-hwmon/patch/868bdc4f-9d45-475c-963e-f5232a8b95@praktifix.dwd.de/
> 
> Could it be applied as single patch or need to rebase over "Pro A520M-C II"
> patch?
> 
Sorry, I don't understand what you are trying to say. I just applied all patches
in sequence as received, with no conflicts. Should I undo that ?

Guenter

