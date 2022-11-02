Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234FC615C90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 07:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiKBG5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 02:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiKBG5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 02:57:31 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130927166
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 23:57:28 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id q7ghoDgDmjJi0q7ghoGZUx; Wed, 02 Nov 2022 07:57:26 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 02 Nov 2022 07:57:26 +0100
X-ME-IP: 86.243.100.34
Message-ID: <a0df7655-ac8c-0834-0872-2fa97d5b8797@wanadoo.fr>
Date:   Wed, 2 Nov 2022 07:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
 <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
 <20221102064747.GA8903@lst.de>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221102064747.GA8903@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/11/2022 à 07:47, Christoph Hellwig a écrit :
> What are th other 29 patches doing in this series?  Due to the lack of
> context individual patches from series have to through /dev/null here,
> sorry.
> 

Hi,

in each patch, in order to give some context, I wrote:
    ---
    This patch is part of a serie that axes all usages of strtobool().
    Each patch can be applied independently from the other ones.

    The last patch of the serie removes the definition of strtobool().

    You may not be in copy of the cover letter. So, if needed, it is
    available at [1].

    [1]: 
https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/


What is the best strategy for sending such patches?

Should I send only individual patches?
Should everybody be in copy of all patches? Or at least of the cover letter?


Some patches have already been Acked or even applied. So I'll wait a bit 
so that things stabilize before resending what is remaining.

CJ
