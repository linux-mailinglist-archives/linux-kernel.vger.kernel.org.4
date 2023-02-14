Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54CE695D00
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjBNId0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBNIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:33:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F168A974D;
        Tue, 14 Feb 2023 00:33:22 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id h4so17554392lja.2;
        Tue, 14 Feb 2023 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3btgZZ+VvYhtAijf0w9nPe8dkvozarsDU4nJ42Vwmc=;
        b=VQlJhY9VpUefEHCLxEnsAkhuoKDQO15F9j4pR50Rpa0UNZNwsQM3ur+8xJz7XaE2Y6
         iUYW0+oR0HKi6OamNh7Srz20sQ8yNvQvtEV7RpctZSEgcph+V+fzZ6wJv9ZfHrxTqvJi
         zMp3C21g2wd/bQnN7s6+zONddtFjJHt7o+dT5xswac6xAQurpWhlWKUqOTbEtsEOv8Ct
         3i8QCEpZOB3dmul86Dnlmdn9Zh56mZYI1qW98c+2sQRn0nxtlZqzXWexNqHsaJ1yNAUX
         Yb0WXUOblBGx7CzcCwWSxxi5mPAqtCN8HCMQzb37aPWmzEwuBgLZU1RO4wCsqYdAd2fe
         xzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3btgZZ+VvYhtAijf0w9nPe8dkvozarsDU4nJ42Vwmc=;
        b=HJrpQ4mR1bV/YrxsZMQSULl9fL6Ln40mMKQnIkQ858p/urmjuA6rIdxRghZ5gcn0Sr
         Phaqs8sFOKblU6vwzNQkeMBC5J3fyLsWGreBJ0xjABpIvklFcYZdbfgReP+ABTuA0f0h
         9rXM/5F9RLk/cZG0iJssNdNJfPMpeKC4+nyhVLIEq3hLMAfoSeK+u54CWG0uU1vRSz/6
         avqKZG83OAi3QlLbaaaUuY5u743hGbINm7JzQbTpVbfBvxds/wX5mraclbODDPto9J+J
         GCXZxomfwABCVn2HXDNbM0oJ7+Jfy9zYQ4+lsDWQL+cm18yTT6c9TmjQ12dXvkNdi2Co
         DwSw==
X-Gm-Message-State: AO0yUKWJczyCKZf1TvTJdCh9TpsSh83ci5ZdujIJiyof+2s1oNJ5+Q4R
        cLjF5+lyOg9C2KKJwKHqgQZF2aFZULc=
X-Google-Smtp-Source: AK7set+zFfL/DUdoIvBUW4BehA1ur3Z5h04TLOiJ+Je88+o4esnyYA4vZc+gT7lqEwxaf7BeP7M7bg==
X-Received: by 2002:a2e:8806:0:b0:293:2ef5:9434 with SMTP id x6-20020a2e8806000000b002932ef59434mr667276ljh.2.1676363600939;
        Tue, 14 Feb 2023 00:33:20 -0800 (PST)
Received: from [192.168.1.103] ([31.173.87.80])
        by smtp.gmail.com with ESMTPSA id h23-20020a2e9ed7000000b0028f7e86f522sm2306263ljk.96.2023.02.14.00.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:33:20 -0800 (PST)
Subject: Re: [PATCH] ata: pata_octeon_cf: drop kernel-doc notation
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        David Daney <ddaney@caviumnetworks.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-ide@vger.kernel.org
References: <20230213212549.29914-1-rdunlap@infradead.org>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <51fb5b13-3e9c-785f-b96f-6f398389d434@gmail.com>
Date:   Tue, 14 Feb 2023 11:33:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230213212549.29914-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

   Hm, why didn't you CC me?

On 2/14/23 12:25 AM, Randy Dunlap wrote:

> Fix a slew of kernel-doc warnings in pata_octeon_cf.c by changing
> all "/**" comments to "/*" since they are not in kernel-doc format.
> 
> Fixes: 3c929c6f5aa7 ("libata: New driver for OCTEON SOC Compact Flash interface (v7).")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202302101722.5O56RClE-lkp@intel.com/
> Cc: David Daney <ddaney@caviumnetworks.com>
> Cc: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-ide@vger.kernel.org

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey
