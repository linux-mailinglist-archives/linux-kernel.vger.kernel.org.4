Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4904A722C08
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbjFEP7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjFEP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:59:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19A18B0
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:59:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68BD2D75;
        Mon,  5 Jun 2023 09:00:28 -0700 (PDT)
Received: from [10.57.25.141] (unknown [10.57.25.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DE343F663;
        Mon,  5 Jun 2023 08:59:41 -0700 (PDT)
Message-ID: <ebb09b1b-26ab-48dc-d69f-c7fcbd5d48e8@arm.com>
Date:   Mon, 5 Jun 2023 16:59:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.1
Subject: Re: [PATCH v4 1/4] devres: Provide krealloc_array
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Coresight ML <coresight@lists.linaro.org>
References: <20230509094942.396150-1-james.clark@arm.com>
 <20230509094942.396150-2-james.clark@arm.com>
 <2023051340-sinuous-darkroom-2497@gregkh>
 <89ad5070-db72-7bf1-5d86-a89fea54e789@arm.com>
 <2023051530-immunize-pony-49ef@gregkh>
 <46bb773c-31a8-c57a-0cde-39c27d0a6e36@arm.com>
 <2023060104-removal-map-b194@gregkh>
 <f52a1dee-70f2-e3b4-4aa2-f591d7d8063e@arm.com>
 <6cbdce5c-d470-9717-774d-2d25c9fc24c1@arm.com>
 <2023060546-deputy-geriatric-2706@gregkh>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <2023060546-deputy-geriatric-2706@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 16:20, Greg KH wrote:
> On Mon, Jun 05, 2023 at 02:39:44PM +0100, Suzuki K Poulose wrote:

>> Does this look fine with you ?
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git/log/?h=tmp/devm_krealloc_array
> 
> Looks good to me!

Thank you so much for checking ! I will push this to coresight/next.

Suzuki
