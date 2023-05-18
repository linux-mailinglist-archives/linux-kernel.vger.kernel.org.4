Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050427078AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjERD5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjERD5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B13B3586;
        Wed, 17 May 2023 20:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD27564943;
        Thu, 18 May 2023 03:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69EFC433EF;
        Thu, 18 May 2023 03:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684382226;
        bh=fEg8/325U2005AbgntETyCrW+YJgMPJvvQBV+djJOsk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WuLA5zR+gwH3h1l14V32L/SOKzakDf4NoUcuzjG5vx+GO/BBqkKQbPfhYfWnP2n1N
         sNvylGOc2mdDeC0BQy5YxSD+ZB9oXJ2J7TLhSKjjqCIADa3CQgqYXeiqg4qx4gkcNa
         K7sEA9IhGW8vEKdiEtrbsTmthjDAgRNqvvJLBgvuv5H9nWRYCk6YgddDsnzWWsSX3l
         93s0BwuAjYGBsSSWfNZ1HvgimfsNhpV6Iccj22rUSRbJVP2PU4B1q38+9V4XXjPyoT
         ukCOeH0AHZ6A6KE8l9eIOa+Ma3cxblMo9EM2YARiFPrWdWl40RQNtEIGmc9RYbkIdb
         rA9aqBpXmlu8A==
Message-ID: <72b07d00-53f1-9da3-1663-24282f192d75@kernel.org>
Date:   Wed, 17 May 2023 21:57:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: linux-next: Tree for May 15 (net/ipv4/ipconfig.c:)
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Wetterwald <martin@wetterwald.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20230515141235.0777c631@canb.auug.org.au>
 <81d74a8e-6bfb-5ed6-9851-faf120a6e9f8@infradead.org>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <81d74a8e-6bfb-5ed6-9851-faf120a6e9f8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 8:23 PM, Randy Dunlap wrote:
> 
> 
> On 5/14/23 21:12, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20230512:
> 
> ../net/ipv4/ipconfig.c:177:12: warning: 'ic_nameservers_fallback' defined but not used [-Wunused-variable]
>   177 | static int ic_nameservers_fallback __initdata;
>       |            ^~~~~~~~~~~~~~~~~~~~~~~
> 

Martin: please send a followup. Most likely it needs to be moved under a
config option.
