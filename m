Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6C0711F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 07:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjEZFT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 01:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjEZFTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 01:19:55 -0400
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4B189
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 22:19:53 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 2PriqiGNB8SAU2Priq0xRk; Fri, 26 May 2023 07:19:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1685078391;
        bh=R6G7vkcYS8zlOgnSGCnCfG/yugvrJXcxtCb5k84ADOs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=A/6vgAQo4iT2nUnz4fRJtn5JGtOBRbYQ8NNMqBlVX+ueQv+CcRls2Hw0KjsC1j9C6
         HdCkViZHGQ22znRWN1snMh0nXgwKUGF6in8B3ziXEpA8HBws1NG8sGb8pv8+I/IVCI
         bk8IKZXIz3m873vVYqlaHc5L2Yh+pcX4q2KpGrHUrogzWHQG2dx270K8xOpvxnq4+l
         ZbbE2TgXnJ1T/IxqqHnhP39Y0Uyk+SJLvDnAw8qRyyr9ngcxxDBhG1U2QVDJvrALxi
         ggcWagqL5w8RhXE4qUudgTshbO0I18kW+DjYc88wKS6EZn+FUui4Y8qD8XXsKmqb3s
         AA94upSBNFcCA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 26 May 2023 07:19:51 +0200
X-ME-IP: 86.243.2.178
Message-ID: <9c01906d-5f2d-e522-a487-3120c5b2e404@wanadoo.fr>
Date:   Fri, 26 May 2023 07:19:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: RE: RE: [PATCH] pinctrl:sunplus: Add check for kmalloc
To:     =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Wells Lu <wellslutw@gmail.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
References: <1684836688-9204-1-git-send-email-wellslutw@gmail.com>
 <ZGztCHNr1jmpFq0A@surfacebook>
 <1560e9c0e5154802ab020b9da846d65f@sphcmbx02.sunplus.com.tw>
 <ZG0V6_bUaz3Thy0q@surfacebook>
 <b9207257-b04f-ee2e-7025-015b0f22358a@wanadoo.fr>
 <dd0ea27640d2420eb3b521076c643919@sphcmbx02.sunplus.com.tw>
 <dbb3c0bd-3b09-2b59-8cd1-2838b9880abf@wanadoo.fr>
 <ee46e6d5d9a74265915345e2887338a3@sphcmbx02.sunplus.com.tw>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ee46e6d5d9a74265915345e2887338a3@sphcmbx02.sunplus.com.tw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 26/05/2023 à 04:04, Wells Lu 呂芳騰 a écrit :
> Hi,
> 
> I forced sppctl_dt_node_to_map() to always return -ENOMEM when it configs GPIO pins.
> Here is the report of kmemleak:
> 

Nice, thanks.

CJ

