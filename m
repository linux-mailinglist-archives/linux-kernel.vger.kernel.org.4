Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32022610F2E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJ1K6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJ1K6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:58:05 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52192EF55
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:57:57 -0700 (PDT)
Received: from mailrelay2.pub.mailoutpod2-cph3.one.com (mailrelay2.pub.mailoutpod2-cph3.one.com [104.37.34.7])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPS
        id 6061012b-56af-11ed-a925-d0431ea8a290;
        Fri, 28 Oct 2022 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berginkonsult.se; s=rsa1;
        h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
         subject:mime-version:date:message-id:from;
        bh=kA29Uae9pNDmiilF2kxIxk5SKCRQrz1myBuRn56hAdU=;
        b=Q9XIX7kycrYm+IYy9u6s+j8QsOjSiUX2AAzgjeD5S+sYpmU+QqeBGx/2lz6Oeh9zcxNTz60eY8W76
         1w5JHfLpT+eAMzrPGWbkenhvTydqNJkbKoMa1R+gYRcriLLkjnvbnLekI5sBSC8IIS+UhoPG4PnCzQ
         7BstZQTUgVzNRYZm6NTfCEBC+c3PdccZtum4NvfiBTIBzR6bD4r+siEhZXWheyGd16M4UOQF/Fh53F
         lbI2NFWKvWpR5ARm5vHm28CFXNBkwzY6dj3GfC0uvc4UbSWR2JlcJHnlOZTEhhVT50NPlrB+io3R7l
         GQKLZlM7ZPhAAKAGSk+VTx02ubS4Grg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=berginkonsult.se; s=ed1;
        h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:
         subject:mime-version:date:message-id:from;
        bh=kA29Uae9pNDmiilF2kxIxk5SKCRQrz1myBuRn56hAdU=;
        b=JOB1ie2St9eIjmYsI90Y0f+3pKIyVxdRqaDj7qAL//04kcPn8fbs9qIONm28PRamML1Ye88NqSham
         KIvFe+xBg==
X-HalOne-ID: 5fdb2752-56af-11ed-ad16-335755252108
Received: from [192.168.100.34] (ua-213-113-159-147.bbcust.telenor.se [213.113.159.147])
        by mailrelay2 (Halon) with ESMTPSA
        id 5fdb2752-56af-11ed-ad16-335755252108;
        Fri, 28 Oct 2022 10:57:55 +0000 (UTC)
Message-ID: <35dadf46-862b-f174-9870-7685a6945389@berginkonsult.se>
Date:   Fri, 28 Oct 2022 12:57:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] ASoC: cs42xx8-i2c.c: add module device table for of
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     james.schulman@cirrus.com, david.rhodes@cirrus.com,
        tanureal@opensource.cirrus.com, rf@opensource.cirrus.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
References: <20221027115057.442925-1-peter@berginkonsult.se>
 <20221028075045.493191-1-peter@berginkonsult.se>
 <Y1u1Hl7GaTlS/jeF@sirena.org.uk>
From:   Peter Bergin <peter@berginkonsult.se>
In-Reply-To: <Y1u1Hl7GaTlS/jeF@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-28 12:55, Mark Brown wrote:
> On Fri, Oct 28, 2022 at 09:50:44AM +0200, Peter Bergin wrote:
>> When trying to connect the device with the driver through
>> device-tree it is not working. The of_device_id is defined in
>> cs42xx8.c but is not correctly included in cs42xx8-i2c.c.
> Please don't send new patches in reply to old patches or serieses, this
> makes it harder for both people and tools to understand what is going
> on - it can bury things in mailboxes and make it difficult to keep track
> of what current patches are, both for the new patches and the old ones.

Thanks for the instructions! Will follow on the next update. I'm new to 
this and trying to learn, pointers like this are very welcome. :-)

Best regards,
/Peter

