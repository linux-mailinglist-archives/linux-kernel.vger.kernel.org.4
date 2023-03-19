Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2AF6C020C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 14:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCSN22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 09:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjCSN2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 09:28:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321DF1E5D9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:28:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id g18so9561986ljl.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 06:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679232499;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U085WPx3PknCWGTgV9CLiUBDPWZ8nYvt3NwSvqgQP74=;
        b=kKErUWuVOAp+eU+Q3rPtmRHwXtPKcSh8qeHsr+smCIUgzc1C3C0sM6jb8Cfomt7pWA
         xysNCniommKH3IEtiKdSFAuZffJ9fnZjlU67pg9y9qciMWHIT/CUf4GSgO7HMrmwTt/I
         KekKtw728GS99NO4u+ao3MOGdlqntbG5TtugLuQKwK0c+wS5+HaLiKHWNkHBL8vSmH8D
         Ijm2zDOCbRDYZADLjLXlJ7gmqqBDS1ZuDfsZSFWWJ3gjD8x1CWeSoB11ZtyYOSjJwyEN
         JcPk9R0rVp8rp43N7hlVQPfEzuA1EnmuAdHVPtKRSe5hfwxHi73wrCqTdSYnElBYSQMi
         TthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679232499;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U085WPx3PknCWGTgV9CLiUBDPWZ8nYvt3NwSvqgQP74=;
        b=JESiceCqHP4Umx7UZ9VYjYVxJ0y2iqisGdCAPXKioPdKMuS61rF7K8lGRCWBDHQf1T
         Ne0T2a2MwLHwE+4+brDLbo+jGYRVN+gXUVTjjVxdgeDRxgEiYG3AEZYZBcpx6tAQEqnM
         qNKjjHskRf9Vk8cGOqK/JP3fXJ6Klg6RhJRXk0mhp15KJZEVDrJabpFsAhYPA4Ku5sOr
         yD12zHg2yqun+OswinhQ08Qyxra4Eo9C9HFEcSv7ODlKcRrSWK9ffSlThvfI2bMIvQ1S
         ABaTiDOyp1I5/zL7L0CwgnxQFf+v2epdP0TbE2XbSEgicPz1lZc2/AkWItpT/gshr1RA
         ss9g==
X-Gm-Message-State: AO0yUKU3hgBfRHSZeeM0EmV6DOlUo9tv6uU/OD0gotCAFiQiIpocZamg
        bYRjTqA1RCZnCA6WwhHcMDA=
X-Google-Smtp-Source: AK7set83/08Uv/NUXTqhHUk+kE83ctIswsRw4sGFfd9eI4zVL19Hw/HfkCnjns2zGGKxiMjwDZJVcw==
X-Received: by 2002:a2e:9c46:0:b0:293:2bc6:d50b with SMTP id t6-20020a2e9c46000000b002932bc6d50bmr4683277ljj.18.1679232499131;
        Sun, 19 Mar 2023 06:28:19 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id u14-20020a2e854e000000b00299ab2475ebsm1297793ljj.1.2023.03.19.06.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 06:28:18 -0700 (PDT)
Message-ID: <e32ae8d1-f0e4-5434-49e0-c19701967b24@gmail.com>
Date:   Sun, 19 Mar 2023 15:28:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US, en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     mka@chromium.org, Liam Girdwood <lgirdwood@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, briannorris@chromium.org
References: <20230316195444.3946980-1-dianders@chromium.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 0/7] regulator: Set PROBE_PREFER_ASYNCHRONOUS for
 everything in drivers/regulator
In-Reply-To: <20230316195444.3946980-1-dianders@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho peeps,

On 3/16/23 21:54, Douglas Anderson wrote:
> This series directly follows from the discussion when I tried to turn
> on PROBE_PREFER_ASYNCHRONOUS just for the fixed-regulator [1] and
> attempts to switch everything in drivers/regulator over to async
> probe.
> 
> Like the similar patch series I did for the MMC subsystem a few years
> ago [2], I've split this patch series into batches corresponding to
> drivers corresponding to actively maintained stable kernel trees with
> the idea to break the patch series up somewhat.
> 
> Most of the description of this series is contained in the first patch
> of the series and then the further patches simply refer back to the
> first one. The logic and reasoning behind all the patches is exactly
> the same.
> 
> As talked about in the first patch, it wouldn't be at all shocking if
> this broke someone. Hopefully this doesn't cause too much of a
> problem. Most of the problems expected would be real underlying bugs
> that already existed and were just tickled by this change. If you're
> facing a problem, it's fairly easy to force individual drivers back to
> "synchronous" probing while the problem is tracked down and fixed.
> 
> I am opting _not_ to CC every single person involved in each of these
> regulators on this patch series because I suspect that the mailing
> lists couldn't handle CCing that many people. This should be on LKML
> so hopefully people can find it there and respond to it that
> way. Anyone who responds will get CCed on future versions, if there
> are any.

The ROHM bd71837/47 (which is included in this series) as well as for 
the ROHM bd71815, bd71828, bd9576 and bd9573 (which are included in the 
other series) - there should be no PMIC internal dependencies to 
regulators. So, from my perspective this looks good.

Right after saying this - I don't have access to most of the boards 
using these PMICs - nor do I know what kind of system level issues there 
may be - hence my ack is not really worth much - but at least I can say: 
"Yes, bring em on - I am mentally prepared for the bug reports" :)

Thanks!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

