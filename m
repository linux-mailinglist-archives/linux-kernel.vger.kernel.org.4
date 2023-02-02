Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F854687273
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 01:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBBAjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 19:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBBAjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 19:39:04 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FEB1EBD4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 16:38:09 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so2602443wmb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 16:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysJlmM9nlJAmY9FF3751KAdsw1NaojV1QEcIsHtz84g=;
        b=wlFxrwDeuRmjS6Yx5pqeXZSzZ1QwoQLFhH7gYuLp/HNtE9giqgDkoY5fZYbZ6A0XLu
         7Y/flA0JC7K5lODPYOC4tv3SjSyg6YY8ElY67+in9t8CKYGHG5iumtcpk9glngnWwavG
         U01Llmg5Lz5sp1ZIZ4xR4o8OKJdNFfOOTTNOMMqlri0pusWFXqtyBfDxZSJS5h6Vdyjz
         mhAfM8QTa8zffYvmuBLnQJRPt/llkQeBjdbrSIK+Cx52Tg5ce1YIC2hY4NHi9Y/f27fg
         WVi8uBlOooxRhpbOUVkGQhAIZP7v1ZiYq0ow896wtiNrSlmGiBsQPZoYt2YKOLIKcH0H
         tp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysJlmM9nlJAmY9FF3751KAdsw1NaojV1QEcIsHtz84g=;
        b=yEIH5MRYd3fz6nAy2Cc1ODdLieBPwdVclTCOrr2TtU48/Mqdfyc5tuCucHVr3h6ku5
         9NWCxTn+O6iogv3z4XsyUHYtnQSRXsZFlmpJDgTjJ+T16f006GjH3VMlvngEF5zjYdXU
         xH37JNwmSOWxDcbwZ8GP3h3SRiQx5BE6Y6AJidBBKhevDmOG2m0wd/KzQqS4Y30wmQG+
         ilMydDjeKOEyROTWRu98c1A/D5sC5edovktrQ+zPOb/JIG6TLfcPjGsj9GLl2oejvKqQ
         IWWsu5vlN9VXeN++B8oF7ACOEM2fRF25i+LUzJAPPdlzYk//1P2HHq1AVvD/171pLqHM
         JtEw==
X-Gm-Message-State: AO0yUKWYMaZVbE4mswCXo02BG/tAkSAwPDEIyzMceQ4nmDXpvRM985Gq
        GAJuwKxTPn2MlPVluB00Jzrb6hI3xxMSEgIS
X-Google-Smtp-Source: AK7set8q0lFUeh/wpKIoRKCXiQhDqZfQuxvCaIKkLTDoel9Z6n2uUMIR7BuOXGLmzSzJm9o+Qc9mMQ==
X-Received: by 2002:a05:600c:16c4:b0:3dc:4b87:a570 with SMTP id l4-20020a05600c16c400b003dc4b87a570mr4122153wmn.35.1675298283300;
        Wed, 01 Feb 2023 16:38:03 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24-20020a05600c0b5800b003cfa622a18asm3135432wmr.3.2023.02.01.16.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 16:38:02 -0800 (PST)
Message-ID: <8ffcfbf4-a146-11f8-cc86-b2c273f423c4@linaro.org>
Date:   Thu, 2 Feb 2023 00:38:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCHv4 11/12] dmapool: link blocks across pages
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>,
        Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc:     Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org, hch@lst.de,
        tonyb@cybernetics.com, akpm@linux-foundation.org,
        kernel-team@meta.com, linux-arm-msm@vger.kernel.org
References: <20230126215125.4069751-1-kbusch@meta.com>
 <20230126215125.4069751-12-kbusch@meta.com>
 <CAJB8c05HgmDqMn9KwOi2P6+s-c8zt6-oiW6gOo==CDv6=HNahQ@mail.gmail.com>
 <Y9qk13UwzpzN+Y2q@kbusch-mbp.dhcp.thefacebook.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y9qk13UwzpzN+Y2q@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2023 17:43, Keith Busch wrote:
> On Wed, Feb 01, 2023 at 05:42:04PM +0000, Bryan O'Donoghue wrote:
>> On Thu, Jan 26, 2023 at 9:55 PM Keith Busch <kbusch@meta.com> wrote:
>> So.
>>
>> Somehow this commit has broken USB device mode for me with the
>> Chipidea IP on msm8916 and msm8939.
>>
>> Bisecting down I find this is the inflection point
>>
>> commit ced6d06a81fb69e2f625b0c4b272b687a3789faa (HEAD -> usb-test-delete)
> 
> Thanks for the report. I'll look into this immediately.

Just to confirm if I revert that patch on the tip of my working tree USB 
device works again

Here's a dirty working tree

https://git.codelinaro.org/bryan.odonoghue/kernel/-/commits/linux-next-23-02-01-msm8939-nocpr

---
bod
