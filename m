Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127663734D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKXIHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiKXIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:07:10 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52EFBE868
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:07:08 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id E6DE51382;
        Thu, 24 Nov 2022 09:07:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1669277227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oyThiqymInQ+VthPmFXExjCfeb3J0zdU0dVGbxnNXU=;
        b=cyU95ByhbpMSEw5v4I3cWJcsGYse3UlbVRxkrc9er/Fep/usCpQ61tPKAVzreU7IPUaVEV
        ag5eaUTxa31vcayMTrzUvl1ytLirgqtZ8klXQ6KP+vwnvrus5oPoONysP6vAfIgdkEBL2n
        LX/opTqBYDhKToWnMW48mwhBYWSA05av+ihwQ3Xx2qMN0xf9820HAsbCV8h9EoxPz0lVAf
        JyDQWvFRApxuf5iikIJGgL3+u07iHr9TQ7NWmCVSGjOpGpkk2EL9PCIjFeF0r1QGZDWzvm
        68F3+tnc3gG+rmhmXP7Q5w3kH5KdPgzbp7w00YnJKg3/HgnGrWWv2uSh3IlfIg==
MIME-Version: 1.0
Date:   Thu, 24 Nov 2022 09:07:06 +0100
From:   Michael Walle <michael@walle.cc>
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] These are the required patches I found while adding
In-Reply-To: <20221123211335.126417-1-nathan.morrison@timesys.com>
References: <20221123211335.126417-1-nathan.morrison@timesys.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bb6c006a27184ffa0e4ab9303cffcc72@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Am 2022-11-23 22:13, schrieb Nathan Barrett-Morrison:
> 1) The core framework needs some additional logic for 8S-8S-8S to pass 
> through
> succesfully.
> 
> 2) The IS25LX256 chip needs added to the SPI part table along with
> various fixups

Unfortunately, I can't make any sense of this series. First of all, the
IS25LX256 [1] doesn't support 8S-8S-8S, only 8D-8D-8D and 1S-8S-8S, see
ch. 4. Confused, I've looked at your octal str enable function and it 
writes
0xc7 to the volatile configuration register 0x00. According to the 
datasheet,
that is the enable for the octal DTR mode.

Please explain your problem and your motivation in the cover 
letter/commit
message and how you fix it.

[1] https://www.issi.com/WW/pdf/25LX-WX256-128.pdf

-michael
