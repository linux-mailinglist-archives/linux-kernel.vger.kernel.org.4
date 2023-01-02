Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222765B05E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjABLPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjABLPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:15:12 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF009633F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:15:05 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id F0D42320090A;
        Mon,  2 Jan 2023 06:15:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 02 Jan 2023 06:15:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672658104; x=1672744504; bh=JQ8xtRKxmn
        +OZwWN5jOfx1IkvUUdz9LGSdeeBeq4v30=; b=edZWf9LviaBsQJozEhigGSXxlO
        DuQUj6rAra7T3XG8zKypCEeyW+n7jZDehmPfqOX752MujIxl54uakDKsYVWafQyb
        cNOpJ7zVftW/pu9AGAkIsmDwaiSNskdmTtB8KOeOQQ1tWCxqblZhMpPKU+j5K65P
        iC8rj1JEsXzSIHRbLRViGm2DpYTptTg3Hm8GPFIRg2GdTOvrrWw1RinZlUDSiNJp
        puDA0PpLig3w1a2U6IyIUqB+Zzi1sFolo1UZtfvyQ9MnaDOdtJac8SJBfGcDS4uz
        WUwNVILFr/Fbn6FScxrxHXdA50edz0tjeCek555qz6MntmxESVzkjrYyklTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672658104; x=
        1672744504; bh=JQ8xtRKxmn+OZwWN5jOfx1IkvUUdz9LGSdeeBeq4v30=; b=P
        rBjL7DsrgB3idQM/uZxTCraBCT+O8B753ou6LNAzpApE0+cs31TtdUhja9zF/jJr
        Ik/KKk/L8gvwgrfcPIJ0qwBQ6Fu+reHPX6XWFXcm7h7NUDAUj+dmpylGShtTIt2f
        +JEpdPFBeNWmB5roNgNMvljCwlJN7GTpLm6le+1nv4tn2jMprrs6h6ZqPMOVNZ4O
        FSFkDUIpo/AseX1IzTQv1PcPWf+3lIOGq2vnpvt18EIGaTBFXO+cyRn3REHR5Irq
        f7n4PNwAcnFD+9ALVv06TR0ZF62M740LCwvv3erRDEC/0IsegVU/5UbRYXgeMsa6
        X+Albcup3a31ATHY+8rlQ==
X-ME-Sender: <xms:uLyyYwUsqjNT_l-XoCzpppt3Ovaa08DlkVAvYCZC3rle1fFwCK4w-A>
    <xme:uLyyY0lYkxXrRJwjrQ0egE3gUzglSXPyNHYuts_GyXGEVwotqJ2zH6Oz_0sOKXGJI
    _pRhIU40O97bJREZg>
X-ME-Received: <xmr:uLyyY0aFujm2wSBeTkMeahkC9IqumjqaUXshyL5shckNs10DcdZrIP6twY0KQtIUOE7g2KWfXOfOcy0JprDHTcr7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedvgddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeekueeijeefueffkeekteegleevjeeiteehiedvtdejiedv
    vdelvdffvddvtdeugfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:uLyyY_UOk_1tIMcD4QOvg7SHGJgXPfZq-uMYP9CB4XAILsriDzfs3A>
    <xmx:uLyyY6lALZMTdnbtpniQhB9ULWUZuT43-FGNrV6hSwYNllXNMehq1Q>
    <xmx:uLyyY0f6Dv1De-23TZJfn36TVYH2nor1NxTMxHu6CRJSdmEIhEVvWQ>
    <xmx:uLyyY_jWjUwOyjwQ2qFFZ8MbpS4kpRNMihaPda94I492D966BL6DFA>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jan 2023 06:15:02 -0500 (EST)
Message-ID: <b6e06ab3-1e31-d547-29cc-38037891227f@tom-fitzhenry.me.uk>
Date:   Mon, 2 Jan 2023 22:15:00 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] mfd: rk808: re-add rk808-clkout to RK818
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Lee Jones <lee@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221228140708.26431-1-tom@tom-fitzhenry.me.uk>
 <257b19f7-89ce-39cd-a403-b5a03d92c7bf@redhat.com>
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <257b19f7-89ce-39cd-a403-b5a03d92c7bf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/22 05:27, Javier Martinez Canillas wrote:
> On 12/28/22 15:07, Tom Fitzhenry wrote:
>> Fixes RK818 (e.g. on Pinephone Pro) to register its clock, without which
>> dependent devices (e.g. wifi/BT, via sdio-wifi-pwrseq) fail to probe.
>>
>> This line was removed in commit 3633daacea2e
>> ("mfd: rk808: Permit having multiple PMIC instances"), but only from RK818.
>>
> 
> Maybe add a Fixes: 3633daacea2e ("mfd: rk808: Permit having multiple PMIC instances") ?

SGTM. I have added this to the v2 patch.

> The patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks, I have added this to the v2 patch.

