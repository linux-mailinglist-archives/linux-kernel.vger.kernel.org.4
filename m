Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D6A5E81FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbiIWSrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIWSra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:47:30 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96E6120584
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 11:47:29 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2EA14580AB5;
        Fri, 23 Sep 2022 14:47:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 23 Sep 2022 14:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663958849; x=1663962449; bh=qo3CYYH+x0
        KzkklxDqq7gxHs69euR9fR9lwXjAKaH5k=; b=pj5ljiAo8N4izK1Z4Ob9Qy10cd
        AqHgbAFTddrFGBKahcAIhMBAQ9pjDDrqD+4Lj2JBix/D6gcBpBmS+O59/xjiic2O
        vt43qok+qPJECzDr9Z4Q0Jj7a7froaYWannBSfgIlKNk2S7+9CO3Ney2azhqtzyI
        wx3yCD05EXu6M64YYFJ9Fm0k64PoaeUaY1+YwUOWXWSapny68I6WaFgH+MTUSFNy
        F3WqUXiXFs2uOtTlaoIQQsLNT5cCdx4wKJU+Oce1Tn3QSnQ1qYqkDq+l9Q7bfeD/
        x2ETrNIp1vaAx9senTXn6cu7TVOXZY+oi21Hd2Okm/nigDPf3+an5s5BEvow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663958849; x=1663962449; bh=qo3CYYH+x0KzkklxDqq7gxHs69eu
        R9fR9lwXjAKaH5k=; b=hUyaPn5ZiXJ64xU+51g0jXtF33XkmTsTWXIXbyIF3Mit
        LRTYyn0b8BllTHiu4hO75fjMlDv9+GZbR1gg/Qc3cLeXlqNdaerY5EEkiXul2y+Z
        n2+1pLmzjxUdUH3FkN1bZz5YzgnUaUYlTVfVQG+HmYOyXHECEuxbdHfWrvv45/6A
        SQQNtPi6o+Bt6s481rKbpmaJSYHKKHy2sTLlLAqQ++kzsHoNrZJANkpN909AZz/3
        7EayaGFiEbG2pq1bR+59Q8wEheLUYWmLeBPwU1D+JfnbBjz1bkxrcG4gdnMGuV7p
        MhpRY+quLRbHP/lX/+829YlhVpX8eJ0nuxhj5aNR7A==
X-ME-Sender: <xms:QP8tY8gh5QGmyaPX7J_jAbokbpE9eGIkep0XgeGmFz9yQ0ZuSLe3hw>
    <xme:QP8tY1AuP4f75Q0HLZulmnML6EGKhAOC1mBRilLlmu0VUbn9Zh_rZerZCkBGzI-yb
    kNeCPmOVRdwjo2S8R0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefiedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QP8tY0HwomLMMicDl7j1gzB4PW6addPqHN7zHhjUFWEglHPiH5Fq5g>
    <xmx:QP8tY9QdCoIhZPnQKZ6fOIk4eH81n8l1Yw_wDLS2XLKehN8ItXhKrQ>
    <xmx:QP8tY5zvzgh5_y1yEnJK8iWClCFZqeiPRNc969rHJDFR7S-EyrA0PA>
    <xmx:Qf8tY0_U1esJunMp6rqhxEAS58oFl8qvwygqJxezRWzx1AZSi8e8hg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 25172B60086; Fri, 23 Sep 2022 14:47:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <9aff6eac-71f0-4a5d-a26f-c2cc91a37555@www.fastmail.com>
In-Reply-To: <ea5feb59-59b2-a0ad-e878-9b431d810291@infradead.org>
References: <202209180926.OaCX9uMr-lkp@intel.com>
 <ea5feb59-59b2-a0ad-e878-9b431d810291@infradead.org>
Date:   Fri, 23 Sep 2022 20:47:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Randy Dunlap" <rdunlap@infradead.org>,
        "kernel test robot" <lkp@intel.com>,
        "Qin Jian" <qinjian@cqplus1.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: sunplus-uart.c:undefined reference to `uart_suspend_port'
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022, at 7:22 AM, Randy Dunlap wrote:
> Arnd, Qin Jian,
>
> Fix is here:
> https://lore.kernel.org/lkml/20220901000821.15376-1-rdunlap@infradead.org/

I picked up the patch now. I was debating whether we should just remove
the 'select' entirely and handle this using the defconfig as we do
for most other platforms, but your patch is the easier fix, and
I didn't want to risk getting it wrong if I rush in a different fix
before 6.0.

      Arnd
