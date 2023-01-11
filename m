Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A776658C8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbjAKKQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjAKKP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:15:59 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 28A9AA448;
        Wed, 11 Jan 2023 02:14:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCF7DFEC;
        Wed, 11 Jan 2023 02:14:52 -0800 (PST)
Received: from [10.162.42.70] (unknown [10.162.42.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D289A3F587;
        Wed, 11 Jan 2023 02:14:07 -0800 (PST)
Message-ID: <7c9eae15-fb84-bbcb-6e31-3199d9752ad8@arm.com>
Date:   Wed, 11 Jan 2023 15:44:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com
References: <20230105160346.29018-1-faiz.abbas@arm.com>
 <20230108163741.GA30997-robh@kernel.org>
 <f0ad7a4e-a8af-77d4-09e4-3717041677e7@arm.com>
 <cf65926c-d2c1-f1bc-6e27-f07611a5cce8@linaro.org>
From:   Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>
In-Reply-To: <cf65926c-d2c1-f1bc-6e27-f07611a5cce8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krysztof,

On 1/10/2023 2:15 PM, Krzysztof Kozlowski wrote:
> On 10/01/2023 09:23, Mohammad Faiz Abbas Rizvi wrote:
>> Hi Rob,
> (...)
>
>> Thanks,
>>
>> Faiz
>>
>> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> Please fix your mail setup. We cannot work in upstream/LKML with
> confidential emails. Since I was not a intended recipient (I don't know
> who is), then I should start removing your emails?

Apologies for this. This was my first email that went outside. I have configured my email to not append this notice anymore.

Thanks,

Faiz

