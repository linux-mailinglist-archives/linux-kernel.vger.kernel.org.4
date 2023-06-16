Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB86732FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345561AbjFPLQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244499AbjFPLQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:16:08 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE137AC;
        Fri, 16 Jun 2023 04:16:04 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 0649086103;
        Fri, 16 Jun 2023 13:16:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1686914162;
        bh=OxZM2+EnYD+j/heb84+JUmtDueMa5fTTJYm2Q9ArZLo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OdtVBoEyI1CgdsJi57N5xLA7gibjHuzF/2ckQASeeBmWXHLiMHjf5R9XBphtw8qyP
         jliI2uC/jKwJHSXKWwRvqqT8SwVoHa42Fy2kYqu/iqK0hgowHUqdwzKkK73EX3+tgA
         dE+zREh0tGORy2hC2/3V8lYxOGFVmBtdW+6K0yvtpszYxahTig5m4fDTlmEWeI5Lj7
         M25/Qcuo6FukPzGAs3H7IjR1LTbonrbjazQhjtA7M3dZ+BbRBPt+phjMiUO6Bu8Tea
         KdpqBKIA7X/HjL4Wp/wrn0kLquwWix8nRNqZ60W/NkeUx+umFWZ1Kf+5Nt3Xv8aFm9
         dQ3p4b7wmW2PA==
Message-ID: <b7e978c9-43cc-2d9a-f3f8-4bfe143895ca@denx.de>
Date:   Fri, 16 Jun 2023 13:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tty: serial: imx: fix rs485 rx after tx
Content-Language: en-US
To:     Martin Fuzzey <martin.fuzzey@flowbird.group>,
        linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230616104838.2729694-1-martin.fuzzey@flowbird.group>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 12:47, Martin Fuzzey wrote:
> Since commit 79d0224f6bf2 ("tty: serial: imx: Handle RS485 DE signal
> active high") RS485 reception no longer works after a transmission.

This RS485 is just a gift that keeps on giving, sigh.

I'll dig into this in a few days as time permits.
