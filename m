Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEAA6738AE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjASMgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjASMfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:35:36 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C598882980;
        Thu, 19 Jan 2023 04:32:23 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id a14-20020a17090a70ce00b00229a2f73c56so5680958pjm.3;
        Thu, 19 Jan 2023 04:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sac0uH94+eobhDT6asHKNrz1H50xBId/HUVcG82XASU=;
        b=d4Pkg8YtiFu9qkBkslpyzTX4ODlCF9cPEMdGnccfXp9pVlB7Vag6mr8HXNJmuXLxDn
         v2SjiZJNerWirVEzTDYpl5Yess++WVZ43DfMGIyA4SOqizYpn9OxVWYpDs1IYj7cScVz
         IHBYxn11qPw9pjUcWeQ3Sbr7rlPVOeBitce19/cUT+LD9SXz2R0GoSwK/2Cs8D8hkTyX
         ra9U/huH4aU3StkandszQyDGq0gsRS6WRdvFSkIYyf865Uy6KQ9Xtb+Ayy/qMqZtdZp9
         EsNAOLR/9WLqLBmz8s99rZjS51VsJ4Zcgg9q7UZSa0nZYFU+lq+rxCvnpkpv0TpJPe1p
         z48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sac0uH94+eobhDT6asHKNrz1H50xBId/HUVcG82XASU=;
        b=jaDm9UzkUWvNsQJ9wE4XyZo/RaWd9Qsf48gxdz8yBRaQiSF1iqjD9wvyH2HjXlngwu
         +OTly6OnvCO552kroUww+KSLVeq6OY4U8BSwNnVojL4QNAt8GTymK1QIlXFZn+h/ra0J
         6zohLIdipAI8WkxSn27BV7PVa4W549Jlp2jZsB93qLo7mqH3w0hWQ9asoqjWOD1H1it+
         dFPZfzxLYUVvkP9rwJ207lR6UHUfzhjNfgo22xa0lP8GSRp5bt2SlOV/3p8pa5qcJfFK
         si62FQ8/9Yl+kELoV8kS8JhNhPFb8Q2qIsVxnlHlOxRC3rV462FN75Ko7JXsmf9msKmT
         0vrQ==
X-Gm-Message-State: AFqh2kosW54lAYt7BkpGxl07Pabn6nI1xGPKQfcRKb2707SwmxHIPsrf
        0Qy7jClqvzJLRnBNYwZjon4=
X-Google-Smtp-Source: AMrXdXt9rTfqNetfn4/vNfsbYTeURrALPYPObN6cMaL1/hbxUPZX9w6h9rBJE0nj685Q5cQ51ckjDg==
X-Received: by 2002:a17:902:f60b:b0:194:a663:675b with SMTP id n11-20020a170902f60b00b00194a663675bmr11286433plg.19.1674131459889;
        Thu, 19 Jan 2023 04:30:59 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-93.three.co.id. [180.214.233.93])
        by smtp.gmail.com with ESMTPSA id x3-20020a170902a38300b001896522a23bsm24993664pla.39.2023.01.19.04.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 04:30:59 -0800 (PST)
Message-ID: <13f7a493-d1b6-481b-63a5-64080a4aee90@gmail.com>
Date:   Thu, 19 Jan 2023 19:30:52 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 6/6] Documentation: amd_pstate: Update amd_pstate
 status sysfs for guided
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, santosh.shukla@amd.com,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>
References: <20230119115017.10188-1-wyes.karny@amd.com>
 <20230119115017.10188-7-wyes.karny@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230119115017.10188-7-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/23 18:50, Wyes Karny wrote:
> +- In autonomous mode, platform ignores the desired performance level request
> +  and takes into account only the values set to the Minimum requested
> +  performance, Maximum requested performance and Energy Performance Preference
> +  registers.

"minimum, maximum, and energy performance registers."

> +- In non-autonomous mode, platform gets desired performance level
> +  from OS directly through Desired Performance Register.
> +- In guided-autonomous mode, platform sets operating performance level
> +  autonomously according to the current workload and within the limits set by
> +  OS through min and max performance registers.
>  

The rest is LGTM.

-- 
An old man doll... just what I always wanted! - Clara

