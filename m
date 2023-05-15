Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9B37037CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbjEORYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243672AbjEORXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:23:45 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21965A9
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 10:22:23 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id ybtopjGaAOrpCybtpptulC; Mon, 15 May 2023 19:22:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1684171340;
        bh=j2msEUStbZgsGPWRMf2BCODl+2adw4zpJFULujwK2sI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=lvlmcUU9OrnvTmkwZf+/yvSSTnH+zL4jQ86xVrXIg/w3eFhpYzHrwCYpkfWJjJSMb
         0D9z0koQ2s6uiAuh4ACsC6aIKxVWQ161pkZHBENe/yN0CVrPnuRAdQBGw4Xn3gv8Qz
         sQuwnfDC7UvPm2SJcpOLM7gPdass42BFSnq5oDJjyaWegMuynVDMkUVZvrjmzB9UTU
         VwGHszlUb52qHFlu50SjEeNxR9deuD8VpFYBGpnmI7rUZg1JtqyxlssrSBxmCfV8Cl
         XQq9Lz53BJFQ020ME8uHd5zT+Y+O3y9bXCUpvQsLMjJsCaa7k3749wT91nxF/nRMiU
         sFT468zZoIcPg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 May 2023 19:22:20 +0200
X-ME-IP: 86.243.2.178
Message-ID: <af3073e9-e270-f8f0-ecf1-fb28eb21c7dc@wanadoo.fr>
Date:   Mon, 15 May 2023 19:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] nvmet: Reorder fields in 'struct nvme_ctrl'
Content-Language: fr
To:     Keith Busch <kbusch@kernel.org>
Cc:     hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <cover.1682941568.git.christophe.jaillet@wanadoo.fr>
 <af016d2a5e7e7bb503eadb15037b80bc9813b94c.1682941568.git.christophe.jaillet@wanadoo.fr>
 <ZGI/6DT30JBfQPnG@kbusch-mbp>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZGI/6DT30JBfQPnG@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 15/05/2023 à 16:21, Keith Busch a écrit :
> On Mon, May 01, 2023 at 02:40:26PM +0200, Christophe JAILLET wrote:
>> Group some variables based on their sizes to reduce holes.
>> On x86_64, this shrinks the size of 'struct nvmet_sq' from 5368 to 5344
>> bytes when all CONFIG_* are defined.
> 
> This patch is changing struct nvme_ctrl but the commit log only mentions
> struct nvmet_sq, which was handled in patch 1/5. I'll just fix that up
> when applying.
>   

Thanks for catching and fixing it :).

CJ

