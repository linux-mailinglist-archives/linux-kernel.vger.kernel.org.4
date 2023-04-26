Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25136EF780
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241181AbjDZPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240754AbjDZPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 11:08:16 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37221618E;
        Wed, 26 Apr 2023 08:07:58 -0700 (PDT)
Received: from [IPV6:2408:824e:f25:7460:99d6:1295:58e5:1589] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33QF7CbZ012118-33QF7Cba012118
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 26 Apr 2023 23:07:12 +0800
Message-ID: <4cdd1cd2-bf9a-ed55-946d-48f917f72342@hust.edu.cn>
Date:   Wed, 26 Apr 2023 23:07:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH] spi: davinci: Remove dead code in `davinci_spi_probe()`
To:     Mark Brown <broonie@kernel.org>
Cc:     Li Ningke <lnk_01@hust.edu.cn>,
        hust-os-kernel-patches@googlegroups.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan Carpenter <error27@gmail.com>
References: <20230423032446.34347-1-lnk_01@hust.edu.cn>
 <d29c4b3e-9e82-4ea9-9f0c-a8e2c7637eb9@sirena.org.uk>
 <46299274-d827-279f-cadf-020e93296c13@hust.edu.cn>
 <ed846afc-7155-4998-9a8d-e9d9e8aaf8e2@sirena.org.uk>
 <1488abfa-9a0e-970b-e074-11842a6c6413@hust.edu.cn>
 <dbcc6739-e741-495f-85f9-bac104647194@sirena.org.uk>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <dbcc6739-e741-495f-85f9-bac104647194@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/4/26 22:13, Mark Brown wrote:
> On Wed, Apr 26, 2023 at 09:50:26AM +0800, Dongliang Mu wrote:
>
>> Second, from code review of platform_get_irq / platform_get_irq_optional, it
>> would warn IRQ 0 as an invalid IRQ number.
>> out:
>> 	if (WARN(!ret, "0 is an invalid IRQ number\n"))
>> 		return -EINVAL;
>> 	return ret;
> Like I say I'm not sure that's actually accurate for all architectures
> yet.

I see. Let's wait and see. When it becomes stable and universal for all 
architectures, we could clean up them all together.

Currently our team just works to make Smatch happy :)

