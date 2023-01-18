Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6D36715C3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjARIDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjARH4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:56:41 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE24D5D114
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:32:18 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6FA845C00DC;
        Wed, 18 Jan 2023 02:32:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 18 Jan 2023 02:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674027136; x=1674113536; bh=Dtk1WJnznf
        +PzMyNOebVNgDSKkdCzLVaDG2VU6k2wHQ=; b=OJ6IWFlQoH6Wf94rHtNwgP8aGu
        zPCg1IER5MvxGQb6kJ4QNkrqXAeRQuPdKB/kDpWsaWIcOnw9yxCFuNZFsbZu+4at
        jXc18c75YHtnKm4lh4mbP2sHnx4XQxq/hYnbXEx3hz+Lpu9dKN4V2sjSswYDFRgN
        COA1zBR6qYVUFL0v/vjCErIBtMeeiF1So4jBEnhw1ewWj0GoIzTe4Uc3R8dLm3dc
        GZTqhjIESdXhaBPnLTMjlb7IaEjGmLE5hmZiGak/uQxvfLnsx3AxoDcuH8INUdb+
        TAj7JOq5vaBMRy8plF/0f3rvR/lPTUiKCovoxiCFT9Ve5Hy8XMQ/4Hlv5oJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674027136; x=1674113536; bh=Dtk1WJnznf+PzMyNOebVNgDSKkdC
        zLVaDG2VU6k2wHQ=; b=GV5tKQAUG3x1NdoSLRsMQxwzAxDK3V3lYkODWNpxk5JF
        kzG7VsR0gcCApJVEwdSz6HKwcaiUdzSUC8nLuNRsBKPqAwitqwdqE12rmEEg1m/9
        WXwihPoI94XEVq/lTigVRHRUwZBDujSK2SporF7Ulx5ljHO0n69PyWvvyHoeesNF
        bmGoXr9H8RW7eNQnk7DT6fkg5Ufa4FOFcX+NhQR6wdLtTGGRq7uZ/3BVNKou8aju
        IcZWuGIpG+QF6xbBzuPoNxJeFB2Id0iuMPBFDfno+k62fa4bkfzD0JR710D/PDIy
        k4UN3NB+VvnPBSEUHbGwBHRt/0WgyzFC3N45sD3nRw==
X-ME-Sender: <xms:gKDHY729WOrMR867P2Bk3CGsSQShPAhmt4YfG996zAWDcELS8IXs6w>
    <xme:gKDHY6Gzcpp78qgMXZq9lFPs8hyC0CgtK91PMU0L9P5q82NBNrNwsRXYQcC1h2R2X
    H7BTl_PI_hwpXc8w-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtjedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:gKDHY755Bf6xHev079dwWd0chKFyYDs6mzNz17NbwMM9K2Vws9ccLg>
    <xmx:gKDHYw32wFcoQ9Bq25ErgGo7vZ-ZjnZW5eahrMT9vT-u-s6U4rrPyA>
    <xmx:gKDHY-E1eBDuh7kZWhuBZizvu5evBmrVRbkOco3qif64ab497HQ6xA>
    <xmx:gKDHY8ZNHiy6tbk_Za47nnyKScUh-s8tm2ftSJf9n-EUvpfdbABp3w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 16BEEB60086; Wed, 18 Jan 2023 02:32:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1187-g678636ba0d-fm-20230113.001-g678636ba
Mime-Version: 1.0
Message-Id: <55cb1658-488e-4ed3-b5f9-5d97c0041dd9@app.fastmail.com>
In-Reply-To: <40bf8f6c-c2a1-88cd-163a-256d8d0bb029@amd.com>
References: <20230117164133.1245749-1-arnd@kernel.org>
 <d6166b85-01df-405b-3112-d9bde16b6bd9@amd.com>
 <eec4d2fd-f305-452a-a47f-83203da494df@app.fastmail.com>
 <40bf8f6c-c2a1-88cd-163a-256d8d0bb029@amd.com>
Date:   Wed, 18 Jan 2023 08:31:55 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Michal Simek" <michal.simek@amd.com>,
        "Tanmay Shah" <tanmays@amd.com>, "Arnd Bergmann" <arnd@kernel.org>,
        "Michal Simek" <michal.simek@xilinx.com>
Cc:     soc@kernel.org, "Tanmay Shah" <tanmay.shah@xilinx.com>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Ben Levinsky" <ben.levinsky@amd.com>,
        "Ronak Jain" <ronak.jain@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: zynqmp: fix declarations for gcc-13
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023, at 08:29, Michal Simek wrote:
> On 1/17/23 21:03, Arnd Bergmann wrote:
>> 
>> On Tue, Jan 17, 2023, at 20:53, Tanmay Shah wrote:
>>> This looks good to me. Thanks for fixing this.
>>>
>>> Something must have gone wrong when I ran sparse check on this patch.
>> 
>> I don't think any of our previous tooling caught this, only gcc-13
>> changed some of the behavior around enums.
>> 
>>> Just one question, does this patch need "fixes:" tag?
>> 
>> Probably a good idea:
>> 
>> Fixes: a5e56980cfb7 ("firmware: xilinx: Add RPU configuration APIs")
>> 
>> I can apply this directly to the soc fixes branch if you like
>> and add that line.
>
> I have other patches in my soc branch to send you too.
> Around next week I will be sending PR for it.
> I can include this one too but up2you.

Since this is required for building with the latest compiler
I think we want this in 6.2 and backported to stable kernels
quickly. I'm about to send a fixes pull request for 6.2, so I'll
just include it here.

    Arnd
