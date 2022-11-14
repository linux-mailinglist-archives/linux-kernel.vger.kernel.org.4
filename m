Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C496E628BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiKNVzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbiKNVzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:55:41 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D79E089;
        Mon, 14 Nov 2022 13:55:40 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so31592422ejb.13;
        Mon, 14 Nov 2022 13:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6ROxNTXIADOvvm1oDqKgevEgxWpoOw7xcRSJwQ0+mw=;
        b=Y8pQ6J8w5ocpEEHFcgYQqZiDcc+1KD6NeLV93RRdX3NtQFxjm9EJH/7e4lo7b1C4PW
         9LnLtaoUYZxBqTOwyvRCIu7irVtaSh3tpFAqDBqYNgqPYYR/4KVL26H4ZrmlZcqhr6+S
         rAt0OotrJQDNgW3qaQSxrdrl6tSyUnagSfG6mdrJ64YUi26XhH1OoABNGSU3GSncsAWC
         D8UTa+fE4Hs5FqRIl9P4h7UHAvr5Me3KwWUR8QUsE81ejBeIjr9SHfesAxk3Af7M/G1r
         S47n493zIVvZrs1gJ+Rp1ay41xCA9b2hpZ+eAHifefYNDzEL4U9F1QLHJuXoRVg459F1
         0XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6ROxNTXIADOvvm1oDqKgevEgxWpoOw7xcRSJwQ0+mw=;
        b=YjtOJuQlRN1m4YcmZl/zqDls8Y6Krq0WbqB1FKiYQgHvXnib11biDVfbQ2GZMoyZ7/
         XlPXGij2XErDVY/Dhjwpt5J3W/6XGcoTYD6i+Ur2wtZjNw+uKsQ0v13gnMnIByuJQ+3W
         LS9sLTJnHTooeno4dCi7jp8HGPvEHWCAMDjUePVhfy+/CZHDoqsNKB2vr+vfRt4sTQba
         3Aj+GfobhFrBY+jCRoZ2hB20L+msxK+SIZ+w67vJ6M4bC62X3PaIBbe1ISEEp8fT1PJf
         c/UBlr1QDgZBG85nH7EpfMWq8k5eF1aPYO/I1Srn2N3CoWIi567eH19aL68siodRmhXp
         mQFA==
X-Gm-Message-State: ANoB5pl1mOhfOi/bslSHMfdLiDk53b9ZHLLsqPvny+fTrEOjOF9koawP
        0+4jTkSRtXh/yxJOAldM6MU=
X-Google-Smtp-Source: AA0mqf6g4N78DzMRMt8k0FPC6+XJqpf4AkBqvvdvoB8Ha8UYqCfQFrpHs3k/qaLqZnexIG0KpUDuxw==
X-Received: by 2002:a17:906:7b4f:b0:78d:f40b:42f8 with SMTP id n15-20020a1709067b4f00b0078df40b42f8mr11866540ejo.129.1668462939255;
        Mon, 14 Nov 2022 13:55:39 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:dc32:99d6:97a8:f82? (2a02-a466-68ed-1-dc32-99d6-97a8-f82.fixed6.kpn.net. [2a02:a466:68ed:1:dc32:99d6:97a8:f82])
        by smtp.gmail.com with ESMTPSA id r2-20020a1709061ba200b0074136cac2e7sm4629085ejg.81.2022.11.14.13.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 13:55:38 -0800 (PST)
Message-ID: <b8fb2ead-6177-ea22-4d5c-a10a994eda2d@gmail.com>
Date:   Mon, 14 Nov 2022 22:55:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ferry Toth <ftoth@exalondelft.nl>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephen Boyd <swboyd@chromium.org>
References: <20221110211132.297512-1-ftoth@exalondelft.nl>
 <20221110211132.297512-2-ftoth@exalondelft.nl> <Y23m5H5zRbv5fwcF@kroah.com>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <Y23m5H5zRbv5fwcF@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 11-11-2022 om 07:08 schreef Greg Kroah-Hartman:
> On Thu, Nov 10, 2022 at 10:11:31PM +0100, Ferry Toth wrote:
>> Since commit 0f010171
>> Dual Role support on Intel Merrifield platform broke due to rearranging
>> the call to dwc3_get_extcon().
> 
> Please see the kernel documentation for how to refer to commits.  This
> should be written as:
> 
> 	Since commit 0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if
> 	extcon is present"), Dual role....

Thanks I'll fix that in v3.

>> It appears to be caused by ulpi_read_id() on the first test write failing
>> with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy via
>> DT when the test write fails and returns 0 in that case even if DT does not
>> provide the phy. As a result usb probe completes without phy.
>>
>> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
> 
> What commit does this fix?

It's complicated, not sure how to explain this clearly:
ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT") started to 
hide -ETIMEDOUT by returning 0. That problem was hidden due to another
problem causing dwc3 to be deferred. But not properly, causing an 
infinite probe loop. This was fixed for quite some time by an out of 
tree patch. Now 0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral 
if extcon is present") accidentally fixes the probe loop, makes the out 
tree patch obsolete, but exposes the initial problem.

In short this patch fixes ef6a7bcfb01c ("usb: ulpi: Support device 
discovery via DT") by returning -ETIMEDOUT to its user, who should 
handle it appropriately. In case of dwc3 probe it sets -EPROBE_DEFER and 
bails out.

I'll add the short fixes: in v3.

> Should this also get a cc: stable?

I will add.

> thanks,
> 
> greg k-h

