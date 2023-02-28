Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A36A5DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 17:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjB1Q7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 11:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjB1Q7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 11:59:15 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F42063AB6;
        Tue, 28 Feb 2023 08:59:07 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 662645C01A5;
        Tue, 28 Feb 2023 11:59:07 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 28 Feb 2023 11:59:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1677603547; x=1677689947; bh=Ub7nGi8CXk
        YFk6pL5n50rcqGGgaORCubLMdPuhB4UGo=; b=ZRAMlnoZLRHl3Q9bPUPBhN8voM
        ntIl7uxo6EPfcGNEt/o7y70QSGHWYozaFA/UREjA7BS4XisAjxhXiD7B3lf9OysI
        C3X34lqb6Q6mjxHPOG2A1uUlEyRa24Y7a0n/6qYZCF/DG7LyJ3abn07bRTPOa1Dj
        nIhRMISQ7riaHDpb/sI8nFhjVkMAtU+XYSvRbJvvAbL+KIqNrwMrlLPRmFgX5KlD
        A1VqWoknwg1AM84h1HyqciA00PU5SF2H2ZUAC9ri/X5Vk9L1k7g9yZ0NIi1wpdxl
        pc+6oqO07orDDTs2DqmdP4DGlZM6equVpfu4XfeX2lENkKYt6Mle6Kujw6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677603547; x=1677689947; bh=Ub7nGi8CXkYFk6pL5n50rcqGGgaO
        RCubLMdPuhB4UGo=; b=nr+fmc7TpSYgBl8EDO8JdmlbKttgbGYmh3XQOiEpThG4
        RJG9fao1LILBrDHOPtMCUagIpgJOGlj6v8863SgsWiGPD/Y4ANwYFMnvR3t6SEUP
        PGsKn5294KWiSPhtTUdnLF6ShIRZXJlsyEC8JgHTqWiGvmzcktl47W1xw/677tR1
        55dbX4E5vSG6f2zySH+yiDlRuZe2KgmLWX0TXJoJ2fajRcnS+oX9KpN27dvRX1de
        HeT2GRl87FU8yY5Y90BJP73N5JMuptVgR6SJaNxlbPZxBBnPtEbq+4MlRToFyE9j
        TmWOdCoqd82UHexjsNpkOdDgxgYaQmUrTwnjydw1hA==
X-ME-Sender: <xms:2zL-Yz6AtOcc9jtiAwQh4J1fSVWYk3FP2gggegg6FVEs0ag4tBC9LQ>
    <xme:2zL-Y45qMBgeQ1LGRAm1KMPHV38vxLWYYYR8N_b_u99oL25ZzQIllpYVrq3RNGSYk
    0vpw4Wdycop9AO1XM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudelfedgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:2zL-Y6dKoSJpKUj-euMLixLczBPc-a3YHv7fQE-uEmBldf8YQGTT-A>
    <xmx:2zL-Y0I_lpDBGWz2SydbJhsPw_SJ19Ujez7NM07iePDCkx1T4FJ_GQ>
    <xmx:2zL-Y3L_6VULXzgycuFPYkfVn0KtPvXk37i2BopOKl42GaMacCR3rw>
    <xmx:2zL-Y9gsLwC0iAlgEVCXRDgR7CeQARJRo8oH4597hkwoa1Jyn29-KA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 3CAA2B60086; Tue, 28 Feb 2023 11:59:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-183-gbf7d00f500-fm-20230220.001-gbf7d00f5
Mime-Version: 1.0
Message-Id: <c5e36887-f84d-40ef-bef9-8a3947bbb73f@app.fastmail.com>
In-Reply-To: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
References: <20230228164752.55682-1-manivannan.sadhasivam@linaro.org>
Date:   Tue, 28 Feb 2023 17:58:37 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        "Bjorn Andersson" <andersson@kernel.org>
Cc:     "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] Qcom: Fix PCI I/O range defined in devicetree
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023, at 17:47, Manivannan Sadhasivam wrote:
> Hi,
>
> This series fixes the issue with PCI I/O ranges defined in devicetree of
> Qualcomm SoCs as reported by Arnd [1]. Most of the Qualcomm SoCs define
> identical mapping for the PCI I/O range. But the PCI device I/O ports
> are usually located between 0x0 to 64KiB/1MiB. So the defined PCI addresses are
> mostly bogus. The lack of bug report on this issue indicates that no one really
> tested legacy PCI devices with these SoCs.
>
> This series also contains a couple of cleanup patches that aligns the entries of
> ranges property.

Looks good to me. I already commented that we may also want to use
64KB everywhere instead of 1MB for the per-host window size. Regardless
of that, please add

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I would also prefer to do this in fewer patches, maybe one to
change all the prefixes, and another one to change the location,
or whichever way Bjorn prefers.

     Arnd
