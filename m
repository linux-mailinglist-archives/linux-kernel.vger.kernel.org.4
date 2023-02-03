Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408DF689A22
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjBCNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbjBCNuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:50:07 -0500
Received: from omta035.useast.a.cloudfilter.net (omta035.useast.a.cloudfilter.net [44.202.169.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8208F8DAE0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 05:50:03 -0800 (PST)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id NmJ1pLU7Csq1sNwS2pwK4q; Fri, 03 Feb 2023 13:50:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTP
        id NwS1p4pebOjiGNwS1pUusH; Fri, 03 Feb 2023 13:50:01 +0000
X-Authority-Analysis: v=2.4 cv=A/1/goaG c=1 sm=1 tr=0 ts=63dd1109
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=wTog8WU66it3cfrESHnF4A==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=m04uMKEZRckA:10
 a=wYkD_t78qR0A:10 a=7T_mhvgX4LM0xDefXN8A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nfvZ96BrG5fGeqbIzSxz3kPTSkmeAy6LnZ8/UueNOmo=; b=TfEx5VjdpDytiqvVkfKzqhmyig
        GT8JecRLWYtUwnOTw2twgiuRm4WC9U94X6fKQ1Yj7XwOm37pRHOjFxrildsuKtE+4qJic4gh4rnPs
        67jyNrATMKJ0yjuWzcAC2S4ZCAhekqCT8jlcHpD+a1LUvsEgCbaAWB0Y6xRcBp/RiU3ZTcEVYbiYb
        GErA6TjebKlZ1du/teXeLfRQQdOt2rEUAuDXf35t3Eu7LW0V38WphXHgzrN8RYxrjzP3BBDm4OvWQ
        3c9m4CD16oI9nYCrgVKYx0kM1J2eGyoHKotqxPMu7/F8FS9wMNPa2ca7SLGcXTpuUWEAwa9OOWolS
        LXP8+kqw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:53588 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <gustavo@embeddedor.com>)
        id 1pNwS0-003U2j-P0;
        Fri, 03 Feb 2023 07:50:00 -0600
Message-ID: <0dad546c-203a-062c-8922-54d506529cd7@embeddedor.com>
Date:   Fri, 3 Feb 2023 07:50:19 -0600
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
 <bb43c410-bd8c-66fe-19a1-0f41442838eb@embeddedor.com>
 <Y90ExljX2qCsowhu@sirena.org.uk>
 <652684af-bd10-99da-1ed8-104407493428@embeddedor.com>
 <Y90P3kik6ONZg3U4@sirena.org.uk>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Y90P3kik6ONZg3U4@sirena.org.uk>
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
X-Exim-ID: 1pNwS0-003U2j-P0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.7]) [187.162.31.110]:53588
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBqud5Moqi2Mju0pqaFxGS0TtuWcb6+BBykscQl8z03ta/ZC4OJj2bpRauszAIpFnvOoCoiRcc8XpcHlaN7JV7b6KcGNtdjZ8f/30or/M1S7RkeFgkxa
 Zk6xnpQIs1XkeR0gCssC1awL28wfWUi8HNQJqBHs6bqeDDEI4ZjLOEV29Q5/ffCrezn/mSMPUNabQJlilRTKxCl9XdIqfTG+995lQqQCuKdkNeAIAZkkzver
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/23 07:45, Mark Brown wrote:
> On Fri, Feb 03, 2023 at 07:27:03AM -0600, Gustavo A. R. Silva wrote:
> 
>> I think we have run into this same issue (you not being listed in the
>> MAINTAINERS file) at least once in the past, right? (thinkingface)
> 
>> IMHO, the sensible solution for this is to keep the MAINTAINERS file
>> up-to-date. So, get_maintainer.pl can continue to be useful for people.
> 
> Sure, feel free to send an update...

[chuckles]
