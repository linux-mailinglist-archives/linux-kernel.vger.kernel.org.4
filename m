Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0862606373
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJTOpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiJTOpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:45:02 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B5FA5700;
        Thu, 20 Oct 2022 07:44:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7587132008FC;
        Thu, 20 Oct 2022 10:44:52 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 20 Oct 2022 10:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666277092; x=1666363492; bh=XOzeuPW2Qi
        ixpmZ2B6KTbuBWjAk7F4JwVSLfTWQZDNg=; b=wM+Q8gXUrHCWLCViwZYO05VfRi
        4xa1M1EZWWz9hleo5goER29t2I4OGeSGsBXi+eTTXFFS+aYSWHRoIMSm24gSwdTX
        efcXhFeohUWTthOfbOXo3XdlhYXeZ5byABmOitDhzwGk3qxKra+IwfkvEVc0u28v
        I8PEFjfOMPvb43M1Faspt8yzEAkSWgp5P6QVJSaFbDj6Ez6SiaH9f5EIBFrz3m7b
        VQM8NH9dq0d2tp8UT8n/k/oWIZ/rRExJNp4aSrMCBNdtGo1P9sBoKLa58gPJ3qdF
        63lJuzvj4VkoNlF8c+Zix2rDoJ+Luy6u3ARufhu8LqLOLN4i+wEeQ67jNP2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666277092; x=1666363492; bh=XOzeuPW2QiixpmZ2B6KTbuBWjAk7
        F4JwVSLfTWQZDNg=; b=CiVUC37ZiOnHfYOBUKFULR6rrg2C8rSwK3cwurnx7WPO
        SqzarpayTFTtIIxOQLvyvXAlT5HYUuOfXHv16wxDsKaxlh9ZRF6TsCD7DiBiPEo5
        S+piUdtwlz9BczvT8eDDapiTq+0AwZUgRQaGhnhX5HAuHwresz2fg13c1lCvf3yz
        9M+3vOkiKuafq/tV6eXUN0PaEcyMCYCC/76tXe2tnu2lksUJ53nZ/eZQyP1xJuHB
        WjvOUbt/SLG4+UjplBAsmGgCQ7zwoQSrNx+JiZ1SmWPBTlNYP5ZeR33Z45vAVlLO
        9d/FLEFBSBgMzucUUuojBNki3ryH/O7BLkFv4Waneg==
X-ME-Sender: <xms:415RY6tmrYaacvPfoKGnXNMPTlnlow_gkNSqkTDuClFpQyGDMfLzTw>
    <xme:415RY_d0rFnr69p-qJw2AkV0vnuz9muqBT6kh30vZZTKTAWPDhIVMsyv1z_v1XiaK
    bMYIdA7mgON7fHRm5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeliedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:415RY1wPmByBBRXqYhiOJyqyP3wLtQRowAz8HFPbrHBE3wbfL9yXVg>
    <xmx:415RY1OePgC_TuhO0xdoKhZKq3OHmFni1na-aEiPCSVU1PqruCzrBg>
    <xmx:415RY6-_r4d_mcBO3eqU_FGbcNXxUP3BM6F6rlBatpi6UeklbNVzlA>
    <xmx:5F5RYxafd92hLUatBzWC59HkhTe4n7YA9PMMRB_n5Sa2XYIM3PFYyg>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CDCAEB60086; Thu, 20 Oct 2022 10:44:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <ef23d179-15fa-4ad9-8ddc-ccad7790f8d0@app.fastmail.com>
In-Reply-To: <0f29aa0297d6fc5daa86f81925754c1f6d3f679c.camel@savoirfairelinux.com>
References: <20221018133800.10636-1-firas.ashkar@savoirfairelinux.com>
 <a577dfcf-5a0a-4568-8f6d-872a8324dfcc@app.fastmail.com>
 <0f29aa0297d6fc5daa86f81925754c1f6d3f679c.camel@savoirfairelinux.com>
Date:   Thu, 20 Oct 2022 16:44:31 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Firas Ashkar" <firas.ashkar@savoirfairelinux.com>,
        alex@digriz.org.uk, "Ulf Hansson" <ulf.hansson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mmc: add TS7800 FPGA based MMC controller driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022, at 16:42, firas ashkar wrote:
>> 
>> > +
>> > +#define DRIVER_NAME "ts7800v1_sdmmc"
>> 
>> Maybe drop this macro and just use the string directly.
> This define macro used in multiple locations

Yes, exactly that is the problem. Other drivers use the
same macro name, so it's very hard to grep for the actual
string.

    Arnd
