Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC65639155
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiKYWVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKYWVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:21:50 -0500
Received: from smtp.220.in.ua (smtp.220.in.ua [89.184.67.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1177826AF5;
        Fri, 25 Nov 2022 14:21:48 -0800 (PST)
Received: from [192.168.202.100] (unknown [95.67.115.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.220.in.ua (Postfix) with ESMTPSA id D5EE51A21FD2;
        Sat, 26 Nov 2022 00:21:44 +0200 (EET)
Message-ID: <a31377d1-1791-8588-a296-4b42d91fa0a6@kaa.org.ua>
Date:   Sat, 26 Nov 2022 00:21:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: uk-UA
To:     Wang Yufen <wangyufen@huaweicloud.com>,
        Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Machek <pavel@ucw.cz>
References: <1667983694-15040-1-git-send-email-wangyufen@huawei.com>
 <1667983694-15040-3-git-send-email-wangyufen@huawei.com>
 <5D15416B-1866-4031-9958-7CD763C0BD6E@kaa.org.ua>
 <bbd67e6a-8ce0-dbe8-6ab1-9d4a015f4ee9@huawei.com>
 <6D18A607-EC63-495F-BA2D-78E0DB056D3C@kaa.org.ua>
 <c53e4614-eb06-cda8-f9da-2ca58396df54@huawei.com>
 <AA4E5187-59BC-4E04-B392-7BD48F0443A1@kaa.org.ua>
 <d509ee79-e73a-b236-bed9-8d40b8f6d460@huaweicloud.com>
 <f5969fbb-bdbb-6841-e1db-3c32a7a27061@huaweicloud.com>
From:   Oleh Kravchenko <oleg@kaa.org.ua>
Subject: Re: [PATCH 02/13] leds: el15203000: Fix devm vs. non-devm ordering
In-Reply-To: <f5969fbb-bdbb-6841-e1db-3c32a7a27061@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Wang,

22.11.22 03:10, Wang Yufen пише:
> 
> Hi Oleh,
> 
> Judging from the deallocation order above, there is a issue that the &priv->lock used after destroy, right?
> 
> And thanks Wei for the detailed explanation.
> 
> Thanks,
> Wang

Sorry, guys.
The last russian missile attack made my work impossible.
I will try to verify all when I have the ability.

