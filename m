Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511EC6F6907
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjEDKZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjEDKZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:25:31 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB6F49FD
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:25:30 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f3284dfe34so550235e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 03:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683195929; x=1685787929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHdkDwrOfS1Pl3Nuhj1rXOfP6XDushocOsRTj6KWz1M=;
        b=NXPG9Wfz9UQjR4hk0My7PWYpRBGdoM6I++VZy/nwy0ivpO8NnUw5EbGKy2Jgkt53Ow
         2+mNP5maUaGlmvvIst0a5fdVKCagqPvsF4XC6emqUGFPei3ZPBbCiOdzbH0QRh8Aclh0
         YWfYiyPujjnIgmvqcToYaw926YDyqjV0wtVXjilSsLWDKTQ7SezvyyU393QcQMyAdewj
         l1yHJJ1LNOp9xFcnDpmZiV7j3D4wrYryz90R8EB8XwNxKA0K9zJG35Gcps0awa4Wth1t
         YHQZ1jNwg5UXHx7+B2nm9iZM6NSnHtFHISTJu9eEmaGQtbZBH5JMQ/lqZAy5lVy356+C
         JVNQ==
X-Gm-Message-State: AC+VfDz8RA/dwUIN+HlbBbk0v3aQnLmA4xtbzAQXxCFfPitEdOmGje3K
        jjmO5LmGY25HtEsc+1pUSXw=
X-Google-Smtp-Source: ACHHUZ7t6M+shOVxJ7YoMgvBWCMlytSjbzzI/g47scm56f7mEpYxhxFFG4jVNweVmv2Ev8pE7eBdPA==
X-Received: by 2002:a05:600c:602a:b0:3f1:8c5d:145 with SMTP id az42-20020a05600c602a00b003f18c5d0145mr7009157wmb.0.1683195928651;
        Thu, 04 May 2023 03:25:28 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f17122587bsm4466407wml.36.2023.05.04.03.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:25:28 -0700 (PDT)
Message-ID: <dca2b65a-2b76-50ed-7c58-e304efe1021c@grimberg.me>
Date:   Thu, 4 May 2023 13:25:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v3 0/9] Unifying fabrics drivers
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
References: <20230504091259.29100-1-dwagner@suse.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230504091259.29100-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I've rebased on nvme-6.4 and gave it a bit of testing. Up to the last patch it seems to
> work fine, at least blktests doesn't trigger any errors.
> 
> I've tried to split the pure moving code around part from the part where we need
> to change some code. That means the last two patches highlight the problems I
> run into with this attempt to implement the setup_transport() callback

This should be perfectly fine covering loop as well. I think that
eventually it can cover pci as well, but we can promote it there in
time perhaps.
