Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2466E4BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjDQOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDQOjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:39:46 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9ABBBB7;
        Mon, 17 Apr 2023 07:39:29 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 87E785C0134;
        Mon, 17 Apr 2023 10:39:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Mon, 17 Apr 2023 10:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1681742368; x=1681828768; bh=47
        c10joXrSC6smqeymYuL6B/dgnBcNYu/wXLczUzxvY=; b=l6CZtui1XunEZtfBDf
        jjluImFNB8dbdEd3aO57e8gxqvmhUSHBYmSppZ/iRm30iovpUiOxsz7NRdbbslaH
        V1o6dtN1zExc97YmtCQ0oYK5/LVv4bm4/AuNstRkuegAfR5mxhyKBs0l3DGvulde
        gEviA8MWFO4t5Qk9FHhjXkJxs2xlYDr/0+DDEVAFr99N62YzEEQeY42kXkgvtBFx
        nlgR+a/rXvF3IUQ4hpVOGBZJ81FVaoJZkBQmcX4p/KPgfed6kwnnU34nfh6x4QXg
        TRTPntriVfV70IZSB/G8ypMkXlzzrlq7rtrSrJGunNk/htouuLhLIx1NlpHDCjqY
        s/ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681742368; x=1681828768; bh=47c10joXrSC6s
        mqeymYuL6B/dgnBcNYu/wXLczUzxvY=; b=a2BfTa1DW3CYLyZmvLzlAg+sbJQJE
        AKf7esjVvLG1jBe5vX3xVqAaQ8EzWPaIgrBGXDQoS8d1g+IE41HIoaaEGyYBSFi/
        O89knLsuZpapns1Td68OpAkxD+piEG1apKjNdRs+qgTQYXI/L4AuUiqxTNbsPX3X
        k4pcDZ7GnIzOZGYnBOBr5v7rbvp2TLTE/LZcGe04AIkehmGCZ9t0PftpaP2/+Rye
        Vz0oSTt0J0+liYG1v5j9Uo6f1zVKwlg5R15kgy5VAesDRQibW8pbhvUJyBywCPd2
        wsMU9svyd/3DXACd1/63yildDNJZwULPwIRZFoC/AJSjvh/KigXAdPExA==
X-ME-Sender: <xms:IFo9ZDt5D54t93c_r5GleKb8eHJbZmpKw54RHIXToLjRjlbH8bKaHw>
    <xme:IFo9ZEe822eWFLFKmjM03hZ-e09x0q_aUOGpyiS7iDFUhjSLrn97ct1WLttJQgZ3K
    4bY-urITJHwl5SK7Vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:IFo9ZGxMi76KFncYw7pvAxPBkAHaJWUu0aJ3R2BPOuSuJdW8kVbRUw>
    <xmx:IFo9ZCP-a6gJL1VFdAj6i2LVHPjIPYR5PWL2wEuX9ezdX77pW1jLkg>
    <xmx:IFo9ZD9r1ppiiwLIp_p9Rr5J8K2fBu3ulgmbJ_Fgjmrc5fG2m0IwZg>
    <xmx:IFo9ZJcXdueAD46DODLQniqwkQ-poMzBXn-Myh2I4YceDbqsWl1Wsg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 43545B60086; Mon, 17 Apr 2023 10:39:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-372-g43825cb665-fm-20230411.003-g43825cb6
Mime-Version: 1.0
Message-Id: <c74ba848-dccd-4d31-88ea-1788d0beac73@app.fastmail.com>
In-Reply-To: <4c4e4a51-8afd-c6e2-91c6-090cc0382d9e@linaro.org>
References: <20230413131705.3073911-1-brgl@bgdev.pl>
 <20230413131705.3073911-3-brgl@bgdev.pl>
 <4c4e4a51-8afd-c6e2-91c6-090cc0382d9e@linaro.org>
Date:   Mon, 17 Apr 2023 16:38:58 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Bartosz Golaszewski" <brgl@bgdev.pl>,
        "Sebastian Reichel" <sre@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "Bartosz Golaszewski" <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/4] arm64: defconfig: enable building the nvmem-reboot-mode module
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023, at 17:16, Krzysztof Kozlowski wrote:
> On 13/04/2023 15:17, Bartosz Golaszewski wrote:
>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> 
>> This module is used by the Qualcomm sa8775p platform for passing the
>> reboot reason to the bootloader. Enable building it in the arm64
>> defconfig as a module.
>> 
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!

     Arnd
