Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A074C73CECF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 09:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjFYHHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjFYHHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 03:07:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345BCBF;
        Sun, 25 Jun 2023 00:07:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C27460ADE;
        Sun, 25 Jun 2023 07:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999C4C433C0;
        Sun, 25 Jun 2023 07:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687676865;
        bh=QneLE4H1o+Lxh8t2cx4M+9W8iJfMgYZLsP6GgnjIgtU=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=SItTricsiYViqlheveu8Us1v90DnbiFWUT3tNXJAW36asiL4uGAy8x2s7QVNladu6
         rGH3PJcy1wJf+fabkDWoG/WP1LhMGg3fbjw0SOKC6W7BRuGI/5W0wA/smzeP9ANvbz
         /tuLajILSf26vRI5Am4nUH0hlB/4lD7TqM8750GbkwmEHeI7bCN56Qc1r2jpI6xP1v
         Nd65l1GLYDwspVOM3bnPfiFAXxNtkwiI52vcpqLUx4d6MDEatX/+DtK8IuGjcxKD2N
         ZITA5JVREebb6wXe8HTtYiFz3E8gpXoPHKdXGoRGzE5pwRzf8IlTWw+WbMFcrBe24C
         COqMvqWsy6pOA==
Message-ID: <f93949dd-e90f-a9bf-33b3-4f31c4328c7d@kernel.org>
Date:   Sun, 25 Jun 2023 15:07:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, hch@infradead.org, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230310123604.1820231-1-chao@kernel.org>
 <b53321ab-679d-e007-6407-6bd00149948e@kernel.org>
 <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From:   Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v5] scsi: support packing multi-segment in UNMAP command
In-Reply-To: <yq17ct0nijm.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/23 5:51, Martin K. Petersen wrote:
> 
> Chao,
> 
>> SCSI maintainers,
>>
>> Any comments on this patch?
> 
> I have an updated version of your original multi-segment UNMAP support
> queued in a discard topic branch that I intend to submit shortly.
> Without the UFS HPB bits.
> 

Martin,

Any progress on this patch?

https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git/commit/?h=5.20/discovery&id=834e3cef205d324c66bbc7edd85541be59f1f7b6
