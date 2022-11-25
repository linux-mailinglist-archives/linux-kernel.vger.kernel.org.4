Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35863824F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 03:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKYCOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 21:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKYCOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:14:23 -0500
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Nov 2022 18:14:20 PST
Received: from level.ms.sapientia.ro (level.ms.sapientia.ro [193.16.218.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7405923EBA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 18:14:20 -0800 (PST)
Received: from localhost (level.ms.sapientia.ro [127.0.0.1])
        by level.ms.sapientia.ro (Postfix) with ESMTP id 58771FAEA57;
        Fri, 25 Nov 2022 03:21:29 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.11.0 level.ms.sapientia.ro 58771FAEA57
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms.sapientia.ro;
        s=default; t=1669339289;
        bh=JhoFTZyH7NV7eGe2T47ydbyz5xrk1QXnWQdNieuDhbs=;
        h=Date:From:To:Subject:Reply-To:From;
        b=pey7aCijrCj6bngv0slwZAGAdknGRnvLGZvu/wFMhUf5+LV6KZS6XkzHbVlIb7w/P
         K0lvcuJf3UtibqkyxTuN0T3P6UtixbLxcBlWRuQqTI5D2A/bOnmL33qW19lLQhI4kF
         iW5eI3TCRo5XlVe2BW1n2NjERxn8SxfJDGyf7WvY=
X-Virus-Scanned: by B3 SapScan
Received: from level.ms.sapientia.ro ([127.0.0.1])
        by localhost (level.ms.sapientia.ro [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I5RbvZdS8YmV; Fri, 25 Nov 2022 03:21:26 +0200 (EET)
Received: from level.ms.sapientia.ro (level.ms.sapientia.ro [127.0.0.1])
        by level.ms.sapientia.ro (Postfix) with ESMTPSA id 338F06FBE154;
        Fri, 25 Nov 2022 03:19:18 +0200 (EET)
DKIM-Filter: OpenDKIM Filter v2.11.0 level.ms.sapientia.ro 338F06FBE154
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ms.sapientia.ro;
        s=default; t=1669339161;
        bh=JhoFTZyH7NV7eGe2T47ydbyz5xrk1QXnWQdNieuDhbs=;
        h=Date:From:To:Subject:Reply-To:From;
        b=aIVllG9fQpDvVyrwx5W9bxa74ySF/t8D1y8rNIKks4kvHBeDVVictZb5NfVq6MYQd
         CPaQ05WVl7cw2sSQ2ooeu7uRad0gBZuSGLbY8edrLQCNT8Zy7Cri0mG3SuF4XPVHVH
         Ivqfn+ynZWExqpG6wpV+dQiNla6J6B8P+1R4th2g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 25 Nov 2022 02:19:17 +0100
From:   Lukas <csaki.ildiko@ms.sapientia.ro>
To:     undisclosed-recipients:;
Subject: Please Review
Reply-To: lukas@marineinzynieriagleam-jobs.com
Mail-Reply-To: lukas@marineinzynieriagleam-jobs.com
Message-ID: <ec618ed45b80e7d1035797d69c474f2f@ms.sapientia.ro>
X-Sender: csaki.ildiko@ms.sapientia.ro
User-Agent: Roundcube Webmail/1.3.4
X-Spam-Status: Yes, score=5.1 required=5.0 tests=ADVANCE_FEE_3_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,LOTS_OF_MONEY,
        MONEY_FRAUD_5,NA_DOLLARS,SPF_HELO_PASS,SPF_PASS,UNDISC_MONEY,
        XFER_LOTSA_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8776]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.2 XFER_LOTSA_MONEY Transfer a lot of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
        *  0.0 ADVANCE_FEE_3_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend,

I am writing to you on behalf of my client Mr. Yusuf Habib. My name is 
Lukas, I am an investment portfolio Manager at MetLife, and my client 
(Mr. Yusuf Habib) has a large sum of money and he is looking for someone 
to help him manage the funds.

The Saudi government filed charges against my-client Mr. Yusuf Habib 
with the aim of keeping him in prison indefinitely. A variety of local 
and foreign politicians, civil activists, and journalists consider the 
process leading to the imprisonment of Mr. Yusuf to be politically 
motivated. My client's involvement and financial support for Jamal Ahmad 
Khashoggi posed the most challenge ever to Mohammed bin Salman Al Saud 
who happens to be the current Crown Prince of Saudi Arabia. The money is 
currently deposited in the name of an existing Investment entity.

My client Mr. Yusuf Habib has presented a subtle offer that will need 
the help of a partner like you to complete successfully. Mr. Yusuf Habib 
is in a difficult situation, and he must immediately relocate certain 
sums of money and this must be done in such a way that it must not be 
tied to Mr. Yusuf Habib. The money is currently deposited in the name of 
an existing Investment entity.
Your role will be to:

[1]. Act as the original beneficiary of the funds.
[2]. Receive the funds into a business / private bank account.
[3]. Invest / Manage the funds outside of Turkey
[4]. Value of funds: 35 million US Dollars.

See the website below to understand better the problem Mr. Yusuf Habib 
faced all these past years:

Everything will be done legally to ensure the rights to the funds are 
transferred to you. If you agree to partner with Mr. Yusuf Habib in this 
partnership business proposal, he will compensate you with 35% percent 
of the total sum.
Terms will be discussed when you show interest and if you aren't 
interested and you know of someone looking for an investor, please give 
him / her my contact.

Should you prefer I re-contact you with more express facts. Then make 
your interest known.

Sincerely,
Lukas.
