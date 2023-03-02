Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F866A8788
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjCBRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 12:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCBRGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:06:54 -0500
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Mar 2023 09:06:51 PST
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9ED41B5D;
        Thu,  2 Mar 2023 09:06:50 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B23AA100B5C;
        Thu,  2 Mar 2023 16:57:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a262.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 44AAD100D62;
        Thu,  2 Mar 2023 16:57:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677776279; a=rsa-sha256;
        cv=none;
        b=h+b7bWahO/kuD41OCWw+zOkVLlaSjPuacllwAN9+zqHS49cn/tDG0MMsBBSoX7Tjsadctn
        ep24YM7qCCSXJj1n4gDOG5IuFOmsXQrSaQoV79ciIVHYpIOd0tkYfz0tPs7hRxehUOiL6N
        0aiz+CjLdHaGFxva5YpcCDV5CB7vBN6pVmRQ4FPeTVuybndAp036Y+hhlI+DxLHfq+K5g5
        FChauPa+G8I/whQZDnSaTQ/Hua765qQo+hp+j8Goe8bP4I4f8UDBHPPkOT7kWculvFBwMd
        rJ6OW3Zmz6KmFue9ZBpHMp+IZQ4t9fG3hPI3NVim2A2pLkkY8sqT+vui5BRDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677776279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=BtMMHrhC+VxWMHcM9Z5TNWKVxCwkBeOHL18S5DW5UYw=;
        b=iBKpNiVrMtoeaucKaLthtdLl8zygkq7HbEoY0bCd9f7KkjxzZiA9gSMI3gVuPGjGf1MWJk
        xWO6eLeiGN+HFF1rszdvCzg/AcPBG6cuQVoxnFMeyRBz3ZE4u1C0e5o2cyEL+WSX2LAJ3H
        xRgecjwOR1LsG0b3U369TY5qOo6kICc8nGVAGas0RYj78T31wFxDoV4Jy4jhfKr95xZOIf
        9sT8NO57bhVB21A3CCqxHSlY7bcX6x0trdhoQjcU4Z1d7CQFd/k5HNqs/Ezv94SWz+ChGz
        KJKJCQv2X1FHA3cz8LC1QVmdjgYfu2MwFQ2pLMAsMHdUTLSOi2Z10fVLpJeVdA==
ARC-Authentication-Results: i=1;
        rspamd-fd4f5fb8c-wzv7n;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Coil-Desert: 2ab2c85054887b60_1677776279472_3546099934
X-MC-Loop-Signature: 1677776279472:2981588585
X-MC-Ingress-Time: 1677776279472
Received: from pdx1-sub0-mail-a262.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.89 (trex/6.7.2);
        Thu, 02 Mar 2023 16:57:59 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a262.dreamhost.com (Postfix) with ESMTPSA id 4PSHMp0Qk2zy1;
        Thu,  2 Mar 2023 08:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677776246;
        bh=BtMMHrhC+VxWMHcM9Z5TNWKVxCwkBeOHL18S5DW5UYw=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=hw2XolLhYTPkanbG8GCpzvPw+Uit3qCFH/vA8YgC31HvFYKoBhmodjTcNHwJ/oYVh
         VCxD2olWCNE3gyAhrIdI2BRHC6oukxIjHY1OnWFBPJ9oBVDATFlPLhVF0C6S4jRPkw
         Y7wdmzkWEgZ0YVx2rQGKPgEk5vQChC7pi36OEeiWPW29ShzYmcLmDKJXEy+0rGYOZs
         3RsbApjs4iXwQ711yzJVE80yZDVynvbdQCj1sO4dbCr27TNsU1E1SBJQvfHiD/5Psw
         vl/EOguojwvGCRLNhgWMZvKb+R6me2sjOgdBbp4uImqoVdLNGlLIJPuNhwtq24vdHL
         2ARWjyy/EIRBg==
Date:   Thu, 2 Mar 2023 08:28:38 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: Fix hdm decoder init by adding COMMIT field
 check
Message-ID: <20230302162838.euflpp5luvkqcc7f@offworld>
References: <CGME20230228224029uscas1p1e2fb92a8a595f80fa2985b452899d785@uscas1p1.samsung.com>
 <20230228224014.1402545-1-fan.ni@samsung.com>
 <346a8225-609e-0188-ec8a-4abe8d271a09@intel.com>
 <20230302062305.GA1444578@bgt-140510-bm03>
 <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e10b60ab-f666-8124-eb8f-6a2da6c0f989@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Mar 2023, Dave Jiang wrote:

> It does sound like a bug with QEMU emulation currently.

Agreed, but still, crashing the kernel is always a no no - like with
the passthrough decoder situation we had.

Thanks,
Davidlohr
