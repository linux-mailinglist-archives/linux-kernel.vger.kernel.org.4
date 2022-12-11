Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF45649438
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 13:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiLKMpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 07:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiLKMo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 07:44:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A9BE31;
        Sun, 11 Dec 2022 04:44:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id fy4so8996794pjb.0;
        Sun, 11 Dec 2022 04:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BIynU2NWG7vKdIOfvZ+4asmhXgFyDxZr8sjMOqoFm8=;
        b=VLTR7S/5ahNq29JrLlj5T02niU5r0jRh5WDqvlUJIfcTSpIEpzp81s8kGrBPHDXP0B
         tOZN0FlJjcKYQwFlxGliUGZTkgXsKcQc3RbSg3t9HqcCLJ2sYbN65lsRdjEv4d3Ieipd
         /++8MJEOed7jHqmpcLZRBpL6fxIgF5bnecqhSUejVteb9/vPQW06qcwOHn0sok3JZoOO
         js6Jk/GGYyV3M2lHhJ5Tae1CGHfTY8+Nvz1idEjTvRwOEq++Zj4MFSLqu8XwLTqyxX8c
         v8dbXeurnS/gLdxLUrM/xLQhp8LQwFg2BTGpf47mhbi20bXhzX+IdV9hoRhu5vfwW1qM
         fKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BIynU2NWG7vKdIOfvZ+4asmhXgFyDxZr8sjMOqoFm8=;
        b=PPKK+/z+XeXnRGEw+lZBACFF8NToFRSFXb3W8X4xT3g8e91Z5Ksiz5sTNOkDPRhWxm
         uPLVZxvq4lmJFUhpDC2UDuyq/YQKhaXAt+nmgNHK0ysxl+ZK0a4pGwLJjdNJcKidNnS6
         4eXbFKTY1OWWkZlpeG5WMNqtkUV/E/b/qw7BUqAjd9lWMszB/5NsbDa1h9pv5DlYf6eK
         0C91IEfZ1VjMHeOeE3eZ3TXwXJY+XvFbLyaAMBMr+e86N8t7JGVDnaLaMLauH5xuxVTM
         bNlDIG6Dt8/hLrkKtXKK6g5hKmbM5KsxAhiSL8msDFNnVE13yB3gkLaGol4SrG10clRN
         lz6A==
X-Gm-Message-State: ANoB5pkIBJwS05jpTNXTUpCC7ok4rBa5+H7MD3s7CPYI8ayod+Dv3dAH
        s82iWgybJkWFzMebkGC1zl0=
X-Google-Smtp-Source: AA0mqf7yK/8RDsOO7DyGcjv6lNtY/SWehdEVnXgQu3jHlPDi09fOM7Wba1DgYdpDPCZKOaXs9yAeeA==
X-Received: by 2002:a05:6a20:ce4a:b0:a4:69a2:6dd7 with SMTP id id10-20020a056a20ce4a00b000a469a26dd7mr15160149pzb.0.1670762698199;
        Sun, 11 Dec 2022 04:44:58 -0800 (PST)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id w15-20020a17090a4f4f00b00218fb3bec27sm3620808pjl.56.2022.12.11.04.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Dec 2022 04:44:57 -0800 (PST)
Message-ID: <38ad5cab-bcb1-bb23-b141-7ffc07acde78@gmail.com>
Date:   Sun, 11 Dec 2022 19:44:50 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] Documentation: gpu: vc4: add blank line separator before
 KUnit code block
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel test robot <lkp@intel.com>
References: <202212102116.A10vg3jG-lkp@intel.com>
 <20221211053051.18125-1-bagasdotme@gmail.com>
 <fb978a9e-43af-865a-00c6-d98499414ec5@igalia.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <fb978a9e-43af-865a-00c6-d98499414ec5@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/22 18:32, Maíra Canal wrote:
> I believe Maxime fixed this issue on [1], but it hasn't been yet merged
> into drm-misc-next.
> 
> [1]
> https://lore.kernel.org/dri-devel/20221208094727.2848310-1-maxime@cerno.tech/
> 

Ah! I don't see that!

Thanks anyway.

-- 
An old man doll... just what I always wanted! - Clara

