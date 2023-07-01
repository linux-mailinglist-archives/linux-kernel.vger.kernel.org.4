Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45997448D0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 14:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjGAMLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 08:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAMLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 08:11:15 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149B03AAD;
        Sat,  1 Jul 2023 05:11:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6686c74183cso2205868b3a.1;
        Sat, 01 Jul 2023 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688213473; x=1690805473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1GyuonBm6IUr0u+r5GEAQVpS0cfgB5k80PSwBGFToY=;
        b=KfCNmTFBwiLTda6Dm+DznJq70IhnOvAFC/zYQHCxe3keuHYR4JHjK5JzgH4OkDx2yc
         hXpmbi/rlz80nZG5ufKcxKROcSkcMnBzEzjN+EDQtS3VlvdbOpRBAVlBpgBnv/BYemCc
         wwjnVDGWI4Qzw2yXTiy3Id8dcsfpr+15qamDPQ7CYGPm1bGG6DTkZaT/j87fsezktniz
         A78OIPMEG9uotIa/b1AmRA/pcI9ZJVIL51/IaKmIWTytbxVRL9bH6W0wS5KPuWYcgZGT
         X1X0YWjCoQEJB5G7XGtcQV45Dis4/iB0Rtm+TH4X6Lu0/mQAT7RmcK72eszUsej+8JpZ
         COiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688213473; x=1690805473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1GyuonBm6IUr0u+r5GEAQVpS0cfgB5k80PSwBGFToY=;
        b=jklLHdAabqjjw6qKK+qdwTrBMNAQm2AZYk22NY+FyTugYyvT6NG55ke28yfZySXGCH
         I5sRCpuOx/fEe2DFi7XoOu6ykadnzVzDHaGUoQjpfSGEJgBV57xZaJNv8iJbLysz3e1E
         cJw2OrjR93v9aZQthVkTZoFKNoNPTakKC4+t6mb5A+y52Uu7ft0hH1mF93s0iouQlB3Y
         LIC1B1lMKaS2hF5B54wUTvJFVWSPIiWjgM/XDlHuZVBOe7AKyizk7hgnFqRCUQz/7f3/
         Sw2ShMz0/trYIxf6cgOZazo+EOTZU+UozlrLoStHcBe6J91TgUu2O2v/XqRFRo/IHSuc
         /0wQ==
X-Gm-Message-State: ABy/qLa9XCeNwRqPBwjAmSBFtN8ctCkrzsrrHw/bXiQ4bJRCBt75EPBV
        jk0ZGamUWvU0IagA0nva53s=
X-Google-Smtp-Source: APBJJlFta5cKHhIgxiLxamDAB/Qw2W5giLxoywNe8po2TJMX0I3gw3Sfh3ev9H6ouhWZEi/AI96i4g==
X-Received: by 2002:a05:6a00:14cc:b0:66f:912b:d6f with SMTP id w12-20020a056a0014cc00b0066f912b0d6fmr7785028pfu.0.1688213473510;
        Sat, 01 Jul 2023 05:11:13 -0700 (PDT)
Received: from [192.168.50.210] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id i22-20020aa78b56000000b006687198c3easm11781138pfd.179.2023.07.01.05.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 05:11:13 -0700 (PDT)
Message-ID: <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
Date:   Sat, 1 Jul 2023 05:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Content-Language: en-US
To:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230620133711.22840-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/20/2023 6:37 AM, Daniel Wagner wrote:
> Commit 4c984154efa1 ("nvme-fc: change controllers first connect to use
> reconnect path") made the connection attempt asynchronous in order to
> make the connection attempt from autoconnect/boot via udev/systemd up
> case a bit more reliable.
> 
> Unfortunately, one side effect of this is that any wrong parameters
> provided from userspace will not be directly reported as invalid, e.g.
> auth keys.
> 
> So instead having the policy code inside the kernel it's better to
> address this in userspace, for example in nvme-cli or nvme-stas.
> 
> This aligns the fc transport with tcp and rdma.

As much as you want to make this change to make transports "similar", I 
am dead set against it unless you are completing a long qualification of 
the change on real FC hardware and FC-NVME devices. There is probably 
1.5 yrs of testing of different race conditions that drove this change. 
You cannot declare success from a simplistic toy tool such as fcloop for 
validation.

The original issues exist, probably have even morphed given the time 
from the original change, and this will seriously disrupt the transport 
and any downstream releases.  So I have a very strong NACK on this change.

Yes - things such as the connect failure results are difficult to return 
back to nvme-cli. I have had many gripes about the nvme-cli's behavior 
over the years, especially on negative cases due to race conditions 
which required retries. It still fails this miserably.  The async 
reconnect path solved many of these issues for fc.

For the auth failure, how do we deal with things if auth fails over time 
as reconnects fail due to a credential changes ?  I would think 
commonality of this behavior drives part of the choice.

-- james
