Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627205EB488
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiIZW2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiIZW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:27:58 -0400
Received: from omta033.useast.a.cloudfilter.net (omta033.useast.a.cloudfilter.net [44.202.169.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A01A8E9BF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:27:57 -0700 (PDT)
Received: from eig-obgw-5019a.ext.cloudfilter.net ([10.0.29.142])
        by cmsmtp with ESMTP
        id cvCxoaqT8h3t8cwZwoPAIL; Mon, 26 Sep 2022 22:27:56 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id cwZuo8EFjRnBscwZuoYCVd; Mon, 26 Sep 2022 22:27:54 +0000
X-Authority-Analysis: v=2.4 cv=Z6L/oVdA c=1 sm=1 tr=0 ts=6332276a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=aukr7FhhocSji02eYO7jmA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=xOM3xZuef0cA:10
 a=wYkD_t78qR0A:10 a=iox4zFpeAAAA:8 a=foHCeV_ZAAAA:8 a=VwQbUJbxAAAA:8
 a=P2InLthoESwt6vYYg4gA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=h8a9FgHX5U4dIE3jaWyr:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4qq7HZal1zXmdipeTuMCQi90iSHTfHneYxHZyhIjH3k=; b=JBQdcnhcWkrdtfhnIY+ItiYfLA
        SuZmvVNJtRFIRQ49zbxk91lBjJ5SbBysC7ArpbVOeAWWtLt4H0KlGimmzD2u0U6+UPUeCDBDT2nAk
        alw/D1AvrLeEZ7z9W49dTQbQXoMroTu3Fs7h4pnDiN5UPy8pUfjIdhuyHCUYRyRT/tYA0fw8dNgl4
        yAOJASCvp3eqyIf/jlhjxAwYn3mIov3Mom/UKCBsVrwP2cu5pOcErmU0wMG1xi4qlpVLbQQt5BqWs
        QHz+x8mKDOBoUR8Pb4nvngtB+aUwkMYpwZ3r7EmkWm5Ew9WnHJaa8FXYNhMVFBfKQs9Ej8Y/5P6Q4
        KJJfQREQ==;
Received: from 187.184.158.174.cable.dyn.cableonline.com.mx ([187.184.158.174]:20322 helo=[192.168.0.24])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ocwZt-003JXQ-3T;
        Mon, 26 Sep 2022 17:27:53 -0500
Message-ID: <81af0106-a732-ce45-bb1c-c45db9e1aeb9@embeddedor.com>
Date:   Mon, 26 Sep 2022 17:27:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH][next] ASoC: SOF: control.h: Replace zero-length array
 with DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <YzIcZ11k8RiQtS2T@work> <YzIj6tdtDe9YrX+I@sirena.org.uk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <YzIj6tdtDe9YrX+I@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.158.174
X-Source-L: No
X-Exim-ID: 1ocwZt-003JXQ-3T
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.158.174.cable.dyn.cableonline.com.mx ([192.168.0.24]) [187.184.158.174]:20322
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOVsv5es+LQYXmNSljeRTN3qkRCtF70IR+Z7tiCv61qEJf8+1WILe7AVFSWwVMeytBWlgHjbPKQJRINNfCoyCE0QS2Djkl+32bY4yiZQYaZQFAkk87rW
 TM0FtOCP5ST+LA1VON5GS3oxDyAtiWCKJ9WFv6vf6et/3MweobXCp7CpsrXzgssbozUftODtW6OzwrOSt29jLA2BCBlN8LJRdGRoiNETv9UHXRsRArcEzWAD
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/26/22 17:12, Mark Brown wrote:
> On Mon, Sep 26, 2022 at 04:40:55PM -0500, Gustavo A. R. Silva wrote:
>> Zero-length arrays are deprecated and we are moving towards adopting
>> C99 flexible-array members, instead. So, replace zero-length arrays
>> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
>> helper macro.
>>
>> This helper allows for flexible-array members in unions.
> 
> As documented in submitting-patches.rst please send patches to the
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.

That's exactly what I intended to do:

$ scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback include/sound/sof/control.h

Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)

Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)

alsa-devel@alsa-project.org (moderated list:SOUND)

linux-kernel@vger.kernel.org (open list)

Did you see anything wrong with this or something...?

Thanks
--
Gustavo
