Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F82873FF7F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjF0PRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjF0PR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EF52D60
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9EFE26113C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94714C433C8;
        Tue, 27 Jun 2023 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687879042;
        bh=JLFnvqaCEuMGWGsFZp5HIVWVrdSzRgIIllbHWfNkc94=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gix3SdZARGqFuya47b/hYn6M5FAKuv7SvLWXGPYTMsy9SlnzetL6xHKyOSAI96hkV
         FHg90LgYR7bnVE4RE3n6wjE/aZd6/qY9QIw9g7KAA7JLTtXQcGaysw6zKMeEYmgR46
         ssTN6wjNeSt/sWDv/2o3RumDcqw20UlYR3DipLLubZSteJPehZ7L1RsulcyjOJfBHT
         bpBLqu9+lo15RU4jIqBl7d7+5xSaHIBiVCfniJPqFfn1aJpMqMghkuZzZwTQvAQxDD
         FC+CO44MIRQQVJG5FlPuwTWPqAuEJeGOjiOwNemUjSoagYpySmgCstkYsuN5IV0YGL
         YQqK31ebI0W/g==
Message-ID: <53f5390d-b86a-94a0-3d3a-e2f6ffe19707@kernel.org>
Date:   Tue, 27 Jun 2023 10:17:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/12] New Crypto service commands
Content-Language: en-US
To:     "Ang, Tien Sung" <tien.sung.ang@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230623032029.1755017-1-tien.sung.ang@intel.com>
 <239e7171-1d29-0208-ca6c-abc85ccbe0e9@kernel.org>
 <DM8PR11MB5735AB9B7112E33B173C4251BE23A@DM8PR11MB5735.namprd11.prod.outlook.com>
 <e65cd698-3ac5-4eb7-a65c-2647c77af78f@kernel.org>
 <DM8PR11MB57351C38071E9960A6B5FECCBE23A@DM8PR11MB5735.namprd11.prod.outlook.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <DM8PR11MB57351C38071E9960A6B5FECCBE23A@DM8PR11MB5735.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/23/23 02:35, Ang, Tien Sung wrote:
> 
> 
>> -----Original Message-----
>> From: Dinh Nguyen <dinguyen@kernel.org>
>> Sent: Friday, 23 June, 2023 3:32 PM
>> To: Ang, Tien Sung <tien.sung.ang@intel.com>
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 00/12] New Crypto service commands
>>
>>
>>
>> On 6/23/23 01:53, Ang, Tien Sung wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Dinh Nguyen <dinguyen@kernel.org>
>>>> Sent: Friday, 23 June, 2023 1:37 PM
>>>> To: Ang, Tien Sung <tien.sung.ang@intel.com>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH 00/12] New Crypto service commands
>>>>
>>>>
>>>>
>>>> On 6/22/23 22:20, tien.sung.ang@intel.com wrote:
>>>>> From: Ang Tien Sung <tien.sung.ang@intel.com>
>>>>>
>>>>> hi,
>>>>> This patch set comprises updates to the svc driver to add new crypto
>>>>> services for AES encryption/decryption, SHA2 digest generation, SHA2
>>>>> MAC verification, ECDSA hash signing, ECDSA SHA2 data signing, ECDSA
>>>>> hash signature verification, ECDSA SHA2 data signature verification
>>>>> crypto key management and lastly ECDSA public key retrieval.
>>>>> The additions of the commands are all standard entries to svc driver
>>>>> with minimal logic.
>>>>>
>>>>
>>>> I guess I'll ask the same question, who's the consumer for these?
>>>>
>>>>
>>> This commands will be used by the future and current downstream crypto
>>> driver that is under redesign.
>>> The svc driver is merely a firmware messenger that is used to send
>>> Mailbox commands to the SDM firmware.
>>> It is essential for us to begin doing this first. Thanks
>>>
>>
>> I think what you're going to find out quickly when you upstream more is that
>> the community will not care about your downstream stuff. The problem I
>> have with this patch is that you're adding code that no-one is using at the
>> moment and with the crypto driver being redesigned, this code may or may
>> not get used, right? Let's focus on the getting the crypto driver first.
>>
>> Dinh
> I disagree. Our customers want the SVC driver to be updated. They will use a
> combination of down-stream sources and upstream sources. The crypto driver
> development is another matter. We should focus on ensuring the SVC driver is
> fully upstream will all features. Hope you understand. Let us get there.
> 

Sorry, but in good stewardship, I cannot accept code that is going to be 
unused in the kernel. If any other community members want to chime in, 
I'm open.

Dinh
