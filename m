Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9256F0506
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbjD0L2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243754AbjD0L2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:28:09 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CA759C4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:28:06 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a69f686345so64919315ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1682594886; x=1685186886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4uUPRhwCZBn49apj5K2SGGBqEkKq4v7kGq4xBC/z0Dg=;
        b=WbCEAcw8j5XJyOKTX2P4iW2LNZK0ehEFGDGloqBAoj1DwmT9PHFhwXpos1bXys8Csc
         BpNdtnKsVBTrW6cRLUhOiAI0IXdY/6sYVRKtSQBQtshwi8WzNBpxyVsmZebQF4Cpin3T
         pQT6iza1odijCWIIB88WWhssdfi9SU/VjDKwPpi0QZjWCMFJZScQFeYm47aMkABv6+xp
         pxYdZpc9gqe2mgmzVD/SoMaPB+vbDJqD+MYiyjJZcvlxOSyf4B2IYHkQv96el3z5OWBj
         w+YOel6nezMlv+pstY2BMVxS7SVt865vq7sXHEwgrE8zdFQKqWyVQwMaJRQ0g5W5d/hY
         4wDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682594886; x=1685186886;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4uUPRhwCZBn49apj5K2SGGBqEkKq4v7kGq4xBC/z0Dg=;
        b=Q5nKOqeik7InxUe2aWhqWo3x3MFaSxwyA3ePsXx5JpT3wSI14hpIa4isdqf0qK2eBU
         JlQYKT1e3ct8JOJUhS8qGlxjv/5OeQX0qSccmnUyahLaXF0rlZI/xZu5T/VgbBouCcDg
         w5WtIuH9VaJE2pACD9FJePq5Piao539V6M/+YbfA5tzotu3SSgvh2L+0SnTpMud/VJMu
         AiEwAIiXIc0RUD360uuLFwwZRzsQ+XEjUHP7BVtxo9GHUqlC7Kxpa4MBfbELE6YjbTn5
         eSRuEShcp9krZNgtNcGOZHPdx5HgBzKvQPsxvhXfggvoAflugheWlmK0qfKRC6ehikfZ
         CrQA==
X-Gm-Message-State: AC+VfDxu/dWA6RIRQx5t6c2NW79Mne5tldTE8cuPRkthgXx9G05sDjb3
        tXeqlVy0aOANGnBypIMsowkomQ==
X-Google-Smtp-Source: ACHHUZ6Gwsz41V4bSDIveZBr44XGhht0wHgs1JpqCZZ0IFcjUzetIi6IbdGH3sig9m7NYOpbh7FOlA==
X-Received: by 2002:a17:902:ec8e:b0:1a9:9ace:3e74 with SMTP id x14-20020a170902ec8e00b001a99ace3e74mr1354102plg.65.1682594886295;
        Thu, 27 Apr 2023 04:28:06 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:d855:461d:14be:2cce:b776? ([2405:201:d02f:d855:461d:14be:2cce:b776])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001a0763fa8d6sm11485349plo.98.2023.04.27.04.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 04:28:05 -0700 (PDT)
Message-ID: <cda57ab9-bc08-f756-f13f-aeff71d2aaa6@9elements.com>
Date:   Thu, 27 Apr 2023 16:58:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] regulator: max5970: Rename driver and remove wildcard
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
References: <20230427102254.3864526-1-Naresh.Solanki@9elements.com>
 <20230427102254.3864526-2-Naresh.Solanki@9elements.com>
 <1e1383c5-26ae-4874-8873-cb3b8d1a04f0@sirena.org.uk>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <1e1383c5-26ae-4874-8873-cb3b8d1a04f0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 27-04-2023 04:44 pm, Mark Brown wrote:
> On Thu, Apr 27, 2023 at 12:22:54PM +0200, Naresh Solanki wrote:
>> The previous version of this driver included wildcards in file names and
>> descriptions. This patch renames the driver to only support MAX5970 and
>> MAX5978, which are the only chips that the driver actually supports.
> 
> You've not copied me on the rest of the series so I don't know what's
> going on with dependencies.  When sending a patch series it is important
> to ensure that all the various maintainers understand what the
> relationship between the patches as the expecation is that there will be
> interdependencies.  Either copy everyone on the whole series or at least
> copy them on the cover letter and explain what's going on.  If there are
> no strong interdependencies then it's generally simplest to just send
> the patches separately to avoid any possible confusion.
Thanks for letting me know.
Will resend with maintainers included in every patch.

Regards,
Naresh
