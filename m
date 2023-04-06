Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF046DA579
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbjDFWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 18:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbjDFWBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 18:01:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E993EB463
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 15:00:59 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id nc3so12011406qvb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 15:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680818458; x=1683410458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ta3JLtW21yvnqsr8gqKdWnhkJg3SK9UIwXLc4Y7NpvE=;
        b=I7r/dYznaE7l7UhrlO+tqohb9aiHOvLgawUVRumaWg5nEfpaiJRp6f4NJ1Y4eviNk0
         fWchrd6c0s6SqMkqc8nxqP9K1pvaTlzFg6ydVak18SvPPvUSQdGVCYHkn2SiVzA+yvpq
         W1z3OM5OahGwtQJ956c2AJ91maBiuj7RP0E9//Q9Eiq+G7P6DXqh2wrOXudThqxQSQVG
         AcA1d5Cb4hTXDcG2Kdm4K2TeOZyhro0ts4R4o15I+NI0T/ABXJhJo3BNRNH7BtW1T2f+
         RtE22WzgtSnLWDWcHYNHFT/sqffUz+oSMUtswZDkDts0ldNFBcFUsk1I+X9uQ5l2LIH+
         IoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818458; x=1683410458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta3JLtW21yvnqsr8gqKdWnhkJg3SK9UIwXLc4Y7NpvE=;
        b=Zuh+YNbAlpeD6e2ltLu80AIF1zvlml0ilhMBumUXAuQ/UKn6jpWP9w2ai6FAnPt4Ec
         groTk1SjWF6gv3AssNq+64NzUgCXII30TIYfb5V7LV4913SBseyXFXnCUwC/50BTxyto
         4skgmFM+VZtPq/mHUNoEaxWOSooHPRm9PZuDitQG263XuhBJC//piLZ5O4ZL0/eQjXaw
         1esr5w0YwYFIPJaCN8moLgY93ZcTFPp4CJUI3qTOKELQRTPW7zChOENJVa8mZCNo/xrH
         MJPn7cT0DN4ApzCPaucxybNC701NYBAmmCy2txsfP5488iFQL+GLP9GHsN4LCvhq42GB
         AOMg==
X-Gm-Message-State: AAQBX9enWwPnBNXfO8PiSEh41mgNXRWhvu9hB1YYf0CS/oeP1fs0sZsD
        fZmIKrMqRQntv2P3bHComcw9UttOs4A9wQ==
X-Google-Smtp-Source: AKy350boBpE2YzU/DtDYKD2APlnUNd6LJyDg/vGiFiGxV73XDyIMFW9lMhjkciKDB1e9SjxOsoXWtw==
X-Received: by 2002:a05:6214:501c:b0:5e7:9e1b:b26d with SMTP id jo28-20020a056214501c00b005e79e1bb26dmr1593107qvb.16.1680818458092;
        Thu, 06 Apr 2023 15:00:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x78-20020a376351000000b007466432a559sm791346qkb.86.2023.04.06.15.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:00:57 -0700 (PDT)
Message-ID: <5958dcbe-6de5-ce8e-5740-390aae52c298@gmail.com>
Date:   Thu, 6 Apr 2023 15:00:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/gdb: Print interrupts
Content-Language: en-US
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>, kapil.hali@broadcom.com
References: <20230406215903.1581378-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230406215903.1581378-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 14:59, Florian Fainelli wrote:
> This GDB scripts prints the interrupts in the system in the same way
> that /proc/interrupts does. This does not include the architecture
> specific part done by arch_show_interrupts(). Example output:

Andrew, scratch that version, sorry I forgot to update the commit 
message to indicate that it *does* include arch_show_interrupts() for 
x86, ARM, ARM64 and MIPS. Also ARM64 should use the helper to show 
irq_err_count. V2 coming up shortly.
-- 
Florian

