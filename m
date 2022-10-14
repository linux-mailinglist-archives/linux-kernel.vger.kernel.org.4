Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27825FEE81
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 15:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJNNXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 09:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiJNNXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 09:23:36 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FE219E02F;
        Fri, 14 Oct 2022 06:23:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 204so4881651pfx.10;
        Fri, 14 Oct 2022 06:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H4xjddBFiOmnGZiEUX+Vkve3fnj+3YiCzJcAITektSg=;
        b=poRwLrKa8hytQgqfDrCIrlZsIKc/WjHdmwh5WVCOLwwN5YTtz0Sj6kNQQfbTZtVsyo
         iHncZ6EQWssbnwHf1jWsb0BjS5kHSBMH6eacY0aisCxYT+TAqpafPfK0qsaPAanoG3N5
         4pzcJr6YeJ9C4ip+7tEKw+Hm0Cz7HUUxjnhgqvqX9gqmuDFEBzkh2SfwBFMpmdAhpIO8
         7DOshSJ9Y9PKsxRnUWBcJK7J2IbQmUHrM5nbu7HFCmJEQywaVU83Gi1hhRf+xAK2hsjc
         HtW0I9BQdcsLYJabD/FLJdmlGOEKMXFzgWP4pyvlWIGBvolmvingHAasKl43QnbIQWCf
         VV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H4xjddBFiOmnGZiEUX+Vkve3fnj+3YiCzJcAITektSg=;
        b=x+gyjWLNdDgrCjaaneIHyhIlC1/leS0vFlfDjKqFBLSsW5BhZ4CjUHUOJ6e1QNyaO6
         7jEiGei6H8jjd0TpGBGmpe/IkzF+ZWuAS+HnrK/oVcQkhovYc6HrzbQqFQJTiWMYS8E0
         b+krol3qusijw725+GtWnIqlsy0PmTzaNdUzXsn0K3ysW/kWuSWTvtF1gXLEqJ5KwDGc
         I5XTA2eWWNrJ/ALlLT5wcVNi6afPgN2BeSLG5BHogXOoCICDh11YiX4abE+BxrewOzmo
         K3OyI+RqfQUN64CTNJfxJ8ZW8LNlD7ni2zU2oFrWI09Sn8PejG+0L3AjAE1M+8S9kMb7
         HsKQ==
X-Gm-Message-State: ACrzQf06yVzL7g5BPeJqWR5FTFcD24d+XWcZxBhrP3JXYeCdvop+M9Yd
        NZXpQUUNnbCYVhCxdsOXYrSCQcIqmn/PuCfo
X-Google-Smtp-Source: AMsMyM47NgsJUD3wlIBoNzJ/JovZeZncfRVPxI7Qv48gn0JbBAbhB6rbDZS5KFk4nKXRKDgbyhfZPw==
X-Received: by 2002:a63:f07:0:b0:440:5c6e:5833 with SMTP id e7-20020a630f07000000b004405c6e5833mr4625962pgl.375.1665753814898;
        Fri, 14 Oct 2022 06:23:34 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id n18-20020aa79852000000b005631af4ece2sm1665778pfq.182.2022.10.14.06.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 06:23:34 -0700 (PDT)
Message-ID: <7353e949-17cc-ed8e-7e98-b3f3e0840623@gmail.com>
Date:   Fri, 14 Oct 2022 20:23:26 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 2/2] Documentation: kdump: describe VMCOREINFO export for
 RISCV64
To:     Conor Dooley <conor@kernel.org>
Cc:     Xianting Tian <xianting.tian@linux.alibaba.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, heiko@sntech.de,
        guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net, Conor.Dooley@microchip.com,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, heinrich.schuchardt@canonical.com,
        k-hagio-ab@nec.com, hschauhan@nulltrace.org, yixun.lan@gmail.com
References: <20221014074810.4471-1-xianting.tian@linux.alibaba.com>
 <20221014074810.4471-3-xianting.tian@linux.alibaba.com>
 <Y0ldrJ91ac0um3++@debian.me> <Y0lfuixXue4k4poY@spud>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y0lfuixXue4k4poY@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 20:10, Conor Dooley wrote:
> Without whitespace highlighting, your change threw me for a sec.. But
> yeah, having the overline is inconsistent with other headings in the
> doc.
> 
> What I wanted to ask about was the linelength as I don't know anything
> about rst. Is it possible to avoid having the ~150 character line or is
> that a necessary evil?
> 

I think the section describes correct range exports; however since there
are many such ranges with distinct purposes, it is better to split the
section into multiple sections describing each range.

If we go without splitting, the 150-character header is necessary (I don't
know how to split the header text line without trigger any warnings).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

