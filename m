Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36796ED6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjDXVaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjDXVaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:30:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833A46198;
        Mon, 24 Apr 2023 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=M2D/TWPKxXfKGm9ptSRC6XjyJPx/YeFNWRMxLsuDqUw=; b=fm2O+/eTMsMTmAELlXGXZ1MaJj
        acakCSYKEPGQu74EEFr7CVuGyhtIMxNwBRnhHR3zs760fOdmFl61rNGYbr5cWkgjIx5Wxxky4ciVB
        LDT14/oz5CBTJhROhosXgBBB5uGaAHZcNglueEim+J150cT5d6NlXgpDywJw+0EZ1bcOI9QzgxIeo
        Gs6iVb9haX0t4HSAizdDeVAcyKn7U8updDeXoQsKRQresWjRSRmGn8pqh8mKfab93Kva+o/lKP6FG
        TPFkN7722dn0XtSmyko8nlmvpdIJOJTYiOKwNy8hTnb9NO7d3Ox/n55t1eCTrjaVmG2b7Vg9EAUey
        n4ctdpFw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pr3lB-00HDQw-1Z;
        Mon, 24 Apr 2023 21:30:09 +0000
Message-ID: <3eadc4aa-1271-8ac6-0b29-7faa99234724@infradead.org>
Date:   Mon, 24 Apr 2023 14:30:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/4] platform/x86: wmi: Add kernel doc comments
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230420233226.14561-1-W_Armin@gmx.de>
 <20230420233226.14561-2-W_Armin@gmx.de>
 <5a8effb3-e176-5a2f-4650-17765384e60c@infradead.org>
 <ca9bac63-8700-3b37-0674-b1c16a137d2d@gmx.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ca9bac63-8700-3b37-0674-b1c16a137d2d@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/23 14:20, Armin Wolf wrote:
> Am 22.04.23 um 04:54 schrieb Randy Dunlap:
> 
>> Hi,
>>
>> On 4/20/23 16:32, Armin Wolf wrote:
>>> Add kernel doc comments useful for documenting the functions/structs
>>> used to interact with the WMI driver core.
>>>
>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>> ---
>>>   drivers/platform/x86/wmi.c | 51 +++++++++++++++++++++++++++++++-------
>>>   include/linux/wmi.h        | 41 +++++++++++++++++++++++++++---
>>>   2 files changed, 80 insertions(+), 12 deletions(-)
>>>

>>> +/**
>>> + * struct wmi_device - WMI device structure
>>> + * @dev: Device associated with this WMI device
>>> + * @setable: True for devices implementing the Set Control Method
>> private: fields are not normally documented in kernel-doc.
> 
> Hi,
> 
> since @setable is only used internally by the WMI driver core, i thought it might
> be beneficial to exclude it from the normal driver interface documentation and only
> use it for subsystem-internal documentation.

OK then. :)

-- 
~Randy
