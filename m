Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8601E73326A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344232AbjFPNpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFPNpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:45:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C63189;
        Fri, 16 Jun 2023 06:45:35 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qA9lY-0004cA-UG; Fri, 16 Jun 2023 15:45:28 +0200
Message-ID: <bfe90a36-f7ef-7ea7-da4c-f04da2700fbd@leemhuis.info>
Date:   Fri, 16 Jun 2023 15:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] sfc: add CONFIG_INET dependency for TC offload
Content-Language: en-US, de-DE
To:     Edward Cree <ecree.xilinx@gmail.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Martin Habets <habetsm.xilinx@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Alejandro Lucero <alejandro.lucero-palau@amd.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-net-drivers@amd.com,
        linux-kernel@vger.kernel.org
References: <20230616090844.2677815-1-arnd@kernel.org>
 <20230616090844.2677815-2-arnd@kernel.org>
 <2fa7c4a5-79cb-b504-2381-08cb629d473d@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <2fa7c4a5-79cb-b504-2381-08cb629d473d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686923135;602a25fd;
X-HE-SMSGID: 1qA9lY-0004cA-UG
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.06.23 13:39, Edward Cree wrote:
> On 16/06/2023 10:08, Arnd Bergmann wrote:
>>
>> Fixes: a1e82162af0b8 ("sfc: generate encap headers for TC offload")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
>  and I think you also need
> Fixes: 7e5e7d800011 ("sfc: neighbour lookup for TC encap action offload")
>  since that added the references to ip_route_output_flow and arp_tbl (the
>  commit in your Fixes: added the ip_send_check reference on top of that).
> 
> You also might want to add the Closes: tag from [1], I don't know how
>  that works but I assume it'll make someone's regression-bot happy.
>
> [1] https://lore.kernel.org/oe-kbuild-all/202306151656.yttECVTP-lkp@intel.com/

FWIW, yes, regression tracking relies on them (for now Link: and the
newly introduced Closes: work; the latter came up totally independent of
regression tracking). And I have no problem with being the bad guy here. :-D

But for completeness, in case anyone cares:

It's Linus that for many years already wants these links. He a while ago
mentioned that in a few posts I bookmarked:

https://lore.kernel.org/all/CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com/
https://lore.kernel.org/all/CAHk-=wjxzafG-=J8oT30s7upn4RhBs6TX-uVFZ5rME+L5_DoJA@mail.gmail.com/

But that's nothing new: Documentation/process/submitting-patches.rst
explained this usage for many years already (I just made this more
explicit a while a go).

Ciao, Thorsten
