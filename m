Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E5A623B91
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiKJGBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKJGBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:01:45 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1627B37
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 22:01:43 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id t0d8oFZvJTyout0d8ovHf5; Thu, 10 Nov 2022 07:01:41 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 10 Nov 2022 07:01:41 +0100
X-ME-IP: 86.243.100.34
Message-ID: <d975ae16-58b8-a844-7ffd-7fa06159311c@wanadoo.fr>
Date:   Thu, 10 Nov 2022 07:01:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v10 1/2] thermal: loongson-2: add thermal management
 support
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20221103083407.4039-1-zhuyinbo@loongson.cn>
 <d634c8db-3036-08eb-24d2-568771b0e104@loongson.cn>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <d634c8db-3036-08eb-24d2-568771b0e104@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/11/2022 à 09:09, Yinbo Zhu a écrit :
> Hi Rafael J.Wysocki,
> 
> I just have a verified on your tree about my patch again, it is okay,
> if no other proplems, please help merge it to your tree and sync it to 
> linux mainline tree.
> 
> Thanks,
> Yinbo.
> 

Hi,

I've sent a few nits on v10, that you are obviously free to take into 
account or not.

However, one of these comments is about thermal_add_hwmon_sysfs() vs 
devm_thermal_add_hwmon_sysfs() in loongson2_thermal_probe().

IMHO, if I'm correct, at least this comment should be fixed.

CJ

