Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44FA70562C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjEPSmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:41:58 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51347DBB;
        Tue, 16 May 2023 11:41:57 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 83A9632005D8;
        Tue, 16 May 2023 14:41:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 16 May 2023 14:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684262514; x=1684348914; bh=1f
        O/kNiPZp193hSkVlltEYLsa9D2ujsWk0QBHwBUXQs=; b=N/JVojQTPhfhFUcxTF
        bC2h9gp91uSiiryNj0JMM8kSCSswT/mIUWUuuLj1mjt0YamBO5B75yyPej5IGZid
        v8eLmWe3FMr3/hLz9mpuG4GEJvh32vzRYztJ1iTfqgp78f+ZohkSMeoIqsIJVNbR
        tJz6ojdfKb7ZVErkZfixTshP8PbxEzZLzbsub2z8vVFou7PHs+WlhU1UO+FU7Ltc
        lUYhY1u6nSWw8u3EnRH9VYyY4GAGzzg3P0nsYYtpqQQyxc04jGDg7xzPuryLAWfU
        NQFTpH22J4UG9pgFAhjaWHmrZzkjT2GrvwJm/cbBP1YYVWojQVB5sEZ1dOjFvGPg
        xIkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684262514; x=1684348914; bh=1fO/kNiPZp193
        hSkVlltEYLsa9D2ujsWk0QBHwBUXQs=; b=GBIdhMzAHV5AbsYkMaHe9wtFFyNpN
        i2HZQbbsCGB9eq1pzPErI66Z46TU53StbwERuJfgcHls7iHpgYBVD4Gv2l5WUmsS
        8nzkAgBgxZFdEq/x5+rPSQrVY0s/6clJIc1aj0KNQUGd771gDEKD8R9meVlElEsw
        TGlsYn1pK6VARzMS7b0DhNK/PIknA9HgoaDtRIzL794WFslEfk8LMaJvGQG4s8j+
        fZd9aNLgen8UIkeY6kYC0Uuoh6TDrjP9jmFZf58BEe5oUhpKZbVd3Q+bUvpSgdnm
        IHEKNdE+/jbpy1/1H/+aaOrqZSY/uPb7b+o9ObAYAAeq3pQtybHgE5MBg==
X-ME-Sender: <xms:cc5jZJFZUBRn_PLdBeQZmweVGK_g1MgItCFPnRjnkl1mjaz8X8Zv7w>
    <xme:cc5jZOWEUG6gZ5WkWnrzmuQOawz9i2Cn8VzAw3UNIZr_Gnm2vAR_71a16ifMm0bBQ
    dvdk4Twr2gYzh1JRlk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehledguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:cc5jZLKrKmC5RtPD9du3Ou_htScBAA6Sdlfr7UkB4NPF4eloRULeOg>
    <xmx:cc5jZPFyaDFpFlS2rmAyEnhRcO0NfOU9_5LIKzzxecoOjgKs2t2tcQ>
    <xmx:cc5jZPU6LRHC_gm0Z41a3SDuqpL-6SsxkJa7NoOkuOO9QuucIPzvLA>
    <xmx:cs5jZCNWTfVwCdQAWyXQK7IYln6VsLzrcQigz78VYqxCDYYtWPNkkg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AB514B60086; Tue, 16 May 2023 14:41:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-431-g1d6a3ebb56-fm-20230511.001-g1d6a3ebb
Mime-Version: 1.0
Message-Id: <14213f52-5460-4455-9e15-739b04fda1ed@app.fastmail.com>
In-Reply-To: <64cdd9b6-dae3-f335-63a7-c20ed9b63920@quicinc.com>
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com>
 <7d397e67-5d56-4975-98af-1ac9746c07f4@app.fastmail.com>
 <64cdd9b6-dae3-f335-63a7-c20ed9b63920@quicinc.com>
Date:   Tue, 16 May 2023 20:41:32 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Trilok Soni" <quic_tsoni@quicinc.com>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Souradeep Chowdhury" <quic_schowdhu@quicinc.com>
Cc:     "Andy Gross" <agross@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        "Sibi Sankar" <quic_sibis@quicinc.com>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V6 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region within
 IMEM
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023, at 20:34, Trilok Soni wrote:
> On 5/16/2023 1:16 AM, Arnd Bergmann wrote:
>
> To understand bit better here, what you are suggesting here that
> application bootloader (e.g., UEFI app for Linux) can read these
> boot values from the IMEM and encode them into the devicetree properties
> which can be later retrieved directly from the userspace.

I'm not entirely sure I understand the concept of "application bootloader",
but in principle this can be anything that runs before the devicetree
is handed off from the final boot loader to the kernel.

> I am fine with this approach as well and in this case we just
> need to submit the bindings document, right?

Yes, exactly.

     Arnd
