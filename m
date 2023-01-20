Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F194675EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjATUcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjATUcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:32:19 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD29872A0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 12:32:18 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 2DA83240703
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 21:32:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1674246737; bh=3U0QnUhsNTtPLMBnBxIw39Ig6pLG0EYmIgcK+IN7/kA=;
        h=Date:Subject:To:Cc:From:From;
        b=EPkwnkvLqv2AwwBtomWlVDCBZGFP2N0pdw/aQtJQ7lxEmPYP1KybdCWd9mlTthko2
         pDohf4+15VO9UVdf12rpvMTgW9m9dEe1K/HT3cwAFCURlggWvEBL7Cjd8wY+ZAwOU7
         qCCTYe5v3noiuXY0zBAb8plviBLs20OlMbT032Bh9uqAFIbxabG5njA0LSYGEB2yNL
         iRrWpvA9wud2jXTPL7MIYT70rWgCI7tNFnaAR006Cox7KLTxBG5Y6HPNNIYfj3vPVv
         CEtItMqrRmk/61gt/qITb3ChgrCGOXdgdgxGTZL7rCKOHP/hUn2ijhIYFZ4L2nWYbQ
         EFoY6l7qutVug==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4NzB4Y0LxQz9rxL;
        Fri, 20 Jan 2023 21:32:13 +0100 (CET)
Message-ID: <5de61071-6b22-440c-d095-1360512fbccd@posteo.de>
Date:   Fri, 20 Jan 2023 20:32:12 +0000
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/2] hwmon: (nct6775) B650/B660/X670 ASUS boards
 support
To:     Guenter Roeck <linux@roeck-us.net>,
        Denis Pauk <pauk.denis@gmail.com>
Cc:     ahmad@khalifa.ws, chunkeey@gmail.com, greg@krypto.org,
        hubert.banas@gmail.com, igor@svelig.com, jaap.dehaan@freenet.de,
        jdelvare@suse.com, jeroen@beerstra.org, jonfarr87@gmail.com,
        jwp@redhat.com, kdudka@redhat.com, kernel@melin.net,
        kpietrzak@disroot.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, me@rebtoor.com,
        metalcaedes@gmail.com, michael@theoddone.net,
        mikhail.v.gavrilov@gmail.com, mundanedefoliation@gmail.com,
        nephartyz@gmail.com, oleksandr@natalenko.name, pehlm@pekholm.org,
        renedis@hotmail.com, robert@swiecki.net,
        sahan.h.fernando@gmail.com, sst@poczta.fm, to.eivind@gmail.com,
        torvic9@mailbox.org
References: <20230111212241.7456-1-pauk.denis@gmail.com>
 <20230111212241.7456-2-pauk.denis@gmail.com>
 <20230115161224.GA1246527@roeck-us.net>
 <6fd769f9-da0e-c4a8-dc0e-a1e464c2d9fc@posteo.de>
 <a6906293-634f-a7b0-8fde-92816192130f@roeck-us.net>
Content-Language: de-DE
From:   Sebastian Arnhold <sebastian.arnhold@posteo.de>
In-Reply-To: <a6906293-634f-a7b0-8fde-92816192130f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I didn't want to annoy you! Just wondered why it didn't work and 
whether I made a mistake, or if it really wasn't included in linux-next.

Thanks for all your amazing work in making this chip function properly 
and bringing fan control to many of the latest AM5 boards! :)

Kind regards,
Sebastian

Am 20.01.23 um 21:28 schrieb Guenter Roeck:
> On 1/20/23 11:50, Sebastian Arnhold wrote:
>> Is it just me, or is the support for my mainboard "TUF GAMING 
>> X670E-PLUS WIFI" now implemented into the latest "linux-next" kernel 
>> (I verified this by looking at the source code at 
>> /drivers/hwmon/nct6775-core.c), but the actual patch that contains 
>> the NCT6799D driver is still missing?
>>
>> I had to patch my linux-next kernel with the patch from 
>> https://patchwork.kernel.org/project/linux-hwmon/patch/20221228135744.281752-1-linux@roeck-us.net/ 
>> to get it working.
>>
>
> Well, yes, I do have day-to-day work that I am getting paid for,
> and I did not have time to resubmit the patch adding support for
> NCT6799.
>
> Guenter
>
