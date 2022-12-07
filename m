Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 825EB645922
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLGLh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiLGLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:37:52 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C10DFF4;
        Wed,  7 Dec 2022 03:37:50 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id m14so27661171wrh.7;
        Wed, 07 Dec 2022 03:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSx+NHus5C140t0IdCwSwoBUrF77uz0yHbBdAVrKbRY=;
        b=UW76HS4Ol137yUz+T+kGjTQ5R030MITUJaF/p19FFAIKKPc3vJJVjJ3H/1Er4jfWOI
         yO5KLAD0EfAHPytLLnSRcrZNWqfa9gs9hdQV/Fr3rQqxv9Q6/lCznGyt5d9tqbC4oZYC
         oQeq6xYfhZ/R34MjTB4qfbqGjblvMeuoBBcd+lzqxVJ9ShLUduA/E+mN27E2+JVvqfdh
         V+Cse5pdHEDW42mP5KSv/N7OWyLbzJSEJoxn+2pWCfC9C9rQy2XVK1hdqTyGZZQbbU28
         pxPLfJqhe6ar7RvGAaRsWItSb4rKXo/yjid6KiFUNDL/+B5Hk8LumEzsXub7Qr+/4UXA
         RM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSx+NHus5C140t0IdCwSwoBUrF77uz0yHbBdAVrKbRY=;
        b=VGmVp9krTLeEmiGJK4MMjTLD9Wfa7+Hbf/ZQk7IzYM6ymbEgEBJx9H7l6z+NAJkZdU
         BOg3ZsuTdINoW+ADpkHLKxJsl0dCJSlM6CM5/HpgoL6W/TjvLAf6ruZPFilnWtbcXijz
         Xht0J6L8DCJZdng8a3KBPL0S8dpQ0+jkl3jLI8zBAwnnCW0lZpaCsCb6iqICnGqO6a1m
         Tx8BKPAsuKw1ggz3CVBJJ4X943enFe84AqHpRNSOptVzVdMHP2by7KO7sQ9x4f9yX3Us
         NlOvY86pIFyYhq9/Dsi1Qa7ERS6PRivo7dqQVSMfYfCNP1d/y5b1H6ASMYwMuUHVhZi5
         lwGg==
X-Gm-Message-State: ANoB5pltZxQmqwHYNe6GntMDUGxQ8gsp7LVc7AtiSMG046jEHf59Ng3p
        uK1Ro2Zi3lHeaRrzaVOeBvq58nQxMjU=
X-Google-Smtp-Source: AA0mqf4p2nOY/jWwz5AwjCWj9sidu0hYmkVKuvOONAt3xdjQF1ebnTBAvaMOneqyvxijv3KQUrsyRg==
X-Received: by 2002:a5d:5955:0:b0:241:553e:5040 with SMTP id e21-20020a5d5955000000b00241553e5040mr49767905wri.578.1670413069324;
        Wed, 07 Dec 2022 03:37:49 -0800 (PST)
Received: from [192.168.0.14] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id h3-20020adff4c3000000b00241fab5a296sm7555754wrp.40.2022.12.07.03.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 03:37:49 -0800 (PST)
Message-ID: <b049ad99-3859-45f3-5292-5ac53260f4ee@gmail.com>
Date:   Wed, 7 Dec 2022 11:37:48 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] device property: Fix documentation for
 fwnode_get_next_parent()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221207112219.2652411-1-linmq006@gmail.com>
 <Y5B51wScX5v2tr8m@smile.fi.intel.com>
From:   Daniel Scally <djrscally@gmail.com>
In-Reply-To: <Y5B51wScX5v2tr8m@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/12/2022 11:32, Andy Shevchenko wrote:
> On Wed, Dec 07, 2022 at 03:22:18PM +0400, Miaoqian Lin wrote:
>> Use fwnode_handle_put() on the node pointer to release the refcount.
>> Change fwnode_handle_node() to fwnode_handle_put().
> Looks correct to me, thanks!
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


And to me too:


Reviewed-by: Daniel Scally <djrscally@gmail.com>

>
>> Fixes: 233872585de1 ("device property: Add fwnode_get_next_parent()")
>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>> ---
>>  drivers/base/property.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/property.c b/drivers/base/property.c
>> index 2a5a37fcd998..daa1e379762b 100644
>> --- a/drivers/base/property.c
>> +++ b/drivers/base/property.c
>> @@ -601,7 +601,7 @@ EXPORT_SYMBOL_GPL(fwnode_get_parent);
>>   * node's parents.
>>   *
>>   * Returns a node pointer with refcount incremented, use
>> - * fwnode_handle_node() on it when done.
>> + * fwnode_handle_put() on it when done.
>>   */
>>  struct fwnode_handle *fwnode_get_next_parent(struct fwnode_handle *fwnode)
>>  {
>> -- 
>> 2.25.1
>>
