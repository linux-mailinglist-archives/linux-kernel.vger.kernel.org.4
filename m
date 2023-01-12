Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D8B666C27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbjALILp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbjALILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:11:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1774A4C727;
        Thu, 12 Jan 2023 00:11:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA49B81D90;
        Thu, 12 Jan 2023 08:11:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA3C433EF;
        Thu, 12 Jan 2023 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673511079;
        bh=omEZp3lmrTt3GrVewdVony8ojSj5H8hp7rwM9j19Lhk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rPOHjuUXe5lo5QJz91xI2vJSSodx/v+COsN3j+ST4HcIDjOkX+XGSBifE4+bj0XIQ
         7ZTLLr3VwfwFonXtnXEmHFb+8xdxLXLReBoNFRoEVLG/DYsHQrBC09tCZWx8z1XD/w
         qpeJtekvRy61tb61l1OpMU7kKqBxVWiS+TmXyHf8trtwaSrbe/CIU6xO9vyFv+I85w
         IBwrt81wt7M3/H6FBFUCyOMHJyIPZzrvHHNEsAGBlP8BUB0Rzo4BIbC353vyWUo2Ix
         /c+PUC9MSWiinzDAyFj6w9NNlVv513DUtEzytE0BswUvzVsD5mnFn+tPuoWeG6RQVm
         G0Jt0GUoz+i5Q==
Message-ID: <f92ff708-add2-44c3-8e51-33a1279cecbf@kernel.org>
Date:   Thu, 12 Jan 2023 09:11:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/6] dt-bindings: media: platform: visconti: Add
 Toshiba Visconti Video Input Interface bindings
To:     yuji2.ishikawa@toshiba.co.jp, hverkuil@xs4all.nl,
        laurent.pinchart@ideasonboard.com, mchehab@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230110014143.18684-1-yuji2.ishikawa@toshiba.co.jp>
 <20230110014143.18684-2-yuji2.ishikawa@toshiba.co.jp>
 <b0245b64-a3eb-a242-8824-9effe0c63f0e@kernel.org>
 <TYAPR01MB62019B464730E0268B58E90492FC9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
 <14ffd7a0-caf3-d5ee-18bb-df4e53f276c7@kernel.org>
 <TYAPR01MB62014698C65E5ADFBD07C65F92FD9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <TYAPR01MB62014698C65E5ADFBD07C65F92FD9@TYAPR01MB6201.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 03:05, yuji2.ishikawa@toshiba.co.jp wrote:
>>>> Compatible must be specific. You called your SoC visconti5, didn't you?
>>>>
>>>
>>> The Video Input Interface hardware is likely to be used at future SoCs
>>> of Visconti Architecture.
>>> Does compatible have to be specific to SoC's model name rather than
>>> architecture name?
>>
>> Compatibles should always be specific to SoC model name. Adding more generic
>> family fallback is also good idea when it is applicable.
>>
> 
> I'll update the compatible to "toshiba,visconti5-viif".
> I'll consider adding generic version "toshiba,visconti-viif" when a successor SoC gets available.

Are you sure? You will have to wait at least one cycle between DTS and
driver change, due to ABI break of DTB users.

Best regards,
Krzysztof

