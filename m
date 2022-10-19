Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C9C603B29
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 10:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJSILo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 04:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJSILk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 04:11:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 263017B1C9;
        Wed, 19 Oct 2022 01:11:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8618E1042;
        Wed, 19 Oct 2022 01:11:43 -0700 (PDT)
Received: from [192.168.99.12] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3FDD3F7D8;
        Wed, 19 Oct 2022 01:11:35 -0700 (PDT)
Message-ID: <9f2d2032-8859-4388-489a-ba5cd2cee432@foss.arm.com>
Date:   Wed, 19 Oct 2022 09:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org> <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <e9f980a7-fba8-4610-a058-b74e51d6ab24@foss.arm.com>
 <Y0AfK7sVphNkQA4q@kernel.org>
 <0b3afc5d-c4a1-8a50-45c3-20c706c3ecfd@foss.arm.com>
 <Y0QkIjO4pvPuzeMB@kernel.org>
From:   Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <Y0QkIjO4pvPuzeMB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/10/22 14:54, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 10, 2022 at 08:02:29AM +0100, Carsten Haitzler escreveu:
>> On 10/7/22 13:44, Arnaldo Carvalho de Melo wrote:
>>> Em Fri, Oct 07, 2022 at 12:34:51PM +0100, Carsten Haitzler escreveu:
>>>> On 10/6/22 13:58, Leo Yan wrote:
>>>> oh sorry - indeed i didn't see this problem coming after fixing the
>>>> conflicts. i've got an update of the patches that fix that. should i just
>>>> send through the 2 updates patches as a v10 or the whole series?
> 
>>> No need, I did some fixes taking into account the comments on this
>>> thread, we can go on and fix things from what I have now at
>>> acme/perf/core, which I'll send to Linus today.
>   
>> oh cool. i'll let patches sit for now - let me know if there's anything you
>> want/need from me.
> 
> Not right now, I'm now just waiting for Linus to merge what I sent, then
> you can continue from upstream.

I'm not sure what you have sent to Linus? The patch series? Specific 
patches?
