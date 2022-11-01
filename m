Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558FC6155F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiKAXOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbiKAXOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:14:21 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10616406;
        Tue,  1 Nov 2022 16:14:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2C49D365;
        Tue,  1 Nov 2022 23:14:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2C49D365
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1667344459; bh=yfCsvhxxQ2FvjPEHe6DUzgBOrNXkR4Ue1LPQt2qCL8Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gYoHh0Iu/NVG6sKlncbumrNVFgdBfG0LXdxTQm6SQve7UZC4iwo4K62sQ6a8VqPRF
         YKe+HleQbdlWzH3BgONsggp3BIdXAi+m+mSlCtakKBHRBEnJ6Dycg6z65FATu5pLCn
         8aOLEDMSkbog+h5MU+YWBosoWiIicBnLbBXo9PerHy6TqKtSgShFSykymLCpdwwF9N
         MqHaor1OgT96PpEJk5LzVRGidMq1KXn2dYqUHGGghF73b1d/AiX/pp2NfWN/3Bl4xE
         iScXQA6+e1xvdyaCpej2stbmhhVI20DBMARWM8kLWDyT+DtjM8hBrVCtvM/pCgmNMW
         UeWsMcq3NN0dA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: arm: marvell: Add Orion codenames and
 archive homepage
In-Reply-To: <20221101224230.wbd37f7zbaueevkn@pali>
References: <20220719080807.16729-1-pali@kernel.org>
 <20220817231208.42emdluzead2hweg@pali>
 <20220923224346.tgws4gxd5daoz2rm@pali>
 <20221101224230.wbd37f7zbaueevkn@pali>
Date:   Tue, 01 Nov 2022 17:14:18 -0600
Message-ID: <871qqmxo6t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Saturday 24 September 2022 00:43:46 Pali Roh=C3=A1r wrote:
>> On Thursday 18 August 2022 01:12:08 Pali Roh=C3=A1r wrote:
>> > On Tuesday 19 July 2022 10:08:07 Pali Roh=C3=A1r wrote:
>> > > Orion codenames are extracted from menuconfig ARCH_ORION5X and
>> > > old Orion homepage with 88F5182/88F5281 was found in web archive.
>> > >=20
>> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> >=20
>> > PING?
>>=20
>> PING?
>
> PING?

Hmm...so I have no idea what happened here or why this fell through the
cracks so badly.  I've applied it now, sorry for making you work so
hard...

jon
