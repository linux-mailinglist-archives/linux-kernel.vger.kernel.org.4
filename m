Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BEA70A77B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 13:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjETLL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 07:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjETLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 07:11:56 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE1412C;
        Sat, 20 May 2023 04:11:54 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E6F6E24E156;
        Sat, 20 May 2023 19:11:45 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 20 May
 2023 19:10:50 +0800
Received: from [192.168.125.107] (113.72.146.100) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 20 May
 2023 19:10:50 +0800
Message-ID: <24b0e9bf-7e15-ed9c-5265-3a150e7d3450@starfivetech.com>
Date:   Sat, 20 May 2023 19:10:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/4] dt-bindings: power: Add power-domain header for
 JH7110
To:     Conor Dooley <conor@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
 <20230519060202.15296-2-changhuang.liang@starfivetech.com>
 <20230519-irk-dwelled-6a499c482e62@spud>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <20230519-irk-dwelled-6a499c482e62@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.146.100]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/5/20 2:42, Conor Dooley wrote:
> On Thu, May 18, 2023 at 11:01:59PM -0700, Changhuang Liang wrote:
>> Add power-domain header for JH7110 SoC, it can use to operate dphy
>> power.
> 
> That is not an accurate description of what you are doing here!
> **IF** you resubmit for another reason, please change that wording
> to match what you are doing here. Otherwise, I will fix it up on
> application.
> 

OK, thanks for your comment

