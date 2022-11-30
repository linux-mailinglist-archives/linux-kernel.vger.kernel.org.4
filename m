Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFDC63D27B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbiK3Jvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiK3Jv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:51:29 -0500
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0734225C7C;
        Wed, 30 Nov 2022 01:51:26 -0800 (PST)
Received: from [172.21.63.214] (nat-out.molgen.mpg.de [141.14.15.184])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 71B0060028142;
        Wed, 30 Nov 2022 10:51:24 +0100 (CET)
Message-ID: <46ae0280-d259-a1dc-fb1b-91116f14aa64@molgen.mpg.de>
Date:   Wed, 30 Nov 2022 10:51:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] Bluetooth: btusb: Add a new PID/VID 13d3/3549 for
 RTL8822CU
Content-Language: en-US
To:     Jinchuan Li <lifangpi@hotmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        972624427@qq.com, Gongwei Li <ligongwei@kylinos.cn>
References: <SI2PR02MB46038FD0DE47A12629F9FB25DD159@SI2PR02MB4603.apcprd02.prod.outlook.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <SI2PR02MB46038FD0DE47A12629F9FB25DD159@SI2PR02MB4603.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jinchuan,


Am 30.11.22 um 10:16 schrieb jinchuan li:
> From: ligongwei <ligongwei@kylinos.cn>

[…]

> Signed-off-by: Gongwei Li <ligongwei@kylinos.cn>

It’d be nice, if you also used *Gongwei Li* in the author field (From:).


Kind regards,

Paul
