Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826786D39FC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 21:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjDBTX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 15:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDBTX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 15:23:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B0E6194;
        Sun,  2 Apr 2023 12:23:56 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B21BB5C010C;
        Sun,  2 Apr 2023 15:23:53 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Sun, 02 Apr 2023 15:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1680463433; x=1680549833; bh=kkNbyRljaYc9FJTztqR1CFE1tS2ZZwX6jaP
        Nlt9y7Uw=; b=RCI2w2HTwM1SY80QEJ7vFDO+6pMdfsKVIs05/g3wyK7EFJTeL15
        zoNHiw8wxYfO90TCnUSGbN1qhaDxvqQxXrgA/ti3XCp8bWy9lh4jLEwAkFeRQaux
        qEZCYTVoNUPrRUNeVgdaa12RflIGvanlnTUzEAejfmje32AXdp4CEKe8hl3C1Q6+
        uqmIgWW2EbRQOs2C7SPX0c/xADeyR/ZlL4mDXBa8K3PzJ9ehIIz+hrBLd4h1zVE9
        DkoTy9pshVIDiClyJCQJRIWcPtq0DjVK+GiR+9e/nJTvhMfYLCQ8lgJbN/8nXGTw
        BSyHV3CXJjpe8qLC7I38aAWnAPFauGDt9vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680463433; x=1680549833; bh=kkNbyRljaYc9FJTztqR1CFE1tS2ZZwX6jaP
        Nlt9y7Uw=; b=CWuhAmqJTVifnoQp2ZdOSOEPUVvAHfrJXINg1sDu/2Ckaag2ot+
        X1W3WEVOF+0BKPrffNOynPzAltTojKiikyMwzO4zpv5bIjGXz4hx5QWGyE7W202J
        ZmonjQu24XA4O9lgG8clGl3pqP9tvOhkjdhDH0+gFqBKH6eGWGIZ4A1oNxJ7YNdt
        sclrywrlrCnrNqqu4SY1ziCW7NEm4xuf+aFrNIEVWL9zDM+V+mc82KToJTckjTto
        c4KX2UPjQp/q/rO5aT7e4VZWBanyMZ/6B63k2h0+ZMo2r8RYUVw48jFkUp8RXa0r
        Wjj6t5LgP4fTDturwd67ajfCKGAjORmQDDg==
X-ME-Sender: <xms:SNYpZDGLUfVMWeMH4jR3tyHvmlz1g_9PISpAHvGgiuvWaiJvvjVKMA>
    <xme:SNYpZAVm6M1puOKI-FwPGIBIQCx0_cF5xjiw7KAiw7GTQXmLE8e0eCT9kNMyaLgj3
    SecJpVYXGtJbPwG8fQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeihedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    ofgrrhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvg
    gssgdrtggrqeenucggtffrrghtthgvrhhnpeefjeegvddugedvkeehvdfffeejhfeutdfh
    tdehheekffduvdfgteejgeejueefgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggr
    rhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:SNYpZFJGmNFyXmMv7AGCWa3LthaeMR8FG7S5_GVfm48L7XsHr6d2UA>
    <xmx:SNYpZBEJf0HpcuKzMr05wK9qZbLPLQbgjF-E6ffCmHqxDeoYyQojQw>
    <xmx:SNYpZJXmK1vGlL994DlyjOy6oArVKj8aoGrxUERs2IG2bYt12jGriA>
    <xmx:SdYpZHf9_W1CRDaiTGGLuAxfIZQ1-MNKmLOmwW4juciWF2BVe8pm_Q>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B02A7C60091; Sun,  2 Apr 2023 15:23:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <dfd65bd6-26d8-4ef4-8eaa-3cc412f381ec@app.fastmail.com>
In-Reply-To: <f2bbd848-2079-d5cb-6a59-9040708dc429@amd.com>
References: <mpearson-lenovo@squebb.ca>
 <20230401184345.208960-1-mpearson-lenovo@squebb.ca>
 <f2bbd848-2079-d5cb-6a59-9040708dc429@amd.com>
Date:   Sun, 02 Apr 2023 15:23:31 -0400
From:   "Mark Pearson" <mpearson-lenovo@squebb.ca>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     "Hans de Goede" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "Armin Wolf" <W_Armin@gmx.de>,
        "Mirsad Goran Todorovac" <mirsad.todorovac@alu.unizg.hr>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] platform/x86: think-lmi: Fix memory leaks when parsing
 ThinkStation WMI strings
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario

On Sun, Apr 2, 2023, at 10:04 AM, Mario Limonciello wrote:
> On 4/1/23 13:43, Mark Pearson wrote:
>
>> My previous commit introduced a memory leak where the item allocated
>> from tlmi_setting was not freed.
>> This commit also renames it to avoid confusion with the similarly name
>> variable in the same function.
>>
>> Fixes: 8a02d70679fc ("platform/x86: think-lmi: Add possible_values fo=
r ThinkStation")
>> Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Link: https://lore.kernel.org/lkml/df26ff45-8933-f2b3-25f4-6ee51ccda7=
d8@gmx.de/T/
>> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>> ---
>> This patch series builds on top of the proposed patch from Armin Wolf
>> "platform/x86: think-lmi: Fix memory leak when showing current settin=
gs"
>
> Which version of the patch did you do it from?=C2=A0 I tried to apply =
v3 of=20
> Armin's patch
> to Linus' tree and then apply these two.
>
> The first applied, but the second had conflicts.=C2=A0 Here was my bas=
e (with=20
> patch 1 in
> this series applied).

I was using v2 - but there shouldn't be any code changes between v3 and =
v2....so I hadn't re-based.

I'm working in the fixes branch from pdx86.git (with the aim of making i=
t easier for Hans to pull in the patches). It's possible I've goofed som=
ehow...though not sure how :(

I'll go double check - but likely won't be until tomorrow I'm afraid. I =
should probably just wait for the patch to be accepted and then work fro=
m there....

Mark
