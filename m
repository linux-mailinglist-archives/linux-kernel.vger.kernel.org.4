Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9241A6A6545
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjCACGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCACGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:06:01 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA7755B6;
        Tue, 28 Feb 2023 18:06:00 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-172afa7bee2so12983750fac.6;
        Tue, 28 Feb 2023 18:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677636360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xVqcFtg7kVG8V0qj9xxJLXTxKinuC56rq4O/0sV1arw=;
        b=qSzmpSmGykvvwQ8KGqUAcVFJASpvfqa6eqOT1rcPebO6HO+sWPd/1gyC5YSuK3uEBL
         iptefhYBM+M4/45Q6oSJfs0GTqAFpeRmWKzo3r9+L/oOS8pIenHiaLILBkbOvgVAQBJG
         L/g2WF1oykOE7IqfbKzT68smXfRphV0dRLmrW5BTnpX7m0fBNF9uG4TPt9ccEclCeR5J
         mJ8ULOhM4Ha4hplkaNf1izk9hrtOqHeMrrOiXn8GV7+64yFLL4yxQo8ycHdWYmMFWMR1
         C8kgAG1QEhd7HVMujOW7SBw8TfzrmTOdbiMDVrhgmVURki4VUXrDxUEDv4QHzKIYux1e
         gVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677636360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xVqcFtg7kVG8V0qj9xxJLXTxKinuC56rq4O/0sV1arw=;
        b=sCxQy9mjOlsnr0io0U+dyOgUG0jUqA+9dfL6cBQVXmqTnHvSZVLJTQxJ9uvXKKtTC+
         g8dK59Yd1ECJUgIgm8Gj0s4OVWylqdmItqBxDVULHT8POB76P6Mfjz0xk9QHFkCNtso7
         UJOsrAw0qMUMje4qXT+uq14EcMETuwES5VJyjQ7meXPbQbhWeFNuK8ZY17M+PYDY8Jby
         /wJ38PzAR/IL8prqANUvmzTs94fhgjnOLjOnkMmVaYfyrBzIRNXyGSUHo93vgK4GkuDB
         K/O9ZliHJ0RD6IjNE4wVPNU0ncfb76/y+UgxQoRhV1nFqUhYoNj2VGaUr0Mg16A06rYL
         SEvQ==
X-Gm-Message-State: AO0yUKUHMOFkZI1twCkrimDOrhHnPe0SMYIRYQToiGdQTfryfBAXC2QU
        /Kh62GeYtrAwwOXAYYLOMkI=
X-Google-Smtp-Source: AK7set9AxPxVAxJ4JgJoNQHlubLlU9fkkq1N5br5KsrCpT0/qVCTQlgIHjJiRSQkMHTg79UklbAFpw==
X-Received: by 2002:a05:6870:e309:b0:176:2145:5e18 with SMTP id z9-20020a056870e30900b0017621455e18mr501822oad.46.1677636360021;
        Tue, 28 Feb 2023 18:06:00 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:488d:18da:bebc:d316? ([2600:1700:2442:6db0:488d:18da:bebc:d316])
        by smtp.gmail.com with ESMTPSA id eg41-20020a05687098a900b001724742cfcesm3948184oab.38.2023.02.28.18.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 18:05:59 -0800 (PST)
Message-ID: <cbf76155-4355-5241-d7a5-816e6721ce1b@gmail.com>
Date:   Tue, 28 Feb 2023 20:05:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230223213418.891942-1-frowand.list@gmail.com>
 <20230223213418.891942-2-frowand.list@gmail.com>
 <CAL_JsqLR9sm+GRU8EP4eO_Ln2UhD=ztdAU834CzP8RSv2s2jQg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <CAL_JsqLR9sm+GRU8EP4eO_Ln2UhD=ztdAU834CzP8RSv2s2jQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 11:17, Rob Herring wrote:
> On Thu, Feb 23, 2023 at 3:34 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> When enabling CONFIG_OF on a platform where of_root is not populated by
>> firmware, we end up without a root node. In order to apply overlays and
>> create subnodes of the root node, we need one. Create this root node
>> by unflattening an empty builtin dtb.
>>
>> If firmware provides a flattened device tree (FDT) then the FDT is
>> unflattened via setup_arch().  Otherwise, setup_of() which is called
>> immediately after setup_arch(), and will create the default root node
>> if it does not exist.
> 
> Why do we need a hook after setup_arch() rather than an initcall?
> 
> Rob

It might work as an initcall today.  Maybe not in the future as other
initcalls are added.

But my main stream of thinking is that before the patch "we know" that
the device tree data structure exists when setup_arch() returns.
Adding setup_of() immediately after setup_arch() retains that
guarantee, but one line later in start_kernel().

I could have instead put the call to setup_of() into each architectures'
setup_arch(), but that would just be duplicating the same code for each
architecture, which did not seem like a good choice.

-Frank
