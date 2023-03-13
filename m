Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4A6B7CDF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 16:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjCMP4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjCMPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:54:47 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E55623A4D;
        Mon, 13 Mar 2023 08:54:13 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Pb1Rk0CCdz4BKKw;
        Mon, 13 Mar 2023 17:54:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678722850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXXncOJAYBtDWEiU6+zQPGG41pup/xf/5ptlabsdAFI=;
        b=T+86Ad0m4km/S0b4JlvgLob0ZYKjPrJGOhCfs0JjitQDkd+bf19JxWcJRAI1n7exrSIYdB
        TZOmfxXkqqh/GygkretVpeZrAk63R6jFfiOLzGukTzn8zo7PVRSDIWEgqkhQxN6JX77SPe
        wJSor9gMMR6mzVXbjlIL/mruqHm9S3p/YK/Ts74R7MABcOZmSmcPPwjZK5YBRaJyA9BUoQ
        4U76xDZgWc4KRdsI71GLmixHTZpZL7pzBjR4TpWBY/K5u156CAcM/RDfY9017NKRsft33L
        voeuEIsFClqU4k7MwgONFceSmJFLbMkkppr/YMsXYe9KqaYnzUPJutPIAo72gQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678722850; a=rsa-sha256;
        cv=none;
        b=IFEqagaG+iIVK3AvzD3aTprO8xLtfVUnCTQ8b9h62tw+RYkMO06WcEsFMmcC+r/HXyUV8x
        H5/lK/og+WnlkoFIDU+032Z2NWPLtNntQKR83jqhVOzM1lXYqijVydva8ofASbp70WVyQ/
        pBG5QZ+BqU9ixeQnxpCs6AsqVyGu2DvxRvGwcpgXRoT6InrXJdItgsT0K8b/zhGIONFBTA
        9uNfs0IPPJlnL9TyutRku3EPOCkCqN3SD/3SSC7+Ajd+drwvDqZyPje5f/Avyn6fKTrn7p
        Oi/0Own2yDeMfiQ33pe3JqgIhIP0QlMxts9mPSgdi9rn9pDae7mMPcZ3jo0oWQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678722850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eXXncOJAYBtDWEiU6+zQPGG41pup/xf/5ptlabsdAFI=;
        b=DQ2NOyaP7/srDBlcKi+7kssbTzcxVJihoufWNPlseceb9hnPh78ylJXcpRZ8EkJypNehMf
        +NW21b4cYq3s2NqEH82oqeBuF4+MbMar/cOAuKtuUChejohhsbo3/+qngdMM+y2g0Rz1e0
        NNYJuMWq0Ew10+x+8QR/L76O4ZkXg0/RR56NszIN4zVPRXKgwdtR5hFZrRQNQmd/MRlZJ6
        1k347djFfVkjbbYbUTv4hr2crm8YyVFUD+6IeikVwdA12qflv4zaP7HsV6kmXLs6EkEDJs
        n4pWJgnNHrXWEozjz5g9ZV0mLgllCdIDabLapiDtEkhbYc+nGLArpw4nlNVQUw==
Received: from [IPV6:2001:14ba:440a:f000::3] (dktgsyyyyyyyyyyyyyybt-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::3])
        by dungeon.fi (Postfix) with ESMTPSA id CA8B43F270;
        Mon, 13 Mar 2023 17:54:07 +0200 (EET)
Message-ID: <6a964f3b-ed7a-d6d8-690e-7595b448039e@iki.fi>
Date:   Mon, 13 Mar 2023 17:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313010416.845252-1-kasper@iki.fi>
 <ZA7KIs2jA/acpN9n@kroah.com> <a1ba59be-30aa-08e9-65e7-2c458cc164f9@iki.fi>
 <ZA7Wh2Z/DdKOsOYr@kroah.com> <71fd009b-8378-d5b0-5243-5279b2b880ee@iki.fi>
 <ZA9GK2bPd9VhomgG@kroah.com>
From:   Jarkko Sonninen <kasper@iki.fi>
In-Reply-To: <ZA9GK2bPd9VhomgG@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/23 17:50, Greg Kroah-Hartman wrote:
> On Mon, Mar 13, 2023 at 05:07:59PM +0200, Jarkko Sonninen wrote:
>> On 3/13/23 09:53, Greg Kroah-Hartman wrote:
>>> On Mon, Mar 13, 2023 at 09:49:26AM +0200, Jarkko Sonninen wrote:
>>>>>> +{
>>>>>> +	void __user *argp = (void __user *)arg;
>>>>>> +
>>>>>> +	switch (cmd) {
>>>>>> +	case TIOCGRS485:
>>>>>> +		return xr_get_rs485_config(tty, argp);
>>>>>> +	case TIOCSRS485:
>>>>>> +		return xr_set_rs485_config(tty, argp);
>>>>>> +	}
>>>>>> +	return -ENOIOCTLCMD;
>>>>> Wrong ioctl return value :(
>>>> What is the correct ioctl error return value ?
>>>> ENOIOCTLCMD was used in most places in usb serial as an error return.
>>> ENOTTY is the correct one for when an ioctl is not handled by the ioctl
>>> call.
>>>
>>> thanks,
>>>
>>> greg k-h
>> Using ENOTTY breaks all other tty ioctls.
> What other tty ioctls?
>
> confused,
>
> greg k-h

For example TCGETS and TCFLSH

     - Jarkko

