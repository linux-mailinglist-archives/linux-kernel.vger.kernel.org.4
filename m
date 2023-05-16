Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA92470479D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjEPIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjEPIUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:20:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4123040DE;
        Tue, 16 May 2023 01:19:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AE00A5C01BA;
        Tue, 16 May 2023 04:19:58 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 16 May 2023 04:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684225198; x=1684311598; bh=/z
        Oa7snEU3Cp/EeHjqLX2PpkdorLY7kygrSpj6S6YOk=; b=FAEydWB/kiSkfeXIOD
        C2AI0MFMwa0AYMof78OjMTcYRKAP28pWtvKNzwid6BnCvSevEWC3/X/QcSfCToU2
        F8fM4azm9lKq0wQdollznwHX9js7QB0amVRvWJXk7mG1LkAd8o7kGrGI8fk2tEeZ
        exJQgaODPo2NsBmZF/pKpB9Gyy1kAlotpa55UwkZyueem1xlfhrZ+PEcIGMC+A77
        riNyhuPPl71MicJaiHVQxKRalo+MAvEWzeIGA/A/OIsiweKXxqevwTRF4NikIax8
        o+rB21JmmlqVaK7yALgrAZFtviAahN3F77kzKxqUa3+OtzaYWlo5NQp+ss7gne2P
        Tugw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684225198; x=1684311598; bh=/zOa7snEU3Cp/
        EeHjqLX2PpkdorLY7kygrSpj6S6YOk=; b=VltTvEGRgjkVrCYFHjhqv2JcrnYA7
        kP0az0DvZdTVRJLCMLhRmW6O08T9CK14RBrcsI/BbiYtuXs6huZtYcYlin9jptyb
        AmKhBcnnxqT3oYbX6Ix2PVuDT02mrdTLdIHAFdmu0WvVuUsIQ2SWPWpkN5Y0anZX
        yGcvTDX00c4J1Ouhhnj/89TKEff/ADZ62lk0+Hsr1BYmSi0hrymazgSQXAeo761K
        0bHl46u533+x6spAOzsA700NilOdNIKEn0lwR2Ce5nKF2Q+Zwpy6I+bp3fLyODf0
        NtJWxwJhrGPB3sJqLaDipf8DvVqw9ktQUvIoqmHYd6pNybxu4e9xOOzFg==
X-ME-Sender: <xms:rjxjZHA3ZBSUC6pJ6khnKwcOIKP_T2E1Nss8bKbTOrpBF-FXzqthMw>
    <xme:rjxjZNhWsDux6uOEcNPk-P_PapV_y8eefOjBJPXMiub7KwVUH7uoDKGXApAxtwgnA
    7GYOQVHaQLhKl5nGhU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:rjxjZClimy6GdniBJuKdmUJqBYPygwhVeL3IWa9UBP8fDvCvQ-lmTg>
    <xmx:rjxjZJwNCcOjLVr10PC90SADQIcpe6Gra6LMabaRzHQMPDahQwxL0Q>
    <xmx:rjxjZMS3KD0MvXxmy_wAPCcBx-IWioDQLomYiSfYEHJqdlrHPRosmQ>
    <xmx:rjxjZF_NLF-hxcK4Xfjgya5Ol92jUCGM3bs3V6lkvs3IT6TU5z7uwQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7C615B60086; Tue, 16 May 2023 04:19:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-415-gf2b17fe6c3-fm-20230503.001-gf2b17fe6
Mime-Version: 1.0
Message-Id: <3faa9bf7-b42c-4951-8103-9ea2fe02eac1@app.fastmail.com>
In-Reply-To: <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
Date:   Tue, 16 May 2023 10:19:38 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V6 2/3] soc: qcom: boot_stat: Add Driver Support for Boot Stats
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 9, 2023, at 12:52, Souradeep Chowdhury wrote:
> All of Qualcomm's proprietary Android boot-loaders capture boot time
> stats, like the time when the bootloader started execution and at what
> point the bootloader handed over control to the kernel etc. in the IMEM
> region. This information is captured in a specific format by this driver
> by mapping a structure to the IMEM memory region and then accessing the
> members of the structure to show the information within debugfs file.
> This information is useful in verifying if the existing boot KPIs have
> regressed or not. The information is shown in milliseconds, a sample
> log from sm8450(waipio) device is as follows:-
>
> /sys/kernel/debug/qcom_boot_stats # cat abl_time
> 17898 ms
> /sys/kernel/debug/qcom_boot_stats # cat pre_abl_time
> 2879 ms
>
> The Module Power Manager(MPM) sleep counter starts ticking at the PBL
> stage and the timestamp generated by the sleep counter is logged by
> the Qualcomm proprietary bootloader(ABL) at two points-> First when it
> starts execution which is logged here as "pre_abl_time" and the second
> when it is about to load the kernel logged as "abl_time". Documentation
> details are also added in Documentation/ABI/testing/debugfs-driver-bootstat
>
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../ABI/testing/debugfs-driver-bootstat       |  17 +++
>  drivers/soc/qcom/Kconfig                      |  10 ++
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/boot_stats.c                 | 100 ++++++++++++++++++

As mentioned in my reply to the binding, I don't think this should
be a driver at all. On top of that, even if it was a driver, it is
clearly not a "soc" driver since nothing in it has any relevance to
the hardware, rather than the first-stage loader, and drivers/soc/
drivers should never have their own user space interface either.

       Arnd
