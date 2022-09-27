Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707415EBD39
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiI0I1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiI0I13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:27:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC096A9C24;
        Tue, 27 Sep 2022 01:27:28 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c24so8459448plo.3;
        Tue, 27 Sep 2022 01:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=0iQkW1MBbd3Qu0jhcGLXpiVvHU6Vrhi7uAf9jfUn1nw=;
        b=SMNBjjIrhylzKBYnyQT9wFzHYKCcI+omcAbDBU1yTUGayONVrXfX1RYtGX2gkuvd+S
         bR2FZNjSOVeX5AjSndtPVrVbFWX5TCNP9C4T2h3BS6m4wOOrWjxDmCjlXh5ZGuhHQjbo
         BvOCJWFywvVQwNizqbU1LsOKi8dLHUA4r5NpA2d9I85BsviMmdJzXNmR1HMR7ubQAMBi
         6rlAAHJRHkHTVjKEP9QFrsVPxKFSoNxyubz5osesjUhFLoCe7SnM5vzPIYbPzuKvpemp
         vQOu+dVPHCh8NA5ZKZ89FqrsCYAUNtCcuwVvaBvE2mgdYx5nZK6WCTgpColFYdxnpU6y
         Bgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0iQkW1MBbd3Qu0jhcGLXpiVvHU6Vrhi7uAf9jfUn1nw=;
        b=tVjdC1aFmjbZAbDkBwYP74Iv/bED32ZAy3HgWhOhgss+hrUoCGrPeF9Za2unwCPHCW
         gIwkSKCJ11o9qltjNVPqBJjHEYNd68Wmo4Y5AAArcy80qsnYW+36tX2tw2IX+jHuRsS0
         D29liqhwsiY7QvY2hxtns023PAG0stWBhALJX0ChPKHcPaTX9UqXetYMFs/dfSgHVBED
         9jNomTUXy8dMfp413zi4CcvPxj+9qHKTUmHLrmE4+fDhzAT9fB7XIJuaJWHsbGkVoeUz
         aU0wM2ezXs4CYiAjzqfGk27Fi2yl5/bm0cWO804aUDaxtdTrqawIuZ3aXwbOUSoLmEua
         drhA==
X-Gm-Message-State: ACrzQf12Koj1ZBTANPG8tGGuc7c3Nmxe038RmZlNbNpRo4hOL7YK/7xP
        SJ5WvClY6tb3pRRcOe8VgvQ=
X-Google-Smtp-Source: AMsMyM7fqDaei6uuGADfoP38nOHpulV98Is8xC72Gfefg86j4ozZVgKCMDhuKsWuZgHbj8S5aExPAw==
X-Received: by 2002:a17:902:ec8f:b0:177:ff40:19bf with SMTP id x15-20020a170902ec8f00b00177ff4019bfmr25484792plg.141.1664267248368;
        Tue, 27 Sep 2022 01:27:28 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id y63-20020a626442000000b0053b9e5d365bsm1007487pfb.216.2022.09.27.01.27.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:27:27 -0700 (PDT)
Message-ID: <f0c27a5b-fee2-eb64-6855-639e7ea65d37@gmail.com>
Date:   Tue, 27 Sep 2022 15:27:24 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation and
 practices
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
References: <20220926211149.2278214-1-kristen@linux.intel.com>
 <dd89a30e-5403-8844-036c-9c9107cac888@gmail.com> <YzKyqNJk72TY//42@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <YzKyqNJk72TY//42@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 15:22, Greg Kroah-Hartman wrote:
>> When was the bootstrap period be concluded?
> 
> I do not understand the question, sorry.  What exactly are you asking
> here?
> 
> confused,
> 
> greg k-h

Hi Greg,

In the patch, the mention to bootstrap period of CoC committee is
replaced with note about dynamic nature of CoC interpretation. I asked
when the duration of bootstrap period was before we got into status quo.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
