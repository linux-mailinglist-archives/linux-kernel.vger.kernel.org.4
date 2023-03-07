Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA0D6AD631
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjCGEWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCGEVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:21:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B4D80E16
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:21:13 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cw28so47432802edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 20:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678162872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6hqEkT/LNIvtq4ZHl1mUunRseH00GHLQMY6WXXGwOM=;
        b=u+d6SR1Z/9lh6/d/v7YLU5EvQpi4JWlyT7b9prNf+4U5AoEgCQQVnm8OdlYQzJZOIZ
         rrsMK7F6DKD0B0zFC/tThzB/VtSGXossihkiH6CqXNt2iaJTaHq7BFl5peXPNz4ncLjt
         ewpE90AghDEbOlkFxovEti0nIUTyq9f2FCXOmNffaxOilR+RjGmgtido6cPX4WNylNmP
         npiPJZ5asIycPfjVsKrJNI+VlUG+Dqcg2sYRkRqcP6KERqe/R3ftwDQ+wKIdAHXCojM0
         K8i1biFqUW/O4UMCpOKkLBx2lD2cjaiWq5PHKi7FFs2WfD/wR4yt0BtrvKOpjEgfbXHn
         up+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678162872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R6hqEkT/LNIvtq4ZHl1mUunRseH00GHLQMY6WXXGwOM=;
        b=dtnYm3LarYUUHyZJOA6gnYBftbSzP1M+JVCbu6FNUQuRV+zWq9VEFIQ5g7VWoJlHjp
         lDr/O2T/EWxaR0Eo+xNGPI/VN8wHCBBHeaYSP231AbAEioxySZmCsU+InCMbQPDOgho+
         zUJWN3OSP/1Hq1VC6t/4X1KA25PjmSnceDAOEl1IoAXRuHCxtjphBh2paFUz1zssn7iI
         5jNbgebtssYxY6skI2kIky+iH+/Rg9TPIl5lDWEBajx4I8/hstaBFc+HlOJ8rebJqhj/
         CwG25vmwHJKnCPRjc/MX0tZveEpC0paNaWK5trbwhAYnAC/7+qzBxjlH0Koajn1EzuX1
         nnZQ==
X-Gm-Message-State: AO0yUKVhXDPo/MLUZ12akFrNslJAUr4q0xvVyVlIPXHba99ZV/D9+qri
        KsV0hu9bUz7vlwpGlW6LhhWc20coAL6HQs2eeKIvRw==
X-Google-Smtp-Source: AK7set+r0tF6JBXxJqwMfhX4rBE0rEOE9RzrvS5/X9eHIIFUmglTdwr4eZPvR7zlr6tvrFh3wGOs3A==
X-Received: by 2002:a17:906:308e:b0:878:7a0e:5730 with SMTP id 14-20020a170906308e00b008787a0e5730mr13215080ejv.56.1678162872128;
        Mon, 06 Mar 2023 20:21:12 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id n24-20020a1709062bd800b008b17aa6afc8sm5429013ejg.30.2023.03.06.20.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 20:21:11 -0800 (PST)
Message-ID: <1bbda9e6-37fb-195b-fd62-0e437847c636@linaro.org>
Date:   Tue, 7 Mar 2023 04:21:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V5 09/15] spi: Add stacked and parallel memories support
 in SPI core
Content-Language: en-US
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        broonie@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        vigneshr@ti.com, jic23@kernel.org, pratyush@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230306172109.595464-1-amit.kumar-mahapatra@amd.com>
 <20230306172109.595464-10-amit.kumar-mahapatra@amd.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230306172109.595464-10-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were too many recipients in To and Cc and I couldn't reply to the
email. I whipped off the Cc filed and most of the people from To and
added the lists in Cc.

On 3/6/23 17:21, Amit Kumar Mahapatra wrote:
> Multi CS support using GPIO is not tested due to unavailability of
> necessary hardware setup.

Please don't add code that is not used or tested.

Cheers,
ta
