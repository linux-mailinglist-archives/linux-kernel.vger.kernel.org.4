Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A67C740E82
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjF1KSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjF1KM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:12:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E96430EF;
        Wed, 28 Jun 2023 03:11:15 -0700 (PDT)
Received: from [192.168.10.54] (unknown [182.179.162.32])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C54CC66070ED;
        Wed, 28 Jun 2023 11:11:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687947073;
        bh=+hTAKw1NKwWF7O6O7zjctXoD72Rg+Gz5knAUIDDxoFc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=oTMnRGxrMGrmYTix1SqIX4oqkQWQff16z2kQ64Rlu/paG9F9ttgibiSNNCAWLLj+i
         KrXQPyt+XBJaT12F+RnX/fCbv9E5q2ZgYiTD2/lwKfFE7LFbXZ/JCc/5vJn/XLspnD
         SfgW18FaBFnERz4hhXJjs7i8sHHSL6DGbQPNkxrZUWuUGrQw1PKHGIS8FlE5VZr2o4
         hOPx9Kpi+S++hQdH9lQsfbdAaTWUZMz6J1evvNuQkxX/rxIlEa3cP7ynCbDGX4IMhC
         CleiARiS3tQsV9dCsj5iNQ3wR8rU1QADCfscthyejt0u2VIqJ+xfUPMa5OW9AOVwkB
         N3JrafTlZojxw==
Message-ID: <ab74f8a3-03a5-723e-7fa7-fa09f5bb5170@collabora.com>
Date:   Wed, 28 Jun 2023 15:11:07 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Subject: Re: [PATCH] accessibility: speakup: remove linux/version.h
Content-Language: en-US
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org
References: <20230303125152.2030241-1-usama.anjum@collabora.com>
 <fb6121fc-101f-0779-b752-ac8202eb761e@collabora.com>
 <20230616145028.7rzrbqfj7wmoenj6@begin>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20230616145028.7rzrbqfj7wmoenj6@begin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 7:50 PM, Samuel Thibault wrote:
> Muhammad Usama Anjum, le ven. 16 juin 2023 17:53:12 +0500, a ecrit:
>> Soft reminder.
> 
> It somehow hadn't appeared in my inbox.
This patch hasn't been accepted yet.

> 
>> On 3/3/23 5:51 PM, Muhammad Usama Anjum wrote:
>>> make versioncheck reports the following:
>>> ./drivers/accessibility/speakup/genmap.c: 13 linux/version.h not needed.
>>> ./drivers/accessibility/speakup/makemapdata.c: 13 linux/version.h not needed.
>>>
>>> So remove linux/version.h from both of these files.
>>>
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Thanks!
> 
>>> ---
>>>  drivers/accessibility/speakup/genmap.c      | 1 -
>>>  drivers/accessibility/speakup/makemapdata.c | 1 -
>>>  2 files changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/accessibility/speakup/genmap.c b/drivers/accessibility/speakup/genmap.c
>>> index 0125000e00d9..0882bab10fb8 100644
>>> --- a/drivers/accessibility/speakup/genmap.c
>>> +++ b/drivers/accessibility/speakup/genmap.c
>>> @@ -10,7 +10,6 @@
>>>  #include <stdio.h>
>>>  #include <libgen.h>
>>>  #include <string.h>
>>> -#include <linux/version.h>
>>>  #include <ctype.h>
>>>  #include "utils.h"
>>>  
>>> diff --git a/drivers/accessibility/speakup/makemapdata.c b/drivers/accessibility/speakup/makemapdata.c
>>> index d7d41bb9b05f..55e4ef8a93dc 100644
>>> --- a/drivers/accessibility/speakup/makemapdata.c
>>> +++ b/drivers/accessibility/speakup/makemapdata.c
>>> @@ -10,7 +10,6 @@
>>>  #include <stdio.h>
>>>  #include <libgen.h>
>>>  #include <string.h>
>>> -#include <linux/version.h>
>>>  #include <ctype.h>
>>>  #include "utils.h"
>>>  
>>
>> -- 
>> BR,
>> Muhammad Usama Anjum
>>
> 

-- 
BR,
Muhammad Usama Anjum
