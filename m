Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A06B73993D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 10:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjFVIT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 04:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjFVITY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 04:19:24 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172C71BE3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:19:18 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51a2c8e5a2cso9010280a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 01:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1687421957; x=1690013957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jHOSAVpysPPk0w7f3FRoclTHTOeGMXkD/WXz6o43PNs=;
        b=3Qv846galtOKu5j1ZWBEoKDHHvAGKed9GxYf8jtUaOyAmrvsfZjDSr11Mtds2ZkfsI
         z8E8JaX+BZgWcwZ2px/vjwXcVXe/G2papWnvWRx6juFbdgri5wzM8KU/VFH3hTMSEY/0
         VfuMGKTLX1S39ewKkuOV2SpC+iB2Qxt8EdDCl8XAOUYAhUTLDSJj03+VyN3vhCChcTCl
         lrqf85TQV4hEAXb07GWK4bCN0TBaaVw/tm7VOhXosmsRqHnh6sbKdsnQJ3TgsnBbZGFI
         ddqk0x6z9ItamUScnrwLYCUjQwH4H12zJ3Nk3UozHB53yrgaeMe70sas3bN2pKoz74Zq
         Os1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687421957; x=1690013957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jHOSAVpysPPk0w7f3FRoclTHTOeGMXkD/WXz6o43PNs=;
        b=BjuvQFL1kdjBSqtwgduVJSXxApa8CaG856IyHtgYVXoJV9d04dmiWBrwf3jSLE4TDH
         ZWmIenE0/hFi8y6N/xHvK9gfSIIKj2tOR2e8TTuzD5sKQ9aRdeyn2KNkFUKyt5d8bzmf
         PcZl+aWiYEskhDXs/yVWgx09oZL8SklAzYbamOqH14kxZRIR/b5IueskRsVSFe/qaqg2
         98YHS6y537ztGYbmKSg1yX6dfsnzF5S7uXolUd0HsFd2MgyyfyalEFqRygZ6+q5a5q1v
         jKLHBZTctOJTx2VVZZmWVjnQDYB4pId+qGd73irM6KJoRlq9JxHMeikhVKo6g12I2zIc
         2RNQ==
X-Gm-Message-State: AC+VfDzOwvPxBDB/A91Vtx51JVcDZGqlR/fFOHS4rBBNVg8cslmtak2a
        eviTvYRrNOv/ZpZuUGhm3egXAw==
X-Google-Smtp-Source: ACHHUZ5DAgOwgq4jsUtrZx0dccBdImVh49Nsq8bOifuGfOiRsZ8BsC2vF2kKv6FbxkokTfB+nxu/0g==
X-Received: by 2002:a17:907:e93:b0:989:1a52:72b0 with SMTP id ho19-20020a1709070e9300b009891a5272b0mr7626807ejc.36.1687421957297;
        Thu, 22 Jun 2023 01:19:17 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:c154:8b90:b6a7:cb1d? ([2a02:578:8593:1200:c154:8b90:b6a7:cb1d])
        by smtp.gmail.com with ESMTPSA id q13-20020a170906360d00b009827b97c89csm4166097ejb.102.2023.06.22.01.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jun 2023 01:19:17 -0700 (PDT)
Message-ID: <88685bc2-8467-b999-4b2e-91c381c04d8e@tessares.net>
Date:   Thu, 22 Jun 2023 10:19:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/8] selftests: mptcp: connect: fix comment typo
To:     Yueh-Shun Li <shamrocklee@posteo.net>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Kalle Valo <kvalo@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-scsi@vger.kernel.org,
        mptcp@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230622012627.15050-1-shamrocklee@posteo.net>
 <20230622012627.15050-8-shamrocklee@posteo.net>
Content-Language: en-GB
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230622012627.15050-8-shamrocklee@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yueh-Shun,

On 22/06/2023 03:26, Yueh-Shun Li wrote:
> Spell "transmissions" properly.
> 
> Found by searching for keyword "tranm".
> 
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>

Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Thanks,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
