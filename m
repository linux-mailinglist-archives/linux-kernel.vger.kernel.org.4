Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBC5632B74
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiKURuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKURuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:50:21 -0500
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D3CD14E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202112; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JfUlmWwfrcwQGX0MmqgM2w05+AY0+GgsgRaGdODHtvM=; b=e43ckbPYrKjFQrIQWV2QmWTxQ8
        2F4/7ywsrlGjaE5g8vhW32NtVERr7qj2At1ZDwpb62Azqk0X5wuaxOIBSeYe+ML5tqwSKxudGV7V8
        KjoiBYa1b9U//tU3lh46J7Z6zy4Ejc2+nBxnSFq1BfHcyl9kLpXS4OsHBGsMr4JEjqpwHO3UpIovP
        +DzFo4MDtwgjclvpM0oKgfyhzXJ9JdFiFeV5SSN+jJRb02wlXGyp82Cbl/77UtMGu0VqiHjGq2Zhm
        DzmqQrPIXerOZlrGWK3T90BS/Bt1nYrWt28vNQ6s5qTiauAR1UvLbVISdh9o1nYElt7B++dW6orTP
        Ao8It4ww==;
Received: from [2a01:799:95e:1700:6395:ccbd:d000:d42b] (port=49862)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1oxAvy-0002k9-FP; Mon, 21 Nov 2022 18:50:18 +0100
Message-ID: <243c2d1e-fbbb-5b7b-3a5f-0a34c5084fa3@tronnes.org>
Date:   Mon, 21 Nov 2022 18:50:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: git send-email friendly smtp provider anyone?
To:     Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
 <9-qCHLoI7vMtVX2UmZbrcDSyMIJRqoWx6G2sZEn08RP15vYjPwng_fInDkKYPvllUddwXshfYs_fIpPH3_TeFLat2MQx_LT5Hfb0dxb1vGA=@emersion.fr>
 <72e873e9-d4df-895b-2531-30168b8a4d64@tronnes.org>
 <29wzxSbEeYmXyru0ObDIAEG_W_4Wh0qj77Y6zMgmfT6UbaftflIVKCcAdEuSsmsIoK-85IvhTC73Yh8UDm6et4EK5JZZbeeByj_j0spUc9Y=@emersion.fr>
 <OO82gksmp_i249qMnDryWunPoUrSyyFxpxi009wWlytDaijmvalJffHrcPyMNLdfSzcIl5reNfJ2r2SmDVSG8xYXrIIbzc9rw-_bJPMDlag=@emersion.fr>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
In-Reply-To: <OO82gksmp_i249qMnDryWunPoUrSyyFxpxi009wWlytDaijmvalJffHrcPyMNLdfSzcIl5reNfJ2r2SmDVSG8xYXrIIbzc9rw-_bJPMDlag=@emersion.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 21.11.2022 18.06, skrev Simon Ser:
> On Monday, November 21st, 2022 at 18:02, Simon Ser <contact@emersion.fr> wrote:
> 
>> On Monday, November 21st, 2022 at 17:52, Noralf Trønnes noralf@tronnes.org wrote:
>>
>>> Den 21.11.2022 14.33, skrev Simon Ser:
>>>
>>>> I think you can apply for a linux.dev mailbox 1.
>>>
>>> Yeah you're right, I didn't know about that possibility.
>>> But it depends on whether or not I can just use their smtp server and
>>> keep my current email address. This looks like what's the problem with
>>> my current ISP, I need to use the email account I have in their email
>>> service (that I've never used) for sending through their smtp server,
>>> but I want to send From: another email address.
>>
>> That's not possible. It breaks DKIM, so your emails will end up in Spam
>> folders or be rejected. You need to use the SMTP server tied to your
>> email address.
> 
> That said, you can send patches from an email address different from
> the one in your patches. IOW, you can send patches committed by
> <noralf@tronnes.org> from any email account.
> 
> The From in the email header won't match the commit, but the very first
> line of the patch will hold that information.

Thanks that was useful information. I've seen the DKIM abbr. but haven't
looked into the meaning of it.

I tried:

git send-email --from=noralf.tronnes@altiboxmail.no
--reply=noralf@tronnes.org

and now I'm getting 'pass' in the Authentication-Results field, so
that's progress. I'm still not getting all the emails through, so I
still have that problem, I'll have to wait and see what the ISP can tell me.

But this means that a linux.dev mailbox is an option for me should my
ISP be a blocker.

Noralf.
