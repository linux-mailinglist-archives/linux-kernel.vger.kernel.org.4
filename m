Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CE46BD96B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCPTkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbjCPTkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:40:00 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A79F052;
        Thu, 16 Mar 2023 12:39:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l13so3071755qtv.3;
        Thu, 16 Mar 2023 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678995590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yeSVuJbfbAiyDBbGVZqQfzWs/qS0G4aw3en1JoLjwsI=;
        b=Hi9u3mWWGZ9aUUQJaxhocbFPtGGZJbSSkHZNECkQX4As4UhkH/7dA1SneR7pqJn2g6
         eNJo1Z6Y7sWQQhRkB4di/rtQGQJZFYUY0viEOjUXiuy1gxo0xTqCtuPeDKZ57qVBHKkz
         Z/G7hcEONPelJkKBkI91Ya/nqeawH5I4StGU8g3ESSViEkWh9vxOVbmrxvRDLw5uL/jV
         Rc7lF6hjDhhvYIA42jZ2rrvspA5H8VX1HaMNV7DJa119t2HYqjrxRsQebTGllRREWtRw
         s9oe4LSyfbyRUbCVbP0dvICPhI6l7dGEWT4wPhEUARxRwewG4hXzGDUBnYG9UScU50SM
         PZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678995590;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeSVuJbfbAiyDBbGVZqQfzWs/qS0G4aw3en1JoLjwsI=;
        b=5lkmgDERe4vEsHCvZagPY252y+cR49bbjk/4UUc3xhyJ/a7dZC8z4dQUENAcCh/x6m
         L6BJEzou3TJVeSzHE/90ODTcACW5pZdWHEFyNHGzDxB3OaaytwzlzIBeR9aGd6bGnIa3
         QP++NSHEsC/vnUhU4fuKv2FsBxYNMuyYYJsTIafNZ9fM9rgzoLKqR0m0+iX0BCm+dTbo
         CsQMVxfa0RvEpzAOxoATHT25OlipntHva+T+DY9W+Kb5w3JoIy2Ixzdn1EkjevfssQ8z
         0YtiuVkewk1tqL268o55kAv5ad4kRp145H7G+wfSBbqiF4VoCktUqvo0bUm2XbXrLFG3
         CxOA==
X-Gm-Message-State: AO0yUKWdnFzKhPBkX0gL0z2DEy3fkqZpbGbp2/ahE0sLqLgssCsPnxfl
        o3U3wASJ9+qUzbVXX7XryGg=
X-Google-Smtp-Source: AK7set9/gD9oz/juFzwwPpXYLsbKki4M6ojVnzOgwTm5FzdVXowFN13ZGmMdTnUJA9uqOSWu9jJU6A==
X-Received: by 2002:ac8:7d50:0:b0:3bf:e15f:935c with SMTP id h16-20020ac87d50000000b003bfe15f935cmr8067883qtb.14.1678995590082;
        Thu, 16 Mar 2023 12:39:50 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i21-20020ac87655000000b003b9a73cd120sm214723qtr.17.2023.03.16.12.39.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 12:39:49 -0700 (PDT)
Message-ID: <f47a2b11-dc89-08c8-76ef-d82ca116bed4@gmail.com>
Date:   Thu, 16 Mar 2023 12:39:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] irqchip/bcm-6345-l1: request memory region
Content-Language: en-US
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tglx@linutronix.de,
        maz@kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230316180701.783785-1-noltari@gmail.com>
 <20230316192833.1603149-1-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230316192833.1603149-1-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/16/23 12:28, Álvaro Fernández Rojas wrote:
> Request memory region in order to display it in /proc/iomem.
> Also stop printing the MMIO address since it just displays (ptrval).
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian

