Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62F66888E2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjBBVSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBBVSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:18:31 -0500
Received: from omta33.uswest2.a.cloudfilter.net (omta33.uswest2.a.cloudfilter.net [35.89.44.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0B46A31A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:18:30 -0800 (PST)
Received: from eig-obgw-6019a.ext.cloudfilter.net ([10.0.30.145])
        by cmsmtp with ESMTP
        id Ng2ep5QctII8dNgyUpZ2IU; Thu, 02 Feb 2023 21:18:30 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id NgyTpLxfDWk52NgyTpe4j2; Thu, 02 Feb 2023 21:18:29 +0000
X-Authority-Analysis: v=2.4 cv=QOZ7+yHL c=1 sm=1 tr=0 ts=63dc28a5
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=iox4zFpeAAAA:8 a=foHCeV_ZAAAA:8 a=VwQbUJbxAAAA:8
 a=mdQ3zACRoVh8_Dy_WlkA:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
 a=h8a9FgHX5U4dIE3jaWyr:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z06T/nkFeiE9v5s4+CdVnUZn2OYhwUVRq1KHTfhar1c=; b=i2Oiqd0B5Rd7RGZA4MnBTpzvb2
        J8gLRFxnbRWnKLkiFNihEIPu8/7lV9M4GNYIV3o663e1pt5g1S6hdJ7a/eBbpKcDNgyNneA1RwoVs
        2eOjBlFTuJqs7XeYuOobRnqFWcT7GoYuAtCUaEY1taD189YznECNsXby38NIsjQIKBNcFzQ+2Ivot
        wt6OfRU2Wn9KA9CsLhOgQr1547oqS9ccpi3TsxT1EYgBit6E/kWxwsb5uzmHsf0AelD3lUoBQz790
        WX+iKoPuGEJabQ5a9qjxkqnObu5ArJ2hRhwfej8CHCd6HMfhwkanseJn1PxaW46lXfCxLUiW0LgLV
        QvHVSKuw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:42006 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pNgyS-0034yj-LE;
        Thu, 02 Feb 2023 15:18:28 -0600
Message-ID: <bb43c410-bd8c-66fe-19a1-0f41442838eb@embeddedor.com>
Date:   Thu, 2 Feb 2023 15:18:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH][next] ASoC: uapi: Replace zero-length arrays with
 __DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <YzIzUjUuJKf0mkKg@work>
 <fcd83e77-a3fb-9061-771a-8509ea6f5950@embeddedor.com>
 <Y9wmnfTi/p4FuRmd@sirena.org.uk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Y9wmnfTi/p4FuRmd@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1pNgyS-0034yj-LE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:42006
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHJ47NBbJuTmodi7MjqCGSOlKjO3htDjuJDvjXCq/oZwHtufXiJI/2ylIa4PS5IChSZ3GktikZz3kopN294ITuw5jdh5i/ptGGRZyyVjLOTqKSfmAORs
 1yxxBvGXNDSrilh4Kz8W3biAPZDuPC3Xuhc+0CKpDTHT8SnM2LU2I7/WhHRlw0XIe2DhipDXhuccEK+eXhSt21oLO4z0/Wuv+D6EGCvblfRRWuvCqagt/joJ
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/2/23 15:09, Mark Brown wrote:
> On Thu, Feb 02, 2023 at 02:34:17PM -0600, Gustavo A. R. Silva wrote:
>> Hi Takashi,
>>
>> I wonder if this can go through your tree.
>>
>> It's already been reviewed by a couple of people. :)
> 
> As documented in submitting-patches.rst please send patches to the
> maintainers for the code you would like to change.  The normal kernel
> workflow is that people apply patches from their inboxes, if they aren't
> copied they are likely to not see the patch at all and it is much more
> difficult to apply patches.

Yep; that's exactly what I did. :)

scripts/get_maintainer.pl --nokeywords --nogit --nogit-fallback include/uapi/sound/asoc.h
Jaroslav Kysela <perex@perex.cz> (maintainer:SOUND)
Takashi Iwai <tiwai@suse.com> (maintainer:SOUND)
alsa-devel@alsa-project.org (moderated list:SOUND)
linux-kernel@vger.kernel.org (open list)

If you're one the maintainers of that file, you're clearly not listed as such.

--
Gustavo
