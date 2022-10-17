Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A726004F5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 03:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJQBvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 21:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiJQBvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 21:51:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73C83BC61
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:51:18 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q9so9196525pgq.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 18:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0u2/qB79DDSymMhjMNmMe7kf6mNO0BFvgwh+ZdNdWY=;
        b=i29c64fcZ385P5gN/bC6pCEuW/uWOjN5BMPnSv425TTet9kAcW62+87LRLwptVNfSm
         bL7KHV4KC8OvnT0u7OQ2flB6V4B90PANDqtW0kDul6OnfUOtbwQUn7eF1J7PMguHOMED
         sYP4INZwaDGFeQ7idPAGnusGuhqiCJortJUIvJdDH+Ol9pOxw/l8d7qdBAiGRBdHrIpr
         26CvZEYx59N2Pu8/Tp9G5Wn/6/9eq2FqYlzx4LqhBfxZwGyzO1TMrisTKuaLwERlLQxA
         EErCBNGsG2ILHEJk6lW8WPKKm/gw/wGoOtMEi7NsPA4eJwNYhHojQxkhQYY9iZEHjb1X
         Mtjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O0u2/qB79DDSymMhjMNmMe7kf6mNO0BFvgwh+ZdNdWY=;
        b=pg410NAdwulOGVYWd9r/Jxe5jCbb+jzSX2azvQb1v+PH1E0tOEXFI4K/uu2/qIRXdp
         dZGtL/LMGBZ1t0T0TkfyxsW8DJtUnNkmQQzM4dG3Olaofe6zv8FZOI2JS0SAVFcgPba0
         GrX9tQwTX8Ss7F26vyoTlKbXbQBQR9NGOf483Zv5dmsQTAO3bWczQBv32hmBduQHo8c1
         6nqObZ5LlG9awoNJQbDF6hwAMTyBFq3I8fJu+uJvVhy1k6Zst0SDyt94FY53CQXihRrq
         V2hvwmZzERaoAWwN7Lc28syP2ZUbp2qI0tF8dMFiUkSj9EarBrt7psDXetZIrUfT2x72
         hoMg==
X-Gm-Message-State: ACrzQf1XABfZRaAxJfg2Xa0L1SSTwIo7jE3Jsyecw1l2nC5c76Quj4Ah
        BKeneg27AakJx1OsQ64oJmhDcmEtjuY=
X-Google-Smtp-Source: AMsMyM5vViC/nHuZEYX6WRA8n+EnpFuattZzIjESrObM8WLhJB5lqRBuOhsJkd46jBXsztGXBam/LQ==
X-Received: by 2002:a63:d512:0:b0:46a:ff05:ce8c with SMTP id c18-20020a63d512000000b0046aff05ce8cmr8876870pgg.292.1665971478234;
        Sun, 16 Oct 2022 18:51:18 -0700 (PDT)
Received: from [30.221.129.18] ([47.246.101.50])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b0017f7bef8cfasm5327349ple.281.2022.10.16.18.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 18:51:17 -0700 (PDT)
Message-ID: <06a7f382-5eaa-9489-3c28-aa4bfb804327@gmail.com>
Date:   Mon, 17 Oct 2022 09:51:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: reflink deadlock when clone file to
 the same directory simultaneously
To:     Andrew Morton <akpm@linux-foundation.org>, Gang He <ghe@suse.com>
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
References: <20210729110230.18983-1-ghe@suse.com>
 <5821fd0f-2018-dc1b-a5c0-f948a7debff4@linux.alibaba.com>
 <c7e1f0a7-e75c-d1e0-870d-dc480d070079@suse.com>
 <71608a14-58f4-dba0-d695-fee65de89192@linux.alibaba.com>
 <801438f5-655a-c708-aa25-343d54a2f11e@suse.com>
 <86e3d724-3147-ccaa-998f-0f857c575f7e@linux.alibaba.com>
 <a0a9710f-461a-99c8-92f6-a99bb11b3a4e@suse.com>
 <4ba3b404-824b-90a3-ef43-9ab6510ee073@linux.alibaba.com>
 <5a1af56c-3eab-5baf-62a3-1c98bac104ba@suse.com>
 <db7119a5-f120-cebe-42a1-dc2f64db620d@suse.com>
 <20221016162950.09db2b5f503ac87823cd1687@linux-foundation.org>
Content-Language: en-US
From:   Joseph Qi <jiangqi903@gmail.com>
In-Reply-To: <20221016162950.09db2b5f503ac87823cd1687@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 10/17/22 7:29 AM, Andrew Morton via Ocfs2-devel wrote:
> On Thu, 26 Aug 2021 13:56:16 +0800 Gang He <ghe@suse.com> wrote:
> 
>> So, I will send a new patch to fix this deadlock problem via dlmglue layer.
>> For this patch, I want to change the patch comments as a reflink 
>> improvement patch.
> 
> Did this ever happen?  I've been sitting on this patch for ages.
> 
Looked back this thread, the root cause of deadlock seems to be the
asynchronous of fsdlm handling. So this is not a right fix.
While for the performance improvement, I need some test data as well.

Thanks,
Joseph
