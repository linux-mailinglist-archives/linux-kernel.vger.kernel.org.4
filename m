Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69B74A699
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 00:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGFWLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 18:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFWLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 18:11:16 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DEC1725;
        Thu,  6 Jul 2023 15:11:14 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5AE3C862AE;
        Fri,  7 Jul 2023 00:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1688681472;
        bh=0EIkI2jUI4DFcoRWiE7tteNt5GIFvY9v+UbpdSJnVDs=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=il+Bf/oB+qrKGRQGAOOh8OKqT4gYPlcuD3JqNBo5FJuxZcYAtRxtbXrs+QgHXE9jU
         RKLfszdUe4tvYLquFv7btSnPW6O2WqTejIxax0MLqWlkXWL3M0+k0seG78m34OmXrE
         jvrwPgn7Hlq+OuHrgi/99ghLKGypxirQV3Kgp1TFaKE8LnUaLWm8vvqx76c6dndWjw
         8Fuc9aZf0F0U2cIGyjmMWy3ZTPLvue3XNZS9OMJjnoDiAGyB7CANzNMRhWupl0nmLE
         RrbMMta24Ep8b8JQrvo0zwyk4ZFmN5Nyy13059mLzsR7Kuti6wFiyKIlDryDVEsdvG
         pqnw/ApBFyuhg==
Message-ID: <64358ffc-449d-b676-6ac6-a2f273c3129d@denx.de>
Date:   Fri, 7 Jul 2023 00:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tty: serial: imx: fix rs485 rx after tx
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
 <b7e978c9-43cc-2d9a-f3f8-4bfe143895ca@denx.de>
In-Reply-To: <b7e978c9-43cc-2d9a-f3f8-4bfe143895ca@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 13:16, Marek Vasut wrote:
> On 6/16/23 12:47, Martin Fuzzey wrote:
>> Since commit 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal
>> active high") RS485 reception no longer works after a transmission.
> 
> This RS485 is just a gift that keeps on giving, sigh.
> 
> I'll dig into this in a few days as time permits.

Alas, time did not permit until now, but yes, this makes sense.

Thanks

And sorry for the delayed reply.
